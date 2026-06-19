# ======================================================================
# DC script: synthesize abs_comparator standalone (area measurement)
#
# Usage (from synopsysDC/):
#   dc_shell -f sweep/no_retime/run_abs_comparator.tcl
#   TOP=abs_comparator_origin dc_shell -f sweep/no_retime/run_abs_comparator.tcl
#   TOP=abs_comparator_only   dc_shell -f sweep/no_retime/run_abs_comparator.tcl
#
# TOP variants (default: abs_comparator):
#   abs_comparator         - segmented subtraction (production)
#   abs_comparator_origin  - naive comparator
#   abs_comparator_only    - FP32-only comparator
# ======================================================================
set_host_options -max_cores 8

remove_design -all

if {[info exists env(TOP)]} {
    set top $env(TOP)
} else {
    set top abs_comparator
}

set valid_tops {abs_comparator abs_comparator_origin abs_comparator_only}
if {[lsearch -exact $valid_tops $top] < 0} {
    puts "ERROR: unknown TOP=$top (valid: $valid_tops)"
    exit 1
}

set tag [clock format [clock seconds] -format "%m%d-%H%M"]
set sweep_root "sweep_run/no_retime"
file mkdir $sweep_root
set run_dir [file normalize "$sweep_root/run-${top}-${tag}"]
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

analyze -library WORK -format sverilog "$v2_dir/fpall_pkg.sv"
analyze -library WORK -format sverilog "$v2_dir/utils/abs_comparator.sv"

elaborate $top -library WORK

link
check_design
set_max_area 0

# Combinational block: no clock constraints
compile_ultra -no_autoungroup -no_boundary_optimization

# ----------------------------------------------------------------------
# Reports
# ----------------------------------------------------------------------
set bus_inference_style "%s\[%d\]"
set bus_naming_style "%s\[%d\]"
set hdlout_internal_busses true
change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed "a-z A-Z 0-9 _" -max_length 255 -type cell
define_name_rules name_rule -allowed "a-z A-Z 0-9 _[]" -max_length 255 -type net
define_name_rules name_rule -map {{"\*cell\*" "cell"}}
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule

write -format verilog -hierarchy -output "$run_dir/post-synth.v"
report_area  -hierarchy > "$run_dir/area.rpt"
report_power            > "$run_dir/power.rpt"
report_timing           > "$run_dir/timing.rpt"
report_reference        > "$run_dir/reference.rpt"

set area 0.0
set leaf_cells 0

if {[file exists "$run_dir/area.rpt"]} {
    set fp [open "$run_dir/area.rpt" r]
    while {[gets $fp line] >= 0} {
        if {[regexp {Total cell area:\s+([0-9\.]+)} $line match val]} {
            set area $val
        }
        if {[regexp {Leaf Cell Count:\s+([0-9]+)} $line match val]} {
            set leaf_cells $val
        }
    }
    close $fp
}

puts "========================================"
puts "Done $top"
puts "  Run dir     : $run_dir"
puts "  Total area  : $area"
puts "  Leaf cells  : $leaf_cells"
puts "  Area report : $run_dir/area.rpt"
puts "========================================"

exit
