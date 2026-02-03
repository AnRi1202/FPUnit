### simple
xrun -v200x -64bit -sv ../rtl/src/src_shared_combine_sv/*.vhdl ../rtl/src/src_shared_combine_sv/*.sv ../rtl/src/*.vhdl  -top TestBench_FPAdd_8_23_Freq1_uid2_Freq1_uid13 -access +rwc -input "@run 10500ns; exit"


xrun -v200x -64bit -sv ../rtl/src/src_shared_combine_sv/*.vhdl ../rtl/src/src_shared_combine_sv/*.sv ../rtl/src/*.vhdl  -top TestBench_FPMult_8_23_uid2_Freq1_uid3_Freq1_uid282 -access +rwc -input "@run 50112ns; exit"


xrun -v200x -64bit -sv ../rtl/src/src_shared_combine_sv/*.vhdl ../rtl/src/src_shared_combine_sv/*.sv ../rtl/src/*.vhdl  -top TestBench_FPDiv_8_23_Freq1_uid2_Freq1_uid20  -access +rwc -input "@run 50112ns; exit"



xrun -v200x -64bit -sv ../rtl/src/src_shared_combine_sv/*.vhdl ../rtl/src/src_shared_combine_sv/*.sv ../rtl/src/*.vhdl  -top TestBench_FPSqrt_8_23_Freq1_uid3  -access +rwc -input "@run 10112ns; exit"


### 現在

xrun -v200x -64bit -sv ../rtl/src/src_shared_combine_sv/*.vhdl ../rtl/src/src_shared_combine_sv/*.sv ../rtl/src/src_shared_combine_sv/utils/*.sv ../rtl/src/*.vhdl -top TestBench_FPAdd_8_23_Freq1_uid2_Freq1_uid13 -access +rwc -input "@run 300500ns; exit"