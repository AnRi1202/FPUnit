import os
import subprocess
import re
import sys
import glob
from concurrent.futures import ProcessPoolExecutor, as_completed

# Configuration
frequencies = [100, 200, 300, 400, 500, 600]
MAX_PARALLEL = int(os.environ.get("SWEEP_PARALLEL", "6"))  # 並列数 (環境変数で上書き可)
types = ["add", "mult"]
clock_period = 0.5

# Directories
base_rtl_dir = "../src/rtl"
syn_dir = os.getcwd()

# TCL Template (run_dir は各ジョブの作業ディレクトリ内の reports/)
tcl_template = """
set_host_options -max_cores 8
file mkdir WORK
define_design_lib WORK -path ./WORK
set_app_var alib_library_analysis_path ./WORK

# Libraries
set cell_lib "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"
set search_path "$cell_lib/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set link_library "[list $cell_lib/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db ]"
set target_library $link_library

# Analysis
set rtl_path "{rtl_path}"
set file_to_analyze "{file_path}"
set entity_name "{entity_name}"

# Analyze ALL VHDL files in the directory to resolve dependencies (components)
analyze -library WORK -format vhdl [glob "$rtl_path/*.vhdl"]

# Elaborate with NUM_OPS parameter if it's fpall
elaborate $entity_name -library WORK {params}

# Constraints
set main_clock_period {clock_period}
create_clock -name clk -period $main_clock_period [get_ports clk]
set_input_delay -clock clk 0.1 [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay -clock clk 0.1 [all_outputs]
set_input_transition 0.05 [remove_from_collection [all_inputs] [get_ports clk]]
set_load 0.1 [all_outputs]

# Compile
compile_ultra

# Output (run_dir はジョブ専用ディレクトリ内)
set run_dir "{run_dir}"
file mkdir $run_dir
report_area -hierarchy > $run_dir/area.rpt
report_timing -delay_type max -max_paths 1 > $run_dir/timing.rpt
exit
"""

def get_entities(file_path):
    entities = []
    with open(file_path, 'r') as f:
        content = f.read()
        # Look for entity declaration: entity X is
        matches = re.findall(r"entity\s+(\w+)\s+is", content, re.IGNORECASE)
        entities = matches
    return entities

def parse_results(run_dir):
    area_rpt = os.path.join(run_dir, "area.rpt")
    timing_rpt = os.path.join(run_dir, "timing.rpt")
    
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


def run_one_synth(args):
    """1ジョブ実行。専用サブディレクトリで dc_shell を動かす。"""
    freq, t, variant_label, num_ops, entity_name, params, abs_base_dir, abs_file_path, tcl_template, clock_period, syn_dir = args
    job_name = f"f{freq}_{t}_{variant_label}"
    job_dir = os.path.join(syn_dir, "sweep_run", job_name)
    os.makedirs(job_dir, exist_ok=True)
    run_dir = os.path.join(job_dir, "reports")
    os.makedirs(run_dir, exist_ok=True)

    tcl_content = tcl_template.format(
        rtl_path=abs_base_dir,
        file_path=abs_file_path,
        entity_name=entity_name,
        clock_period=clock_period,
        run_dir=run_dir,
        params=params
    )
    tcl_file = os.path.join(job_dir, "run.tcl")
    with open(tcl_file, "w") as f:
        f.write(tcl_content)

    log_file = os.path.join(syn_dir, "logs", f"sweep_{job_name}.log")
    os.makedirs(os.path.dirname(log_file), exist_ok=True)
    full_cmd = f"source ~/.cshrc; cd {job_dir} && dc_shell-xg-t -f run.tcl >& {log_file}"

    try:
        subprocess.run(["tcsh", "-c", full_cmd], check=True, timeout=3600)
        area, arrival = parse_results(run_dir)
        return (freq, t, variant_label, area, arrival, None)
    except subprocess.CalledProcessError as e:
        return (freq, t, variant_label, "Error", "Error", str(e))
    except subprocess.TimeoutExpired:
        return (freq, t, variant_label, "Timeout", "Timeout", "timeout")

# Load existing results for skipping
results = []
done_keys = set()
csv_file = "sweep_summary_flopoco_all.csv"
if os.path.exists(csv_file):
    with open(csv_file, "r") as f:
        lines = f.readlines()[1:] # skip header
        for line in lines:
            parts = line.strip().split(',')
            if len(parts) >= 5:
                # Freq,Type,Variant,Area,MaxDataArrival
                results.append((parts[0], parts[1], parts[2], parts[3], parts[4]))
                done_keys.add((str(parts[0]), str(parts[1]), str(parts[2])))

print("Starting F100-F600 Sweep (parallel)...")

# Build task list
tasks = []
for freq in frequencies:
    base_dir = os.path.abspath(os.path.join(syn_dir, base_rtl_dir, f"base_f{freq}"))
    sweep_targets = [
        ("fpall", "4OPS", 4), ("fpall", "5OPS", 5), ("fpall", "6OPS", 6), ("fpall", "7OPS", 7),
        ("add", "FP32", None), ("add", "BF16", None),
        ("mult", "FP32", None), ("mult", "BF16", None)
    ]
    for t, variant_label, num_ops in sweep_targets:
        if (str(freq), str(t), str(variant_label)) in done_keys:
            continue
        if t == "fpall":
            filename = f"f{freq}_fpall_origin.vhdl"
            entity_prefix = f"f{freq}_fpall_origin"
            params = f'-parameters "NUM_OPS={num_ops}"'
        else:
            suffix = "_bf16" if variant_label == "BF16" else ""
            filename = f"fp{t}{suffix}_f{freq}.vhdl"
            entity_prefix = "FPAdd" if t == "add" else "FPMult"
            params = ""
        file_path = os.path.join(base_dir, filename)
        abs_file_path = os.path.abspath(file_path)
        if not os.path.exists(abs_file_path):
            continue
        entities = get_entities(abs_file_path)
        if not entities:
            continue
        entity_name = entity_prefix if t == "fpall" else None
        if not entity_name:
            pattern = rf"{entity_prefix}_8_23_Freq\d+_uid\d+"
            for ent in entities:
                if re.match(pattern, ent):
                    entity_name = ent
                    break
        if not entity_name:
            continue
        tasks.append((freq, t, variant_label, num_ops, entity_name, params, base_dir, abs_file_path))

if not tasks:
    print("All tasks already in CSV or skipped. Done.")
else:
    print(f"Running {len(tasks)} tasks with max {MAX_PARALLEL} parallel workers...")

    def run_task(t):
        return run_one_synth(t + (tcl_template, clock_period, syn_dir))

    with ProcessPoolExecutor(max_workers=MAX_PARALLEL) as ex:
        futures = {ex.submit(run_task, task): task for task in tasks}
        for fut in as_completed(futures):
            task = futures[fut]
            try:
                r = fut.result()
                freq, t, variant_label, area, arrival, err = r
                results.append((freq, t, variant_label, area, arrival))
                msg = f"  f{freq} {t} {variant_label}: Area={area}, Arrival={arrival}"
                if err:
                    msg += f" ({err})"
                print(msg)
            except Exception as e:
                freq, t, variant_label = task[0], task[1], task[2]
                results.append((freq, t, variant_label, "Error", "Error"))
                print(f"  f{freq} {t} {variant_label}: Exception {e}")
            sys.stdout.flush()
            with open(csv_file, "w") as f:
                f.write("Freq,Type,Variant,Area,MaxDataArrival\n")
                for r in sorted(results, key=lambda x: (x[0], x[1], x[2])):
                    f.write(f"{r[0]},{r[1]},{r[2]},{r[3]},{r[4]}\n")

print("F100-F600 Sweep Completed.")
