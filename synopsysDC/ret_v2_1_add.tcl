# ======================================================================
# DC script (retiming for bf16_add_ret.sv)
# This script supports variable pipeline stages for BF16 Add.
# ======================================================================
set_host_options -max_cores 8

remove_design -all

# --- Pipeline Stage Selection ---
if {[info exists env(PIPE)]} {
    set num_pipe $env(PIPE)
} else {
    set num_pipe 11
}
set main_clock_period 0.5

set tag [clock format [clock seconds] -format "%m%d-%H%M"]
set run_dir [file normalize "run-bf16_add_ret-P${num_pipe}-T${main_clock_period}-${tag}"]
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
set v2_dir "$rtl_dir/v2_bf16_full"
set v2_1_dir "$rtl_dir/v2_1_bf16_add"

# Analyze supporting files (from v2_bf16_full as they are shared/imported)
analyze -library WORK -format sverilog "$v2_dir/fpall_pkg.sv"
analyze -library WORK -format vhdl     "$v2_dir/utils.vhdl"
analyze -library WORK -format sverilog "$v2_dir/utils/abs_comparator.sv"
analyze -library WORK -format sverilog "$v2_dir/utils/barrel_shifter.sv"
analyze -library WORK -format sverilog "$v2_dir/utils/normalizer.sv"

# Analyze the main SystemVerilog files
analyze -library WORK -format sverilog "$v2_1_dir/bf16_add.sv"
analyze -library WORK -format sverilog "$v2_1_dir/bf16_add_ret.sv"

# Elaborate top-level with parameters
elaborate bf16_add_ret -library WORK -parameters "PARAM_PIPE=${num_pipe}"

link
check_design
set_max_area 0

# ----------------------------------------------------------------------
# Clocks & Constraints
# ----------------------------------------------------------------------
create_clock -name clk -period $main_clock_period [get_ports clk]
# set input/output delay
set input_ports [remove_from_collection [all_inputs] [get_ports clk]]
set_input_delay 0.0 -clock clk $input_ports

set output_ports [all_outputs]
set_output_delay 0.0 -clock clk $output_ports

set_input_transition 0.0 [remove_from_collection [all_inputs] [get_ports clk]]

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

# Parsing results for summary
set area 0.0
set dat "N/A"

if {[file exists "$run_dir/area.rpt"]} {
    set fp [open "$run_dir/area.rpt" r]
    while {[gets $fp line] >= 0} {
        if {[regexp {Total cell area:\s+([0-9\.]+)} $line match val]} {
            set area $val
        }
    }
    close $fp
}

if {[file exists "$run_dir/timing_setup.rpt"]} {
    set fp [open "$run_dir/timing_setup.rpt" r]
    while {[gets $fp line] >= 0} {
        if {[regexp {data arrival time\s+([0-9\.\-]+)} $line match val]} {
            set dat $val
        }
    }
    close $fp
}

puts "Done bf16_add_ret_pipe${num_pipe}: Area=$area, DAT=$dat"

exit
