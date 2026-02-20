global g_init_clk_freq
global g_saxi_freq
global g_dma_addr_width
global g_dma_m_axi_width
global g_eth_port
global g_saxi_prot
global g_board_part

create_bd_design Eth_CMAC_syst

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 qsfp_4x
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 qsfp_refck

set AXIProt  [string replace $g_saxi_prot   [string first "-" $g_saxi_prot] end]
set AXIWidth [string replace $g_saxi_prot 0 [string first "-" $g_saxi_prot]    ]

create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi
set_property -dict [ list \
   CONFIG.ADDR_WIDTH 22 \
   CONFIG.ARUSER_WIDTH 0 \
   CONFIG.AWUSER_WIDTH 0 \
   CONFIG.BUSER_WIDTH 0 \
   CONFIG.DATA_WIDTH $AXIWidth \
   CONFIG.HAS_BRESP 1 \
   CONFIG.HAS_BURST 1 \
   CONFIG.HAS_CACHE 0 \
   CONFIG.HAS_LOCK 0 \
   CONFIG.HAS_PROT 0 \
   CONFIG.HAS_QOS 0 \
   CONFIG.HAS_REGION 0 \
   CONFIG.HAS_RRESP 1 \
   CONFIG.HAS_WSTRB 1 \
   CONFIG.ID_WIDTH 0 \
   CONFIG.MAX_BURST_LENGTH 256 \
   CONFIG.NUM_READ_OUTSTANDING 256 \
   CONFIG.NUM_READ_THREADS 16 \
   CONFIG.NUM_WRITE_OUTSTANDING 256 \
   CONFIG.NUM_WRITE_THREADS 16 \
   CONFIG.PROTOCOL $AXIProt \
   CONFIG.READ_WRITE_MODE READ_WRITE \
   CONFIG.RUSER_BITS_PER_BYTE 0 \
   CONFIG.RUSER_WIDTH 0 \
   CONFIG.SUPPORTS_NARROW_BURST 1 \
   CONFIG.WUSER_BITS_PER_BYTE 0 \
   CONFIG.WUSER_WIDTH 0 \
] [get_bd_intf_ports s_axi]

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_dma
set_property -dict [ list \
   CONFIG.ADDR_WIDTH $g_dma_addr_width \
   CONFIG.DATA_WIDTH $g_dma_m_axi_width \
   CONFIG.HAS_BURST 1 \
   CONFIG.HAS_LOCK 0 \
   CONFIG.HAS_QOS 0 \
   CONFIG.HAS_REGION 0 \
   CONFIG.NUM_READ_OUTSTANDING 256 \
   CONFIG.NUM_WRITE_OUTSTANDING 256 \
   CONFIG.PROTOCOL AXI4 \
] [get_bd_intf_ports m_axi_dma]

create_bd_port -dir O -from 1 -to 0 intc
create_bd_port -dir I -from 47 -to 0 mac_addr
create_bd_port -dir I -type clk -freq_hz $g_init_clk_freq init_clk
create_bd_port -dir I -type clk -freq_hz $g_saxi_freq s_axi_clk
create_bd_port -dir I -type rst s_axi_resetn
set_property -dict [ list \
   CONFIG.POLARITY ACTIVE_LOW \
] [get_bd_ports s_axi_resetn]
set_property CONFIG.ASSOCIATED_RESET s_axi_resetn [get_bd_ports s_axi_clk]

set eth100gb_init_clk_freq [expr $g_init_clk_freq/1000000]

if { $g_board_part == "u55c" } {
	set g_eth100gb_freq "161.1328125"
	if { $g_eth_port == "qsfp0" } {
		set g_cmac_loc   "CMACE4_X0Y3"
		set g_gt_grp_loc "X0Y24~X0Y27"
		set g_lane1_loc  "X0Y24"
		set g_lane2_loc  "X0Y25"
		set g_lane3_loc  "X0Y26"
		set g_lane4_loc  "X0Y27"
	} elseif { $g_eth_port == "qsfp1" } {
		set g_cmac_loc   "CMACE4_X0Y4"
		set g_gt_grp_loc "X0Y28~X0Y31"
		set g_lane1_loc  "X0Y28"
		set g_lane2_loc  "X0Y29"
		set g_lane3_loc  "X0Y30"
		set g_lane4_loc  "X0Y31"
	} else {
		puts "Invalid ethernet port $g_eth_port"
		exit 1
	}
} else {
	puts "Board $g_board_part not supported"
	exit 1
}

create_bd_cell -type ip -vlnv xilinx.com:ip:cmac_usplus:3.1 eth100gb
set_property -dict [ list \
   CONFIG.ADD_GT_CNRL_STS_PORTS 0 \
   CONFIG.CMAC_CAUI4_MODE 1 \
   CONFIG.CMAC_CORE_SELECT $g_cmac_loc \
   CONFIG.DIFFCLK_BOARD_INTERFACE Custom \
   CONFIG.ENABLE_AXI_INTERFACE 1 \
   CONFIG.ENABLE_PIPELINE_REG 0 \
   CONFIG.ENABLE_TIME_STAMPING 0 \
   CONFIG.ETHERNET_BOARD_INTERFACE Custom \
   CONFIG.GT_GROUP_SELECT $g_gt_grp_loc \
   CONFIG.GT_REF_CLK_FREQ $g_eth100gb_freq \
   CONFIG.GT_RX_BUFFER_BYPASS 0 \
   CONFIG.INCLUDE_AUTO_NEG_LT_LOGIC 0 \
   CONFIG.INCLUDE_RS_FEC 0 \
   CONFIG.INCLUDE_STATISTICS_COUNTERS 0 \
   CONFIG.LANE10_GT_LOC NA \
   CONFIG.LANE1_GT_LOC $g_lane1_loc \
   CONFIG.LANE2_GT_LOC $g_lane2_loc \
   CONFIG.LANE3_GT_LOC $g_lane3_loc \
   CONFIG.LANE4_GT_LOC $g_lane4_loc \
   CONFIG.LANE5_GT_LOC NA \
   CONFIG.LANE6_GT_LOC NA \
   CONFIG.LANE7_GT_LOC NA \
   CONFIG.LANE8_GT_LOC NA \
   CONFIG.LANE9_GT_LOC NA \
   CONFIG.NUM_LANES 4x25 \
   CONFIG.PLL_TYPE QPLL0 \
   CONFIG.RX_CHECK_ACK 1 \
   CONFIG.RX_EQ_MODE AUTO \
   CONFIG.RX_FLOW_CONTROL 0 \
   CONFIG.RX_FORWARD_CONTROL_FRAMES 0 \
   CONFIG.RX_GT_BUFFER 1 \
   CONFIG.RX_MAX_PACKET_LEN 9600 \
   CONFIG.RX_MIN_PACKET_LEN 64 \
   CONFIG.TX_FLOW_CONTROL 0 \
   CONFIG.TX_OTN_INTERFACE 0 \
   CONFIG.USER_INTERFACE AXIS \
   CONFIG.USE_BOARD_FLOW true \
   CONFIG.GT_DRP_CLK $eth100gb_init_clk_freq \
] [get_bd_cells eth100gb]

set g_refport_freq [format {%0.0f} [expr $g_eth100gb_freq*1000000]]
set_property -dict [ list \
   CONFIG.FREQ_HZ $g_refport_freq \
] [get_bd_intf_ports qsfp_refck]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 eth_dma
set_property -dict [ list \
   CONFIG.c_addr_width $g_dma_addr_width \
   CONFIG.c_include_mm2s_dre 1 \
   CONFIG.c_include_s2mm_dre 1 \
   CONFIG.c_include_sg 1 \
   CONFIG.c_m_axi_mm2s_data_width 512 \
   CONFIG.c_m_axis_mm2s_tdata_width 512 \
   CONFIG.c_mm2s_burst_size 64 \
   CONFIG.c_s2mm_burst_size 64 \
   CONFIG.c_sg_include_stscntrl_strm 0 \
   CONFIG.c_sg_length_width 22 \
] [get_bd_cells eth_dma]

create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter: rx_clk_conv
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter: tx_clk_conv
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset: rx_reset
set_property -dict [list \
  CONFIG.C_AUX_RST_WIDTH 1 \
  CONFIG.C_EXT_RST_WIDTH 1 \
] [get_bd_cells rx_reset]
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset: tx_reset
set_property -dict [list \
  CONFIG.C_AUX_RST_WIDTH 1 \
  CONFIG.C_EXT_RST_WIDTH 1 \
] [get_bd_cells tx_reset]

create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect: periph_connect
set_property -dict [ list \
   CONFIG.NUM_MI 3 \
   CONFIG.NUM_SI 1 \
] [get_bd_cells periph_connect]

create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect: dma_intconnect
set_property -dict [ list \
   CONFIG.NUM_SI   3 \
   CONFIG.NUM_CLKS 1 \
] [get_bd_cells dma_intconnect]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio mac_gpio
set_property -dict [list \
   CONFIG.C_ALL_INPUTS 1 \
   CONFIG.C_ALL_OUTPUTS 0 \
   CONFIG.C_ALL_INPUTS_2 1 \
   CONFIG.C_ALL_OUTPUTS_2 0 \
   CONFIG.C_IS_DUAL 1 \
   CONFIG.C_GPIO2_WIDTH 16 \
] [get_bd_cells mac_gpio]

create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilslice mac_slice_lo
set_property -dict [list \
   CONFIG.DIN_FROM 31 \
   CONFIG.DIN_TO 0 \
   CONFIG.DIN_WIDTH 48 \
] [get_bd_cells mac_slice_lo]

create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilslice mac_slice_hi
set_property -dict [list \
   CONFIG.DIN_FROM 47 \
   CONFIG.DIN_TO 32 \
   CONFIG.DIN_WIDTH 48 \
] [get_bd_cells mac_slice_hi]

create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo: tx_fifo
set_property -dict [ list \
   CONFIG.FIFO_DEPTH 256 \
   CONFIG.FIFO_MODE 2 \
   CONFIG.IS_ACLK_ASYNC 0 \
] [get_bd_cells tx_fifo]

create_bd_cell -type ip -vlnv bsc:eth:eth_rx_fifo_wrapper:1.0 rx_fifo
set_property -dict [ list \
   CONFIG.FRAME_QUEUE_LEN 4096 \
] [get_bd_cells rx_fifo]

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat: concat_intc
set_property -dict [ list \
   CONFIG.NUM_PORTS 2 \
] [get_bd_cells concat_intc]

create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic: s_axi_rstn_inv
set_property -dict [ list \
   CONFIG.C_OPERATION not \
   CONFIG.C_SIZE 1 \
] [get_bd_cells s_axi_rstn_inv]

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant: const_gnd
set_property -dict [ list \
   CONFIG.CONST_VAL 0 \
] [get_bd_cells const_gnd]

# Interfaces
connect_bd_intf_net [get_bd_intf_ports qsfp_4x] [get_bd_intf_pins eth100gb/gt_serial_port]
connect_bd_intf_net [get_bd_intf_ports qsfp_refck] [get_bd_intf_pins eth100gb/gt_ref_clk]
connect_bd_intf_net [get_bd_intf_pins eth100gb/s_axi] [get_bd_intf_pins periph_connect/M00_AXI]
connect_bd_intf_net [get_bd_intf_pins eth_dma/S_AXI_LITE] [get_bd_intf_pins periph_connect/M01_AXI]
connect_bd_intf_net [get_bd_intf_pins rx_fifo/so] [get_bd_intf_pins rx_clk_conv/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins rx_clk_conv/M_AXIS] [get_bd_intf_pins eth_dma/S_AXIS_S2MM]
connect_bd_intf_net [get_bd_intf_pins tx_clk_conv/M_AXIS] [get_bd_intf_pins tx_fifo/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXIS_MM2S] [get_bd_intf_pins tx_clk_conv/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins eth100gb/axis_rx] [get_bd_intf_pins rx_fifo/rx]
connect_bd_intf_net [get_bd_intf_ports s_axi] [get_bd_intf_pins periph_connect/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins eth100gb/axis_tx] [get_bd_intf_pins tx_fifo/M_AXIS]
connect_bd_intf_net [get_bd_intf_pins periph_connect/M02_AXI] [get_bd_intf_pins mac_gpio/S_AXI]
connect_bd_intf_net [get_bd_intf_ports m_axi_dma] [get_bd_intf_pins dma_intconnect/M00_AXI]
connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXI_SG] [get_bd_intf_pins dma_intconnect/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXI_MM2S] [get_bd_intf_pins dma_intconnect/S01_AXI]
connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXI_S2MM] [get_bd_intf_pins dma_intconnect/S02_AXI]

# Misc
connect_bd_net [get_bd_pins mac_slice_lo/Dout] [get_bd_pins mac_gpio/gpio_io_i]
connect_bd_net [get_bd_pins mac_slice_hi/Dout] [get_bd_pins mac_gpio/gpio2_io_i]
connect_bd_net [get_bd_ports mac_addr] [get_bd_pins mac_slice_lo/Din] [get_bd_pins mac_slice_hi/Din]
connect_bd_net [get_bd_ports intc] [get_bd_pins concat_intc/dout]
connect_bd_net [get_bd_pins concat_intc/In0] [get_bd_pins eth_dma/mm2s_introut]
connect_bd_net [get_bd_pins concat_intc/In1] [get_bd_pins eth_dma/s2mm_introut]

# Clocks
connect_bd_net [get_bd_ports s_axi_clk] [get_bd_pins eth100gb/s_axi_aclk] [get_bd_pins periph_connect/aclk] [get_bd_pins mac_gpio/s_axi_aclk] [get_bd_pins rx_clk_conv/m_axis_aclk] [get_bd_pins tx_clk_conv/s_axis_aclk] [get_bd_pins dma_intconnect/aclk] [get_bd_pins eth_dma/s_axi_lite_aclk] [get_bd_pins eth_dma/m_axi_sg_aclk] [get_bd_pins eth_dma/m_axi_mm2s_aclk] [get_bd_pins eth_dma/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins eth100gb/gt_rxusrclk2] [get_bd_pins eth100gb/rx_clk] [get_bd_pins rx_fifo/clk] [get_bd_pins rx_clk_conv/s_axis_aclk] [get_bd_pins rx_reset/slowest_sync_clk]
connect_bd_net [get_bd_pins eth100gb/gt_txusrclk2] [get_bd_pins tx_fifo/s_axis_aclk] [get_bd_pins tx_clk_conv/m_axis_aclk] [get_bd_pins tx_reset/slowest_sync_clk]
connect_bd_net [get_bd_ports init_clk] [get_bd_pins eth100gb/init_clk]
connect_bd_net [get_bd_pins const_gnd/dout] [get_bd_pins eth100gb/drp_clk]

# Resets
connect_bd_net [get_bd_ports s_axi_resetn] [get_bd_pins periph_connect/aresetn] [get_bd_pins dma_intconnect/aresetn] [get_bd_pins eth_dma/axi_resetn] [get_bd_pins rx_clk_conv/m_axis_aresetn] [get_bd_pins tx_clk_conv/s_axis_aresetn] [get_bd_pins tx_reset/ext_reset_in] [get_bd_pins rx_reset/ext_reset_in] [get_bd_pins mac_gpio/s_axi_aresetn] [get_bd_pins s_axi_rstn_inv/Op1]
connect_bd_net [get_bd_pins s_axi_rstn_inv/Res] [get_bd_pins eth100gb/s_axi_sreset] [get_bd_pins eth100gb/sys_reset] [get_bd_pins eth100gb/core_rx_reset] [get_bd_pins eth100gb/core_tx_reset] [get_bd_pins eth100gb/gtwiz_reset_tx_datapath] [get_bd_pins eth100gb/gtwiz_reset_rx_datapath]
connect_bd_net [get_bd_pins tx_reset/peripheral_aresetn] [get_bd_pins tx_fifo/s_axis_aresetn] [get_bd_pins tx_clk_conv/m_axis_aresetn]
connect_bd_net [get_bd_pins rx_reset/peripheral_aresetn] [get_bd_pins rx_fifo/rstn] [get_bd_pins rx_clk_conv/s_axis_aresetn]

assign_bd_address -offset 0x00010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs eth100gb/s_axi/Reg]
assign_bd_address -offset 0x00000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs eth_dma/S_AXI_LITE/Reg]
assign_bd_address -offset 0x00006000 -range 0x00001000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs mac_gpio/S_AXI/Reg]

assign_bd_address -offset 0x00000000 -range [expr (1 << $g_dma_addr_width)] -target_address_space [get_bd_addr_spaces eth_dma/Data_MM2S] [get_bd_addr_segs m_axi_dma/Reg]
assign_bd_address -offset 0x00000000 -range [expr (1 << $g_dma_addr_width)] -target_address_space [get_bd_addr_spaces eth_dma/Data_S2MM] [get_bd_addr_segs m_axi_dma/Reg]
assign_bd_address -offset 0x00000000 -range [expr (1 << $g_dma_addr_width)] -target_address_space [get_bd_addr_spaces eth_dma/Data_SG]   [get_bd_addr_segs m_axi_dma/Reg]

validate_bd_design
save_bd_design
