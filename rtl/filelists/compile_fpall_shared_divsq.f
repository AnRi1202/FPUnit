# File list for compiling FPALL_Shared_divsq and dependencies
# VHDL files in dependency order

# Origin files (providing IntAdder and other helper components)
${ROOT}/rtl/src/FPAdd_Kin_f1_origin.vhdl
${ROOT}/rtl/src/FPMult_Kin_f1_origin.vhdl
${ROOT}/rtl/src/FPDiv_Kin_f1_origin.vhdl

# Shared source files
${ROOT}/rtl/src/src_shared/FPAdd_NoRA.vhdl
${ROOT}/rtl/src/src_shared/FPMult_NoRA.vhdl

# New DivSqrt shared module
${ROOT}/rtl/src/src_shared_divsq/FPDivSqrt_Shared.vhdl

# Top-level FPALL_Shared_divsq
${ROOT}/rtl/src/src_shared_divsq/FPALL_Shared_divsq.vhdl

# Testbench
${ROOT}/rtl/tb/tb_fpall_shared_divsq.vhd
