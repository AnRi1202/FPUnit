#!/bin/bash
# Standalone Launcher for FloPoCo Baseline Sweeps (f100-f600)
SESSION="sweep_flopoco"
tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "sweep"
tmux send-keys -t $SESSION:0 "cd synopsysDC" C-m
tmux send-keys -t $SESSION:0 "python3 run_sweep_flopoco_all.py | tee logs/sweep_flopoco_all.log" C-m
echo "Tmux session '$SESSION' created. Monitor with: tmux attach -t $SESSION"
