run_fp16:
	xrun -v200x -64bit -sv -access +rwc ../FPALL_pkg.sv ../tb/*.sv ../FPALL_shared.sv ../utils/*.sv ../../*.vhdl

run_fp32:
	xrun -v200x -64bit -sv -access +rwc -top tb_fpadd_fp32 ../FPALL_pkg.sv ../tb/*.sv ../utils/*.sv ../FPALL_shared.sv  ../../*.vhdl