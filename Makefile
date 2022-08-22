ROOT_DIR  = $(PWD)
VIVADO_VER  := 2021.2
VIVADO_PATH := /opt/Xilinx/Vivado/$(VIVADO_VER)/bin/
VIVADO_XLNX := $(VIVADO_PATH)/vivado
VIVADO_OPT  := -mode batch -nolog -nojournal -notrace -source
FPGA_BOARD  ?= u55c
AXI_AWIDTH  ?= 32


DEVICE = uart

all: uart

#Generate the UART IP

$(DEVICE): 
	@(echo "Generate a 16[6|7]50 UART IP for MEEP")
	$(VIVADO_XLNX) $(VIVADO_OPT)  ./tcl/gen_project.tcl -tclargs $(FPGA_BOARD) $(AXI_AWIDTH)
	@(echo "IP created under folder /$@")


clean:
	git clean -f
	@(cd ip; find . -type f ! -name "*.tcl" -exec rm -r {} \;)
	rm -rf xgui project uart



