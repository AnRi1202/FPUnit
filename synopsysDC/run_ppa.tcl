proc pause {{msg "Press Enter to continue..."}} {
  puts -nonewline $msg
  flush stdout
  gets stdin
}
# Environment Setup
set_host_options -max_cores 8 

# Libraries
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

# =========================
# define folder structure
# ==========================
define_design_lib WORK -path ./WORK
# file mkdir output/new
# file mkdir report/new

set rpt_file "output_ppa/results_summary.csv"
set f [open $rpt_file w]
puts $f "Entity,TotalArea,LeakagePower,DynamicPower,Slack"
close $f

proc run_synth_common {entity_name label} {
    global rpt_file
    
    elaborate $entity_name -library WORK
    
    # Constraints 
    set_max_area 0
    # 1000 ns = 1 us 1MHz
    set main_clock_period 1000 
    set percentage_delay 0.10
    create_clock -name clock -period $main_clock_period [get_ports clk]
    
    set input_ports [remove_from_collection [all_inputs] [get_ports clk]]
    set_input_delay [expr $percentage_delay * $main_clock_period] -clock clock $input_ports
    set_input_transition [expr $percentage_delay * $main_clock_period] $input_ports
    
    set output_ports [all_outputs]
    set_output_delay [expr $percentage_delay * $main_clock_period] -clock clock $output_ports
    
    set_max_transition 1.0000 [current_design]
    set_max_capacitance 0.2000 [current_design]
    set_max_fanout 10.0000 [current_design]
    set_load 0.1 [all_outputs]


    # Compile
    compile_ultra -no_autoungroup -no_boundary_optimization
    
    set area 0.0
    set leak_power 0.0
    set dyn_power 0.0
    set slack "N/A"
    
    set rpt_area "output_ppa/${label}_area.rpt"
    set rpt_pwr "output_ppa/${label}_power.rpt"
    set rpt_time "output_ppa/${label}_timing.rpt"
    
    report_area -hierarchy > $rpt_area
    report_power > $rpt_pwr
    report_timing > $rpt_time
    
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
}

# Task 1: Baseline FPAdd
puts "--- Task 1: FPAdd ---"
remove_design -all
analyze -library WORK -format "./src/FPAdd_frequency=1_target=Kintex7_wE=8_wF=23_FPAdd"
run_synth_common "FPAdd_8_23_Freq1_uid2" "FPAdd"

# # Task 2: Baseline FPMult
# puts "--- Task 2: FPMult ---"
# remove_design -all
# analyze -library WORK -format vhdl "src/FPMult_frequency=1_target=Kintex7_wE=8_wF=23_FPMult.vhdl"
# run_synth_common "FPMult_8_23_uid2_Freq1_uid3" "FPMult"

# # Task 3: Shared FPAddMul
# puts "--- Task 3: Shared ---"
# remove_design -all
# analyze -library WORK -format vhdl "./src/FPAdd_frequency=1_target=Kintex7_wE=8_wF=23_FPAdd.vhdl"
# analyze -library WORK -format vhdl "./src/FPMult_frequency=1_target=Kintex7_wE=8_wF=23_FPMult.vhdl"
# analyze -library WORK -format vhdl "./src_shared/FPAdd_NoRA.vhdl"
# analyze -library WORK -format vhdl "./src_shared/FPMult_NoRA.vhdl"
# analyze -library WORK -format vhdl "./src_shared/FPAddMul_Shared.vhdl"
# run_synth_common "FPAddMul_Shared" "FPAddMul_Shared"

# # Task 4: Mux34
# puts "--- Task 4: Mux34 ---"
# remove_design -all
# # Use absolute path to stay safe
# analyze -library WORK -format vhdl "/fs1/eecg/janders/iderikut/dev/research/flopoco_synth/synopsysDC/src_shared/Mux34.vhdl"
# run_synth_common "Mux34" "Mux34"

# exit
