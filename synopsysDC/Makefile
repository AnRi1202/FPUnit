SCRIPT ?= run_ppa.tcl
LOG ?= $(basename $(SCRIPT)).log

run:
	rm -r WORK
	mkdir WORK
	dc_shell-xg-t -f $(SCRIPT) -o $(LOG)

clean:
	rm -rf output/* *.pvl *.log *.svf *.syn *.sdc alib-52 command.log default.svf *.mr
	mkdir -p output

