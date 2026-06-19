#!/bin/bash
SYN="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$SYN"
mkdir -p logs
# Launcher for FPAddMulBF16_origin_ret sweep (6ops addmul: FP32+BF16) in tmux
SESSION="sweep_flopoco_addmul_bf16"


tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "addmul_bf16"
tmux send-keys -t $SESSION:0 "python3 sweep/retime/run_sweep_flopoco_origin_addmul_bf16.py | tee logs/sweep_flopoco_origin_addmul_bf16.log" C-m

echo "Tmux session '$SESSION' created."
echo "Monitor with: tmux attach -t $SESSION"
