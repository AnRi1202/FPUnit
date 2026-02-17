#!/bin/bash

SESSION_NAME="v3_sweep"

# Kill existing session if it exists to ensure fresh start
tmux kill-session -t $SESSION_NAME 2>/dev/null

# Create new session
tmux new-session -d -s $SESSION_NAME -n "addmul_v3"

# Window 0: Add/Mul V3 Sweep
tmux send-keys -t $SESSION_NAME:0 "cd synopsysDC" C-m
tmux send-keys -t $SESSION_NAME:0 "python3 run_sweep_v3_addmul.py | tee sweep_v3_addmul.log" C-m

# Window 1: Div/Sqrt V3.1 Sweep
tmux new-window -t $SESSION_NAME -n "divsqrt_v3_1"
tmux send-keys -t $SESSION_NAME:1 "cd synopsysDC" C-m
tmux send-keys -t $SESSION_NAME:1 "python3 run_sweep_v3_1_divsqrt.py | tee sweep_v3_1_divsqrt.log" C-m

# Window 2: Monitor
tmux new-window -t $SESSION_NAME -n "monitor"
tmux send-keys -t $SESSION_NAME:2 "cd synopsysDC" C-m
tmux send-keys -t $SESSION_NAME:2 "watch -n 1 'ls -ltr sweep_v3*.log | tail -n 20'" C-m

echo "Tmux session '$SESSION_NAME' created with 3 windows (addmul_v3, divsqrt_v3_1, monitor)."
echo "Attach using: tmux attach -t $SESSION_NAME"
