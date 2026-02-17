#----------------------------------------------------------------------------------------------#
#--------------------------------- Set up environment -----------------------------------------#
#----------------------------------------------------------------------------------------------#
set_host_options -max_cores 8 

# Libraries in search_path will be prioritized
set cell_lib "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"
set ROOT ".."

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
set run_dir "run-$VER-$TASK-$tag"

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
    elaborate $entity_name -library WORK
    # # for sv
    # elaborate $entity_name -library WORK
    
    link

    check_design

    # Constraints 
    set_max_area 0
    set main_clock_period 0.5 
    create_clock -name clk -period $main_clock_period [get_ports clk]
    
    set input_ports [remove_from_collection [all_inputs] [get_ports clk]]
    set_input_delay 0.1 -clock clk $input_ports
    
    set output_ports [all_outputs]
    set_output_delay 0.1 -clock clk $output_ports
    
    set_input_transition 0.05 [remove_from_collection [all_inputs] [get_ports clk]]
    set_load 0.1 [all_outputs]

    # set_max_delay 1000 -from [all_inputs] -to [all_outputs]
    # Compile
    compile_ultra 
    


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
    
    set dat "N/A"
    
    if {[file exists $rpt_time]} {
         set fp [open $rpt_time r]
         while {[gets $fp line] >= 0} {
              if {[regexp {data arrival time\s+([0-9\.\-]+)} $line match val]} {
                  set dat $val
              }
         }
         close $fp
    }
    
    set f [open $rpt_file a]
    puts $f "$label,$area,$leak_power,$dyn_power,$dat"
    close $f
    puts "Done $label: Area=$area, DAT=$dat"
   # ==============================
   # summarize csv
   # =============================== 
}

proc run_synth_common_param {entity_name label params} {
    global rpt_file run_dir
    elaborate $entity_name -library WORK -parameters $params
    
    link
    set_max_area 0
    set main_clock_period 0.5 
    create_clock -name clk -period $main_clock_period [get_ports clk]
    
    set input_ports [remove_from_collection [all_inputs] [get_ports clk]]
    set_input_delay 0.1 -clock clk $input_ports
    
    set output_ports [all_outputs]
    set_output_delay 0.1 -clock clk $output_ports
    
    set_input_transition 0.05 [remove_from_collection [all_inputs] [get_ports clk]]
    set_load 0.1 [all_outputs]
    
    compile_ultra -no_autoungroup -no_boundary_optimization
    
    set rpt_dir "$run_dir/report/new" 
    set out_dir "$run_dir/output/new"
    set rpt_area "$rpt_dir/${label}_area.rpt"
    set rpt_pwr "$rpt_dir/${label}_power.rpt"
    set rpt_time "$rpt_dir/${label}_timing.rpt"
    set rpt_ref "$rpt_dir/${label}_reference.rpt"

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

    write -format verilog -hierarchy -output $out_dir/post-synth.v
    write -format ddc     -hierarchy -output $out_dir/post-synth.ddc
    write_sdc -nosplit $out_dir/post-synth.sdc
    write_sdf $out_dir/post-synth.sdf

    report_area -hierarchy > $rpt_area
    report_power > $rpt_pwr
    report_timing > $rpt_time
    report_reference > $rpt_ref

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
    
    set dat "N/A"
    
    if {[file exists $rpt_time]} {
         set fp [open $rpt_time r]
         while {[gets $fp line] >= 0} {
              if {[regexp {data arrival time\s+([0-9\.\-]+)} $line match val]} {
                  set dat $val
              }
         }
         close $fp
    }
    
    set f [open $rpt_file a]
    puts $f "$label,$area,$leak_power,$dyn_power,$dat"
    close $f
    puts "Done $label: Area=$area, DAT=$dat"
}

proc run_synth_retime {entity_name label} {
    global rpt_file run_dir
    # # for vhdl
    elaborate $entity_name -library WORK
    # # for sv
    # elaborate $entity_name -library WORK
    
    link

    check_design

    # ----------------------------------------------------------------------
    # Clocks & Constraints
    # ----------------------------------------------------------------------
    set main_clock_period 0.5
    create_clock -name clk -period $main_clock_period [get_ports clk]

    set input_ports [remove_from_collection [all_inputs] [get_ports clk]]
    set_input_delay 0.1 -clock clk $input_ports
    
    set output_ports [all_outputs]
    set_output_delay 0.1 -clock clk $output_ports
    
    set_input_transition 0.05 [remove_from_collection [all_inputs] [get_ports clk]]
    set_load 0.1 [all_outputs]

    # ----------------------------------------------------------------------
    # RETIMING: high-effort compile with retime enabled
    # ----------------------------------------------------------------------
    compile_ultra -retime 

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
    
    set dat "N/A"
    
    if {[file exists $rpt_time]} {
         set fp [open $rpt_time r]
         while {[gets $fp line] >= 0} {
              if {[regexp {data arrival time\s+([0-9\.\-]+)} $line match val]} {
                  set dat $val
              }
         }
         close $fp
    }
    
    set f [open $rpt_file a]
    puts $f "$label,$area,$leak_power,$dyn_power,$dat"
    close $f
    puts "Done $label: Area=$area, DAT=$dat"
}

proc analyze_filelist {filelist_path format} {
    global ROOT
    if {![file exists $filelist_path]} {
        puts "Error: Filelist not found at $filelist_path"
        return
    }
    puts ">>> Reading filelist: $filelist_path"
    set fp [open $filelist_path r]
    while {[gets $fp line] >= 0} {
        set line [string trim $line]
        # Skip empty lines and comments
        if {$line == "" || [string match "#*" $line] || [string match "//*" $line]} {
            continue
        }
        # Resolve $ROOT if present
        regsub -all {\$ROOT} $line $ROOT line
        
        puts "  Analyzing: $line"
        if {[catch {analyze -library WORK -format $format $line} msg]} {
            puts "  Warning: Failed to analyze $line: $msg"
        }
    }
    close $fp
}

#----------------------------------------------------------------------------------------------#
#--------------------------------- CHOOSE DESIGNS     -----------------------------------------#
#----------------------------------------------------------------------------------------------#

# #########################     Original     ################################################# 
set origin_dir "$ROOT/src/rtl/original"
set rtl_dir "$ROOT/src/rtl"
# Task 1: Baseline FPAdd
if {$TASK == "all" || $TASK == "1" || $TASK == "FPAdd_VHDL"} {
    puts "--- Task 1: FPAdd ---"
    remove_design -all
    analyze -library WORK -format vhdl "$origin_dir/FPAdd_Kin_f1_origin.vhdl"
    run_synth_common "FPAdd_8_23_Freq1_uid2" "FPAdd_VHDL"
}
if {$TASK == "all" || $TASK == "1_1" || $TASK == "FPAdd_VHDL"} {
    puts "--- Task 1_1: FPAdd f100 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f100/fpadd_f100.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f100/fpadd_bf16_f100.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f100/f100_fracadd_origin.vhdl"
    run_synth_common "f100_fracadd_origin" "FPAdd_f100_VHDL"
}
if {$TASK == "all" || $TASK == "1_2" || $TASK == "FPAdd_VHDL"} {
    puts "--- Task 1_2: FPAdd f200 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f200/fpadd_f200.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f200/fpadd_bf16_f200.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f200/f200_fracadd_origin.vhdl"
    run_synth_common "f200_fracadd_origin" "FPAdd_f200_VHDL"
}
if {$TASK == "all" || $TASK == "1_3" || $TASK == "FPAdd_VHDL"} {
    puts "--- Task 1_3: FPAdd f300 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f300/fpadd_f300.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f300/fpadd_bf16_f300.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f300/f300_fracadd_origin.vhdl"
    run_synth_common "f300_fracadd_origin" "FPAdd_f300_VHDL"
}
if {$TASK == "all" || $TASK == "1_4" || $TASK == "FPAdd_VHDL"} {
    puts "--- Task 1_4: FPAdd f400 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f400/fpadd_f400.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f400/fpadd_bf16_f400.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f400/f400_fracadd_origin.vhdl"
    run_synth_common "f400_fracadd_origin" "FPAdd_f400_VHDL"
}
if {$TASK == "all" || $TASK == "1_5" || $TASK == "FPAdd_VHDL"} {
    puts "--- Task 1_5: FPAdd f500 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f500/fpadd_f500.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f500/fpadd_bf16_f500.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f500/f500_fracadd_origin.vhdl"
    run_synth_common "f500_fracadd_origin" "FPAdd_f500_VHDL"
}
if {$TASK == "all" || $TASK == "1_6" || $TASK == "FPAdd_VHDL"} {
    puts "--- Task 1_6: FPAdd f600 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f600/fpadd_f600.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f600/fpadd_bf16_f600.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f600/f600_fracadd_origin.vhdl"
    run_synth_common "f600_fracadd_origin" "FPAdd_f600_VHDL"
}

# Task 2: Baseline FPMult
if {$TASK == "all" || $TASK == "2" || $TASK == "FPMult"} {
    puts "--- Task 2: FPMult ---"
    remove_design -all
    analyze -library WORK -format vhdl "$origin_dir/FPMult_Kin_f1_origin.vhdl"
    run_synth_common "FPMult_8_23_uid2_Freq1_uid3" "FPMult"
}
if {$TASK == "all" || $TASK == "2_1" || $TASK == "FPMult"} {
    puts "--- Task 2_1: FPMult f100 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f100/fpmult_f100.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f100/fpmult_bf16_f100.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f100/f100_fracmult_origin.vhdl"
    run_synth_common "f100_fracmult_origin" "FPMult_f100_VHDL"
}
if {$TASK == "all" || $TASK == "2_2" || $TASK == "FPMult"} {
    puts "--- Task 2_2: FPMult f200 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f200/fpmult_f200.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f200/fpmult_bf16_f200.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f200/f200_fracmult_origin.vhdl"
    run_synth_common "f200_fracmult_origin" "FPMult_f200_VHDL"
}
if {$TASK == "all" || $TASK == "2_3" || $TASK == "FPMult"} {
    puts "--- Task 2_3: FPMult f300 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f300/fpmult_f300.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f300/fpmult_bf16_f300.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f300/f300_fracmult_origin.vhdl"
    run_synth_common "f300_fracmult_origin" "FPMult_f300_VHDL"
}
if {$TASK == "all" || $TASK == "2_4" || $TASK == "FPMult"} {
    puts "--- Task 2_4: FPMult f400 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f400/fpmult_f400.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f400/fpmult_bf16_f400.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f400/f400_fracmult_origin.vhdl"
    run_synth_common "f400_fracmult_origin" "FPMult_f400_VHDL"
}
if {$TASK == "all" || $TASK == "2_5" || $TASK == "FPMult"} {
    puts "--- Task 2_5: FPMult f500 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f500/fpmult_f500.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f500/fpmult_bf16_f500.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f500/f500_fracmult_origin.vhdl"
    run_synth_common "f500_fracmult_origin" "FPMult_f500_VHDL"
}
if {$TASK == "all" || $TASK == "2_6" || $TASK == "FPMult"} {
    puts "--- Task 2_6: FPMult f600 ---"
    remove_design -all
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f600/fpmult_f600.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f600/fpmult_bf16_f600.vhdl"
    analyze -library WORK -format vhdl "$ROOT/src/rtl/base_f600/f600_fracmult_origin.vhdl"
    run_synth_common "f600_fracmult_origin" "FPMult_f600_VHDL"
}

# Task 3: Baseline FPDiv
if {$TASK == "all" || $TASK == "3" || $TASK == "FPDiv"} {
    puts "--- Task 3: FPDiv ---"
    remove_design -all
    analyze -library WORK -format vhdl "$origin_dir/FPDiv_Kin_f1_origin.vhdl"
    run_synth_common "FPDiv_8_23_Freq1_uid2" "FPDiv"
}

# Task 4: Baseline FPSqrt
if {$TASK == "all" || $TASK == "4" || $TASK == "FPSqrt"} {
    puts "--- Task 4: FPSqrt ---"
    remove_design -all
    analyze -library WORK -format vhdl "$origin_dir/FPSqrt_Kin_f1_origin.vhdl"
    run_synth_common "FPSqrt_8_23" "FPSqrt"
}


# Task 5: Baseline addmul_only
if {$TASK == "all" || $TASK == "5"} {
    puts "--- Task 5: Addmul_only ---"
    remove_design -all
    analyze -library WORK -format vhdl "$origin_dir/FPAdd_Kin_f1_origin.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/FPMult_Kin_f1_origin.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/FPALL_origin.vhdl"
    run_synth_common_param "FPALL_origin" "fpaddmul_only_origin" "NUM_OPS=2"
}

# Task 6: Baseline FPALL
if {$TASK == "all" || $TASK == "6"} {
    puts "--- Task $TASK: FPALL ---"
    remove_design -all
    analyze -library WORK -format vhdl "$origin_dir/FPAdd_Kin_f1_origin.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/FPMult_Kin_f1_origin.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/FPDiv_Kin_f1_origin.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/FPSqrt_Kin_f1_origin.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/FPALL_origin.vhdl"
    run_synth_common_param "FPALL_origin" "FPALL_origin" "NUM_OPS=4"
}

# Task 7: utils 
if {$TASK == "all" || $TASK == "7"} {
    puts "--- Task 7: utils---"
    remove_design -all
    analyze -library WORK -format verilog "$rtl_dir/v2_bf16_full/utils/barrel_shifter.sv"
    run_synth_common "barrel_shifter" "barrel_shifter"
}
# Task 8: utils 
if {$TASK == "all" || $TASK == "8"} {
    puts "--- Task 7: utils---"
    remove_design -all
    analyze -library WORK -format verilog "$rtl_dir/v2_bf16_full/utils/normalizer.sv"
    run_synth_common "normalizer" "normalizer"
}

# Task 9: Baseline FPALL_6op
if {$TASK == "all" || $TASK == "9"} {
    puts "--- Task $TASK: FPALL_6op ---"
    remove_design -all
    analyze -library WORK -format vhdl "$origin_dir/FPAdd_Kin_f1_origin.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/FPMult_Kin_f1_origin.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/FPDiv_Kin_f1_origin.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/FPSqrt_Kin_f1_origin.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/fpadd_bf16_f1.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/fpmult_bf16_f1.vhdl"
    analyze -library WORK -format vhdl "$origin_dir/FPALL_origin.vhdl"
    run_synth_common_param "FPALL_origin" "fpall_6op_origin" "NUM_OPS=6"
}



########################  v_  ####################################

set rtl_pkg    "$ROOT/src/rtl/v2_bf16_full/fpall_pkg.sv"
set vhdl_utils_base "$ROOT/src/rtl/v2_bf16_full/utils.vhdl"


# Task 20: Synthesis by Version Filelist
if {$TASK == "all" || $TASK == "0"} {
    remove_design -all
    # From common baseline (v2_bf16_full) if different
    analyze -library WORK -format vhdl $vhdl_utils_base
    analyze -library WORK -format sverilog $rtl_pkg

    if {[file exists "$ROOT/simulation/filelists/${VER}_sv.f"]} {
        analyze_filelist "$ROOT/simulation/filelists/${VER}_sv.f" sverilog
    }

    if {[file exists "$ROOT/simulation/filelists/${VER}_vhdl.f"]} {
        analyze_filelist "$ROOT/simulation/filelists/${VER}_vhdl.f" vhdl
    }
   
    if {[info exists env(RETIME)] && $env(RETIME) == "1"} {
        puts ">>> Running synthesis with Retiming flow"
        run_synth_retime "$TOP" "$TOP"
    } else {
        run_synth_common "$TOP" "$TOP"
    }
}

exit
