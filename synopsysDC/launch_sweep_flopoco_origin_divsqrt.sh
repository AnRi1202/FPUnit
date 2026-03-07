#!/bin/bash
# Launcher for FloPoCo Div+Sqrt sweep (FPDivSqrt_origin_ret)
SESSION="sweep_flopoco_divsqrt"
cd "$(dirname "$0")"
mkdir -p logs
tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "divsqrt"
tmux send-keys -t $SESSION:0 "cd $(pwd)" C-m
tmux send-keys -t $SESSION:0 "python3 run_sweep_flopoco_origin_divsqrt.py | tee logs/sweep_flopoco_origin_divsqrt.log" C-m
echo "Tmux session '$SESSION' created. Monitor with: tmux attach -t $SESSION"
