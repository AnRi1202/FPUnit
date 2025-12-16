#####################################################
# PrimeTime Script for Flopoco Div/Sqrt Sweep
#####################################################

set power_enable_analysis TRUE   
set_app_var power_enable_analysis true
set power_analysis_mode averaged
set clock_name clk

# Libraries
set cell_lib "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"
set search_path "$cell_lib/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set link_path "* $cell_lib/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db"

set frequencies {500 1000 1500 2000}
set entities {div sqrt}

set summary_file "output/summary_primetime.rpt"
set f_sum [open $summary_file w]
puts $f_sum "Freq(MHz) | Div Power(mW) | Sqrt Power(mW) | Total Power(mW)"
close $f_sum

foreach freq $frequencies {
    puts "Processing Frequency: $freq MHz"
    set total_pwr_at_freq 0.0
    array set pwr_map {}

    foreach ent $entities {
        set design_name "${ent}_${freq}"
        set netlist_file "../../synopsysDC/output/${design_name}.v"
        set sdc_file "../../synopsysDC/output/${design_name}.sdc"
        
        if {![file exists $netlist_file]} {
            puts "Error: Netlist $netlist_file not found. Skipping."
            set pwr_map($ent) 0.0
            continue
        }

        # Clean previous design
        remove_design -all

        # Read Netlist
        read_verilog $netlist_file
        # Link
        # Note: We need to know the top module name. 
        # Since we cannot easily grep Tcl-side without exec, and we know DC preserves hierarchy or uses the entity name.
        # We will assume the entity name is the top module name.
        # We need to find the entity name again from the source or trust DC output.
        # Let's try to link current design (last read).
        current_design
        link_design

        # Source SDC
        source $sdc_file
        
        # Timing Analysis
        set_propagate_clock [get_clocks $clock_name]
        update_timing
        report_timing > output/${design_name}_timing.rpt

        # Power Analysis
        # Set default switching activity if no VCD/SAIF
        set power_default_toggle_rate 0.1 
        set power_default_static_probability 0.5
        
        # Disable timing on reset if it exists
        if {[sizeof_collection [get_ports -quiet rst]] > 0} {
            set_case_analysis 0 rst
            set_false_path -from rst
        } elseif {[sizeof_collection [get_ports -quiet rst_n]] > 0} {
             set_case_analysis 0 rst_n
             set_false_path -from rst_n
        }

        check_power
        update_power
        report_power -nosplit -hierarchy > output/${design_name}_power.rpt
        
        # Parse Power
        set pwr 0.0
        set fp [open "output/${design_name}_power.rpt" r]
        while {[gets $fp line] >= 0} {
             if {[regexp {Total Dynamic Power\s+=\s+([0-9\.eE+-]+)\s+(\w+)} $line match p_val unit]} {
                 # Normalize units if needed. Assuming report_power output is consistent (usually W or mW depending on libs)
                 # Nangate usually reports in W or mW. 
                 # Let's assume the value is what we want or just log it.
                 # Actually, let's just grab the number.
                 set pwr $p_val
                 # Convert to mW if unit is W (basic check)
                 if {$unit == "W"} { set pwr [expr $pwr * 1000.0] }
                 if {$unit == "uW"} { set pwr [expr $pwr / 1000.0] }
             }
        }
        close $fp
        set pwr_map($ent) $pwr
    }
    
    set total_pwr_at_freq [expr $pwr_map(div) + $pwr_map(sqrt)]
    
    set f_sum [open $summary_file a]
    puts $f_sum "$freq | $pwr_map(div) | $pwr_map(sqrt) | $total_pwr_at_freq"
    close $f_sum
}

exit

