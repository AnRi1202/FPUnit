"""
Sweep script for FPMult (with retimed IntMult) + BF16 Mul x2 design.
Design = FP32 multiplier (two-pass retimed intmult) + BF16 Mul (upper lane) + BF16 Mul (lower lane)
Opcode:
  001: FP32 Mul
  101: BF16 Mul x2 (two lanes packed into 34-bit output)

For each frequency, this script:
  1. Generates a VHDL wrapper f{freq}_fpmult_with_bf16.vhdl
  2. Generates a TCL script that:
       - analyzes fpmult_f{freq}_nomult.vhdl + fpmult_bf16_f{freq}.vhdl
       - reads retimed intmult netlist intmult_f{freq}_ret.v
       - compiles the top-level wrapper
       - reports area, timing, registers
"""

import os
import subprocess
import sys
import re

frequencies = [300, 400, 500, 600]

base_rtl   = "/fs1/eecg/janders/iderikut/dev/research/flopoco_synth/src/rtl"
syn_dir    = "/fs1/eecg/janders/iderikut/dev/research/flopoco_synth/synopsysDC"
csv_file   = os.path.join(syn_dir, "sweep_summary_fpmult_with_bf16.csv")

CELL_LIB = "/autofs/fs1.ece/fs1.eecg.janders/bhilareo/form_files/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12"
MEM_LIBS  = " ".join([
    f"/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_{b}baddress_lib.db"
    for b in [6, 7, 8, 9]
])

# ─── VHDL wrapper template ─────────────────────────────────────────────────────
VHDL_TEMPLATE = """\
-- ===========================================================================
-- FPMult (retimed IntMult) + BF16 Mul x2 wrapper  (Freq{freq} MHz)
-- Opcode 001: FP32 Mul  (34-bit FloPoCo format)
-- Opcode 101: BF16 Mul  upper lane [33:16] & lower lane [15:0]
-- ===========================================================================
library ieee;
use ieee.std_logic_1164.all;

entity f{freq}_fpmult_with_bf16 is
    port (
        clk    : in  std_logic;
        opcode : in  std_logic_vector(2 downto 0);
        X      : in  std_logic_vector(33 downto 0);
        Y      : in  std_logic_vector(33 downto 0);
        R      : out std_logic_vector(33 downto 0)
    );
end entity;

architecture arch of f{freq}_fpmult_with_bf16 is
    -- FP32 Multiplier (nomult shell – IntMult provided as retimed netlist)
    component FPMult_8_23_uid2_Freq{freq}_uid3 is
        port (clk : in std_logic;
              X, Y : in  std_logic_vector(33 downto 0);
              R    : out std_logic_vector(33 downto 0));
    end component;

    -- BF16 Multiplier (9-bit mantissa, 8-bit exponent -> 18-bit FloPoCo format)
    component FPMult_8_7_uid2_Freq{freq}_uid3 is
        port (clk : in std_logic;
              X, Y : in  std_logic_vector(17 downto 0);
              R    : out std_logic_vector(17 downto 0));
    end component;

    signal fp32_R              : std_logic_vector(33 downto 0) := (others => '0');
    signal bfmul_h_R, bfmul_l_R : std_logic_vector(17 downto 0) := (others => '0');
    signal bf16_R              : std_logic_vector(33 downto 0) := (others => '0');
    signal X_bf_l, Y_bf_l     : std_logic_vector(17 downto 0);

begin
    -- FP32 Multiplier (retimed IntMult netlist merged via link)
    U_FP32MUL: FPMult_8_23_uid2_Freq{freq}_uid3
        port map (clk => clk, X => X, Y => Y, R => fp32_R);

    -- BF16 Lanes (upper = bits[33:16], lower = bits[15:0])
    X_bf_l <= "00" & X(15 downto 0);
    Y_bf_l <= "00" & Y(15 downto 0);

    U_BFMUL_H: FPMult_8_7_uid2_Freq{freq}_uid3
        port map (clk => clk, X => X(33 downto 16), Y => Y(33 downto 16), R => bfmul_h_R);
    U_BFMUL_L: FPMult_8_7_uid2_Freq{freq}_uid3
        port map (clk => clk, X => X_bf_l,          Y => Y_bf_l,          R => bfmul_l_R);
    bf16_R <= bfmul_h_R & bfmul_l_R(15 downto 0);

    -- Output mux
    with opcode select
        R <= fp32_R  when "001",
             bf16_R  when "101",
             (others => '0') when others;
end architecture;
"""

# ─── TCL template ─────────────────────────────────────────────────────────────
TCL_TEMPLATE = """\
# ======================================================================
# DC script: FPMult (retimed IntMult) + BF16 Mul x2  --  Freq{freq}
# ======================================================================
set_host_options -max_cores 8
remove_design -all

set main_clock_period 0.5

set run_dir  "run-fpmult_with_bf16_f{freq}"
set WORK_DIR "${{run_dir}}/WORK"
file mkdir $run_dir
file mkdir $WORK_DIR

define_design_lib WORK -path $WORK_DIR
set_app_var alib_library_analysis_path $WORK_DIR

set cell_lib "{cell_lib}"
set search_path "$cell_lib/Front_End/Liberty /autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files"
set link_library "[list \\
    $cell_lib/Front_End/Liberty/NangateOpenCellLibrary_typical_CCS.db \\
    {mem_libs_tcl}]"
set target_library $link_library

# Analyze VHDL sources
analyze -library WORK -format vhdl "../src/rtl/base_f{freq}/fpmult_f{freq}_nomult.vhdl"
analyze -library WORK -format vhdl "../src/rtl/base_f{freq}/fpmult_bf16_f{freq}.vhdl"
analyze -library WORK -format vhdl "../src/rtl/base_f{freq}/f{freq}_fpmult_with_bf16.vhdl"

# Read retimed IntMult netlist
read_file -format verilog "./intmult_f{freq}_ret.v"

elaborate f{freq}_fpmult_with_bf16
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
"""

# ─── Helpers ──────────────────────────────────────────────────────────────────
def parse_results(run_dir):
    area, arrival = "N/A", "N/A"
    area_rpt = os.path.join(run_dir, "area.rpt")
    timing_rpt = os.path.join(run_dir, "timing_setup.rpt")
    if os.path.exists(area_rpt):
        for line in open(area_rpt):
            m = re.search(r"Total cell area:\s+([\d\.]+)", line)
            if m:
                area = m.group(1); break
    if os.path.exists(timing_rpt):
        for line in open(timing_rpt):
            m = re.search(r"data arrival time\s+([\d\.]+)", line)
            if m:
                arrival = m.group(1); break
    return area, arrival

# ─── Main ─────────────────────────────────────────────────────────────────────
# Load existing results
results = []
done_keys = set()
if os.path.exists(csv_file):
    for line in open(csv_file).readlines()[1:]:
        parts = line.strip().split(",")
        if len(parts) >= 4:
            results.append(tuple(parts[:4]))
            done_keys.add(str(parts[0]))

mem_libs_tcl = " \\\n    ".join([
    f"/autofs/fs1.ece/fs1.eecg.janders/wangx517/library_compiler/db_files/cgrame_memUnit_32bdata_{b}baddress_lib.db"
    for b in [6, 7, 8, 9]
])

for freq in frequencies:
    freq_str = str(freq)
    if freq_str in done_keys:
        print(f"f{freq}: skipping (already in CSV)")
        continue

    # 1. Write VHDL wrapper
    vhdl_path = os.path.join(base_rtl, f"base_f{freq}", f"f{freq}_fpmult_with_bf16.vhdl")
    with open(vhdl_path, "w") as f:
        f.write(VHDL_TEMPLATE.format(freq=freq))
    print(f"f{freq}: wrote {vhdl_path}")

    # 2. Write TCL
    tcl_content = TCL_TEMPLATE.format(
        freq=freq,
        cell_lib=CELL_LIB,
        mem_libs_tcl=mem_libs_tcl,
    )
    tcl_path = os.path.join(syn_dir, f"run_fpmult_with_bf16_f{freq}.tcl")
    with open(tcl_path, "w") as f:
        f.write(tcl_content)
    print(f"f{freq}: wrote {tcl_path}")

    # 3. Run synthesis
    run_dir = os.path.join(syn_dir, f"run-fpmult_with_bf16_f{freq}")
    log_path = os.path.join(syn_dir, "logs", f"run_fpmult_with_bf16_f{freq}.log")
    os.makedirs(os.path.join(syn_dir, "logs"), exist_ok=True)
    cmd = f"source ~/.cshrc; cd {syn_dir} && dc_shell-xg-t -f run_fpmult_with_bf16_f{freq}.tcl >& {log_path}"
    print(f"f{freq}: launching dc_shell ...")
    try:
        subprocess.run(["tcsh", "-c", cmd], check=True, timeout=3600)
        area, arrival = parse_results(run_dir)
        print(f"f{freq}: Area={area}, Arrival={arrival}")
    except subprocess.CalledProcessError as e:
        area, arrival = "Error", "Error"
        print(f"f{freq}: dc_shell failed: {e}")
    except subprocess.TimeoutExpired:
        area, arrival = "Timeout", "Timeout"
        print(f"f{freq}: timeout")

    results.append((freq_str, area, arrival))
    done_keys.add(freq_str)

    # Write CSV after each frequency
    with open(csv_file, "w") as f:
        f.write("Freq,Area,MaxDataArrival\n")
        for r in sorted(results, key=lambda x: int(x[0])):
            f.write(",".join(str(v) for v in r) + "\n")

print("Done. Results in", csv_file)
