### add 
flopoco frequency=1 target=Kintex7 FPAdd wE=8 wF=23 TestBench

nvc -M 128m --stderr=error -a v2_bf16_full/*.vhdl src/*_origin.vhdl --relaxed --error-limit=0 -e TestBench_FPAdd_8_23_Freq1_uid2_Freq1_uid13  -r --wave=TestBench_FPAdd_8_23_Freq1_uid2_Freq1_uid13.fst --stop-time=10112ns

nvc -M 128m --stderr=error -a v2_bf16_full/*.vhdl src/*_origin.vhdl --relaxed --error-limit=0 -e TestBench_FPAdd_8_23_Freq1_uid2_Freq1_uid13  -r --wave=TestBench_FPAdd_8_23_Freq1_uid2_Freq1_uid13.fst --stop-time=10112ns | grep -ci exact
874

### mult
   

nvc -M 128m --stderr=error -a v2_bf16_full/*.vhdl src/*_origin.vhdl --relaxed --error-limit=0 -e TestBench_FPMult_8_23_uid2_Freq1_uid3_Freq1_uid282  -r --wave=TestBench_FPMult_8_23_uid2_Freq1_uid3_Freq1_uid282.fst --stop-time=50012ns | grep -ci exact

### div
flopoco frequency=1 target=Kintex7 FPDiv wE=8 wF=23 TestBench n=5000

nvc -M 128m --stderr=error -a v2_bf16_full/*.vhdl src/*_origin.vhdl --relaxed --error-limit=0 -e TestBench_FPDiv_8_23_Freq1_uid2_Freq1_uid20  -r --wave=TestBench_FPDiv_8_23_Freq1_uid2_Freq1_uid20.fst --stop-time=50032ns | grep -ci exact
259

### sqrt
flopoco frequency=1 target=Kintex7 FPSqrt wE=8 wF=23 TestBench

nvc -M 128m --stderr=error -a v2_bf16_full/*.vhdl src/*_origin.vhdl --relaxed --error-limit=0 -e TestBench_FPSqrt_8_23_Freq1_uid3  -r --wave=TestBench_FPSqrt_8_23_Freq1_uid3.fst --stop-time=10042ns | grep -ci exact
416

### 余裕があれば
flopoco frequency=1 target=Kintex7 FPMult wE=8 wF=23 TestBench n=10000


nvc -M 128m --stderr=error -a v2_bf16_full/*.vhdl src/*_origin.vhdl --relaxed --error-limit=0 -e TestBench_FPMult_8_23_uid2_Freq1_uid3_Freq1_uid282  -r --wave=TestBench_FPMult_8_23_uid2_Freq1_uid3_Freq1_uid282.fst --stop-time=100012ns | grep -ci exact
537

flopoco frequency=1 target=Kintex7 FPDiv wE=8 wF=23 TestBench n=10000

nvc -M 128m --stderr=error -a v2_bf16_full/*.vhdl src/*_origin.vhdl --relaxed --error-limit=0 -e TestBench_FPDiv_8_23_Freq1_uid2_Freq1_uid20  -r --wave=TestBench_FPDiv_8_23_Freq1_uid2_Freq1_uid20.fst --stop-time=100032ns | grep -ci exact
547
