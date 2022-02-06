ROOT_DIR  = $(PWD)
IP_DIR    = $(ROOT_DIR)/ip
VIVADO_VER  ?= 2021.2
VIVADO_PATH := /opt/Xilinx/Vivado/$(VIVADO_VER)/bin/
VIVADO_XLNX := $(VIVADO_PATH)/vivado
VIVADO_OPT  := -mode batch -nolog -nojournal -notrace -source
FPGA_BOARD  ?= "u280"


#Generate the Aurora DMA IP

generate_ip:
		@(echo "Generate 100Gb Ethernet IP"); mkdir -p $(ROOT_DIR)/ip
		$(VIVADO_XLNX) $(VIVADO_OPT)  ./tcl/gen_project.tcl -tclargs $(FPGA_BOARD)


clean:
	git clean -f
	@(cd ip; find . -type f ! -name "*.tcl" -exec rm -r {} \;)
	rm -rf xgui project bd



