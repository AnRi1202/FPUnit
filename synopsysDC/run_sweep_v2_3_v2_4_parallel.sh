#!/bin/bash

# Parallel launcher for V2.3 (Add/Mul) and V2.4 (Div/Sqrt) sweeps
# Usage: ./run_sweep_v2_3_v2_4_parallel.sh

SESSION="v2_subunits_sweep"

# Kill existing session if it exists
tmux kill-session -t $SESSION 2>/dev/null

# Create a new session
tmux new-session -d -s $SESSION -n "monitor"

# Create window for V2.3 Add/Mul sweep
tmux new-window -t $SESSION:1 -n "v2_3_addmul"
tmux send-keys -t $SESSION:1 "python3 run_sweep_v2_3_addmul.py" C-m

# Create window for V2.4 Div/Sqrt sweep
tmux new-window -t $SESSION:2 -n "v2_4_divsqrt"
tmux send-keys -t $SESSION:2 "python3 run_sweep_v2_4_divsqrt.py" C-m

# Monitoring window
tmux select-window -t $SESSION:0
tmux send-keys -t $SESSION:0 "watch -n 5 'ls -lt run-v2_3_addmul* run-v2_4_divsqrt* | head -n 20'" C-m

echo "Parallel sweeps for V2.3 and V2.4 launched in tmux session: $SESSION"
echo "To monitor progress:"
echo "  tmux attach -t $SESSION"
echo "  - Window 0: Directory monitor"
echo "  - Window 1: V2.3 Add/Mul logs"
echo "  - Window 2: V2.4 Div/Sqrt logs"
