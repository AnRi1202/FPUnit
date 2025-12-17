// File list for FPALL_Shared testbench
// VHDL files in dependency order

// Origin files (providing helper components)
${ROOT}/rtl/src/FPAdd_Kin_f1_origin.vhdl
${ROOT}/rtl/src/FPMult_Kin_f1_origin.vhdl
${ROOT}/rtl/src/FPSqrt_Kin_f1_origin.vhdl
${ROOT}/rtl/src/FPDiv_Kin_f1_origin.vhdl

// Shared IntAdder_27 component
${ROOT}/rtl/src/src_shared/IntAdder_27_Freq1_uid6.vhdl

// Shared source files (NoRA versions)
${ROOT}/rtl/src/src_shared/FPAdd_NoRA.vhdl
${ROOT}/rtl/src/src_shared/FPMult_NoRA.vhdl
${ROOT}/rtl/src/src_shared/FPSqrt_NoRA.vhdl
${ROOT}/rtl/src/src_shared/FPDiv_NoRA.vhdl

// Top-level shared module
${ROOT}/rtl/src/src_shared/FPALL_Shared.vhdl

// Testbench
${ROOT}/rtl/tb/tb_fpall_shared.vhd
