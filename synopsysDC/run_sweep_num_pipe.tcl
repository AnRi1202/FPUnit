# ======================================================================
# DC sweep script: Loop num_pipe 1 to 17
# Modified from ret.tcl to automate PPA data collection
# ======================================================================
set_host_options -max_cores 8

# Output CSV file
set csv_filename "ppa_sweep_results.csv"
set csv_file [open $csv_filename w]
puts $csv_file "num_pipe,total_area,data_arrival_time"
close $csv_file

# ----------------------------------------------------------------------
# Libraries and Setup (copied from ret.tcl)
# ----------------------------------------------------------------------
set cell_lib "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"
set search_path ". $search_path $cell_lib/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"

set target_library [list \
    $cell_lib/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db \
    /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db \
    /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db \
    /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db \
    /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db ]

set link_library "* $target_library"

set v1_dir "../src/rtl/v1_area_opt"
set original_dir "../src/rtl"

# ----------------------------------------------------------------------
# Sweep Loop
# ----------------------------------------------------------------------
for {set p 1} {$p <= 17} {incr p} {
    puts "=========================================================="
    puts "STARTING SYNTHESIS FOR num_pipe = $p"
    puts "=========================================================="
    
    remove_design -all
    
    # Prepare directories for this run
    set run_dir "run_sweep_pipe${p}"
    set work_dir "${run_dir}/WORK"
    file mkdir $run_dir
    file mkdir $work_dir
    
    define_design_lib WORK -path $work_dir
    set_app_var alib_library_analysis_path $work_dir
    
    # Analyze supporting VHDL components (FloPoCo-generated primitives)
    analyze -library WORK -format vhdl "$original_dir/v2_bf16_full/utils.vhdl"
    
    # Analyze the specific piped version
    analyze -library WORK -format sverilog "$v1_dir/pipe/area_opt_${p}.sv"
    
    # Elaborate top-level
    elaborate area_opt -library WORK
    
    link
    check_design
    
    # ------------------------------------------------------------------
    # Constraints (consistent with ret.tcl)
    # ------------------------------------------------------------------
    set main_clock_period 0.5
    create_clock -name clk -period $main_clock_period [get_ports clk]
    
    set inputs_no_clk [remove_from_collection [all_inputs] [get_ports clk]]
    set_input_delay -clock clk 0.20 $inputs_no_clk
    set_output_delay -clock clk 0.20 [all_outputs]
    set_input_transition 0.20 $inputs_no_clk
    set_load 0.1 [all_outputs]
    set_max_area 0
    
    # ------------------------------------------------------------------
    # Synthesis with Retiming
    # ------------------------------------------------------------------
    set_app_var compile_enable_register_merging true
    set_app_var compile_sequential_area_recovery true
    set_optimize_registers true
    compile_ultra -retime
    
    # ------------------------------------------------------------------
    # Data Collection
    # ------------------------------------------------------------------
    
    # Extract total area
    current_design area_opt
    set area_val [get_attribute [current_design] total_area]
    # Extract max arrival time (critical path)
    set timing_path [get_timing_paths -delay_type max -max_paths 1]
    set arrival_time [get_attribute $timing_path arrival]
    
    # Append to CSV
    set csv_file [open $csv_filename a]
    puts $csv_file "${p},${area_val},${arrival_time}"
    close $csv_file
    
    # Save reports for verification
    report_area -hierarchy > "${run_dir}/area.rpt"
    report_timing -delay_type max > "${run_dir}/timing.rpt"
    
    puts "COMPLETED num_pipe = $p: Area=$area_val, Max Arrival=$arrival_time"
}

puts "=========================================================="
puts "Sweep finished. Results saved to $csv_filename"
puts "=========================================================="
exit
