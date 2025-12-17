#!/bin/csh -f

# Cadence Xcelium (xrun) setup
source /CMC/tools/CSHRCs/Cadence.XCELIUM23
source /CMC/tools/CSHRCs/CDNS_license

# Clean previous Xcelium run directory (optional)
if ( -d xcelium.d ) then
  rm -rf xcelium.d
endif

# Compile & simulate with xrun
xrun -v200x -64bit -f compile_shared.f -top tb_fpmul_kintex -access +rwc -timescale 1ns/1ps |& tee xrun_mult.log

echo "Xcelium (xrun) simulation finished. Log: xrun_mult.log"
