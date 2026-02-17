#!/bin/bash

SESSION_NAME="experiments_parallel"

# Kill existing session if it exists to ensure fresh start
tmux kill-session -t $SESSION_NAME 2>/dev/null

# Create new session
tmux new-session -d -s $SESSION_NAME -n "baseline_add"
    
    # Window 0: Baseline Add (f100-f600)
    tmux send-keys -t $SESSION_NAME:0 "./exp_baseline_add.csh" C-m
    
    # Window 1: Baseline Mult (f100-f600)
    tmux new-window -t $SESSION_NAME -n "baseline_mult"
    tmux send-keys -t $SESSION_NAME:1 "./exp_baseline_mult.csh" C-m
    
    # Window 2: V2 Add (1-12)
    tmux new-window -t $SESSION_NAME -n "v2_add"
    tmux send-keys -t $SESSION_NAME:2 "./exp_v2_add.csh" C-m
    
    # Window 3: V2 Mult (1-12)
    tmux new-window -t $SESSION_NAME -n "v2_mult"
    tmux send-keys -t $SESSION_NAME:3 "./exp_v2_mult.csh" C-m

echo "Tmux session '$SESSION_NAME' created with 4 windows (Baseline Add, Baseline Mult, V2 Add, V2 Mult)."
echo "Attach using: tmux attach -t $SESSION_NAME"
