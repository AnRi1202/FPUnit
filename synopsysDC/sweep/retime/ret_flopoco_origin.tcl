# ======================================================================
# DC script (retiming for FPALL_origin_ret.vhdl - FloPoCo baseline)
# This script synthesizes the FloPoCo-generated baseline with retiming.
# ======================================================================
set_host_options -max_cores 8

remove_design -all

# --- Config (Env vars or defaults) ---
set num_ops  [expr {[info exists env(NUM_OPS)]  ? $env(NUM_OPS)  : 6}]
set num_pipe [expr {[info exists env(NUM_PIPE)] ? $env(NUM_PIPE) : 1}]
set main_clock_period 0.5

set tag [clock format [clock seconds] -format "%m%d-%H%M"]
set sweep_root "sweep_run/retime"
file mkdir $sweep_root
set run_dir [file normalize "$sweep_root/run-flopoco_origin_ret-N${num_ops}-P${num_pipe}-T${main_clock_period}-${tag}"]
set WORK_DIR [file normalize "${run_dir}/WORK"]

file mkdir $run_dir
file mkdir $WORK_DIR

define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

# ----------------------------------------------------------------------
# Libraries
# ----------------------------------------------------------------------
set cell_lib "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"
set search_path "$cell_lib/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"

set link_library "[list \
$cell_lib/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db ]"

set target_library $link_library

# ----------------------------------------------------------------------
# Analyze & Elaborate
# ----------------------------------------------------------------------
set rtl_dir [file normalize "../src/rtl/original"]

# Analyze ALL VHDL files in the directory (components + FPALL_origin + FPALL_origin_ret)
analyze -library WORK -format vhdl [glob "$rtl_dir/*.vhdl"]

# Elaborate retiming wrapper with NUM_OPS and NUM_PIPE parameters
elaborate FPALL_origin_ret -library WORK -parameters "NUM_OPS=${num_ops}, NUM_PIPE=${num_pipe}"

link
check_design
set_max_area 0

# ----------------------------------------------------------------------
# Clocks & Constraints
# ----------------------------------------------------------------------
create_clock -name clk -period $main_clock_period [get_ports clk]

set inputs_no_clk [remove_from_collection [all_inputs] [get_ports clk]]
set_input_delay      -clock clk 0.1 $inputs_no_clk
set_output_delay     -clock clk 0.1 [all_outputs]
set_input_transition 0.05 $inputs_no_clk
set_load 0.1 [all_outputs]

# Enable retiming infrastructure
set_optimize_registers true
set_app_var compile_enable_register_merging true
set_app_var compile_sequential_area_recovery true

# ----------------------------------------------------------------------
# RETIMING Synthesis
# ----------------------------------------------------------------------
compile_ultra -retime

# Export reports
write_file -format verilog -hierarchy -output "$run_dir/out_afterRetime.v"
report_area  -hierarchy > $run_dir/area.rpt
report_power            > $run_dir/power.rpt
report_timing -delay_type max -max_paths 1 > $run_dir/timing_setup.rpt
report_register         > $run_dir/registers.rpt

exit
