#!/bin/tcsh
source ~/.cshrc
foreach task (1_1 1_2 1_3 1_4 1_5 1_6)
    echo "Starting Baseline FPAdd Task $task..."
    dc_shell -f run_ppa.tcl -x "set TASK $task; set VER none" | tee run_baseline_add_${task}.log
end
