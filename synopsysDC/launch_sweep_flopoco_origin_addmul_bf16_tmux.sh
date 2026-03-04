#!/bin/bash
# Launcher for FPAddMulBF16_origin_ret sweep (6ops addmul: FP32+BF16) in tmux
SESSION="sweep_flopoco_addmul_bf16"

cd "$(dirname "$0")"
mkdir -p logs

tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "addmul_bf16"
tmux send-keys -t $SESSION:0 "cd $(pwd)" C-m
tmux send-keys -t $SESSION:0 "python3 run_sweep_flopoco_origin_addmul_bf16.py | tee logs/sweep_flopoco_origin_addmul_bf16.log" C-m

echo "Tmux session '$SESSION' created."
echo "Monitor with: tmux attach -t $SESSION"
