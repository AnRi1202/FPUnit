tool_sim:
	cd $(BUILD) && \
	xrun $(XRUN_FLAGS) \
	-top $(TOP) \
	$(addprefix -f ,$(FILELIST_SV)) \
	$(addprefix -f ,$(FILELIST_VHDL))