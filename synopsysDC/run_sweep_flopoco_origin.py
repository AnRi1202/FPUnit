import os
import subprocess
import re
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed

# Configuration
clock_period = 0.5
pipeline_stages = list(range(1, 19))  # 1 to 18
max_parallel = int(os.environ.get("SWEEP_PARALLEL", "4"))  # -j N or env SWEEP_PARALLEL=N

# NUM_OPS to run (command line args: python run_sweep_flopoco_origin.py [-j N] [num_ops ...])
#   -j N: run N jobs in parallel (default: 4 or SWEEP_PARALLEL env)
# NUM_OPS Mapping:
#   1: Add only (FP32)
#   2: Add+Mul (FP32)
#   3: Mul only (FP32)
#   4: All FP32 (Add+Mul+Sqrt+Div)
#   5: Add FP32 + BF16
#   6: All (FP32 + BF16)
#   7: Mul FP32 + BF16
args = sys.argv[1:]
if args and args[0] == "-j" and len(args) >= 2:
    max_parallel = int(args[1])
    args = args[2:]
elif args and args[0].startswith("-j"):
    max_parallel = int(args[0][2:])
    args = args[1:]
num_ops_list = [int(a) for a in args] if args else [6]

# Directories
base_rtl_dir = "../src/rtl"
origin_dir = f"{base_rtl_dir}/original"
syn_dir = os.getcwd()

# TCL Template
tcl_template = """
set_host_options -max_cores 8

remove_design -all

# Config
set num_ops  {num_ops}
set num_pipe {pipe}
set main_clock_period {clock_period}

set tag [clock format [clock seconds] -format "%m%d-%H%M"]
set run_dir [file normalize "{run_dir}"]
set WORK_DIR [file normalize "${{run_dir}}/WORK"]

file mkdir $run_dir
file mkdir $WORK_DIR

define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

# Libraries
set cell_lib "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"
set search_path "$cell_lib/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"

set link_library "[list $cell_lib/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db ]"

set target_library $link_library

# Analyze & Elaborate
set origin_dir "{origin_dir}"

# Analyze ALL VHDL files in the original directory (components + FPALL_origin + FPALL_origin_ret)
analyze -library WORK -format vhdl [glob "$origin_dir/*.vhdl"]

# Elaborate retiming wrapper with NUM_OPS and NUM_PIPE
elaborate FPALL_origin_ret -library WORK -parameters "NUM_OPS=${{num_ops}}, NUM_PIPE=${{num_pipe}}"

link
check_design
set_max_area 0

# Clocks & Constraints
create_clock -name clk -period $main_clock_period [get_ports clk]
set input_ports [remove_from_collection [all_inputs] [get_ports clk]]
set_input_delay 0.1 -clock clk $input_ports
set_output_delay 0.1 -clock clk [all_outputs]
set_input_transition 0.05 [remove_from_collection [all_inputs] [get_ports clk]]
set_load 0.1 [all_outputs]

# Enable retiming infrastructure
set_optimize_registers true
set_app_var compile_enable_register_merging true
set_app_var compile_sequential_area_recovery true

# RETIMING Synthesis
compile_ultra -retime

# Export reports
write_file -format verilog -hierarchy -output "$run_dir/out_afterRetime.v"
report_area  -hierarchy > $run_dir/area.rpt
report_power            > $run_dir/power.rpt
report_timing -delay_type max -max_paths 1 > $run_dir/timing_setup.rpt
report_register         > $run_dir/registers.rpt

exit
"""

def parse_results(run_dir):
    area_rpt     = os.path.join(run_dir, "area.rpt")
    timing_rpt   = os.path.join(run_dir, "timing_setup.rpt")
    register_rpt = os.path.join(run_dir, "registers.rpt")

    area = "N/A"
    data_arrival = "N/A"
    num_registers = "N/A"

    if os.path.exists(area_rpt):
        with open(area_rpt, 'r') as f:
            for line in f:
                if "Total cell area:" in line:
                    match = re.search(r"Total cell area:\s+([\d\.]+)", line)
                    if match:
                        area = match.group(1)
                        break

    if os.path.exists(timing_rpt):
        with open(timing_rpt, 'r') as f:
            for line in f:
                if "data arrival time" in line:
                    match = re.search(r"data arrival time\s+([\d\.]+)", line)
                    if match:
                        data_arrival = match.group(1)
                        break

    if os.path.exists(register_rpt):
        with open(register_rpt, 'r') as f:
            for line in f:
                # e.g. "Number of registers:   234"
                match = re.search(r"Number of registers:\s+(\d+)", line)
                if match:
                    num_registers = match.group(1)
                    break

    return area, data_arrival, num_registers


def run_one_stage(num_ops, pipe, label, tcl_template, abs_origin_dir, clock_period):
    """Run synthesis for one pipeline stage. Returns (pipe, area, arrival, regs)."""
    run_dir_name = f"run-{label}-P{pipe}-T{clock_period}"
    run_dir = os.path.abspath(run_dir_name)
    tcl_content = tcl_template.format(
        num_ops=num_ops,
        pipe=pipe,
        clock_period=clock_period,
        run_dir=run_dir,
        origin_dir=abs_origin_dir,
    )
    tcl_file = f"_sweep_{label}_{pipe}.tcl"
    with open(tcl_file, "w") as f:
        f.write(tcl_content)
    log_file = f"logs/sweep_{label}_{pipe}.log"
    full_cmd = f"source ~/.cshrc; dc_shell-xg-t -f {tcl_file} >& {log_file}"
    try:
        subprocess.run(["tcsh", "-c", full_cmd], check=True)
        area, arrival, regs = parse_results(run_dir)
        return (pipe, area, arrival, regs)
    except subprocess.CalledProcessError as e:
        return (pipe, "Error", "Error", "Error")


abs_origin_dir = os.path.abspath(origin_dir)
os.makedirs("logs", exist_ok=True)

for num_ops in num_ops_list:
    label = f"flopoco_origin_N{num_ops}_ret"
    csv_file = f"sweep_summary_flopoco_origin_N{num_ops}.csv"

    # Load existing results for skipping
    results = []
    done_stages = set()
    if os.path.exists(csv_file):
        with open(csv_file, "r") as f:
            lines = f.readlines()[1:]  # skip header
            for line in lines:
                parts = line.strip().split(',')
                if len(parts) >= 4:
                    results.append((parts[0], parts[1], parts[2], parts[3]))
                    if parts[0].isdigit():
                        done_stages.add(int(parts[0]))

    pipes_to_run = [p for p in pipeline_stages if p not in done_stages]
    for p in sorted(done_stages):
        print(f"  Skipping P{p} (already in {csv_file})")
    print(f"Starting FloPoCo Origin Retiming Sweep (NUM_OPS={num_ops}), {len(pipes_to_run)} stages, max_parallel={max_parallel}...")

    with ThreadPoolExecutor(max_workers=max_parallel) as ex:
        futures = {
            ex.submit(run_one_stage, num_ops, pipe, label, tcl_template, abs_origin_dir, clock_period): pipe
            for pipe in pipes_to_run
        }
        for future in as_completed(futures):
            pipe = futures[future]
            try:
                r = future.result()
                results.append(r)
                print(f"  P{pipe} done: Area={r[1]}, Arrival={r[2]}, Registers={r[3]}")
                sys.stdout.flush()
                # Incremental CSV save
                results_sorted = sorted(results, key=lambda x: int(x[0]) if str(x[0]).isdigit() else 999)
                with open(csv_file, "w") as f:
                    f.write("PipelineStages,Area,MaxDataArrival,Registers\n")
                    for row in results_sorted:
                        f.write(f"{row[0]},{row[1]},{row[2]},{row[3]}\n")
            except Exception as e:
                print(f"  P{pipe} Error: {e}")
                results.append((pipe, "Error", "Error", "Error"))

    print(f"FloPoCo Origin Retiming Sweep (NUM_OPS={num_ops}) Completed.")
    print(f"Results saved to {csv_file}")
