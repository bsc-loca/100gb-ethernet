
################################################################
# This is a generated script based on design: ethernet_test
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source ethernet_test_script.tcl

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:axi_timer:2.0\
xilinx.com:ip:axis_broadcaster:1.1\
xilinx.com:ip:axis_combiner:1.1\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:cmac_usplus:3.1\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:axi_ethernetlite:3.0\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:axis_switch:1.1\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:util_reduced_logic:2.0\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:lmb_v10:3.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB

  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB


  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 lmb_bram ]
  set_property -dict [ list \
   CONFIG.Assume_Synchronous_Clk {true} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {NO_CHANGE} \
   CONFIG.Operating_Mode_B {NO_CHANGE} \
   CONFIG.PRIM_type_to_Implement {URAM} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set qsfp0_156mhz [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 qsfp0_156mhz ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $qsfp0_156mhz

  set qsfp0_4x [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 qsfp0_4x ]

  set sysclk0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sysclk0 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $sysclk0


  # Create ports
  set HBM_CATTRIP [ create_bd_port -dir O -from 0 -to 0 HBM_CATTRIP ]
  set_property USER_COMMENTS.comment_0 "If unused HBM_CATTRIP should be driven low
to avoid the SC shutting down the card (UG1314)" [get_bd_ports /HBM_CATTRIP]
  set QSFP0_FS [ create_bd_port -dir O -from 0 -to 0 QSFP0_FS ]
  set QSFP0_OEB [ create_bd_port -dir O -from 0 -to 0 QSFP0_OEB ]
  set resetn [ create_bd_port -dir I -type rst resetn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $resetn

  # Create instance: GT_STATUS, and set properties
  set GT_STATUS [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 GT_STATUS ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {2} \
 ] $GT_STATUS

  # Create instance: STAT_RX_STATUS_REG, and set properties
  set STAT_RX_STATUS_REG [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 STAT_RX_STATUS_REG ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {14} \
 ] $STAT_RX_STATUS_REG

  # Create instance: STAT_TX_STATUS_REG, and set properties
  set STAT_TX_STATUS_REG [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 STAT_TX_STATUS_REG ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {2} \
 ] $STAT_TX_STATUS_REG

  # Create instance: axi_timer_0, and set properties
  set axi_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0 ]
  set_property -dict [ list \
   CONFIG.enable_timer2 {1} \
 ] $axi_timer_0

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]
  set_property -dict [ list \
   CONFIG.M00_TDATA_REMAP {tdata[31:0]} \
   CONFIG.M01_TDATA_REMAP {tdata[63:32]} \
   CONFIG.M02_TDATA_REMAP {tdata[95:64]} \
   CONFIG.M03_TDATA_REMAP {tdata[127:96]} \
   CONFIG.M04_TDATA_REMAP {tdata[159:128]} \
   CONFIG.M05_TDATA_REMAP {tdata[191:160]} \
   CONFIG.M06_TDATA_REMAP {tdata[223:192]} \
   CONFIG.M07_TDATA_REMAP {tdata[255:224]} \
   CONFIG.M08_TDATA_REMAP {tdata[287:256]} \
   CONFIG.M09_TDATA_REMAP {tdata[319:288]} \
   CONFIG.M10_TDATA_REMAP {tdata[351:320]} \
   CONFIG.M11_TDATA_REMAP {tdata[383:352]} \
   CONFIG.M12_TDATA_REMAP {tdata[415:384]} \
   CONFIG.M13_TDATA_REMAP {tdata[447:416]} \
   CONFIG.M14_TDATA_REMAP {tdata[479:448]} \
   CONFIG.M15_TDATA_REMAP {tdata[511:480]} \
   CONFIG.M_TDATA_NUM_BYTES {4} \
   CONFIG.NUM_MI {16} \
   CONFIG.S_TDATA_NUM_BYTES {64} \
 ] $axis_broadcaster_0

  # Create instance: axis_combiner_0, and set properties
  set axis_combiner_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0 ]
  set_property -dict [ list \
   CONFIG.NUM_SI {16} \
 ] $axis_combiner_0

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_1 ]
  set_property -dict [ list \
   CONFIG.CLK_IN1_BOARD_INTERFACE {sysclk0} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.RESET_BOARD_INTERFACE {resetn} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $clk_wiz_1

  # Create instance: cmac_usplus_0, and set properties
  set cmac_usplus_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:cmac_usplus:3.1 cmac_usplus_0 ]
  set_property -dict [ list \
   CONFIG.ADD_GT_CNRL_STS_PORTS {0} \
   CONFIG.DIFFCLK_BOARD_INTERFACE {qsfp0_156mhz} \
   CONFIG.ENABLE_AXI_INTERFACE {0} \
   CONFIG.ENABLE_PIPELINE_REG {0} \
   CONFIG.ENABLE_TIME_STAMPING {0} \
   CONFIG.ETHERNET_BOARD_INTERFACE {qsfp0_4x} \
   CONFIG.GT_REF_CLK_FREQ {156.25} \
   CONFIG.GT_RX_BUFFER_BYPASS {0} \
   CONFIG.INCLUDE_AUTO_NEG_LT_LOGIC {0} \
   CONFIG.INCLUDE_RS_FEC {1} \
   CONFIG.INCLUDE_STATISTICS_COUNTERS {0} \
   CONFIG.PLL_TYPE {QPLL0} \
   CONFIG.RX_CHECK_ACK {1} \
   CONFIG.RX_EQ_MODE {AUTO} \
   CONFIG.RX_FLOW_CONTROL {0} \
   CONFIG.RX_FORWARD_CONTROL_FRAMES {0} \
   CONFIG.RX_GT_BUFFER {1} \
   CONFIG.TX_FLOW_CONTROL {0} \
   CONFIG.TX_OTN_INTERFACE {0} \
   CONFIG.USER_INTERFACE {AXIS} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $cmac_usplus_0
  set_property USER_COMMENTS.comment_3 "https://www.xilinx.com/support/documentation/ip_documentation/l_ethernet/v3_1/pg211-50g-ethernet.pdf#page=26" [get_bd_intf_pins /cmac_usplus_0/axis_rx]
  set_property USER_COMMENTS.comment_2 "https://www.xilinx.com/support/documentation/ip_documentation/l_ethernet/v3_1/pg211-50g-ethernet.pdf#page=23" [get_bd_intf_pins /cmac_usplus_0/axis_tx]
  set_property USER_COMMENTS.comment_1 "http://www.xilinx.com/support/documentation/ip_documentation/cmac_usplus/v3_1/pg203-cmac-usplus.pdf#page=117
http://www.xilinx.com/support/documentation/user_guides/ug578-ultrascale-gty-transceivers.pdf#page=88" [get_bd_pins /cmac_usplus_0/gt_loopback_in]
  set_property USER_COMMENTS.comment_4 "https://www.xilinx.com/support/documentation/user_guides/ug578-ultrascale-gty-transceivers.pdf#page=88" [get_bd_pins /cmac_usplus_0/gt_loopback_in]

  # Create instance: concat_intc, and set properties
  set concat_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_intc ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {5} \
 ] $concat_intc

  # Create instance: const_gnd, and set properties
  set const_gnd [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_gnd ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $const_gnd

  # Create instance: const_gndx17, and set properties
  set const_gndx17 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_gndx17 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {17} \
 ] $const_gndx17

  # Create instance: const_gndx28, and set properties
  set const_gndx28 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_gndx28 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {28} \
 ] $const_gndx28

  # Create instance: const_gndx31, and set properties
  set const_gndx31 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_gndx31 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {31} \
 ] $const_gndx31

  # Create instance: const_gndx56, and set properties
  set const_gndx56 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_gndx56 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {56} \
 ] $const_gndx56

  # Create instance: const_vcc, and set properties
  set const_vcc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_vcc ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $const_vcc

  # Create instance: const_vccx64, and set properties
  set const_vccx64 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_vccx64 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0xFFFFFFFFFFFFFFFF} \
   CONFIG.CONST_WIDTH {64} \
 ] $const_vccx64

  # Create instance: ctl_rx_enable, and set properties
  set ctl_rx_enable [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ctl_rx_enable ]

  # Create instance: ctl_rx_force_resync, and set properties
  set ctl_rx_force_resync [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ctl_rx_force_resync ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {7} \
   CONFIG.DIN_TO {7} \
   CONFIG.DOUT_WIDTH {1} \
 ] $ctl_rx_force_resync

  # Create instance: ctl_rx_test_pattern, and set properties
  set ctl_rx_test_pattern [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ctl_rx_test_pattern ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {8} \
   CONFIG.DIN_TO {8} \
   CONFIG.DOUT_WIDTH {1} \
 ] $ctl_rx_test_pattern

  # Create instance: ctl_tx_enable, and set properties
  set ctl_tx_enable [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ctl_tx_enable ]

  # Create instance: ctl_tx_send_idle, and set properties
  set ctl_tx_send_idle [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ctl_tx_send_idle ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {5} \
   CONFIG.DIN_TO {5} \
   CONFIG.DOUT_WIDTH {1} \
 ] $ctl_tx_send_idle

  # Create instance: ctl_tx_send_lfi, and set properties
  set ctl_tx_send_lfi [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ctl_tx_send_lfi ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DOUT_WIDTH {1} \
 ] $ctl_tx_send_lfi

  # Create instance: ctl_tx_send_rfi, and set properties
  set ctl_tx_send_rfi [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ctl_tx_send_rfi ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {4} \
   CONFIG.DIN_TO {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $ctl_tx_send_rfi

  # Create instance: ctl_tx_test_pattern, and set properties
  set ctl_tx_test_pattern [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ctl_tx_test_pattern ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {16} \
   CONFIG.DIN_TO {16} \
   CONFIG.DOUT_WIDTH {1} \
 ] $ctl_tx_test_pattern

  # Create instance: dummy_ethernetlite, and set properties
  set dummy_ethernetlite [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 dummy_ethernetlite ]

  # Create instance: eth_dma, and set properties
  set eth_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 eth_dma ]
  set_property -dict [ list \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_mm2s_data_width {512} \
   CONFIG.c_m_axis_mm2s_tdata_width {512} \
   CONFIG.c_mm2s_burst_size {64} \
   CONFIG.c_s2mm_burst_size {64} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {16} \
 ] $eth_dma

  # Create instance: gt_ctl, and set properties
  set gt_ctl [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gt_ctl ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {0} \
   CONFIG.C_ALL_OUTPUTS {0} \
   CONFIG.C_IS_DUAL {0} \
 ] $gt_ctl

  # Create instance: gt_loopback, and set properties
  set gt_loopback [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 gt_loopback ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $gt_loopback

  # Create instance: gt_loopback0, and set properties
  set gt_loopback0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 gt_loopback0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {0} \
   CONFIG.DOUT_WIDTH {3} \
 ] $gt_loopback0

  # Create instance: gt_loopback1, and set properties
  set gt_loopback1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 gt_loopback1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {6} \
   CONFIG.DIN_TO {4} \
   CONFIG.DOUT_WIDTH {3} \
 ] $gt_loopback1

  # Create instance: gt_loopback2, and set properties
  set gt_loopback2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 gt_loopback2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {10} \
   CONFIG.DIN_TO {8} \
   CONFIG.DOUT_WIDTH {3} \
 ] $gt_loopback2

  # Create instance: gt_loopback3, and set properties
  set gt_loopback3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 gt_loopback3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {14} \
   CONFIG.DIN_TO {12} \
   CONFIG.DOUT_WIDTH {3} \
 ] $gt_loopback3

  # Create instance: loopback_fifo, and set properties
  set loopback_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 loopback_fifo ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $loopback_fifo

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_SIZE {32} \
   CONFIG.C_M_AXI_ADDR_WIDTH {32} \
   CONFIG.C_USE_UART {1} \
 ] $mdm_1

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_FSL_LINKS {16} \
   CONFIG.C_I_LMB {1} \
   CONFIG.G_TEMPLATE_LIST {8} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list \
   CONFIG.C_HAS_FAST {1} \
 ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
   CONFIG.NUM_MI {11} \
   CONFIG.NUM_SI {1} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: resetn_inv_0, and set properties
  set resetn_inv_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 resetn_inv_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
 ] $resetn_inv_0

  # Create instance: rx_axis_switch, and set properties
  set rx_axis_switch [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 rx_axis_switch ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {2} \
   CONFIG.ROUTING_MODE {1} \
 ] $rx_axis_switch

  # Create instance: rx_fifo, and set properties
  set rx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 rx_fifo ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {64} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $rx_fifo

  # Create instance: rx_mem, and set properties
  set rx_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 rx_mem ]
  set_property -dict [ list \
   CONFIG.Assume_Synchronous_Clk {true} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.PRIM_type_to_Implement {BRAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTB_Pin {true} \
 ] $rx_mem

  # Create instance: rx_mem_cpu, and set properties
  set rx_mem_cpu [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 rx_mem_cpu ]
  set_property -dict [ list \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.ECC_TYPE {0} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $rx_mem_cpu

  # Create instance: rx_mem_dma, and set properties
  set rx_mem_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 rx_mem_dma ]
  set_property -dict [ list \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.ECC_TYPE {0} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $rx_mem_dma

  # Create instance: rx_rst_gen, and set properties
  set rx_rst_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rx_rst_gen ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {resetn} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $rx_rst_gen

  # Create instance: sys_rst_gen, and set properties
  set sys_rst_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_rst_gen ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {resetn} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $sys_rst_gen

  # Create instance: tx_axis_switch, and set properties
  set tx_axis_switch [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 tx_axis_switch ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_S00_CONNECTIVITY {1} \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {2} \
   CONFIG.ROUTING_MODE {1} \
 ] $tx_axis_switch

  # Create instance: tx_fifo, and set properties
  set tx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 tx_fifo ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $tx_fifo

  # Create instance: tx_mem, and set properties
  set tx_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 tx_mem ]
  set_property -dict [ list \
   CONFIG.Assume_Synchronous_Clk {true} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.PRIM_type_to_Implement {BRAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTB_Pin {true} \
 ] $tx_mem

  # Create instance: tx_mem_cpu, and set properties
  set tx_mem_cpu [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 tx_mem_cpu ]
  set_property -dict [ list \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.ECC_TYPE {0} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $tx_mem_cpu

  # Create instance: tx_mem_dma, and set properties
  set tx_mem_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 tx_mem_dma ]
  set_property -dict [ list \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.ECC_TYPE {0} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $tx_mem_dma

  # Create instance: tx_rst_gen, and set properties
  set tx_rst_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 tx_rst_gen ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {resetn} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $tx_rst_gen

  # Create instance: tx_rx_ctl_stat, and set properties
  set tx_rx_ctl_stat [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 tx_rx_ctl_stat ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {0} \
   CONFIG.C_ALL_OUTPUTS {0} \
   CONFIG.C_IS_DUAL {1} \
 ] $tx_rx_ctl_stat

  # Create instance: util_reduced_logic_0, and set properties
  set util_reduced_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 util_reduced_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {4} \
 ] $util_reduced_logic_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins tx_mem/BRAM_PORTA] [get_bd_intf_pins tx_mem_cpu/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S [get_bd_intf_pins eth_dma/M_AXIS_MM2S] [get_bd_intf_pins tx_axis_switch/S01_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins microblaze_0/S0_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins microblaze_0/S1_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M02_AXIS [get_bd_intf_pins axis_broadcaster_0/M02_AXIS] [get_bd_intf_pins microblaze_0/S2_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M03_AXIS [get_bd_intf_pins axis_broadcaster_0/M03_AXIS] [get_bd_intf_pins microblaze_0/S3_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M04_AXIS [get_bd_intf_pins axis_broadcaster_0/M04_AXIS] [get_bd_intf_pins microblaze_0/S4_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M05_AXIS [get_bd_intf_pins axis_broadcaster_0/M05_AXIS] [get_bd_intf_pins microblaze_0/S5_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M06_AXIS [get_bd_intf_pins axis_broadcaster_0/M06_AXIS] [get_bd_intf_pins microblaze_0/S6_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M07_AXIS [get_bd_intf_pins axis_broadcaster_0/M07_AXIS] [get_bd_intf_pins microblaze_0/S7_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M08_AXIS [get_bd_intf_pins axis_broadcaster_0/M08_AXIS] [get_bd_intf_pins microblaze_0/S8_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M09_AXIS [get_bd_intf_pins axis_broadcaster_0/M09_AXIS] [get_bd_intf_pins microblaze_0/S9_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M10_AXIS [get_bd_intf_pins axis_broadcaster_0/M10_AXIS] [get_bd_intf_pins microblaze_0/S10_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M11_AXIS [get_bd_intf_pins axis_broadcaster_0/M11_AXIS] [get_bd_intf_pins microblaze_0/S11_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M12_AXIS [get_bd_intf_pins axis_broadcaster_0/M12_AXIS] [get_bd_intf_pins microblaze_0/S12_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M13_AXIS [get_bd_intf_pins axis_broadcaster_0/M13_AXIS] [get_bd_intf_pins microblaze_0/S13_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M14_AXIS [get_bd_intf_pins axis_broadcaster_0/M14_AXIS] [get_bd_intf_pins microblaze_0/S14_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M15_AXIS [get_bd_intf_pins axis_broadcaster_0/M15_AXIS] [get_bd_intf_pins microblaze_0/S15_AXIS]
  connect_bd_intf_net -intf_net axis_combiner_0_M_AXIS [get_bd_intf_pins axis_combiner_0/M_AXIS] [get_bd_intf_pins tx_fifo/S_AXIS]
  connect_bd_intf_net -intf_net cmac_usplus_0_axis_rx [get_bd_intf_pins cmac_usplus_0/axis_rx] [get_bd_intf_pins rx_axis_switch/S01_AXIS]
  connect_bd_intf_net -intf_net cmac_usplus_0_gt_serial_port [get_bd_intf_ports qsfp0_4x] [get_bd_intf_pins cmac_usplus_0/gt_serial_port]
  connect_bd_intf_net -intf_net eth_dma_M_AXI_MM2S [get_bd_intf_pins eth_dma/M_AXI_MM2S] [get_bd_intf_pins tx_mem_dma/S_AXI]
  connect_bd_intf_net -intf_net eth_dma_M_AXI_S2MM [get_bd_intf_pins eth_dma/M_AXI_S2MM] [get_bd_intf_pins rx_mem_dma/S_AXI]
  connect_bd_intf_net -intf_net loopback_fifo_M_AXIS [get_bd_intf_pins loopback_fifo/M_AXIS] [get_bd_intf_pins rx_axis_switch/S00_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M0_AXIS [get_bd_intf_pins axis_combiner_0/S00_AXIS] [get_bd_intf_pins microblaze_0/M0_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M10_AXIS [get_bd_intf_pins axis_combiner_0/S10_AXIS] [get_bd_intf_pins microblaze_0/M10_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M11_AXIS [get_bd_intf_pins axis_combiner_0/S11_AXIS] [get_bd_intf_pins microblaze_0/M11_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M12_AXIS [get_bd_intf_pins axis_combiner_0/S12_AXIS] [get_bd_intf_pins microblaze_0/M12_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M13_AXIS [get_bd_intf_pins axis_combiner_0/S13_AXIS] [get_bd_intf_pins microblaze_0/M13_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M14_AXIS [get_bd_intf_pins axis_combiner_0/S14_AXIS] [get_bd_intf_pins microblaze_0/M14_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M15_AXIS [get_bd_intf_pins axis_combiner_0/S15_AXIS] [get_bd_intf_pins microblaze_0/M15_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M1_AXIS [get_bd_intf_pins axis_combiner_0/S01_AXIS] [get_bd_intf_pins microblaze_0/M1_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M2_AXIS [get_bd_intf_pins axis_combiner_0/S02_AXIS] [get_bd_intf_pins microblaze_0/M2_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M3_AXIS [get_bd_intf_pins axis_combiner_0/S03_AXIS] [get_bd_intf_pins microblaze_0/M3_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M4_AXIS [get_bd_intf_pins axis_combiner_0/S04_AXIS] [get_bd_intf_pins microblaze_0/M4_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M5_AXIS [get_bd_intf_pins axis_combiner_0/S05_AXIS] [get_bd_intf_pins microblaze_0/M5_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M6_AXIS [get_bd_intf_pins axis_combiner_0/S06_AXIS] [get_bd_intf_pins microblaze_0/M6_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M7_AXIS [get_bd_intf_pins axis_combiner_0/S07_AXIS] [get_bd_intf_pins microblaze_0/M7_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M8_AXIS [get_bd_intf_pins axis_combiner_0/S08_AXIS] [get_bd_intf_pins microblaze_0/M8_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M9_AXIS [get_bd_intf_pins axis_combiner_0/S09_AXIS] [get_bd_intf_pins microblaze_0/M9_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_axi_dp [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI] [get_bd_intf_pins tx_rx_ctl_stat/S_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI] [get_bd_intf_pins tx_axis_switch/S_AXI_CTRL]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI] [get_bd_intf_pins rx_axis_switch/S_AXI_CTRL]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M05_AXI [get_bd_intf_pins gt_ctl/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M06_AXI [get_bd_intf_pins axi_timer_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M07_AXI [get_bd_intf_pins dummy_ethernetlite/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M08_AXI [get_bd_intf_pins microblaze_0_axi_periph/M08_AXI] [get_bd_intf_pins tx_mem_cpu/S_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M09_AXI [get_bd_intf_pins microblaze_0_axi_periph/M09_AXI] [get_bd_intf_pins rx_mem_cpu/S_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M10_AXI [get_bd_intf_pins eth_dma/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M10_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_intc_axi [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]
  connect_bd_intf_net -intf_net microblaze_0_mdm_axi [get_bd_intf_pins mdm_1/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net qsfp0_156mhz_1 [get_bd_intf_ports qsfp0_156mhz] [get_bd_intf_pins cmac_usplus_0/gt_ref_clk]
  connect_bd_intf_net -intf_net rx_axis_switch_M01_AXIS [get_bd_intf_pins eth_dma/S_AXIS_S2MM] [get_bd_intf_pins rx_axis_switch/M01_AXIS]
  connect_bd_intf_net -intf_net rx_fifo_M_AXIS [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins rx_fifo/M_AXIS]
  connect_bd_intf_net -intf_net rx_mem_ctr_BRAM_PORTA [get_bd_intf_pins rx_mem/BRAM_PORTA] [get_bd_intf_pins rx_mem_cpu/BRAM_PORTA]
  connect_bd_intf_net -intf_net rx_mem_dma_BRAM_PORTA [get_bd_intf_pins rx_mem/BRAM_PORTB] [get_bd_intf_pins rx_mem_dma/BRAM_PORTA]
  connect_bd_intf_net -intf_net rx_switch_M00_AXIS [get_bd_intf_pins rx_axis_switch/M00_AXIS] [get_bd_intf_pins rx_fifo/S_AXIS]
  connect_bd_intf_net -intf_net sysclk0_1 [get_bd_intf_ports sysclk0] [get_bd_intf_pins clk_wiz_1/CLK_IN1_D]
  connect_bd_intf_net -intf_net tx_fifo_M_AXIS [get_bd_intf_pins tx_axis_switch/S00_AXIS] [get_bd_intf_pins tx_fifo/M_AXIS]
  connect_bd_intf_net -intf_net tx_mem_cpu1_BRAM_PORTA [get_bd_intf_pins tx_mem/BRAM_PORTB] [get_bd_intf_pins tx_mem_dma/BRAM_PORTA]
  connect_bd_intf_net -intf_net tx_switch_M00_AXIS [get_bd_intf_pins loopback_fifo/S_AXIS] [get_bd_intf_pins tx_axis_switch/M00_AXIS]
  connect_bd_intf_net -intf_net tx_switch_M01_AXIS [get_bd_intf_pins cmac_usplus_0/axis_tx] [get_bd_intf_pins tx_axis_switch/M01_AXIS]

  # Create port connections
  connect_bd_net -net GT_STATUS_dout [get_bd_pins GT_STATUS/dout] [get_bd_pins gt_ctl/gpio_io_i]
  connect_bd_net -net STAT_RX_STATUS_REG_dout [get_bd_pins STAT_RX_STATUS_REG/dout] [get_bd_pins tx_rx_ctl_stat/gpio2_io_i]
  connect_bd_net -net STAT_TX_STATUS_REG1_dout [get_bd_pins cmac_usplus_0/gt_loopback_in] [get_bd_pins gt_loopback/dout]
  connect_bd_net -net axi_ethernetlite_0_ip2intc_irpt [get_bd_pins concat_intc/In2] [get_bd_pins dummy_ethernetlite/ip2intc_irpt]
  connect_bd_net -net axi_gpio_0_gpio2_io_o [get_bd_pins ctl_rx_enable/Din] [get_bd_pins ctl_rx_force_resync/Din] [get_bd_pins ctl_rx_test_pattern/Din] [get_bd_pins tx_rx_ctl_stat/gpio2_io_o]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins ctl_tx_enable/Din] [get_bd_pins ctl_tx_send_idle/Din] [get_bd_pins ctl_tx_send_lfi/Din] [get_bd_pins ctl_tx_send_rfi/Din] [get_bd_pins ctl_tx_test_pattern/Din] [get_bd_pins tx_rx_ctl_stat/gpio_io_o]
  connect_bd_net -net axi_timer_0_interrupt [get_bd_pins axi_timer_0/interrupt] [get_bd_pins concat_intc/In1]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins clk_wiz_1/locked] [get_bd_pins sys_rst_gen/dcm_locked]
  connect_bd_net -net cmac_usplus_0_gt_powergoodout [get_bd_pins GT_STATUS/In0] [get_bd_pins cmac_usplus_0/gt_powergoodout] [get_bd_pins util_reduced_logic_0/Op1]
  connect_bd_net -net cmac_usplus_0_gt_rxusrclk2 [get_bd_pins cmac_usplus_0/gt_rxusrclk2] [get_bd_pins cmac_usplus_0/rx_clk] [get_bd_pins eth_dma/m_axi_s2mm_aclk] [get_bd_pins loopback_fifo/m_axis_aclk] [get_bd_pins microblaze_0_axi_periph/M09_ACLK] [get_bd_pins rx_axis_switch/aclk] [get_bd_pins rx_fifo/s_axis_aclk] [get_bd_pins rx_mem_cpu/s_axi_aclk] [get_bd_pins rx_mem_dma/s_axi_aclk] [get_bd_pins rx_rst_gen/slowest_sync_clk]
  connect_bd_net -net cmac_usplus_0_gt_txusrclk2 [get_bd_pins cmac_usplus_0/gt_txusrclk2] [get_bd_pins eth_dma/m_axi_mm2s_aclk] [get_bd_pins loopback_fifo/s_axis_aclk] [get_bd_pins microblaze_0_axi_periph/M08_ACLK] [get_bd_pins tx_axis_switch/aclk] [get_bd_pins tx_fifo/m_axis_aclk] [get_bd_pins tx_mem_cpu/s_axi_aclk] [get_bd_pins tx_mem_dma/s_axi_aclk] [get_bd_pins tx_rst_gen/slowest_sync_clk]
  connect_bd_net -net cmac_usplus_0_stat_rx_aligned [get_bd_pins STAT_RX_STATUS_REG/In1] [get_bd_pins cmac_usplus_0/stat_rx_aligned]
  connect_bd_net -net cmac_usplus_0_stat_rx_aligned_err [get_bd_pins STAT_RX_STATUS_REG/In3] [get_bd_pins cmac_usplus_0/stat_rx_aligned_err]
  connect_bd_net -net cmac_usplus_0_stat_rx_bad_preamble [get_bd_pins STAT_RX_STATUS_REG/In10] [get_bd_pins cmac_usplus_0/stat_rx_bad_preamble]
  connect_bd_net -net cmac_usplus_0_stat_rx_bad_sfd [get_bd_pins STAT_RX_STATUS_REG/In11] [get_bd_pins cmac_usplus_0/stat_rx_bad_sfd]
  connect_bd_net -net cmac_usplus_0_stat_rx_got_signal_os [get_bd_pins STAT_RX_STATUS_REG/In12] [get_bd_pins cmac_usplus_0/stat_rx_got_signal_os]
  connect_bd_net -net cmac_usplus_0_stat_rx_hi_ber [get_bd_pins STAT_RX_STATUS_REG/In4] [get_bd_pins cmac_usplus_0/stat_rx_hi_ber]
  connect_bd_net -net cmac_usplus_0_stat_rx_internal_local_fault [get_bd_pins STAT_RX_STATUS_REG/In7] [get_bd_pins cmac_usplus_0/stat_rx_internal_local_fault]
  connect_bd_net -net cmac_usplus_0_stat_rx_local_fault [get_bd_pins STAT_RX_STATUS_REG/In6] [get_bd_pins cmac_usplus_0/stat_rx_local_fault]
  connect_bd_net -net cmac_usplus_0_stat_rx_misaligned [get_bd_pins STAT_RX_STATUS_REG/In2] [get_bd_pins cmac_usplus_0/stat_rx_misaligned]
  connect_bd_net -net cmac_usplus_0_stat_rx_received_local_fault [get_bd_pins STAT_RX_STATUS_REG/In8] [get_bd_pins cmac_usplus_0/stat_rx_received_local_fault]
  connect_bd_net -net cmac_usplus_0_stat_rx_remote_fault [get_bd_pins STAT_RX_STATUS_REG/In5] [get_bd_pins cmac_usplus_0/stat_rx_remote_fault]
  connect_bd_net -net cmac_usplus_0_stat_rx_status [get_bd_pins STAT_RX_STATUS_REG/In0] [get_bd_pins cmac_usplus_0/stat_rx_status]
  connect_bd_net -net cmac_usplus_0_stat_rx_test_pattern_mismatch [get_bd_pins STAT_RX_STATUS_REG/In9] [get_bd_pins cmac_usplus_0/stat_rx_test_pattern_mismatch]
  connect_bd_net -net cmac_usplus_0_stat_tx_local_fault [get_bd_pins STAT_TX_STATUS_REG/In0] [get_bd_pins cmac_usplus_0/stat_tx_local_fault]
  connect_bd_net -net const_gnd_dout [get_bd_ports HBM_CATTRIP] [get_bd_ports QSFP0_OEB] [get_bd_pins axi_timer_0/capturetrig0] [get_bd_pins axi_timer_0/capturetrig1] [get_bd_pins axi_timer_0/freeze] [get_bd_pins cmac_usplus_0/drp_en] [get_bd_pins cmac_usplus_0/drp_we] [get_bd_pins cmac_usplus_0/tx_axis_tuser] [get_bd_pins const_gnd/dout] [get_bd_pins dummy_ethernetlite/phy_col] [get_bd_pins dummy_ethernetlite/phy_crs] [get_bd_pins dummy_ethernetlite/phy_dv] [get_bd_pins dummy_ethernetlite/phy_mdio_i] [get_bd_pins dummy_ethernetlite/phy_rx_clk] [get_bd_pins dummy_ethernetlite/phy_rx_er] [get_bd_pins dummy_ethernetlite/phy_tx_clk]
  connect_bd_net -net const_gndx17_dout [get_bd_pins STAT_RX_STATUS_REG/In13] [get_bd_pins const_gndx17/dout]
  connect_bd_net -net const_gndx18_dout [get_bd_pins STAT_TX_STATUS_REG/In1] [get_bd_pins const_gndx31/dout]
  connect_bd_net -net const_gndx28_dout [get_bd_pins GT_STATUS/In1] [get_bd_pins const_gndx28/dout]
  connect_bd_net -net const_gndx56_dout [get_bd_pins cmac_usplus_0/tx_preamblein] [get_bd_pins const_gndx56/dout]
  connect_bd_net -net const_vcc_dout [get_bd_ports QSFP0_FS] [get_bd_pins const_vcc/dout]
  connect_bd_net -net const_vccx64_dout [get_bd_pins cmac_usplus_0/tx_axis_tkeep] [get_bd_pins const_vccx64/dout]
  connect_bd_net -net ctl_rx_enable_Dout [get_bd_pins cmac_usplus_0/ctl_rx_enable] [get_bd_pins ctl_rx_enable/Dout]
  connect_bd_net -net ctl_rx_force_resync_Dout [get_bd_pins cmac_usplus_0/ctl_rx_force_resync] [get_bd_pins ctl_rx_force_resync/Dout]
  connect_bd_net -net ctl_rx_test_pattern_Dout [get_bd_pins cmac_usplus_0/ctl_rx_test_pattern] [get_bd_pins ctl_rx_test_pattern/Dout]
  connect_bd_net -net ctl_tx_enable_Dout [get_bd_pins cmac_usplus_0/ctl_tx_enable] [get_bd_pins ctl_tx_enable/Dout]
  connect_bd_net -net ctl_tx_send_idle_Dout [get_bd_pins cmac_usplus_0/ctl_tx_send_idle] [get_bd_pins ctl_tx_send_idle/Dout]
  connect_bd_net -net ctl_tx_send_lfi_Dout [get_bd_pins cmac_usplus_0/ctl_tx_send_lfi] [get_bd_pins ctl_tx_send_lfi/Dout]
  connect_bd_net -net ctl_tx_send_rfi_Dout [get_bd_pins cmac_usplus_0/ctl_tx_send_rfi] [get_bd_pins ctl_tx_send_rfi/Dout]
  connect_bd_net -net ctl_tx_test_pattern_Dout [get_bd_pins cmac_usplus_0/ctl_tx_test_pattern] [get_bd_pins ctl_tx_test_pattern/Dout]
  connect_bd_net -net eth_dma_mm2s_introut [get_bd_pins concat_intc/In3] [get_bd_pins eth_dma/mm2s_introut]
  connect_bd_net -net eth_dma_s2mm_introut [get_bd_pins concat_intc/In4] [get_bd_pins eth_dma/s2mm_introut]
  connect_bd_net -net gt_ctl_gpio_io_o [get_bd_pins gt_ctl/gpio_io_o] [get_bd_pins gt_loopback0/Din] [get_bd_pins gt_loopback1/Din] [get_bd_pins gt_loopback2/Din] [get_bd_pins gt_loopback3/Din]
  connect_bd_net -net gt_loopback0_Dout [get_bd_pins gt_loopback/In0] [get_bd_pins gt_loopback0/Dout]
  connect_bd_net -net gt_loopback1_Dout [get_bd_pins gt_loopback/In1] [get_bd_pins gt_loopback1/Dout]
  connect_bd_net -net gt_loopback2_Dout [get_bd_pins gt_loopback/In2] [get_bd_pins gt_loopback2/Dout]
  connect_bd_net -net gt_loopback3_Dout [get_bd_pins gt_loopback/In3] [get_bd_pins gt_loopback3/Dout]
  connect_bd_net -net mdm_1_Interrupt [get_bd_pins concat_intc/In0] [get_bd_pins mdm_1/Interrupt]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rx_rst_gen/mb_debug_sys_rst] [get_bd_pins sys_rst_gen/mb_debug_sys_rst] [get_bd_pins tx_rst_gen/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_combiner_0/aclk] [get_bd_pins clk_wiz_1/clk_out1] [get_bd_pins cmac_usplus_0/drp_clk] [get_bd_pins cmac_usplus_0/init_clk] [get_bd_pins dummy_ethernetlite/s_axi_aclk] [get_bd_pins eth_dma/s_axi_lite_aclk] [get_bd_pins gt_ctl/s_axi_aclk] [get_bd_pins mdm_1/S_AXI_ACLK] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/M06_ACLK] [get_bd_pins microblaze_0_axi_periph/M07_ACLK] [get_bd_pins microblaze_0_axi_periph/M10_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins rx_axis_switch/s_axi_ctrl_aclk] [get_bd_pins rx_fifo/m_axis_aclk] [get_bd_pins sys_rst_gen/slowest_sync_clk] [get_bd_pins tx_axis_switch/s_axi_ctrl_aclk] [get_bd_pins tx_fifo/s_axis_aclk] [get_bd_pins tx_rx_ctl_stat/s_axi_aclk]
  connect_bd_net -net resetn_1 [get_bd_ports resetn] [get_bd_pins resetn_inv_0/Op1] [get_bd_pins rx_rst_gen/ext_reset_in] [get_bd_pins sys_rst_gen/ext_reset_in] [get_bd_pins tx_rst_gen/ext_reset_in]
  connect_bd_net -net resetn_inv_0_Res [get_bd_pins clk_wiz_1/reset] [get_bd_pins cmac_usplus_0/gtwiz_reset_rx_datapath] [get_bd_pins cmac_usplus_0/gtwiz_reset_tx_datapath] [get_bd_pins cmac_usplus_0/sys_reset] [get_bd_pins resetn_inv_0/Res]
  connect_bd_net -net rst_clk_wiz_1_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins sys_rst_gen/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_interconnect_aresetn [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins sys_rst_gen/interconnect_aresetn]
  connect_bd_net -net rst_clk_wiz_1_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst] [get_bd_pins sys_rst_gen/mb_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_combiner_0/aresetn] [get_bd_pins dummy_ethernetlite/s_axi_aresetn] [get_bd_pins eth_dma/axi_resetn] [get_bd_pins gt_ctl/s_axi_aresetn] [get_bd_pins mdm_1/S_AXI_ARESETN] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins microblaze_0_axi_periph/M06_ARESETN] [get_bd_pins microblaze_0_axi_periph/M07_ARESETN] [get_bd_pins microblaze_0_axi_periph/M10_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins rx_axis_switch/s_axi_ctrl_aresetn] [get_bd_pins sys_rst_gen/peripheral_aresetn] [get_bd_pins tx_axis_switch/s_axi_ctrl_aresetn] [get_bd_pins tx_fifo/s_axis_aresetn] [get_bd_pins tx_rx_ctl_stat/s_axi_aresetn]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_reset [get_bd_pins cmac_usplus_0/core_drp_reset] [get_bd_pins sys_rst_gen/peripheral_reset]
  connect_bd_net -net rx_rst_gen_peripheral_aresetn [get_bd_pins microblaze_0_axi_periph/M09_ARESETN] [get_bd_pins rx_axis_switch/aresetn] [get_bd_pins rx_fifo/s_axis_aresetn] [get_bd_pins rx_mem_cpu/s_axi_aresetn] [get_bd_pins rx_mem_dma/s_axi_aresetn] [get_bd_pins rx_rst_gen/peripheral_aresetn]
  connect_bd_net -net rx_rst_gen_peripheral_reset [get_bd_pins cmac_usplus_0/core_rx_reset] [get_bd_pins rx_rst_gen/peripheral_reset]
  connect_bd_net -net stat_tx_local_fault_dout [get_bd_pins STAT_TX_STATUS_REG/dout] [get_bd_pins tx_rx_ctl_stat/gpio_io_i]
  connect_bd_net -net tx_rst_gen_peripheral_aresetn [get_bd_pins loopback_fifo/s_axis_aresetn] [get_bd_pins microblaze_0_axi_periph/M08_ARESETN] [get_bd_pins tx_axis_switch/aresetn] [get_bd_pins tx_mem_cpu/s_axi_aresetn] [get_bd_pins tx_mem_dma/s_axi_aresetn] [get_bd_pins tx_rst_gen/peripheral_aresetn]
  connect_bd_net -net tx_rst_gen_peripheral_reset [get_bd_pins cmac_usplus_0/core_tx_reset] [get_bd_pins tx_rst_gen/peripheral_reset]
  connect_bd_net -net util_reduced_logic_0_Res [get_bd_pins rx_rst_gen/dcm_locked] [get_bd_pins tx_rst_gen/dcm_locked] [get_bd_pins util_reduced_logic_0/Res]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins concat_intc/dout] [get_bd_pins microblaze_0_axi_intc/intr]

  # Create address segments
  assign_bd_address -offset 0x02000000 -range 0x00400000 -target_address_space [get_bd_addr_spaces eth_dma/Data_S2MM] [get_bd_addr_segs rx_mem_dma/S_AXI/Mem0] -force
  assign_bd_address -offset 0x01000000 -range 0x00400000 -target_address_space [get_bd_addr_spaces eth_dma/Data_MM2S] [get_bd_addr_segs tx_mem_dma/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00808400 -range 0x00000080 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_timer_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00400000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x0080C000 -range 0x00002000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs dummy_ethernetlite/S_AXI/Reg] -force
  assign_bd_address -offset 0x0080A600 -range 0x00000080 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs eth_dma/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x0080A200 -range 0x00000200 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gt_ctl/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00400000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00800000 -range 0x00008000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs mdm_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x00808000 -range 0x00000400 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_axi_intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x0080A100 -range 0x00000080 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs rx_axis_switch/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0x02000000 -range 0x00400000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs rx_mem_cpu/S_AXI/Mem0] -force
  assign_bd_address -offset 0x0080A000 -range 0x00000080 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs tx_axis_switch/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0x01000000 -range 0x00400000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs tx_mem_cpu/S_AXI/Mem0] -force
  assign_bd_address -offset 0x0080A400 -range 0x00000200 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs tx_rx_ctl_stat/S_AXI/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

}
# End of create_root_design()




proc available_tcl_procs { } {
   puts "##################################################################"
   puts "# Available Tcl procedures to recreate hierarchical blocks:"
   puts "#"
   puts "#    create_hier_cell_microblaze_0_local_memory parentCell nameHier"
   puts "#    create_root_design"
   puts "#"
   puts "#"
   puts "# The following procedures will create hiearchical blocks with addressing "
   puts "# for IPs within those blocks and their sub-hierarchical blocks. Addressing "
   puts "# will not be handled outside those blocks:"
   puts "#"
   puts "#    create_root_design"
   puts "#"
   puts "##################################################################"
}

available_tcl_procs
