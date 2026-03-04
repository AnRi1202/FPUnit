#!/bin/bash
# Launcher for *_ret designs: P1, NO retiming, get DataArrivalTime
# Runs run_sweep_ret_no_retime_dat.py in tmux
SESSION="sweep_no_ret"

cd "$(dirname "$0")"
mkdir -p logs

tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "no_ret"
tmux send-keys -t $SESSION:0 "cd $(pwd)" C-m
tmux send-keys -t $SESSION:0 "python3 run_sweep_ret_no_retime_dat.py | tee logs/sweep_no_ret_dat.log" C-m

echo "Tmux session '$SESSION' created."
echo "Monitor with: tmux attach -t $SESSION"
