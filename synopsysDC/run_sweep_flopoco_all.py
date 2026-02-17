import os
import subprocess
import re
import sys
import glob

# Configuration
frequencies = [100, 200, 300, 400, 500, 600]
types = ["add", "mult"]
clock_period = 0.5

# Directories
base_rtl_dir = "../src/rtl"
syn_dir = os.getcwd()

# TCL Template
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

# Output
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

print("Starting F100-F600 Sweep...")

for freq in frequencies:
    base_dir = f"{base_rtl_dir}/base_f{freq}"
    
    # We want to sweep both standard (FP32) and BF16, and now FPALL (Combined)
    # Mapping: (Type, VariantLabel, num_ops)
    sweep_targets = [
        ("fpall", "4OPS", 4), # vs v1 (area opt)/ v3(addmult) + v3_1 (divsqrt) 
        ("fpall", "5OPS", 5), # vs v2_1 (frac add)
        ("fpall", "6OPS", 6), # vs v2 (6ops) / vs v2_3(faddmult) + v2_4 (divsqrt)
        ("fpall", "7OPS", 7), # vs v2_2 (frac_addmult)
        ("add", "FP32", None),
        ("add", "BF16", None),
        ("mult", "FP32", None),
        ("mult", "BF16", None)
    ]
    
    for t, variant_label, num_ops in sweep_targets:
        # Determine filename and entity
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
        abs_base_dir = os.path.abspath(base_dir)
        
        if not os.path.exists(abs_file_path):
            print(f"Warning: File {abs_file_path} does not exist. Skipping.")
            continue
            
        entities = get_entities(abs_file_path)
        if not entities:
            print(f"Warning: Could not find any entities in {abs_file_path}. Skipping.")
            continue
        
        entity_name = None
        if t == "fpall":
            entity_name = f"{entity_prefix}_NUM_OPS{num_ops}"
        else:
            # Match FPAdd_8_23_Freq1_uid2
            pattern = rf"{entity_prefix}_8_23_Freq\d+_uid\d+"
            for ent in entities:
                if re.match(pattern, ent):
                    entity_name = ent
                    break
                 
        if not entity_name:
             print(f"Warning: No matching entity found in {abs_file_path}. Found: {entities}. Skipping.")
             continue
             
        run_name = f"run-f{freq}-{t}-{variant_label}"
        run_dir = os.path.abspath(run_name)
        
        # Skip if already in CSV
        if (str(freq), str(t), str(variant_label)) in done_keys:
             print(f"Skipping f{freq} {t} {variant_label} (already in {csv_file})")
             continue

        print(f"Running f{freq} {t} {variant_label} (Entity: {entity_name}, params: {params})")
        sys.stdout.flush()
        
        # Create TCL
        tcl_content = tcl_template.format(
            rtl_path=abs_base_dir,
            file_path=abs_file_path,
            entity_name=entity_name,
            clock_period=clock_period,
            run_dir=run_dir,
            params=params
        )
        
        tcl_file = f"_sweep_f{freq}_{t}_{variant_label}.tcl"
        with open(tcl_file, "w") as f:
            f.write(tcl_content)
            
        log_file = f"logs/sweep_f{freq}_{t}_{variant_label}.log"
        full_cmd = f"source ~/.cshrc; dc_shell-xg-t -f {tcl_file} >& {log_file}"
        
        try:
            subprocess.run(["tcsh", "-c", full_cmd], check=True)
            area, arrival = parse_results(run_dir)
            results.append((freq, t, variant_label, area, arrival))
            print(f"  Result: Area={area}, Arrival={arrival}")
        except subprocess.CalledProcessError as e:
            print(f"  Error: {e}")
            results.append((freq, t, variant_label, "Error", "Error"))
        
        # Incremental save CSV so user can see progress
        with open("sweep_summary_flopoco_all.csv", "w") as f:
            f.write("Freq,Type,Variant,Area,MaxDataArrival\n")
            for r in results:
                f.write(f"{r[0]},{r[1]},{r[2]},{r[3]},{r[4]}\n")

print("F100-F600 Sweep Completed.")
