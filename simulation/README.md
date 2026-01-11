# Simulation Guide

This directory contains the Makefile to run simulations for the Floating Point Units (Add, Div, Sqrt).

## How to Run Simulations

You can run simulations using the `make` command followed by the target name:

- **Add**: `make add`
- **Div**: `make div`
- **Sqrt**: `make sqrt`
- **Sqrt (Pipe)**: `make sqrt_pipe`

## Switching Between "Shared" and "Original" Implementations

The testbenches are designed to switch between the **Original** standalone components (e.g., `FPAdd_8_23_Freq1_uid2`) and the **Shared** wrapper component (`FPALL_Shared_Wrapper`).

To switch implementations, you need to manually edit the corresponding testbench file in `../rtl/tb/random/`.

### 1. Open the Testbench File
- **Add**: `../rtl/tb/random/tb_fpadd_kintex_rand.vhdl`
- **Div**: `../rtl/tb/random/tb_fpdiv_kintext_rand.vhdl`
- **Sqrt**: `../rtl/tb/random/tb_fpsqrt_kintex.vhd`

### 2. Comment/Uncomment the Component Declaration and Instantiation

Inside the testbench architecture, you will find two sections for the Unit Under Test (UUT).

**To use the Shared Implementation (Default):**
Ensure `FPALL_Shared_Wrapper` is uncommented and the original component is commented out.

```vhdl
  -- component FPAdd_8_23_Freq1_uid2 is ... end component; (Commented out)

  component FPALL_Shared_Wrapper is ... end component; (Uncommented)

  begin
  
  -- uut: FPAdd_8_23_Freq1_uid2 ... (Commented out)
  
  uut: FPALL_Shared_Wrapper
    generic map ( OP_CODE_GEN => "00" ) -- "00" for Add, "11" for Div, "10" for Sqrt
    port map ( ... ); 
```

**To use the Original Implementation:**
Comment out `FPALL_Shared_Wrapper` and uncomment the original component.

```vhdl
  component FPAdd_8_23_Freq1_uid2 is ... end component; (Uncommented)

  -- component FPALL_Shared_Wrapper is ... end component; (Commented out)

  begin
  
  uut: FPAdd_8_23_Freq1_uid2 ... (Uncommented)
  
  -- uut: FPALL_Shared_Wrapper ... (Commented out)
```

The Makefile includes source files for both implementations, so you only need to modify the testbench to switch which one is tested.


wrapperを使うshared系は、wrapperの名前が同じなのでtbは変える必要なし
originalについては、 名前が違うので、componentを変える必要あり