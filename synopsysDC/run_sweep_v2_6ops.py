import os
import subprocess
import re
import sys
import glob

# Configuration
clock_period = 0.5
pipeline_stages = list(range(13, 19)) # 1 to 12

# Directories
base_rtl_dir = "../src/rtl"
v2_dir = f"{base_rtl_dir}/v2_bf16_full"
syn_dir = os.getcwd()

# TCL Template
tcl_template = """
set_host_options -max_cores 8

remove_design -all

# Pipeline Stage Selection
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
set v2_dir "{v2_dir}"

# Analyze supporting files
analyze -library WORK -format sverilog "$v2_dir/fpall_pkg.sv"
analyze -library WORK -format vhdl     "$v2_dir/utils.vhdl"
analyze -library WORK -format sverilog "$v2_dir/utils/abs_comparator.sv"
analyze -library WORK -format sverilog "$v2_dir/utils/barrel_shifter.sv"
analyze -library WORK -format sverilog "$v2_dir/utils/normalizer.sv"
analyze -library WORK -format sverilog "$v2_dir/fpall_shared.sv"
analyze -library WORK -format sverilog "$v2_dir/fpall_shared_ret.sv"

# Elaborate top-level with parameters (both AM and DS set to num_pipe)
elaborate fpall_shared_ret -library WORK -parameters "PARAM_PIPE_AM=${{num_pipe}},PARAM_PIPE_DS=${{num_pipe}}"

link
check_design
set_max_area 0

# Clocks & Constraints
create_clock -name clk -period $main_clock_period [get_ports clk]
set input_ports [remove_from_collection [all_inputs] [get_ports clk]]
set_input_delay 0.1 -clock clk $input_ports
set output_ports [all_outputs]
set_output_delay 0.1 -clock clk $output_ports
set_input_transition 0.05 [remove_from_collection [all_inputs] [get_ports clk]]
set_load 0.1 [all_outputs]

# Enable retiming infrastructure
set_optimize_registers true
set_app_var compile_enable_register_merging true
set_app_var compile_sequential_area_recovery true

# Retiming Synthesis
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
    area_rpt = os.path.join(run_dir, "area.rpt")
    timing_rpt = os.path.join(run_dir, "timing_setup.rpt")
    
    area = "N/A"
    data_arrival = "N/A"
    
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
    return area, data_arrival

results = []
print("Starting v2_bf16_full Pipeline Sweep...")

abs_v2_dir = os.path.abspath(v2_dir)

for pipe in pipeline_stages:
    label = "v2_6ops_ret"
    run_dir_name = f"run-{label}-P{pipe}-T{clock_period}"
    run_dir = os.path.abspath(run_dir_name)
    
    # Check if done
    area, arrival = parse_results(run_dir)
    if area != "N/A":
         print(f"Skipping P{pipe} (Done). Area={area}, Arrival={arrival}")
         results.append((pipe, area, arrival))
         continue
    
    print(f"Running P{pipe}")
    sys.stdout.flush()
    
    tcl_content = tcl_template.format(
        pipe=pipe,
        clock_period=clock_period,
        run_dir=run_dir,
        v2_dir=abs_v2_dir
    )
    
    tcl_file = f"_sweep_{label}_{pipe}.tcl"
    with open(tcl_file, "w") as f:
        f.write(tcl_content)
    
    log_file = f"sweep_{label}_{pipe}.log"
    # Use dc_shell-xg-t, sourcing .cshrc first
    full_cmd = f"source ~/.cshrc; dc_shell-xg-t -f {tcl_file} >& {log_file}"
    
    try:
        subprocess.run(["tcsh", "-c", full_cmd], check=True)
        area, arrival = parse_results(run_dir)
        results.append((pipe, area, arrival))
        print(f"  Result: Area={area}, Arrival={arrival}")
    except subprocess.CalledProcessError as e:
        print(f"  Error: {e}")
        results.append((pipe, "Error", "Error"))

# Save CSV
with open("sweep_summary_v2_6ops.csv", "w") as f:
    f.write("PipelineStages,Area,MaxDataArrival\n")
    for r in results:
        f.write(f"{r[0]},{r[1]},{r[2]}\n")

print("v2_bf16_full Sweep Completed.")
