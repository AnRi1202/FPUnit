#!/bin/tcsh
source ~/.cshrc

# ----------------------------------------------------------------------
# 1. Baseline Sweeps (f100-f600 for Add and Mult)
# ----------------------------------------------------------------------
# Task 1_x: FPAdd (1_1=f100 ... 1_6=f600)
foreach task (1_1 1_2 1_3 1_4 1_5 1_6)
    echo "Starting Baseline FPAdd Task $task..."
    dc_shell -f run_ppa.tcl -x "set TASK $task; set VER none" | tee run_baseline_add_${task}.log
end

# Task 2_x: FPMult (2_1=f100 ... 2_6=f600)
foreach task (2_1 2_2 2_3 2_4 2_5 2_6)
    echo "Starting Baseline FPMult Task $task..."
    dc_shell -f run_ppa.tcl -x "set TASK $task; set VER none" | tee run_baseline_mult_${task}.log
end

# ----------------------------------------------------------------------
# 2. V2 Retiming Sweeps (Pipe 1 to 12)
# ----------------------------------------------------------------------
foreach pipe (1 2 3 4 5 6 7 8 9 10 11 12)
    # V2 Add
    echo "Starting V2 Retiming Add (Pipe $pipe)..."
    setenv PIPE $pipe
    dc_shell -f ret_v2_1_add.tcl | tee run_ret_add_pipe${pipe}.log
    
    # V2 Mult
    echo "Starting V2 Retiming Mult (Pipe $pipe)..."
    setenv PIPE $pipe
    dc_shell -f ret_v2_2_mult.tcl | tee run_ret_mult_pipe${pipe}.log
end

echo "All comprehensive experiments finished."
