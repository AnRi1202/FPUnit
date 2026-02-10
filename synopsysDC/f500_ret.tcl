# ======================================================================
# DC script (retiming for area_opt.sv)
# Structure based on synopsysDC/compile.tcl
# ======================================================================

remove_design -all

# ----------------------------------------------------------------------
# Libraries
# ----------------------------------------------------------------------
# Using paths and libraries from synopsysDC/compile.tcl as requested
set search_path "/autofs/fs1.ece/fs1.eecg.janders/bgrady/asic_tools/technology/nanGate/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set link_library   "NangateOpenCellLibrary.db"
set target_library "NangateOpenCellLibrary.db"
set symbol_library ""

# ----------------------------------------------------------------------
# Analyze & Elaborate
# ----------------------------------------------------------------------
set v1_dir "../src/rtl/v1_area_opt"
set original_dir "../src/rtl"

# Analyze supporting VHDL components (FloPoCo-generated primitives)
analyze -library WORK -format vhdl "$original_dir/v2_bf16_full/utils.vhdl"

# Analyze the main SystemVerilog file
analyze -library WORK -format sverilog "$v1_dir/area_opt.sv"

# Elaborate top-level
elaborate area_opt -library WORK

# ----------------------------------------------------------------------
# Clocks
# ----------------------------------------------------------------------
# Target period of 1.0ns (1GHz) as used in compile.tcl baseline
create_clock -name clk  -period 2.0  [get_ports clk]

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

compile_ultra

# Set up result folders (using timestamp like f500.tcl)
set tag [clock format [clock seconds] -format "%Y%m%d-%H%M%S"]  ;# ex: 20251216-141905
set run_dir "run-f500-ret-$tag"
file mkdir $run_dir

# Export baseline netlist & reports
write_file -format verilog -hierarchy -output "$run_dir/out_beforeRetime.v"
write_file -format ddc -hierarchy -output "$run_dir/design_beforeRetime.ddc"

report_exceptions      > $run_dir/exceptions_beforeRetime.rpt
check_timing           > $run_dir/check_timing_beforeRetime.rpt
report_area  -hierarchy > $run_dir/area_beforeRetime.rpt
report_power           > $run_dir/power_beforeRetime.rpt
report_timing -delay_type max -max_paths 20 -transition_time -path full_clock \
  > $run_dir/timing_setup_beforeRetime.rpt
report_timing -delay_type min -max_paths 20 -transition_time -path full_clock \
  > $run_dir/timing_hold_beforeRetime.rpt


# Enable retiming infrastructure 
set_optimize_registers true

# ----------------------------------------------------------------------
# RETIMING: high-effort compile with retime enabled
# ----------------------------------------------------------------------
compile_ultra -retime

# Export retimed netlist & reports
write_file -format verilog -hierarchy -output "$run_dir/out_afterRetime.v"
write_file -format ddc -hierarchy -output "$run_dir/design_afterRetime.ddc"

report_exceptions       > $run_dir/exceptions_afterRetime.rpt
check_timing            > $run_dir/check_timing_afterRetime.rpt
report_area   -hierarchy > $run_dir/area_afterRetime.rpt
report_power            > $run_dir/power_afterRetime.rpt
report_timing -delay_type max -max_paths 20 -transition_time -path full_clock \
  > $run_dir/timing_setup_afterRetime.rpt
report_timing -delay_type min -max_paths 20 -transition_time -path full_clock \
  > $run_dir/timing_hold_afterRetime.rpt

# ----------------------------------------------------------------------
# END
# ----------------------------------------------------------------------
exit
