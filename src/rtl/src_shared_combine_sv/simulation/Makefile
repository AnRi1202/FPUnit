ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

add_fp16:
	xrun -v200x -64bit -sv -access +rwc ../FPALL_pkg.sv ../tb/*.sv ../FPALL_shared.sv ../utils/*.sv ../origin/*.vhdl

add_fp32:
	xrun -v200x -64bit -sv -access +rwc -top tb_fpadd_fp32 ../FPALL_pkg.sv ../tb/*.sv ../utils/*.sv ../FPALL_shared.sv  ../origin/*.vhdl

mult_fp32:
	xrun -v200x -64bit -sv -access +rwc -top tb_fpmult_fp32 ../FPALL_pkg.sv ../tb/*.sv ../utils/*.sv ../FPALL_shared.sv  ../origin/*.vhdl

mult_bf16:
	xrun -v200x -64bit -sv -access +rwc -top tb_fpmult_bf16x2 ../FPALL_pkg.sv ../tb/*.sv ../utils/*.sv ../FPALL_shared.sv  ../origin/*.vhdl

run_flopoco_tb:
	xrun -v200x -64bit -sv -access +rwc -top TestBench_FPAdd_8_23_Freq1_uid2_Freq1_uid13 ../FPALL_pkg.sv ../tb/FPALL_tb.vhdl  \
	../FPALL_wrapper.vhdl ../FPALL_shared.sv  ../utils/*.sv ../origin/*.vhdl  -input "@run 300500ns; exit"