
# ======================================================================
# DC script to measure pure combinatorial delay (DAT) and Area
# ======================================================================
set_host_options -max_cores 8
remove_design -all

# --- Configuration ---
set main_clock_period 100.0 ;# Large period
set tag [clock format [clock seconds] -format "%m%d-%H%M"]
set run_dir [file normalize "run-comb-measure-${tag}"]
set WORK_DIR [file normalize "${run_dir}/WORK"]

file mkdir $run_dir
file mkdir $WORK_DIR
define_design_lib WORK -path $WORK_DIR

# --- Libraries ---
set cell_lib "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db"
set link_library [list $cell_lib]
set target_library $link_library

# --- Procedure to measure a design ---
proc measure_design {label files top_level {params ""}} {
    global run_dir WORK_DIR main_clock_period
    
    puts "\n\n"
    puts "****************************************************"
    puts "* MEASURING: $label (Top: $top_level)"
    puts "****************************************************"
    
    remove_design -all
    foreach f $files {
        if {[string match "*.vhdl" $f] || [string match "*.vhd" $f]} {
            analyze -format vhdl -library WORK $f
        } else {
            analyze -format sverilog -library WORK $f
        }
    }
    
    # Try elaborate
    set elab_cmd "elaborate $top_level -library WORK"
    if {$params != ""} { append elab_cmd " -parameters \"$params\"" }
    
    if {[catch {eval $elab_cmd} err]} {
        puts "ERROR ELABORATING $top_level: $err"
        return [list "Error" "Error"]
    }
    
    current_design $top_level
    link
    
    # Constraints: Define a clock if clk port exists to enable standard reporting
    if {[get_ports -quiet clk] != ""} {
        create_clock -name clk -period $main_clock_period [get_ports clk]
        set_input_delay 0.0 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
        set_output_delay 0.0 -clock clk [all_outputs]
    } else {
        # Purely combinatorial with no clock port
        set_max_delay $main_clock_period -from [all_inputs] -to [all_outputs]
    }
    
    compile_ultra
    
    # Report timing and area
    set timing_rpt "${run_dir}/timing_${label}.rpt"
    set area_rpt   "${run_dir}/area_${label}.rpt"
    report_timing -from [all_inputs] -to [all_outputs] -max_paths 1 > $timing_rpt
    report_area > $area_rpt
    
    # Parse DAT from Timing Report
    set dat "N/A"
    if {[file exists $timing_rpt]} {
        set fp [open $timing_rpt r]
        while {[gets $fp line] >= 0} {
            if {[regexp {data arrival time\s+([\d\.]+)} $line match val]} {
                set dat $val
                break
            }
        }
        close $fp
    }

    # Parse Area from Area Report
    set area "N/A"
    if {[file exists $area_rpt]} {
        set fp [open $area_rpt r]
        while {[gets $fp line] >= 0} {
            if {[regexp {Total cell area:\s+([\d\.]+)} $line match val]} {
                set area $val
                break
            }
        }
        close $fp
    }

    puts "RESULT: Area=$area, DAT=$dat"
    return [list $area $dat]
}

# --- Design Definitions ---
set rtl_dir "../src/rtl"
set v2_full_dir "$rtl_dir/v2_bf16_full"
set utils_vhdl "$v2_full_dir/utils.vhdl"
set results {}

# --- 1. FloPoCo f1 Baselines (FP32 & BF16) ---
lappend results [list "FloPoCo_FP32_Add" [measure_design "flopoco_fp32_add" [list "$rtl_dir/original/FPAdd_Kin_f1_origin.vhdl"] "FPAdd_8_23_Freq1_uid2"]]
lappend results [list "FloPoCo_FP32_Mult" [measure_design "flopoco_fp32_mult" [list "$rtl_dir/original/FPMult_Kin_f1_origin.vhdl"] "FPMult_8_23_uid2_Freq1_uid3"]]
lappend results [list "FloPoCo_FP32_Div" [measure_design "flopoco_fp32_div" [list "$rtl_dir/original/FPDiv_Kin_f1_origin.vhdl"] "FPDiv_8_23_Freq1_uid2"]]
lappend results [list "FloPoCo_FP32_Sqrt" [measure_design "flopoco_fp32_sqrt" [list "$rtl_dir/original/FPSqrt_Kin_f1_origin.vhdl"] "FPSqrt_8_23"]]
lappend results [list "FloPoCo_BF16_Add" [measure_design "flopoco_bf16_add" [list "$rtl_dir/original/fpadd_bf16_f1.vhdl"] "_8_7_FreqFPAdd1_uid2"]]
lappend results [list "FloPoCo_BF16_Mult" [measure_design "flopoco_bf16_mult" [list "$rtl_dir/original/fpmult_bf16_f1.vhdl"] "FPMult_8_7_uid2_Freq1_uid3"]]

# --- 2. V1 (Original area_opt) Baselines ---
lappend results [list "V1_FP32_Add" [measure_design "v1_add" [list "$rtl_dir/v1_1_fp32_add/fp32_add.sv"] "fp32_add"]]
lappend results [list "V1_FP32_Mult" [measure_design "v1_mult" [list "$rtl_dir/v1_2_fp32_mult/fp32_mult.sv"] "fp32_mult"]]

# --- 3. V2 (BF16 Modular) Baselines ---
lappend results [list "V2.3_BF16_AddMul" [measure_design "v2.3_addmul" [list $utils_vhdl "$rtl_dir/v2_3_addmul_only/fpall_pkg.sv" "$rtl_dir/v2_3_addmul_only/addmul_only.sv"] "addmul_only"]]
lappend results [list "V2.4_BF16_DivSqrt" [measure_design "v2.4_divsqrt" [list $utils_vhdl "$rtl_dir/v2_4_divsqrt_only/fpall_pkg.sv" "$rtl_dir/v2_4_divsqrt_only/divsqrt_only.sv"] "divsqrt_only"]]

# --- 4. V3 (V1-based Modular) Baselines ---
lappend results [list "V3_FP32_AddMul" [measure_design "v3_addmul" [list "$rtl_dir/v3_addmul_only/addmul_only.sv"] "addmul_only"]]
lappend results [list "V3.1_FP32_DivSqrt" [measure_design "v3.1_divsqrt" [list "$rtl_dir/v3_1_divsqrt_only/divsqrt_only.sv"] "divsqrt_only"]]

# --- Final Output ---
set csv_file "comb_baseline_dat_area.csv"
set fp [open $csv_file w]
puts $fp "Module,Area,Combinatorial_DAT_ns"
foreach res $results {
    set label [lindex $res 0]
    set metrics [lindex $res 1]
    puts $fp "${label},[lindex $metrics 0],[lindex $metrics 1]"
}
close $fp

echo "Combinatorial measurement completed. Results summarized in $csv_file"
exit
