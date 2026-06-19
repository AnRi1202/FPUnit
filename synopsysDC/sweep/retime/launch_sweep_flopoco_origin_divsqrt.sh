#!/bin/bash
SYN="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$SYN"
mkdir -p logs
# Launcher for FloPoCo Div+Sqrt sweep (FPDivSqrt_origin_ret)
SESSION="sweep_flopoco_divsqrt"
tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "divsqrt"
tmux send-keys -t $SESSION:0 "python3 sweep/retime/run_sweep_flopoco_origin_divsqrt.py | tee logs/sweep_flopoco_origin_divsqrt.log" C-m
echo "Tmux session '$SESSION' created. Monitor with: tmux attach -t $SESSION"
