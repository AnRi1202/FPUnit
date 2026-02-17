set cell_lib "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"
set search_path "$cell_lib/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set target_library [list $cell_lib/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db]
set link_library $target_library

analyze -library WORK -format vhdl "../src/rtl/v2_bf16_full/utils.vhdl"
analyze -library WORK -format sverilog "../src/rtl/v1_area_opt/area_opt_ret.sv"
elaborate area_opt_ret -library WORK -parameters "PARAM_PIPE_AM=1, PARAM_PIPE_DS=1"
link

echo "--- Reporting dont_touch Designs ---"
foreach_in_collection d [get_designs *] {
    if {[get_attribute $d dont_touch] == "true"} {
        echo "[DT] [design] [get_object_name $d]"
    }
}

echo "--- Reporting dont_touch Cells (Top 50) ---"
set count 0
foreach_in_collection c [get_cells -hierarchical *] {
    if {[get_attribute $c dont_touch] == "true"} {
        echo "[DT] [cell] [get_object_name $c] [get_attribute $c ref_name]"
        incr count
        if {$count > 50} { break }
    }
}
echo "Total DT cells found in search: $count"

exit
