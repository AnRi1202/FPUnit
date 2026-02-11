# ======================================================================
# DC script (retiming for area_opt.sv)
# Structure based on synopsysDC/compile.tcl
# ======================================================================
set_host_options -max_cores 8

remove_design -all

set num_pipe 20
set period 1

set tag [clock format [clock seconds] -format "%m%d-%H%M"]
set run_dir [file normalize "run-pipe${num_pipe}-T${period}-ret-${tag}"]
set WORK_DIR [file normalize "${run_dir}/WORK"]

file mkdir $run_dir
file mkdir $WORK_DIR

define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR


# ----------------------------------------------------------------------
# Libraries
# ----------------------------------------------------------------------
# Using paths and libraries from synopsysDC/compile.tcl as requested
set cell_lib "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"

set search_path "$cell_lib/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"

# Set link library
set link_library "[list \
$cell_lib/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db ]"

# Set target library
set target_library "[list \
$cell_lib/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db \
/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db ]"

set symbol_library ""

# ----------------------------------------------------------------------
# Analyze & Elaborate
# ----------------------------------------------------------------------
set v1_dir "../src/rtl/v1_area_opt"
set original_dir "../src/rtl"


# Analyze supporting VHDL components (FloPoCo-generated primitives)
analyze -library WORK -format vhdl "$original_dir/v2_bf16_full/utils.vhdl"

# Analyze the main SystemVerilog file
analyze -library WORK -format sverilog "$v1_dir/pipe/area_opt_$num_pipe.sv"

# Elaborate top-level
elaborate area_opt -library WORK

# ----------------------------------------------------------------------
# Clocks
# ----------------------------------------------------------------------
# Target period of 1.0ns (1GHz) as used in compile.tcl baseline
create_clock -name clk  -period $period  [get_ports clk]


# ----------------------------------------------------------------------
# Basic I/O timing
# ----------------------------------------------------------------------
set inputs_no_clk  [remove_from_collection [all_inputs] [get_ports clk]]
set_input_delay  -clock clk 0.20 $inputs_no_clk
set_output_delay -clock clk 0.20 [all_outputs]

# ----------------------------------------------------------------------
# Before retiming: baseline compile & reports
# ----------------------------------------------------------------------
set_app_var compile_enable_register_merging true
set_app_var compile_sequential_area_recovery true

# compile

# Set up result folders (using timestamp like f500.tcl)


# # Export baseline netlist & reports
# write_file -format verilog -hierarchy -output "$run_dir/out_beforeRetime.v"
# write_file -format ddc -hierarchy -output "$run_dir/design_beforeRetime.ddc"

# report_exceptions      > $run_dir/exceptions_beforeRetime.rpt
# check_timing           > $run_dir/check_timing_beforeRetime.rpt
# report_area  -hierarchy > $run_dir/area_beforeRetime.rpt
# report_power           > $run_dir/power_beforeRetime.rpt
# report_timing -delay_type max -max_paths 20 -transition_time -path full_clock \
#   > $run_dir/timing_setup_beforeRetime.rpt
# report_timing -delay_type min -max_paths 20 -transition_time -path full_clock \
#   > $run_dir/timing_hold_beforeRetime.rpt


# Enable retiming infrastructure 
set_optimize_registers true

# ----------------------------------------------------------------------
# RETIMING: high-effort compile with retime enabled
# ----------------------------------------------------------------------
set_max_area 0

compile_ultra -retime -no_autoungroup -no_boundary_optimization

# Export retimed netlist & reports
write_file -format verilog -hierarchy -output "$run_dir/out_afterRetime.v"
write_file -format ddc -hierarchy -output "$run_dir/design_afterRetime.ddc"

report_exceptions       > $run_dir/exceptions_afterRetime.rpt
check_timing            > $run_dir/check_timing_afterRetime.rpt
report_area   -hierarchy > $run_dir/area_afterRetime.rpt
report_power            > $run_dir/power_afterRetime.rpt
report_timing -delay_type max -max_paths 20 -transition_time -path full_clock \
  > $run_dir/timing_setup_afterRetime.rpt
report_register > $run_dir/registers_afterRetime.rpt
report_timing -delay_type min -max_paths 20 -transition_time -path full_clock \
  > $run_dir/timing_hold_afterRetime.rpt

report_timing -delay_type max \
  -from [all_inputs] -to [all_outputs] \
  -max_paths 50 -transition_time -path full \
  > $run_dir/timing_io_setup_afterRetime.rpt
# ----------------------------------------------------------------------
# END
# ----------------------------------------------------------------------
exit
