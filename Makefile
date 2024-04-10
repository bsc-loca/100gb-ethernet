ROOT_DIR  = $(PWD)
IP_DIR    = $(ROOT_DIR)/ip
# taking default Xilinx install path if not propagated from environment var
VIVADO_VER    ?= 2023.2
XILINX_VIVADO ?= /opt/Xilinx/Vivado/$(VIVADO_VER)/
VIVADO_XLNX   := $(XILINX_VIVADO)/bin/vivado
VIVADO_OPT  := -mode batch -nolog -nojournal -notrace -source
FPGA_BOARD  ?= "u55c"
QSFP_PORT   ?= "qsfp1"
DMA_MEM     ?= "hbm"
SAXI_FREQ   ?= "100000000"
SAXI_PROT   ?= "AXI4LITE-64"


#Generate the 100Gb Ethernet IP

generate_ip: clean
		@(echo "Generate 100Gb Ethernet IP"); mkdir -p $(ROOT_DIR)/ip
		$(VIVADO_XLNX) $(VIVADO_OPT)  ./tcl/gen_project.tcl -tclargs $(FPGA_BOARD) $(QSFP_PORT) $(DMA_MEM) $(SAXI_FREQ) $(SAXI_PROT)


clean:
	git clean -f -x -d 
