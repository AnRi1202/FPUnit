#!/bin/csh -f

# Cadence Xcelium (xrun) setup
source /CMC/tools/CSHRCs/Cadence.XCELIUM23
source /CMC/tools/CSHRCs/CDNS_license

# Clean previous Xcelium run directory (optional)
if ( -d xcelium.d ) then
  rm -rf xcelium.d
endif

# Compile & simulate with xrun (CLI, log: xrun.log)
# -v200x      : VHDL-2002/2008 mode
# -64bit      : 64-bit mode
# -f          : ファイルリスト (compile_mul.f)
# -top        : トップレベルエンティティ名 (VHDL)
# -access     : 波形などのアクセス権
# -timescale  : timescale が書いてないモジュールに 1ns/1ps をデフォルト適用
# Note: xrunのデフォルトはVHDL-2008なので、to_hstring関数が使用可能
xrun -v200x -64bit -f compile_mul.f -top tb_fpmul_kintex -access +rwc -timescale 1ns/1ps |& tee xrun_mul.log

echo "Xcelium (xrun) simulation (compile + elaborate + run) finished. Log: xrun_mul.log"




