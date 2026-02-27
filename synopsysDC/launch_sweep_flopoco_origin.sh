#!/bin/bash
# Launcher for FloPoCo Origin (FPALL_origin_ret) Retiming Sweep
# Each NUM_OPS runs in a separate tmux window IN PARALLEL.
# Usage: ./launch_sweep_flopoco_origin.sh [num_ops ...]
#   e.g. ./launch_sweep_flopoco_origin.sh 6          -> NUM_OPS=6 only
#        ./launch_sweep_flopoco_origin.sh 4 5 6 7    -> all four in parallel
#        ./launch_sweep_flopoco_origin.sh             -> default: 4 5 6 7

NUM_OPS_LIST="${@:-4 5 6 7}"
SESSION="sweep_flopoco_origin"

mkdir -p logs

tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "main"

FIRST=1
for N in $NUM_OPS_LIST; do
    WIN="N${N}"
    if [ $FIRST -eq 1 ]; then
        tmux rename-window -t $SESSION:0 "$WIN"
        FIRST=0
    else
        tmux new-window -t $SESSION -n "$WIN"
    fi
    tmux send-keys -t $SESSION:$WIN "cd $(pwd)" C-m
    tmux send-keys -t $SESSION:$WIN "python3 run_sweep_flopoco_origin.py $N | tee logs/sweep_flopoco_origin_N${N}_master.log" C-m
    echo "  Launched NUM_OPS=$N in window '$WIN'"
done

echo ""
echo "Tmux session '$SESSION' created with ${#} parallel sweeps."
echo "Monitor with: tmux attach -t $SESSION"
echo "Switch windows: Ctrl-b <number> or Ctrl-b n"
