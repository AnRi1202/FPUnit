#!/bin/bash
SYN="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$SYN"
mkdir -p logs
# Launcher for *_ret designs: P1, NO retiming, get DataArrivalTime
# Runs sweep/no_retime/run_sweep_ret_no_retime_dat.py in tmux
SESSION="sweep_no_ret"


tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "no_ret"
tmux send-keys -t $SESSION:0 "python3 sweep/no_retime/run_sweep_ret_no_retime_dat.py | tee logs/sweep_no_ret_dat.log" C-m

echo "Tmux session '$SESSION' created."
echo "Monitor with: tmux attach -t $SESSION"
