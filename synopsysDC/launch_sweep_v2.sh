#!/bin/bash
# Standalone Launcher for V2 (BF16 Full All) Pipeline Sweeps
SESSION="sweep_v2"
tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "sweep"
tmux send-keys -t $SESSION:0 "cd synopsysDC" C-m
tmux send-keys -t $SESSION:0 "python3 run_sweep_v2_all.py | tee logs/sweep_v2_all.log" C-m
echo "Tmux session '$SESSION' created. Monitor with: tmux attach -t $SESSION"
