run:
	xrun -v200x -64bit -sv -access +rwc ../*.sv ../utils/*.sv ../../*.vhdl

run_fp32:
	xrun -v200x -64bit -sv -access +rwc -top tb_fpadd_fp32 ../FPALL_pkg.sv ../utils/*.sv ../FPALL_shared.sv ../add_fp32_tb.sv ../../*.vhdl