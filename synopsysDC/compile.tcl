
# ======================================================================
# DC script (retiming + CDC isolation)
#  - Config_Clock is a slow, configuration clock
#  - CGRA_Clock is the high-speed datapath clock
#  - Generate before/after retime netlists and reports
# ======================================================================

remove_design -all

# ----------------------------------------------------------------------
# Libraries
# ----------------------------------------------------------------------
set search_path "/autofs/fs1.ece/fs1.eecg.janders/bgrady/asic_tools/technology/nanGate/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set link_library   "NangateOpenCellLibrary.db"
set target_library "NangateOpenCellLibrary.db"
set symbol_library ""

# ----------------------------------------------------------------------
# Analyze & Elaborate
# ----------------------------------------------------------------------
analyze -library WORK -format sverilog {./verilog/cgrame.v}
analyze -library WORK -format sverilog {./verilog/cgra_instance.sv}

analyze -library WORK -format vhdl {./vhdl/FPAdd_8_23_F1_uid2__split.vhdl}
analyze -library WORK -format vhdl {./vhdl/FPMult_8_23_8_23_8_23_F1_uid2__split.vhdl}
analyze -library WORK -format vhdl {./vhdl/InputIEEE2FloPoCo.vhdl}
analyze -library WORK -format vhdl {./vhdl/OutputFloPoCo2IEEE.vhdl}

elaborate cgra_instance -architecture verilog -library DEFAULT

# ----------------------------------------------------------------------
# Clocks
# ----------------------------------------------------------------------
create_clock -name CGRA_Clock  -period 1.0  [get_ports CGRA_Clock]
# create_clock -name Config_Clock -period 100.0 [get_ports Config_Clock]

# ----------------------------------------------------------------------
# CDC Isolation: Make them asynchronous so config paths never constrain datapath
# ----------------------------------------------------------------------
# set_clock_groups -asynchronous \
#   -group [get_clocks Config_Clock] \
#   -group [get_clocks CGRA_Clock]

# (Optional) if the CDC does not work (Uncomment the following two line)
# set_false_path -from [get_clocks Config_Clock] -to [get_clocks CGRA_Clock]
# set_false_path -from [get_clocks CGRA_Clock]  -to [get_clocks Config_Clock]

# ----------------------------------------------------------------------
# Basic I/O timing (placeholders; adjust per top-level environment)
# ----------------------------------------------------------------------
# It was not there in the original sdc and can be commented out
set inputs_no_clk  [remove_from_collection [all_inputs] [list [get_ports CGRA_Clock] [get_ports Config_Clock]]]
set_input_delay  -clock CGRA_Clock 0.20 $inputs_no_clk
set_output_delay -clock CGRA_Clock 0.20 [all_outputs]

# ----------------------------------------------------------------------
# Retiming protection for configuration state (optional, recommended)
# ----------------------------------------------------------------------
# set_dont_retime [get_cells -hierarchical *config_reg*]

# ----------------------------------------------------------------------
# Before retiming: baseline compile & reports
# ----------------------------------------------------------------------
set_app_var compile_enable_register_merging true
set_app_var compile_sequential_area_recovery true


compile

# Export baseline netlist & reports
write_file -format verilog -hierarchy -output "./output/out_beforeRetime.v"
write_file -format ddc -hierarchy -output "./output/design_beforeRetime.ddc"

report_exceptions      > output/exceptions_beforeRetime.rpt
check_timing           > output/check_timing_beforeRetime.rpt
report_area  -hierarchy > output/area_beforeRetime.rpt
report_power           > output/power_beforeRetime.rpt
# Useful timing views
report_timing -delay_type max -max_paths 20 -transition_time -path full_clock \
  > output/timing_setup_beforeRetime.rpt
report_timing -delay_type min -max_paths 20 -transition_time -path full_clock \
  > output/timing_hold_beforeRetime.rpt


# Enable retiming infrastructure (won't be used until we call -retime)
set_optimize_registers true

# ----------------------------------------------------------------------
# RETIMING: high-effort compile with retime enabled
# ----------------------------------------------------------------------
# Perform retiming in the CGRA_Clock domain. DC will respect clock groups and not cross CDC.
compile -retime

# Export retimed netlist & reports
write_file -format verilog -hierarchy -output "./output/out_afterRetime.v"
write_file -format ddc -hierarchy -output "./output/design_afterRetime.ddc"

report_exceptions       > output/exceptions_afterRetime.rpt
check_timing            > output/check_timing_afterRetime.rpt
report_area   -hierarchy > output/area_afterRetime.rpt
report_power            > output/power_afterRetime.rpt
report_timing -delay_type max -max_paths 20 -transition_time -path full_clock \
  > output/timing_setup_afterRetime.rpt
report_timing -delay_type min -max_paths 20 -transition_time -path full_clock \
  > output/timing_hold_afterRetime.rpt

# ----------------------------------------------------------------------
# MODE CASE ANALYSIS (Optional Scenarios)
# ----------------------------------------------------------------------
# mux selects (e.g., DUT/.../mux*/select[*]),
# set sel_ones  [get_pins -hierarchical "DUT/TpuMdgrapePE_r0/mux*/select*"]
# set_case_analysis 1 $sel_ones
# report_timing > output/sel1_timing_afterRetime.rpt

# And for selects = 0:
# set sel_zeros [get_pins -hierarchical "DUT/TpuMdgrapePE_r0/mux*/select*"]
# set_case_analysis 0 $sel_zeros
# report_timing > output/sel0_timing_afterRetime.rpt

# ----------------------------------------------------------------------
# END
# ----------------------------------------------------------------------
exit

