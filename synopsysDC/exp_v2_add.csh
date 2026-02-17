#!/bin/tcsh
source ~/.cshrc
foreach pipe (1 2 3 4 5 6 7 8 9 10 11 12)
    echo "Starting V2 Retiming Add (Pipe $pipe)..."
    setenv PIPE $pipe
    dc_shell -f ret_v2_1_add.tcl | tee run_ret_add_pipe${pipe}.log
end
