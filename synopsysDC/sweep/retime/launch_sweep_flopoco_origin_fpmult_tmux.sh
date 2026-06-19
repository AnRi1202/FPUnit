#!/bin/bash
SYN="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$SYN"
mkdir -p logs
# Launcher for FPMult_origin_ret sweep (P1-P18, retiming) in tmux
SESSION="sweep_flopoco_fpmult"


tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "fpmult"
tmux send-keys -t $SESSION:0 "python3 sweep/retime/run_sweep_flopoco_origin_fpmult.py | tee logs/sweep_flopoco_origin_fpmult.log" C-m

echo "Tmux session '$SESSION' created."
echo "Monitor with: tmux attach -t $SESSION"
