#----------------------------------------------------------------------------------------------#
#--------------------------------- Set up environment -----------------------------------------#
#----------------------------------------------------------------------------------------------#
set_host_options -max_cores 8 

# Libraries in search_path will be prioritized
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

# =========================
# define folder structure
# ==========================
set tag [clock format [clock seconds] -format "%Y%m%d-%H%M%S"]  ;# 例: 20251216-141905
set run_dir "run-$tag"
file mkdir $run_dir/output/original
file mkdir $run_dir/report/original

define_design_lib WORK -path ./WORK


analyze -library WORK -format vhdl {../rtl/src/FPAdd_frequency=1_target=Kintex7_wE=8_wF=23_FPAdd.vhdl}
elaborate FPAdd_8_23_Freq1_uid2 -architecture arch -library WORK


link

check_design



## ------------- environment constraint -----------

set_max_area 0
set main_clock_period 1000
set percentage_delay 0.10

## doesn't matter, because F=1Mz is combinational logic
create_clock -name clock -period $main_clock_period clk


set input_ports [remove_from_collection [all_inputs] [get_ports clk]]
puts $input_ports
set_input_delay [expr $percentage_delay * $main_clock_period]  -clock clock [get_ports $input_ports]

set output_ports [all_outputs]
puts $output_ports

set_output_delay [expr $percentage_delay * $main_clock_period] -clock clock $output_ports

set_input_transition [expr $percentage_delay * $main_clock_period] [remove_from_collection [all_inputs] [get_ports clock]]



set_max_transition 1.0000 [current_design]
set_max_capacitance 0.2000 [current_design]
set_max_fanout 10.0000 [current_design]
set_load 0.1 [all_outputs]


# get_nets ce
# set_max_delay 1.0 -from [get_ports ce] -to [all_registers]
set_max_delay 1000 -from [all_inputs] -to [all_outputs]

compile_ultra -no_autoungroup -no_boundary_optimization


report_qor



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
write -format verilog -hierarchy -output $run_dir/output/original/post-synth.v
write -format ddc     -hierarchy -output $run_dir/output/original/post-synth.ddc
write_sdc -nosplit $run_dir/output/original/post-synth.sdc
write_sdf $run_dir/output/original/post-synth.sdf

#--------------------
# Reporting PPA:
#--------------------
report_area -hierarchy > $run_dir/report/original/area_f1_add.rpt
report_power > $run_dir/report/original/power_f1_add.rpt
report_timing > $run_dir/report/original/timing_f1_add.rpt


