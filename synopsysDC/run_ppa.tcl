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

#----------------------------------------------------------------------------------------------#
#--------------------------------- Set up result folders --------------------------------------#
#----------------------------------------------------------------------------------------------#
set tag [clock format [clock seconds] -format "%Y%m%d-%H%M%S"]  ;# 例: 20251216-141905
set run_dir "run-$tag"

file mkdir $run_dir/output/new
file mkdir $run_dir/report/new

define_design_lib WORK -path ./WORK

# for CSV
set rpt_file "$run_dir/results_summary.csv"
set f [open $rpt_file w]
puts $f "Entity,TotalArea,LeakagePower,DynamicPower,Slack"
close $f



proc run_synth_common {entity_name label} {
    global rpt_file run_dir
    # # for vhdl
    # elaborate $entity_name -library WORK
    # # for sv
    elaborate $entity_name -library WORK
    
    link

    check_design

    # Constraints 
    set_max_area 0
    # # 1000 ns = 1 us 1MHz
    # set main_clock_period 1000 
    # set percentage_delay 0.10
    # create_clock -name clock -period $main_clock_period clk
    
    # set input_ports [remove_from_collection [all_inputs] [get_ports clk]]
    # set_input_delay [expr $percentage_delay * $main_clock_period] -clock clock $input_ports
    
    # set output_ports [all_outputs]
    # set_output_delay [expr $percentage_delay * $main_clock_period] -clock clock $output_ports
    
    # set_input_transition [expr $percentage_delay * $main_clock_period] [remove_from_collection [all_inputs] [get_ports clk]]

    # set_max_transition 1.0000 [current_design]
    # set_max_capacitance 0.2000 [current_design]
    # set_max_fanout 10.0000 [current_design]
    # set_load 0.1 [all_outputs]

    # set_max_delay 1000 -from [all_inputs] -to [all_outputs]
    # Compile
    compile_ultra -no_autoungroup  -no_boundary_optimization
    


    set rpt_dir  "$run_dir/report/new" 
    set out_dir  "$run_dir/output/new"


    set rpt_area "$rpt_dir/${label}_area.rpt"
    set rpt_pwr "$rpt_dir/${label}_power.rpt"
    set rpt_time "$rpt_dir/${label}_timing.rpt"
    set rpt_ref "$rpt_dir/${label}_reference.rpt"

    #--------------------
    # Report QoR:
    #--------------------
    report_qor
    #--------------------
    #  Change Naming Rule　なぜかこれの有無でPPAが変わる
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
    write -format verilog -hierarchy -output $out_dir/post-synth.v
    write -format ddc     -hierarchy -output $out_dir/post-synth.ddc
    write_sdc -nosplit $out_dir/post-synth.sdc
    write_sdf $out_dir/post-synth.sdf
    #--------------------
    # Reporting PPA:
    #--------------------
    report_area -hierarchy > $rpt_area
    report_power > $rpt_pwr
    report_timing > $rpt_time
    report_reference > $rpt_ref


   # ==============================
   # summarize csv
   # =============================== 


    set area 0.0
    set leak_power 0.0
    set dyn_power 0.0
    set slack "N/A"

    
    if {[file exists $rpt_area]} {
        set fp [open $rpt_area r]
        while {[gets $fp line] >= 0} {
             if {[regexp {Total cell area:\s+([0-9\.]+)} $line match val]} {
                 set area $val
             }
        }
        close $fp
    }
    
    if {[file exists $rpt_pwr]} {
        set fp [open $rpt_pwr r]
        while {[gets $fp line] >= 0} {
             if {[regexp {Cell Leakage Power\s+=\s+([0-9\.eE+-]+)} $line match val]} {
                 set leak_power $val
             }
             if {[regexp {Total Dynamic Power\s+=\s+([0-9\.eE+-]+)} $line match val]} {
                 set dyn_power $val
             }
        }
        close $fp
    }
    
    if {[file exists $rpt_time]} {
         set fp [open $rpt_time r]
         while {[gets $fp line] >= 0} {
              if {[regexp {slack \(.*\)\s+([0-9\.\-]+)} $line match val]} {
                  set slack $val
              }
         }
         close $fp
    }
    
    set f [open $rpt_file a]
    puts $f "$label,$area,$leak_power,$dyn_power,$slack"
    close $f
    puts "Done $label: Area=$area, Slack=$slack"
   # ==============================
   # summarize csv
   # =============================== 
}

#----------------------------------------------------------------------------------------------#
#--------------------------------- CHOOSE DESIGNS     -----------------------------------------#
#----------------------------------------------------------------------------------------------#

set rtl_dir "../src/rtl"

#########################     Original     ################################################# 

# # # Task 1: Baseline FPAdd
# puts "--- Task 1: FPAdd ---"
# remove_design -all
# analyze -library WORK -format vhdl "$rtl_dir/FPAdd_Kin_f1_origin.vhdl"
# run_synth_common "FPAdd_8_23_Freq1_uid2" "FPAdd_VHDL"

# # # Task 2: Baseline FPMult
# puts "--- Task 2: FPMult ---"
# remove_design -all
# analyze -library WORK -format vhdl "$rtl_dir/FPMult_Kin_f1_origin.vhdl"
# run_synth_common "FPMult_8_23_uid2_Freq1_uid3" "FPMult"

# # # Task 3: Baseline FPDiv
# puts "--- Task 3: FPDiv ---"
# remove_design -all
# analyze -library WORK -format vhdl "$rtl_dir/FPDiv_Kin_f1_origin.vhdl"
# run_synth_common "FPDiv_8_23_Freq1_uid2" "FPDiv"

# # # Task 4: Baseline FPSqrt
# puts "--- Task 4: FPSqrt ---"
# remove_design -all
# analyze -library WORK -format vhdl "$rtl_dir/FPSqrt_Kin_f1_origin.vhdl"
# run_synth_common "FPSqrt_8_23" "FPSqrt"

#########################     ALL     ################################################# 


# # Task 17: shared_combine
# puts "--- Task 17: Shared combine---"
# remove_design -all
# analyze -library WORK -format vhdl "$rtl_dir/FPAdd_Kin_f1_origin.vhdl"
# analyze -library WORK -format vhdl "$rtl_dir/FPMult_Kin_f1_origin.vhdl"
# analyze -library WORK -format vhdl "$rtl_dir/FPDiv_Kin_f1_origin.vhdl"
# analyze -library WORK -format vhdl "$rtl_dir/FPSqrt_Kin_f1_origin.vhdl"

# analyze -library WORK -format vhdl "$rtl_dir/vhdl_src_combine/FPALL_shared.vhdl"
# run_synth_common "FPAllShared" "FPAllShared"


# puts "--- Task 18: Shared combine_sv---"
# remove_design -all
# analyze -library WORK -format vhdl "$rtl_dir/utils.vhdl"

# analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/fpall_pkg.sv"
# analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/normalizer.sv"
# analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/abs_comparator.sv"
# analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/barrel_shifter.sv"

# analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/FPALL_shared.sv"
# run_synth_common "FPAllShared" "FPAllShared"


##################    add_only    ######################################
puts "--- Task 18: Add only---"
remove_design -all
analyze -library WORK -format vhdl "$rtl_dir/utils.vhdl"

analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/fpall_pkg.sv"
analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/normalizer.sv"
analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/abs_comparator.sv"
analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/barrel_shifter.sv"

analyze -library WORK -format sverilog "$rtl_dir/add/FPAdd.sv"
run_synth_common "FPAdd" "FPAdd"

puts "--- Task 18: fractural Add only---"
remove_design -all
analyze -library WORK -format vhdl "$rtl_dir/utils.vhdl"

analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/fpall_pkg.sv"
analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/normalizer.sv"
analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/abs_comparator.sv"
analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/barrel_shifter.sv"

analyze -library WORK -format sverilog "$rtl_dir/add/fractural_FPAdd.sv"
run_synth_common "FPAdd" "fractural_FPAdd"




puts "--- Task 18: fractural Add only---"
remove_design -all
analyze -library WORK -format vhdl "$rtl_dir/utils.vhdl"

analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/fpall_pkg.sv"
analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/normalizer.sv"
analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/abs_comparator.sv"
analyze -library WORK -format sverilog "$rtl_dir/src_shared_combine_sv/utils/barrel_shifter.sv"

analyze -library WORK -format sverilog "$rtl_dir/add/fractural_FPAdd.sv"
run_synth_common "FPAdd" "fractural_FPAdd"




exit


