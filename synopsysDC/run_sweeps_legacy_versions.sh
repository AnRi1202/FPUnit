#!/bin/bash

SESSION_NAME="sweep_py"

# Check if session exists
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
    # Create new session
    tmux new-session -d -s $SESSION_NAME -n "baseline_sweep"
    
    # Window 0: Baseline Sweep (F100-F600, FP32/BF16/FPALL)
    tmux send-keys -t $SESSION_NAME:0 "cd synopsysDC" C-m
    tmux send-keys -t $SESSION_NAME:0 "python3 run_sweep_flopoco_all.py | tee logs/sweep_flopoco_all.log" C-m
    
    # Window 1: V2 6-Ops Pipeline Sweep
    tmux new-window -t $SESSION_NAME -n "v2_6ops_sweep"
    tmux send-keys -t $SESSION_NAME:1 "cd synopsysDC" C-m
    tmux send-keys -t $SESSION_NAME:1 "python3 run_sweep_v2_all.py | tee logs/sweep_v2_all.log" C-m
    
    # Window 2: V1 6-Ops Pipeline Sweep
    tmux new-window -t $SESSION_NAME -n "v1_6ops_sweep"
    tmux send-keys -t $SESSION_NAME:2 "cd synopsysDC" C-m
    tmux send-keys -t $SESSION_NAME:2 "python3 run_sweep_v1_all.py | tee logs/sweep_v1_all.log" C-m
    
    # Window 3: Monitor (htop or file watch)
    tmux new-window -t $SESSION_NAME -n "monitor"
    tmux send-keys -t $SESSION_NAME:3 "cd synopsysDC" C-m
    tmux send-keys -t $SESSION_NAME:3 "watch -n 1 'ls -ltr logs/*.log | tail -n 20'" C-m

    echo "Tmux session '$SESSION_NAME' created."
    echo "Attach using: tmux attach -t $SESSION_NAME"
else
    echo "Session '$SESSION_NAME' already exists. Attach using: tmux attach -t $SESSION_NAME"
fi
