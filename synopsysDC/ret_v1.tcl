# ======================================================================
# DC script (retiming for area_opt_ret.sv - v1_area_opt)
# This script supports operation-specific pipeline stages.
# ======================================================================
set_host_options -max_cores 8

remove_design -all

# --- Pipeline Stage Selection ---
set num_pipe_am 2
set num_pipe_ds 12
set main_clock_period 0.5

set tag [clock format [clock seconds] -format "%m%d-%H%M"]
set run_dir [file normalize "run-v1_ret-AM${num_pipe_am}-DS${num_pipe_ds}-T${main_clock_period}-${tag}"]
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
set rtl_dir "../src/rtl"
set v1_dir "$rtl_dir/v1_area_opt"
set v2_dir "$rtl_dir/v2_bf16_full"

# Analyze supporting VHDL components (FloPoCo-generated primitives)
analyze -library WORK -format vhdl "$v2_dir/utils.vhdl"

# Analyze the main SystemVerilog file
analyze -library WORK -format sverilog "$v1_dir/area_opt_ret.sv"

# Elaborate top-level with parameters
elaborate area_opt_ret -library WORK -parameters "PARAM_PIPE_AM=${num_pipe_am}, PARAM_PIPE_DS=${num_pipe_ds}"

link
check_design
set_max_area 0

# ----------------------------------------------------------------------
# Clocks & Constraints
# ----------------------------------------------------------------------
create_clock -name clk -period $main_clock_period [get_ports clk]

set inputs_no_clk [remove_from_collection [all_inputs] [get_ports clk]]
set_input_delay      -clock clk 0.20 $inputs_no_clk
set_output_delay     -clock clk 0.20 [all_outputs]
set_input_transition 0.20 $inputs_no_clk
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
report_timing -delay_type max -max_paths 5 > $run_dir/timing_setup.rpt
report_register         > $run_dir/registers.rpt

exit
