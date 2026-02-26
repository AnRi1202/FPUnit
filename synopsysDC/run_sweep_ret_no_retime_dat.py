#!/usr/bin/env python3
"""
*_ret designs: PIPE=1 (1 register stage), NO retiming, get data arrival time.
Runs all v1 and v2 _ret designs.
"""
import os
import subprocess
import re
import sys

clock_period = 0.5
syn_dir = os.path.abspath(os.path.dirname(__file__))
rtl_dir = os.path.abspath(os.path.join(syn_dir, "../src/rtl"))
cell_lib = "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"
link_lib = f"[list {cell_lib}/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db ]"

# cell_lib for v1_3/v1_4/v2_3/v2_4 (they use .db path directly)
cell_lib_db = f"{cell_lib}/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db"

def common_header():
    return f"""
set_host_options -max_cores 8
remove_design -all

set main_clock_period {clock_period}
set tag [clock format [clock seconds] -format "%Y%m%d-%H%M%S"]
"""

def common_libs():
    return f"""
set cell_lib "{cell_lib}"
set search_path "${{cell_lib}}/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set link_library {link_lib}
set target_library $link_library
"""

def common_constraints():
    return f"""
create_clock -name clk -period $main_clock_period [get_ports clk]
set inputs_no_clk [remove_from_collection [all_inputs] [get_ports clk]]
set_input_delay      -clock clk 0.1 $inputs_no_clk
set_output_delay     -clock clk 0.1 [all_outputs]
set_input_transition 0.05 $inputs_no_clk
set_load 0.1 [all_outputs]
"""

def common_no_retime_compile():
    return """
# NO retiming - compile only
set_optimize_registers false
compile_ultra

report_area  -hierarchy > $run_dir/area.rpt
report_timing -delay_type max -max_paths 1 > $run_dir/timing_setup.rpt
exit
"""

def make_tcl_v1_area_opt():
    return f"""
{common_header()}
set run_dir [file normalize "run-v1_area_opt_ret-P1-noRetime-$tag"]
set WORK_DIR [file normalize "${{run_dir}}/WORK"]
file mkdir $run_dir
file mkdir $WORK_DIR
define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

{common_libs()}

set v1_dir "{rtl_dir}/v1_area_opt"
set v2_dir "{rtl_dir}/v2_bf16_full"

analyze -library WORK -format vhdl "$v2_dir/utils.vhdl"
analyze -library WORK -format sverilog "$v1_dir/area_opt.sv"
analyze -library WORK -format sverilog "$v1_dir/area_opt_ret.sv"
elaborate area_opt_ret -library WORK -parameters "PARAM_PIPE_AM=1, PARAM_PIPE_DS=1"

link
check_design
set_max_area 0
{common_constraints()}
{common_no_retime_compile()}
"""

def make_tcl_v1_3_addmul():
    return f"""
{common_header()}
set run_dir [file normalize "run-v1_3_addmul_ret-P1-noRetime-$tag"]
set WORK_DIR [file normalize "${{run_dir}}/WORK"]
file mkdir $run_dir
file mkdir $WORK_DIR
define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

set cell_lib "{cell_lib_db}"
set search_path ". /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set link_library "[list $cell_lib /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db ]"
set target_library $link_library

set v1_3_dir "{rtl_dir}/v1_3_addmul_only"
set v2_dir "{rtl_dir}/v2_bf16_full"

analyze -library WORK -format vhdl "$v2_dir/utils.vhdl"
analyze -library WORK -format sverilog "$v1_3_dir/fpall_pkg.sv"
analyze -library WORK -format sverilog "$v1_3_dir/addmul_only.sv"
analyze -library WORK -format sverilog "$v1_3_dir/addmul_only_ret.sv"
elaborate addmul_only_ret -parameters "PARAM_PIPE=1"
current_design addmul_only_ret

link
check_design
{common_constraints()}
set_clock_uncertainty 0.0 clk
{common_no_retime_compile()}
"""

def make_tcl_v1_4_divsqrt():
    return f"""
{common_header()}
set run_dir [file normalize "run-v1_4_divsqrt_ret-P1-noRetime-$tag"]
set WORK_DIR [file normalize "${{run_dir}}/WORK"]
file mkdir $run_dir
file mkdir $WORK_DIR
define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

set cell_lib "{cell_lib_db}"
set search_path ". /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set link_library "[list $cell_lib /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db ]"
set target_library $link_library

set v1_4_dir "{rtl_dir}/v1_4_divsqrt_only"
set v2_dir "{rtl_dir}/v2_bf16_full"

analyze -library WORK -format vhdl "$v2_dir/utils.vhdl"
analyze -library WORK -format sverilog "$v1_4_dir/divsqrt_only.sv"
analyze -library WORK -format sverilog "$v1_4_dir/divsqrt_only_ret.sv"
elaborate divsqrt_only_ret -parameters "PARAM_PIPE=1"
current_design divsqrt_only_ret

link
check_design
{common_constraints()}
set_clock_uncertainty 0.0 clk
{common_no_retime_compile()}
"""

def make_tcl_v2_fpall():
    return f"""
{common_header()}
set run_dir [file normalize "run-v2_fpall_ret-P1-noRetime-$tag"]
set WORK_DIR [file normalize "${{run_dir}}/WORK"]
file mkdir $run_dir
file mkdir $WORK_DIR
define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

{common_libs()}

set v2_dir "{rtl_dir}/v2_bf16_full"

analyze -library WORK -format sverilog "$v2_dir/fpall_pkg.sv"
analyze -library WORK -format vhdl     "$v2_dir/utils.vhdl"
analyze -library WORK -format sverilog "$v2_dir/fpall_shared_ret.sv"
elaborate fpall_shared_ret -library WORK -parameters "PARAM_PIPE_AM=1, PARAM_PIPE_DS=1"

link
check_design
set_max_area 0
{common_constraints()}
{common_no_retime_compile()}
"""

def make_tcl_v2_1_add():
    return f"""
{common_header()}
set run_dir [file normalize "run-bf16_add_ret-P1-noRetime-$tag"]
set WORK_DIR [file normalize "${{run_dir}}/WORK"]
file mkdir $run_dir
file mkdir $WORK_DIR
define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

{common_libs()}

set v2_dir "{rtl_dir}/v2_bf16_full"
set v2_1_dir "{rtl_dir}/v2_1_bf16_add"

analyze -library WORK -format sverilog "$v2_dir/fpall_pkg.sv"
analyze -library WORK -format vhdl     "$v2_dir/utils.vhdl"
analyze -library WORK -format sverilog "$v2_dir/utils/abs_comparator.sv"
analyze -library WORK -format sverilog "$v2_dir/utils/barrel_shifter.sv"
analyze -library WORK -format sverilog "$v2_dir/utils/normalizer.sv"
analyze -library WORK -format sverilog "$v2_1_dir/bf16_add.sv"
analyze -library WORK -format sverilog "$v2_1_dir/bf16_add_ret.sv"
elaborate bf16_add_ret -library WORK -parameters "PARAM_PIPE=1"

link
check_design
set_max_area 0
{common_constraints()}
{common_no_retime_compile()}
"""

def make_tcl_v2_2_mult():
    return f"""
{common_header()}
set run_dir [file normalize "run-bf16_mult_ret-P1-noRetime-$tag"]
set WORK_DIR [file normalize "${{run_dir}}/WORK"]
file mkdir $run_dir
file mkdir $WORK_DIR
define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

{common_libs()}

set v2_dir "{rtl_dir}/v2_bf16_full"
set v2_2_dir "{rtl_dir}/v2_2_bf16_mult"

analyze -library WORK -format sverilog "$v2_dir/fpall_pkg.sv"
analyze -library WORK -format vhdl     "$v2_dir/utils.vhdl"
analyze -library WORK -format sverilog "$v2_2_dir/bf16_mult.sv"
analyze -library WORK -format sverilog "$v2_2_dir/bf16_mult_ret.sv"
elaborate bf16_mult_ret -library WORK -parameters "PARAM_PIPE=1"

link
check_design
set_max_area 0
{common_constraints()}
{common_no_retime_compile()}
"""

def make_tcl_v2_3_addmul():
    return f"""
{common_header()}
set run_dir [file normalize "run-v2_3_addmul_ret-P1-noRetime-$tag"]
set WORK_DIR [file normalize "${{run_dir}}/WORK"]
file mkdir $run_dir
file mkdir $WORK_DIR
define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

set cell_lib "{cell_lib_db}"
set search_path ". /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set link_library "[list $cell_lib /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db ]"
set target_library $link_library

set v2_3_dir "{rtl_dir}/v2_3_addmul_only"
set v2_full_dir "{rtl_dir}/v2_bf16_full"

analyze -library WORK -format vhdl "$v2_full_dir/utils.vhdl"
analyze -library WORK -format sverilog "$v2_3_dir/fpall_pkg.sv"
analyze -library WORK -format sverilog "$v2_full_dir/utils/abs_comparator.sv"
analyze -library WORK -format sverilog "$v2_full_dir/utils/barrel_shifter.sv"
analyze -library WORK -format sverilog "$v2_full_dir/utils/normalizer.sv"
analyze -library WORK -format sverilog "$v2_3_dir/addmul_only.sv"
analyze -library WORK -format sverilog "$v2_3_dir/addmul_only_ret.sv"
elaborate addmul_only_ret -parameters "PARAM_PIPE=1"
current_design addmul_only_ret

link
check_design
{common_constraints()}
set_clock_uncertainty 0.0 clk
{common_no_retime_compile()}
"""

def make_tcl_v2_4_divsqrt():
    return f"""
{common_header()}
set run_dir [file normalize "run-v2_4_divsqrt_ret-P1-noRetime-$tag"]
set WORK_DIR [file normalize "${{run_dir}}/WORK"]
file mkdir $run_dir
file mkdir $WORK_DIR
define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

set cell_lib "{cell_lib_db}"
set search_path ". /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set link_library "[list $cell_lib /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db ]"
set target_library $link_library

set v2_4_dir "{rtl_dir}/v2_4_divsqrt_only"
set v2_full_dir "{rtl_dir}/v2_bf16_full"

analyze -library WORK -format vhdl "$v2_full_dir/utils.vhdl"
analyze -library WORK -format sverilog "$v2_4_dir/divsqrt_only.sv"
analyze -library WORK -format sverilog "$v2_4_dir/divsqrt_only_ret.sv"
elaborate divsqrt_only_ret -parameters "PARAM_PIPE=1"
current_design divsqrt_only_ret

link
check_design
{common_constraints()}
set_clock_uncertainty 0.0 clk
{common_no_retime_compile()}
"""

def parse_results(run_dir):
    area_rpt = os.path.join(run_dir, "area.rpt")
    timing_rpt = os.path.join(run_dir, "timing_setup.rpt")
    area = "N/A"
    dat = "N/A"
    if os.path.exists(area_rpt):
        with open(area_rpt, 'r') as f:
            for line in f:
                if "Total cell area:" in line:
                    m = re.search(r"Total cell area:\s+([\d\.]+)", line)
                    if m:
                        area = m.group(1)
                    break
    if os.path.exists(timing_rpt):
        with open(timing_rpt, 'r') as f:
            for line in f:
                if "data arrival time" in line:
                    m = re.search(r"data arrival time\s+([\d\.\-]+)", line)
                    if m:
                        dat = m.group(1)
                    break
    return area, dat

# Order: smaller designs first (bf16_add ~5min, divsqrt ~10min, addmul ~15min, area_opt/fpall ~30-60min)
DESIGNS = [
    ("v2_1_bf16_add_ret", make_tcl_v2_1_add, "run-bf16_add_ret-P1-noRetime-"),
    ("v2_2_bf16_mult_ret", make_tcl_v2_2_mult, "run-bf16_mult_ret-P1-noRetime-"),
    ("v1_4_divsqrt_ret", make_tcl_v1_4_divsqrt, "run-v1_4_divsqrt_ret-P1-noRetime-"),
    ("v2_4_divsqrt_ret", make_tcl_v2_4_divsqrt, "run-v2_4_divsqrt_ret-P1-noRetime-"),
    ("v1_3_addmul_ret", make_tcl_v1_3_addmul, "run-v1_3_addmul_ret-P1-noRetime-"),
    ("v2_3_addmul_ret", make_tcl_v2_3_addmul, "run-v2_3_addmul_ret-P1-noRetime-"),
    ("v1_area_opt_ret", make_tcl_v1_area_opt, "run-v1_area_opt_ret-P1-noRetime-"),
    ("v2_fpall_ret", make_tcl_v2_fpall, "run-v2_fpall_ret-P1-noRetime-"),
]

def main():
    os.makedirs("logs", exist_ok=True)
    results = []
    print("Note: v1_area_opt_ret and v2_fpall_ret may take 30-60min each. Check logs/sweep_*_P1_noRetime.log for progress.")
    for label, make_tcl_fn, run_pattern in DESIGNS:
        print(f"Running {label} (P1, no retime)...")
        sys.stdout.flush()
        tcl_content = make_tcl_fn()
        tcl_file = f"_sweep_{label}_P1_noRetime.tcl"
        with open(tcl_file, "w") as f:
            f.write(tcl_content)
        log_file = f"logs/sweep_{label}_P1_noRetime.log"
        try:
            subprocess.run(["tcsh", "-c", f"source ~/.cshrc; dc_shell-xg-t -f {tcl_file} >& {log_file}"], check=True, cwd=syn_dir)
            run_dirs = sorted([d for d in os.listdir(syn_dir) if d.startswith(run_pattern)])
            if run_dirs:
                latest = os.path.join(syn_dir, run_dirs[-1])
                area, dat = parse_results(latest)
                results.append((label, area, dat))
                print(f"  Area={area}, DAT={dat}")
            else:
                results.append((label, "Error", "No run dir"))
                print(f"  Error: no run dir found")
        except subprocess.CalledProcessError as e:
            results.append((label, "Error", str(e)))
            print(f"  Error: {e}")
    csv_path = os.path.join(syn_dir, "ret_no_retime_dat_summary.csv")
    with open(csv_path, "w") as f:
        f.write("Design,Area,DataArrivalTime\n")
        for label, area, dat in results:
            f.write(f"{label},{area},{dat}\n")
    print(f"\nWrote {csv_path}")

if __name__ == "__main__":
    main()
