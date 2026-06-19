#!/bin/bash
SYN="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$SYN"
mkdir -p logs
# Launcher for FPAddMul_origin_ret sweep (P1-P18, retiming) in tmux
SESSION="sweep_flopoco_addmul"


tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "addmul"
tmux send-keys -t $SESSION:0 "python3 sweep/retime/run_sweep_flopoco_origin_addmul.py | tee logs/sweep_flopoco_origin_addmul.log" C-m

echo "Tmux session '$SESSION' created."
echo "Monitor with: tmux attach -t $SESSION"
