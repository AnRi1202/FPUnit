#----------------------------------------------------------------------------------------------#
#--------------------------------- Set up environment -----------------------------------------#
#----------------------------------------------------------------------------------------------#
set_host_options -max_cores 8 

# Intermediate files organization
file mkdir WORK
file mkdir output
define_design_lib WORK -path ./WORK
set_app_var alib_library_analysis_path ./WORK
# Prevent scattering by setting default output directory
set_app_var search_path ". $search_path"

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

# Set symbol library (if required)
set symbol_library ""

#----------------------------------------------------------------------------------------------#
#------------------------------------------ Synthesis -----------------------------------------#
#----------------------------------------------------------------------------------------------#

# Analyze and Elaborate
set f200_dir "../src/rtl/base_f200"
    analyze -library WORK -format vhdl "$f200_dir/fpadd_f200.vhdl"
    analyze -library WORK -format vhdl "$f200_dir/fpmult_f200.vhdl"
    analyze -library WORK -format vhdl "$f200_dir/fpdiv_f200.vhdl"
    analyze -library WORK -format vhdl "$f200_dir/fpsqrt_f200.vhdl"
    analyze -library WORK -format vhdl "$f200_dir/f200_fpall_origin.vhdl"
elaborate f200_fpall_origin -architecture arch -library WORK

# Check design and compile:
link
#current_design
check_design

#----------------------------------------------------------------------------------------------#
#---------------------------------------- Constraints -----------------------------------------#
#----------------------------------------------------------------------------------------------#

#Going for the minimum-area:
set_max_area 0

## ---- Clock constraints ---- 
#1 ns -> 1GHz
set main_clock_period 0.5
set percentage_delay 0.10
create_clock -name clock -period $main_clock_period clk

# Input delay and output delay for clock
set input_ports [remove_from_collection [all_inputs] [get_ports clk]]
puts $input_ports
set_input_delay [expr $percentage_delay * $main_clock_period]  -clock clock [get_ports $input_ports]

set output_ports [all_outputs]
puts $output_ports
set_output_delay [expr $percentage_delay * $main_clock_period] -clock clock $output_ports

set_input_transition [expr $percentage_delay * $main_clock_period] [remove_from_collection [all_inputs] [get_ports clk]]

################################################################################
# Enviornement attribute constraint
################################################################################
# Load on the output ports
set_max_transition 1.0000 [current_design]
set_max_capacitance 0.2000 [current_design]
set_max_fanout 10.0000 [current_design]
set_load 0.1 [all_outputs]

#Setting max_Delay for the critical path:
# get_nets ce
# set_max_delay 1.0 -from [get_ports ce] -to [all_registers]

# For some reason, compile ultra does not work with the FP IPs..
compile_ultra -no_autoungroup -no_boundary_optimization

#--------------------
# Report QoR:
#--------------------
report_qor

#--------------------
#  Change Naming Rule
#--------------------

set bus_inference_style "%s\[%d\]"
set bus_naming_style "%s\[%d\]"
set hdlout_internal_busses true

change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed "a-z A-Z 0-9 _" -max_length 255 -type cell
define_name_rules name_rule -allowed "a-z A-Z 0-9 _[]" -max_length 255 -type net
define_name_rules name_rule -map {{"\*cell\*" "cell"}}
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule
set verilogout_higher_designs_first true

#--------------------
# Writing output:
#--------------------
set tag [clock format [clock seconds] -format "%Y%m%d-%H%M%S"]  ;# ex: 20251216-141905
set run_dir "run-f200-$tag"
file mkdir $run_dir 

write -format verilog -hierarchy -output $run_dir/post-synth.v
write -format ddc     -hierarchy -output $run_dir/post-synth.ddc
write_sdc -nosplit output/post-synth.sdc
write_sdf $run_dir/post-synth.sdf

#--------------------
# Reporting PPA:
#--------------------
report_area -hierarchy > $run_dir/area_firstpass_45.rpt
report_power > $run_dir/power_firstpass_45.rpt
report_timing > $run_dir/timing_firstpass_45.rpt

reset_design
remove_design -all

set filename "$run_dir/timing_firstpass_45.rpt"
set fileId [open $filename r]
set new_constraint ""

while {[gets $fileId line] >= 0} {
    if {[regexp {slack \((VIOLATED(?:[^)]*)|MET)\)\s+(-?\d+\.\d+)} $line -> status slack]} {
        set slack_val [expr {$slack}]
        set new_constraint [expr {$main_clock_period - $slack_val}]
        puts "Slack: $slack_val"
        puts "New constraint: $new_constraint"
        break
    }
}

close $fileId

if {$new_constraint == ""} {
    puts "Warning: Could not extract slack from timing report. Using default 1.0"
    set new_constraint 1.0
}

#----------------------------------------------------------------------------------------------#
puts "Method Vimal/Omar: 40% Reduction critical path delay"
set new_constraint [expr {0.6 * $new_constraint}]
puts "New constraint with 40% Reduction critical path delay critical path delay: $new_constraint"
#----------------------------------------------------------------------------------------------#

#elaborate design for area optimization
elaborate f200_fpall_origin -architecture arch -library WORK

# Check design and compile:
link
#current_design
check_design

#----------------------------------------------------------------------------------------------#
#---------------------------------------- Constraints -----------------------------------------#
#----------------------------------------------------------------------------------------------#

#Going for the minimum-area:
set_max_area 0

## ---- Clock constraints ---- 
#1 ns -> 1GHz
set main_clock_period $new_constraint
set percentage_delay 0.10
create_clock -name clock -period $main_clock_period clk


set inputs_no_clk [remove_from_collection [all_inputs] [get_ports clk]]

set_input_delay      -clock clk 0.20 $inputs_no_clk
set_output_delay     -clock clk 0.20 [all_outputs]
set_input_transition 0.20 $inputs_no_clk
set_load 0.1 [all_outputs]
################################################################################
# Enviornement attribute constraint
################################################################################
# Load on the output ports
# set_max_transition 1.0000 [current_design]
# set_max_capacitance 0.2000 [current_design]
# set_max_fanout 10.0000 [current_design]
# set_load 0.1 [all_outputs]

#Setting max_Delay for the critical path:
# get_nets ce
# set_max_delay 1.0 -from [get_ports ce] -to [all_registers]

# For some reason, compile ultra does not work with the FP IPs..
compile_ultra -no_autoungroup -no_boundary_optimization

#--------------------
# Report QoR:
#--------------------
report_qor

#--------------------
#  Change Naming Rule
#--------------------

set bus_inference_style "%s\[%d\]"
set bus_naming_style "%s\[%d\]"
set hdlout_internal_busses true

change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed "a-z A-Z 0-9 _" -max_length 255 -type cell
define_name_rules name_rule -allowed "a-z A-Z 0-9 _[]" -max_length 255 -type net
define_name_rules name_rule -map {{"\*cell\*" "cell"}}
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule
set verilogout_higher_designs_first true

#--------------------
# Writing output:
#--------------------
write -format verilog -hierarchy -output $run_dir/post-synth.v
write -format ddc     -hierarchy -output $run_dir/post-synth.ddc
write_sdc -nosplit output/post-synth.sdc
write_sdf $run_dir/post-synth.sdf

#--------------------
# Reporting PPA:
#--------------------
report_area -hierarchy > $run_dir/area_secondpass_45.rpt
report_timing > $run_dir/timing_secondpass_45.rpt
report_power > $run_dir/power_secondpass_45.rpt

# exit the synopsys design compiler:
exit

