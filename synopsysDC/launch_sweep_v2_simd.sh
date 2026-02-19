#!/bin/bash

# Parallel launcher for V2.1 (BF16 Add) and V2.2 (BF16 Mult) sweeps
# Usage: ./launch_sweep_v2_simd.sh

SESSION="v2_simd_sweep"

# Kill existing session if it exists
tmux kill-session -t $SESSION 2>/dev/null

# Create a new session
tmux new-session -d -s $SESSION -n "monitor"

# Create window for V2.1 BF16 Add sweep
tmux new-window -t $SESSION:1 -n "v2_1_add"
tmux send-keys -t $SESSION:1 "python3 run_sweep_v2_1_add.py" C-m

# Create window for V2.2 BF16 Mult sweep
tmux new-window -t $SESSION:2 -n "v2_2_mult"
tmux send-keys -t $SESSION:2 "python3 run_sweep_v2_2_mult.py" C-m

# Monitoring window
tmux select-window -t $SESSION:0
tmux send-keys -t $SESSION:0 "watch -n 5 'ls -lt run-bf16_add_ret* run-bf16_mult_ret* | head -n 20'" C-m

echo "Parallel sweeps for V2.1 and V2.2 launched in tmux session: $SESSION"
echo "To monitor progress:"
echo "  tmux attach -t $SESSION"
echo "  - Window 0: Directory monitor"
echo "  - Window 1: V2.1 BF16 Add logs"
echo "  - Window 2: V2.2 BF16 Mult logs"
