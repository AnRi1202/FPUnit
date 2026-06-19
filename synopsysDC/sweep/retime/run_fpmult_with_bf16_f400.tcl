# ======================================================================
# DC script: FPMult (retimed IntMult) + BF16 Mul x2  --  Freq400
# ======================================================================
set_host_options -max_cores 8
remove_design -all

set main_clock_period 0.5

set sweep_root "sweep_run/retime"
file mkdir $sweep_root
set run_dir  "$sweep_root/run-fpmult_with_bf16_f400"
set WORK_DIR "${run_dir}/WORK"
file mkdir $run_dir
file mkdir $WORK_DIR

define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

set cell_lib "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"
set search_path "$cell_lib/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set link_library "[list \
    $cell_lib/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db \
    /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_6baddress_lib.db \
    /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_7baddress_lib.db \
    /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_8baddress_lib.db \
    /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_9baddress_lib.db]"
set target_library $link_library

# Analyze VHDL sources
analyze -library WORK -format vhdl "../src/rtl/base_f400/fpmult_f400_nomult.vhdl"
analyze -library WORK -format vhdl "../src/rtl/base_f400/fpmult_bf16_f400.vhdl"
analyze -library WORK -format vhdl "../src/rtl/base_f400/f400_fpmult_with_bf16.vhdl"

# Read retimed IntMult netlist
read_file -format verilog "./intmult_f400_ret.v"

elaborate f400_fpmult_with_bf16
link
check_design
set_max_area 0

# Constraints
create_clock -name clk -period $main_clock_period [get_ports clk]
set inputs_no_clk [remove_from_collection [all_inputs] [get_ports clk]]
set_input_delay      -clock clk 0.1 $inputs_no_clk
set_output_delay     -clock clk 0.1 [all_outputs]
set_input_transition 0.05 $inputs_no_clk
set_load 0.1 [all_outputs]

# Compile
compile_ultra

# Reports
report_area     -hierarchy > $run_dir/area.rpt
report_timing   -delay_type max -max_paths 1 > $run_dir/timing_setup.rpt
report_register             > $run_dir/registers.rpt
exit
