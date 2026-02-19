# RTL Sources for FloPoCo Synthesis

This directory contains various RTL implementations and configurations for FloPoCo-generated arithmetic units, organized by version and optimization target.

## Directory Structure

### Base Configurations
- `original/`: Original FloPoCo generated VHDL files.
- `base_f100/` to `base_f600/`: Base FloPoCo implementations for different target frequencies.

### Versioned Optimizations
- `v0_area_opt/`: area-optimization VHDL implementations.
- `v1_area_opt/`: area-optimized SystemVerilog implementations.
- `v1_1_fp32_add/` & `v1_2_fp32_mult/`: FP32 specific operation modules. These are for synthesis, so logically same as v1.
- `v2_bf16_full/`: 6 operators(v1 + BFADD, BFMULT) implementation.
- `v2_1_bf16_add/` to `v2_4_divsqrt_only/`: FUSED specific operation modules (Add, Mult, AddMult, DivSqrt). These are for synthesis, so logically same as v2.
- `v3_addmul_only/` & `v3_1_divsqrt_only/`:  FP32 specific operation modules. These are for synthesis, so logically same as v1.

## Usage
These files are used as source inputs for Synopsys Design Compiler synthesis sweeps.
