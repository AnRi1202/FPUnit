set_message -no_limit 
setDesignMode -process 45

# supress warnings 
suppressMessage IMPLF-200
suppressMessage IMPFP-3961
suppressMessage TECHLIB-436
suppressMessage TECHLIB-302
suppressMessage IMPEXT-2766
suppressMessage IMPEXT-2882
suppressMessage IMPEXT-2776
suppressMessage IMPEXT-2773
suppressMessage IMPEXT-6197
suppressMessage IMPEXT-3493
suppressMessage IMPDC-1629
suppressMessage TA-146
suppressMessage TA-112
suppressMessage TA-113

set init_design_uniquify 1
set init_lef_file {
    "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/Back_End/lef/NangateOpenCellLibrary.lef"
}

set init_pwr_net   "VDD"
set init_gnd_net   "VSS"

set frequencies {500 1000 1500 2000}
set entities {div sqrt}

set summary_file "output/summary_innovus.rpt"
set f_sum [open $summary_file w]
puts $f_sum "Freq(MHz) | Entity | Area(um2) | Power(mW) | WNS(ns)"
close $f_sum

# Helper to get entity name
proc get_entity_name {file_path} {
    if {[catch {exec grep -i "entity" $file_path | head -1 | awk "{print \$2}"} ent_name]} {
        return "UNKNOWN"
    }
    return $ent_name
}

foreach freq $frequencies {
    foreach ent $entities {
        set design_name "${ent}_${freq}"
        set verilog_file "../../synopsysDC/output/${design_name}.v"
        set sdc_file "../../synopsysDC/output/${design_name}.sdc"
        
        if {![file exists $verilog_file]} {
            puts "Error: $verilog_file not found. Skipping."
            continue
        }

        # Create temporary MMMC file
        set mmmc_file "mmmc_${design_name}.tcl"
        set f [open $mmmc_file w]
        
        set cell_lib "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"
        set lib_file "$cell_lib/Front_End/Liberty/CCS/NangateOpenCellLibrary_typical_ccs.lib"
        set cap_tbl "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/captables/captables/NCSU_FreePDK_45nm.capTbl"

        puts $f "create_rc_corner -name cap_libs -cap_table \"$cap_tbl\" -T 25"
        puts $f "create_library_set -name timing_libs -timing \[list \"$lib_file\"\]"
        puts $f "create_delay_corner -name delay_corner -library_set timing_libs -opcond typical -opcond_library NangateOpenCellLibrary -rc_corner cap_libs"
        puts $f "create_constraint_mode -name constraints -sdc_files \[list \"$sdc_file\"\]"
        puts $f "create_analysis_view -name analysis_view  -delay_corner delay_corner  -constraint_mode constraints"
        puts $f "set_analysis_view   -setup analysis_view   -hold analysis_view"
        puts $f "set_default_view -setup analysis_view -hold analysis_view"
        close $f

        set init_mmmc_file $mmmc_file
        set init_verilog $verilog_file
        
        # Determine Top Cell Name
        if {$ent == "div"} {
             set vhdl_file "../../src/FPDiv_FPSqrt_frequency=${freq}_wE=8_wF=23_FPDiv.vhdl"
        } else {
             set vhdl_file "../../src/FPDiv_FPSqrt_frequency=${freq}_wE=8_wF=23_FPSqrt.vhdl"
        }
        
        set init_top_cell [get_entity_name $vhdl_file]
        
        puts "Initializing Design: $init_top_cell for $freq MHz"
        init_design
        
        # Floorplan
        source basic_fp.tcl
        
        # Power Ring & Route
        globalNetConnect VDD -type pgpin -pin VDD -all
        globalNetConnect VSS -type pgpin -pin VSS -all
        globalNetConnect VDD -type tiehi
        globalNetConnect VSS -type tielo
        
        # Add Ring (Simplified)
        addRing -nets {VDD VSS} -type core_rings -follow core -layer {top M1 bottom M1 left M2 right M2} -width 1.2 -spacing 1.2 -offset 1.2
        sroute -nets {VDD VSS}
        
        # Place
        setPlaceMode -place_global_solver_effort high
        place_opt_design -prefix place
        
        # Route
        setNanoRouteMode  -quiet -routeTdrEffort 5
        routeDesign -globalDetail
        
        # Opt
        optDesign -postRoute -incr
        
        # Add Filler
        setFillerMode -quiet
        addFiller -cell FILL_NW_LL FILL_NW_HH FILL_NW_FA_LL FILL8 FILL64 FILL4 FILL32 FILL2 FILL1_LL FILL16 FILL1 -prefix FILLER

        # Reports
        report_area > output/area_${design_name}.rpt
        report_power -hierarchy all -o output/power_${design_name}.rpt
        report_timing > output/timing_${design_name}.rpt
        
        # Get Data for Summary
        set area [get_metric -metric {design.area}]
        # Innovus returns area in metric struct, or we can parse file. 
        # get_metric is cleaner if available in this version.
        
        # Power
        set pwr "N/A"
        # Parse power file
        set fp_p [open "output/power_${design_name}.rpt" r]
        while {[gets $fp_p line] >= 0} {
             if {[regexp {Total Power\s+:\s+([0-9\.]+)\s+mW} $line match val]} {
                 set pwr $val
             }
        }
        close $fp_p
        
        # Timing (WNS)
        set wns "N/A"
        # Parse timing file
        set fp_t [open "output/timing_${design_name}.rpt" r]
        while {[gets $fp_t line] >= 0} {
             if {[regexp {Slack:\s+(=)?\s*([0-9\.\-]+)} $line match dummy val]} {
                 set wns $val
                 break
             }
        }
        close $fp_t
        
        set f_sum [open $summary_file a]
        puts $f_sum "$freq | $ent | $area | $pwr | $wns"
        close $f_sum
        
        # Cleanup
        freeDesign
        exec rm $mmmc_file
    }
}

exit

