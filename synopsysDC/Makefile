SCRIPT ?= run_ppa.tcl
LOG ?= $(basename $(SCRIPT)).log
TASK ?= 0
TOP ?= none
VER ?= none
RETIME ?= 0
FILELIST ?= none
export ROOT := $(abspath ..)

run:
	@if [ -z "$(TOP)" ]; then echo "Error: TOP is not set. Usage: make run VER=<foldername> TOP=<module_name>"; exit 1; fi
	@if [ -z "$(VER)" ]; then echo "Error: VER is not set. Usage: make run VER=<foldername> TOP=<module_name>"; exit 1; fi
	rm -rf WORK
	mkdir WORK
	RETIME=$(RETIME) dc_shell-xg-t -x "set TASK $(TASK); set VER $(VER); set ROOT $(ROOT); set TOP $(TOP)" -f $(SCRIPT) -o $(LOG)

baseline:
	@if [ -z "$(VER)" ]; then echo "Error: VER is not set. Usage: make baseline VER=base_f200"; exit 1; fi
	rm -rf WORK
	mkdir WORK
	dc_shell-xg-t -x "set VER $(VER); set ROOT $(ROOT)" -f run_baseline.tcl -o run_baseline.log

pipe:
	dc_shell-xg-t -f ret.tcl -o ret.log

ret_ppa:
	dc_shell-xg-t -f ret_ppa.tcl -o ret_ppa.log

clean:
	rm -rf output/* *.pvl *.log *.svf *.syn *.sdc alib-52 command.log default.svf *.mr
	mkdir -p output

