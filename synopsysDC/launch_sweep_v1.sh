#!/bin/bash
# Standalone Launcher for V1 (Area Opt All) Pipeline Sweeps
SESSION="sweep_v1"
tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "sweep"
tmux send-keys -t $SESSION:0 "cd synopsysDC" C-m
tmux send-keys -t $SESSION:0 "python3 run_sweep_v1_all.py | tee logs/sweep_v1_all.log" C-m
echo "Tmux session '$SESSION' created. Monitor with: tmux attach -t $SESSION"
