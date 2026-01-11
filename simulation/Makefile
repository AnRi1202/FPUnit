
# Common Source Files
SRC_ORIGIN = ../rtl/src/FPAdd_Kin_f1_origin.vhdl \
             ../rtl/src/FPDiv_Kin_f1_origin.vhdl \
             ../rtl/src/FPSqrt_Kin_f1_origin.vhdl \
             ../rtl/src/FPMult_Kin_f1_origin.vhdl

SRC_SHARED = ../rtl/src/src_shared/Mux34.vhdl \
             ../rtl/src/src_shared/IntAdder_8.vhdl \
             ../rtl/src/src_shared/IntAdder_27_Freq1_uid6.vhdl \
             ../rtl/src/src_shared/FPAdd_NoRA.vhdl \
             ../rtl/src/src_shared/FPMult_NoRA.vhdl \
             ../rtl/src/src_shared/FPDiv_NoRA.vhdl \
             ../rtl/src/src_shared/FPSqrt_NoRA.vhdl \
             ../rtl/src/src_shared/FPALL_Shared.vhdl \
             ../rtl/src/src_shared/FPALL_Shared_Wrapper.vhdl

SRC_SHARED_DIVSQ = ../rtl/src/src_shared/Mux34.vhdl \
                   ../rtl/src/src_shared/IntAdder_8.vhdl \
                   ../rtl/src/src_shared/IntAdder_27_Freq1_uid6.vhdl \
                   ../rtl/src/src_shared/FPAdd_NoRA.vhdl \
                   ../rtl/src/src_shared/FPMult_NoRA.vhdl \
                   ../rtl/src/src_shared/FPDiv_NoRA.vhdl \
                   ../rtl/src/src_shared/FPSqrt_NoRA.vhdl \
                   ../rtl/src/src_shared_divsq/FPDivSqrt_Shared.vhdl \
                   ../rtl/src/src_shared_divsq/FPALL_Shared_divsq.vhdl \
                   ../rtl/src/src_shared_divsq/FPALL_Shared_divsq_Wrapper.vhdl

# Testbenches
TB_ADD = ../rtl/tb/random/tb_fpadd_kintex_rand.vhdl
TB_DIV = ../rtl/tb/random/tb_fpdiv_kintext_rand.vhdl
TB_SQRT = ../rtl/tb/random/tb_fpsqrt_kintex.vhd
TB_SQRT_PIPE = ../rtl/tb/random/tb_fpsqrt_kintex_pipe.vhd

# Default target
all: add

# Run FPAdd simulation
add:
	xrun -64bit -v93 -top tb_fpadd_8_23 $(SRC_ORIGIN) $(SRC_SHARED) $(TB_ADD)

# Run FPDiv simulation
div:
	xrun -64bit -v93 -top tb_fpdiv_kintex $(SRC_ORIGIN) $(SRC_SHARED) $(TB_DIV)

# Run FPSqrt simulation
sqrt:
	xrun -64bit -v93 -top tb_fpsqrt_kintex $(SRC_ORIGIN) $(SRC_SHARED) $(TB_SQRT)

# Run FPSqrt Pipe simulation
sqrt_pipe:
	xrun -64bit -v93 -top tb_fpsqrt_kintex $(SRC_ORIGIN) $(SRC_SHARED) $(TB_SQRT_PIPE)


# --- Targets for Shared Div/Sqrt (divsq) ---
# Note: To use these, the 'FPALL_Shared_divsq_Wrapper' must be compatible with the testbench.
# Since the TB expects 'FPALL_Shared_Wrapper', we can't just swap the source files if the entity name differs.
# However, if we assume the user might change the TB or we make the wrapper correspond, we can add targets.
# For now, I will add them assuming the intention is to use the divsq source.

# Run FPAdd simulation (divsq version)
add_ds:
	xrun -64bit -v93 -top tb_fpadd_8_23 $(SRC_ORIGIN) $(SRC_SHARED_DIVSQ) $(TB_ADD)

# Run FPDiv simulation (divsq version)
div_ds:
	xrun -64bit -v93 -top tb_fpdiv_kintex $(SRC_ORIGIN) $(SRC_SHARED_DIVSQ) $(TB_DIV)

# Run FPSqrt simulation (divsq version)
sqrt_ds:
	xrun -64bit -v93 -top tb_fpsqrt_kintex $(SRC_ORIGIN) $(SRC_SHARED_DIVSQ) $(TB_SQRT)

clean:
	rm -rf xcelium.d xrun.history xrun.log