#!/bin/tcsh
source ~/.cshrc
foreach task (2_1 2_2 2_3 2_4 2_5 2_6)
    echo "Starting Baseline FPMult Task $task..."
    dc_shell -f run_ppa.tcl -x "set TASK $task; set VER none" | tee run_baseline_mult_${task}.log
end
