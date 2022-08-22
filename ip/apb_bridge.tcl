# Create IP

create_ip -name axi_apb_bridge -vendor xilinx.com -library ip -version 3.0 -module_name axi_apb_bridge_0

set_property -dict [list CONFIG.C_APB_NUM_SLAVES {1}] [get_ips axi_apb_bridge_0]
set_property -dict [list CONFIG.C_ADDR_WIDTH {5}] [get_ips axi_apb_bridge_0]


