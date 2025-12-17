#!/bin/csh -f

# Project root (Run from anywhere)
# Resolve script directory to handle relative paths correctly
set SCRIPT_PATH = `readlink -f $0`
set SCRIPT_DIR = `dirname $SCRIPT_PATH`
setenv ROOT "$SCRIPT_DIR/.."

# Cadence Xcelium (xrun) setup
source /CMC/tools/CSHRCs/Cadence.XCELIUM23
source /CMC/tools/CSHRCs/CDNS_license

# Run directory setup
set TS = `date +"%Y%m%d_%H%M%S"`
set RUN_BASE = "$SCRIPT_DIR/run"
set RUN_DIR  = "$RUN_BASE/run_fpall_shared-$TS"
set LOG_DIR  = "$RUN_DIR/logs"
set WORK_DIR = "$RUN_DIR/work"
set WAVE_DIR = "$RUN_DIR/waves"
set COV_DIR  = "$RUN_DIR/cov"

mkdir -p "$LOG_DIR" "$WORK_DIR" "$WAVE_DIR" "$COV_DIR"

# Log execution details
set CMD_LOG = "$LOG_DIR/command.txt"
echo "Started : `date`"            >! "$CMD_LOG"
echo "ROOT    : $ROOT"            >> "$CMD_LOG"
echo "RUN_DIR : $RUN_DIR"         >> "$CMD_LOG"

# xrun execution log
set XRUN_LOG = "$LOG_DIR/xrun.log"

# Run in work directory
pushd "$WORK_DIR" > /dev/null

if ( -d xcelium.d ) then
  rm -rf xcelium.d
endif

# Parameters
set FILELIST = "$ROOT/simulation/filelist/compile_fpall_shared.f"
set TOP_MOD  = "tb_fpall_shared"

echo "xrun -v200x -64bit -f $FILELIST -top $TOP_MOD -access +rwc -timescale 1ns/1ps" >> "$CMD_LOG"

xrun -v200x -64bit \
  -f "$FILELIST" \
  -top $TOP_MOD \
  -access +rwc \
  -timescale 1ns/1ps \
  |& tee "$XRUN_LOG"

set XRUN_STATUS = $status
popd > /dev/null

# Update latest link
ln -sfn "$RUN_DIR" "$RUN_BASE/latest_fpall_shared"

echo "Xcelium finished. status=$XRUN_STATUS"
echo "Log: $XRUN_LOG"
echo "Run dir: $RUN_DIR"
exit $XRUN_STATUS
