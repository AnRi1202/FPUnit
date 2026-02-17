#!/bin/bash
# Standalone Launcher for Pure Combinatorial DAT & Area Measurement
SESSION="comb_baseline"
tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n "measure"
tmux send-keys -t $SESSION:0 "cd synopsysDC" C-m
tmux send-keys -t $SESSION:0 "source ~/.cshrc; dc_shell-xg-t -f measure_comb_dat.tcl | tee logs/measure_comb_dat.log" C-m
echo "Tmux session '$SESSION' created. Results will be in comb_baseline_dat_area.csv"
