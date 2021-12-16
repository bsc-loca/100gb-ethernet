
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
set scripts_vivado_version 2021.1
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
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:cmac_usplus:3.1\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:axi_ethernetlite:3.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:gig_ethernet_pcs_pma:16.2\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:util_reduced_logic:2.0\
xilinx.com:ip:hbm:1.0\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:util_ds_buf:2.2\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:axis_switch:1.1\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:clk_wiz:6.0\
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
  set MEM_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 MEM_CLK ]

  set QSFP1X [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:sfp_rtl:1.0 QSFP1X ]

  set QSFP1X_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 QSFP1X_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $QSFP1X_CLK

  set QSFP4X [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 QSFP4X ]

  set QSFP4X_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 QSFP4X_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $QSFP4X_CLK

  set SYS_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 SYS_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $SYS_CLK


  # Create ports
  set CPU_RESET_FPGA [ create_bd_port -dir I -type rst CPU_RESET_FPGA ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $CPU_RESET_FPGA
  set HBM_CATTRIP [ create_bd_port -dir O -from 0 -to 0 HBM_CATTRIP ]
  set_property USER_COMMENTS.comment_0 "If unused HBM_CATTRIP should be driven low
to avoid the SC shutting down the card (UG1314)" [get_bd_ports /HBM_CATTRIP]

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

  # Create instance: const_gndx4, and set properties
  set const_gndx4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_gndx4 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {4} \
 ] $const_gndx4

  # Create instance: const_gndx5, and set properties
  set const_gndx5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_gndx5 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {5} \
 ] $const_gndx5

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

  # Create instance: const_gndx32, and set properties
  set const_gndx32 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_gndx32 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {32} \
 ] $const_gndx32

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

  # Create instance: dcache_connect, and set properties
  set dcache_connect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 dcache_connect ]
  set_property -dict [ list \
   CONFIG.NUM_SI {1} \
 ] $dcache_connect

  # Create instance: eth100gb, and set properties
  set eth100gb [ create_bd_cell -type ip -vlnv xilinx.com:ip:cmac_usplus:3.1 eth100gb ]
  set_property -dict [ list \
   CONFIG.ADD_GT_CNRL_STS_PORTS {0} \
   CONFIG.CMAC_CAUI4_MODE {1} \
   CONFIG.CMAC_CORE_SELECT {CMACE4_X0Y6} \
   CONFIG.DIFFCLK_BOARD_INTERFACE {Custom} \
   CONFIG.ENABLE_AXI_INTERFACE {1} \
   CONFIG.ENABLE_PIPELINE_REG {0} \
   CONFIG.ENABLE_TIME_STAMPING {0} \
   CONFIG.ETHERNET_BOARD_INTERFACE {Custom} \
   CONFIG.GT_GROUP_SELECT {X0Y44~X0Y47} \
   CONFIG.GT_REF_CLK_FREQ {156.25} \
   CONFIG.GT_RX_BUFFER_BYPASS {0} \
   CONFIG.INCLUDE_AUTO_NEG_LT_LOGIC {0} \
   CONFIG.INCLUDE_RS_FEC {1} \
   CONFIG.INCLUDE_STATISTICS_COUNTERS {1} \
   CONFIG.LANE10_GT_LOC {NA} \
   CONFIG.LANE1_GT_LOC {X0Y44} \
   CONFIG.LANE2_GT_LOC {X0Y45} \
   CONFIG.LANE3_GT_LOC {X0Y46} \
   CONFIG.LANE4_GT_LOC {X0Y47} \
   CONFIG.LANE5_GT_LOC {NA} \
   CONFIG.LANE6_GT_LOC {NA} \
   CONFIG.LANE7_GT_LOC {NA} \
   CONFIG.LANE8_GT_LOC {NA} \
   CONFIG.LANE9_GT_LOC {NA} \
   CONFIG.NUM_LANES {4x25} \
   CONFIG.PLL_TYPE {QPLL0} \
   CONFIG.RX_CHECK_ACK {1} \
   CONFIG.RX_EQ_MODE {AUTO} \
   CONFIG.RX_FLOW_CONTROL {0} \
   CONFIG.RX_FORWARD_CONTROL_FRAMES {0} \
   CONFIG.RX_GT_BUFFER {1} \
   CONFIG.RX_MAX_PACKET_LEN {9600} \
   CONFIG.RX_MIN_PACKET_LEN {64} \
   CONFIG.TX_FLOW_CONTROL {0} \
   CONFIG.TX_OTN_INTERFACE {0} \
   CONFIG.USER_INTERFACE {AXIS} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $eth100gb
  set_property USER_COMMENTS.comment_3 "https://www.xilinx.com/support/documentation/ip_documentation/l_ethernet/v3_1/pg211-50g-ethernet.pdf#page=26" [get_bd_intf_pins /eth100gb/axis_rx]
  set_property USER_COMMENTS.comment_2 "https://www.xilinx.com/support/documentation/ip_documentation/l_ethernet/v3_1/pg211-50g-ethernet.pdf#page=23" [get_bd_intf_pins /eth100gb/axis_tx]
  set_property USER_COMMENTS.comment_1 "http://www.xilinx.com/support/documentation/ip_documentation/cmac_usplus/v3_1/pg203-cmac-usplus.pdf#page=117
http://www.xilinx.com/support/documentation/user_guides/ug578-ultrascale-gty-transceivers.pdf#page=88" [get_bd_pins /eth100gb/gt_loopback_in]
  set_property USER_COMMENTS.comment_4 "https://www.xilinx.com/support/documentation/user_guides/ug578-ultrascale-gty-transceivers.pdf#page=88" [get_bd_pins /eth100gb/gt_loopback_in]

  # Create instance: eth_dma, and set properties
  set eth_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 eth_dma ]
  set_property -dict [ list \
   CONFIG.c_include_mm2s_dre {1} \
   CONFIG.c_include_s2mm_dre {1} \
   CONFIG.c_include_sg {1} \
   CONFIG.c_m_axi_mm2s_data_width {512} \
   CONFIG.c_m_axis_mm2s_tdata_width {512} \
   CONFIG.c_mm2s_burst_size {64} \
   CONFIG.c_s2mm_burst_size {64} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {22} \
 ] $eth_dma

  # Create instance: ethmac_lite, and set properties
  set ethmac_lite [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 ethmac_lite ]
  set_property -dict [ list \
   CONFIG.C_INCLUDE_GLOBAL_BUFFERS {0} \
   CONFIG.C_INCLUDE_INTERNAL_LOOPBACK {0} \
   CONFIG.C_INCLUDE_MDIO {1} \
   CONFIG.C_RX_PING_PONG {1} \
   CONFIG.C_TX_PING_PONG {1} \
 ] $ethmac_lite

  # Create instance: ext_rstn_inv, and set properties
  set ext_rstn_inv [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 ext_rstn_inv ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
 ] $ext_rstn_inv

  # Create instance: gig_eth_phy, and set properties
  set gig_eth_phy [ create_bd_cell -type ip -vlnv xilinx.com:ip:gig_ethernet_pcs_pma:16.2 gig_eth_phy ]
  set_property -dict [ list \
   CONFIG.Auto_Negotiation {false} \
   CONFIG.DIFFCLK_BOARD_INTERFACE {Custom} \
   CONFIG.DrpClkRate {50} \
   CONFIG.Ext_Management_Interface {false} \
   CONFIG.GT_Location {X0Y40} \
   CONFIG.GTinEx {false} \
   CONFIG.Management_Interface {true} \
   CONFIG.MaxDataRate {1G} \
   CONFIG.RefClkRate {156.25} \
   CONFIG.RxGmiiClkSrc {TXOUTCLK} \
   CONFIG.SGMII_Mode {10_100_1000} \
   CONFIG.SGMII_PHY_Mode {true} \
   CONFIG.Standard {1000BASEX} \
   CONFIG.SupportLevel {Include_Shared_Logic_in_Core} \
   CONFIG.TransceiverControl {false} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $gig_eth_phy

  # Create instance: gig_eth_phy_rxd, and set properties
  set gig_eth_phy_rxd [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 gig_eth_phy_rxd ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {8} \
   CONFIG.DOUT_WIDTH {4} \
 ] $gig_eth_phy_rxd

  # Create instance: gig_eth_phy_txd, and set properties
  set gig_eth_phy_txd [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 gig_eth_phy_txd ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {2} \
 ] $gig_eth_phy_txd

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

  # Create instance: gts_pwr_ok, and set properties
  set gts_pwr_ok [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 gts_pwr_ok ]
  set_property -dict [ list \
   CONFIG.C_SIZE {4} \
 ] $gts_pwr_ok

  # Create instance: hbm_0, and set properties
  set hbm_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:hbm:1.0 hbm_0 ]
  set_property -dict [ list \
   CONFIG.USER_APB_EN {false} \
   CONFIG.USER_CLK_SEL_LIST0 {AXI_01_ACLK} \
   CONFIG.USER_CLK_SEL_LIST1 {AXI_16_ACLK} \
   CONFIG.USER_HBM_CP_1 {3} \
   CONFIG.USER_HBM_DENSITY {4GB} \
   CONFIG.USER_HBM_FBDIV_1 {5} \
   CONFIG.USER_HBM_HEX_CP_RES_1 {0x0000B300} \
   CONFIG.USER_HBM_HEX_FBDIV_CLKOUTDIV_1 {0x00000142} \
   CONFIG.USER_HBM_HEX_LOCK_FB_REF_DLY_1 {0x00000a0a} \
   CONFIG.USER_HBM_LOCK_FB_DLY_1 {10} \
   CONFIG.USER_HBM_LOCK_REF_DLY_1 {10} \
   CONFIG.USER_HBM_RES_1 {11} \
   CONFIG.USER_HBM_STACK {1} \
   CONFIG.USER_MC_ENABLE_00 {TRUE} \
   CONFIG.USER_MC_ENABLE_01 {TRUE} \
   CONFIG.USER_MC_ENABLE_02 {TRUE} \
   CONFIG.USER_MC_ENABLE_03 {TRUE} \
   CONFIG.USER_MC_ENABLE_04 {TRUE} \
   CONFIG.USER_MC_ENABLE_05 {TRUE} \
   CONFIG.USER_MC_ENABLE_06 {TRUE} \
   CONFIG.USER_MC_ENABLE_07 {TRUE} \
   CONFIG.USER_MC_ENABLE_08 {FALSE} \
   CONFIG.USER_MC_ENABLE_09 {FALSE} \
   CONFIG.USER_MC_ENABLE_10 {FALSE} \
   CONFIG.USER_MC_ENABLE_11 {FALSE} \
   CONFIG.USER_MC_ENABLE_12 {FALSE} \
   CONFIG.USER_MC_ENABLE_13 {FALSE} \
   CONFIG.USER_MC_ENABLE_14 {FALSE} \
   CONFIG.USER_MC_ENABLE_15 {FALSE} \
   CONFIG.USER_MC_ENABLE_APB_01 {FALSE} \
   CONFIG.USER_MEMORY_DISPLAY {4096} \
   CONFIG.USER_PHY_ENABLE_08 {FALSE} \
   CONFIG.USER_PHY_ENABLE_09 {FALSE} \
   CONFIG.USER_PHY_ENABLE_10 {FALSE} \
   CONFIG.USER_PHY_ENABLE_11 {FALSE} \
   CONFIG.USER_PHY_ENABLE_12 {FALSE} \
   CONFIG.USER_PHY_ENABLE_13 {FALSE} \
   CONFIG.USER_PHY_ENABLE_14 {FALSE} \
   CONFIG.USER_PHY_ENABLE_15 {FALSE} \
   CONFIG.USER_SAXI_01 {true} \
   CONFIG.USER_SAXI_02 {true} \
   CONFIG.USER_SAXI_03 {false} \
   CONFIG.USER_SAXI_04 {false} \
   CONFIG.USER_SAXI_05 {false} \
   CONFIG.USER_SAXI_06 {false} \
   CONFIG.USER_SAXI_07 {false} \
   CONFIG.USER_SAXI_08 {false} \
   CONFIG.USER_SAXI_09 {false} \
   CONFIG.USER_SAXI_10 {false} \
   CONFIG.USER_SAXI_11 {false} \
   CONFIG.USER_SAXI_12 {false} \
   CONFIG.USER_SAXI_13 {false} \
   CONFIG.USER_SAXI_14 {false} \
   CONFIG.USER_SAXI_15 {false} \
   CONFIG.USER_SAXI_16 {false} \
   CONFIG.USER_SAXI_17 {false} \
   CONFIG.USER_SAXI_18 {false} \
   CONFIG.USER_SAXI_19 {false} \
   CONFIG.USER_SAXI_20 {false} \
   CONFIG.USER_SAXI_21 {false} \
   CONFIG.USER_SAXI_22 {false} \
   CONFIG.USER_SAXI_23 {false} \
   CONFIG.USER_SAXI_24 {false} \
   CONFIG.USER_SAXI_25 {false} \
   CONFIG.USER_SAXI_26 {false} \
   CONFIG.USER_SAXI_27 {false} \
   CONFIG.USER_SAXI_28 {false} \
   CONFIG.USER_SAXI_29 {false} \
   CONFIG.USER_SAXI_30 {false} \
   CONFIG.USER_SAXI_31 {false} \
   CONFIG.USER_SINGLE_STACK_SELECTION {LEFT} \
   CONFIG.USER_SWITCH_ENABLE_01 {FALSE} \
 ] $hbm_0

  # Create instance: icache_connect, and set properties
  set icache_connect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 icache_connect ]
  set_property -dict [ list \
   CONFIG.NUM_SI {1} \
 ] $icache_connect

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

  # Create instance: memclk_buf, and set properties
  set memclk_buf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 memclk_buf ]

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_TAG_BITS {17} \
   CONFIG.C_CACHE_BYTE_SIZE {16384} \
   CONFIG.C_DCACHE_ADDR_TAG {17} \
   CONFIG.C_DCACHE_BYTE_SIZE {16384} \
   CONFIG.C_DCACHE_VICTIMS {8} \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_DIV_ZERO_EXCEPTION {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_FSL_LINKS {16} \
   CONFIG.C_ICACHE_LINE_LEN {8} \
   CONFIG.C_ICACHE_STREAMS {1} \
   CONFIG.C_ICACHE_VICTIMS {8} \
   CONFIG.C_ILL_OPCODE_EXCEPTION {1} \
   CONFIG.C_I_AXI {0} \
   CONFIG.C_I_LMB {1} \
   CONFIG.C_MMU_DTLB_SIZE {4} \
   CONFIG.C_MMU_ITLB_SIZE {2} \
   CONFIG.C_M_AXI_D_BUS_EXCEPTION {1} \
   CONFIG.C_M_AXI_I_BUS_EXCEPTION {1} \
   CONFIG.C_OPCODE_0x0_ILLEGAL {1} \
   CONFIG.C_PVR {2} \
   CONFIG.C_UNALIGNED_EXCEPTIONS {1} \
   CONFIG.C_USE_DCACHE {1} \
   CONFIG.C_USE_DIV {1} \
   CONFIG.C_USE_HW_MUL {2} \
   CONFIG.C_USE_ICACHE {1} \
   CONFIG.C_USE_MMU {3} \
   CONFIG.C_USE_REORDER_INSTR {1} \
   CONFIG.G_TEMPLATE_LIST {4} \
   CONFIG.G_USE_EXCEPTIONS {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list \
   CONFIG.C_HAS_FAST {1} \
 ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: periph_connect, and set properties
  set periph_connect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 periph_connect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {14} \
   CONFIG.NUM_SI {1} \
 ] $periph_connect

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
   CONFIG.Assume_Synchronous_Clk {false} \
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
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $rx_rst_gen

  # Create instance: sg_mem, and set properties
  set sg_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 sg_mem ]
  set_property -dict [ list \
   CONFIG.Assume_Synchronous_Clk {true} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {NO_CHANGE} \
   CONFIG.Operating_Mode_B {NO_CHANGE} \
   CONFIG.PRIM_type_to_Implement {URAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTB_Pin {true} \
 ] $sg_mem

  # Create instance: sg_mem_cpu, and set properties
  set sg_mem_cpu [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 sg_mem_cpu ]
  set_property -dict [ list \
   CONFIG.ECC_TYPE {0} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $sg_mem_cpu

  # Create instance: sg_mem_dma, and set properties
  set sg_mem_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 sg_mem_dma ]
  set_property -dict [ list \
   CONFIG.ECC_TYPE {0} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $sg_mem_dma

  # Create instance: sys_clk_gen, and set properties
  set sys_clk_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 sys_clk_gen ]
  set_property -dict [ list \
   CONFIG.CLKIN2_JITTER_PS {149.99} \
   CONFIG.CLKOUT2_JITTER {132.683} \
   CONFIG.CLKOUT2_PHASE_ERROR {87.180} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {50} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLK_IN1_BOARD_INTERFACE {Custom} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.000} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {24} \
   CONFIG.NUM_OUT_CLKS {2} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
   CONFIG.USE_BOARD_FLOW {true} \
   CONFIG.USE_INCLK_SWITCHOVER {false} \
 ] $sys_clk_gen

  # Create instance: sys_rst_gen, and set properties
  set sys_rst_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_rst_gen ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
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
   CONFIG.HAS_TKEEP {1} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $tx_fifo

  # Create instance: tx_mem, and set properties
  set tx_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 tx_mem ]
  set_property -dict [ list \
   CONFIG.Assume_Synchronous_Clk {false} \
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
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $tx_rst_gen

  # Create instance: tx_rx_ctl_stat, and set properties
  set tx_rx_ctl_stat [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 tx_rx_ctl_stat ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {0} \
   CONFIG.C_ALL_OUTPUTS {0} \
   CONFIG.C_IS_DUAL {1} \
 ] $tx_rx_ctl_stat

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN1_D_0_1 [get_bd_intf_ports SYS_CLK] [get_bd_intf_pins sys_clk_gen/CLK_IN1_D]
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_ports MEM_CLK] [get_bd_intf_pins memclk_buf/CLK_IN_D]
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
  connect_bd_intf_net -intf_net cmac_usplus_0_axis_rx [get_bd_intf_pins eth100gb/axis_rx] [get_bd_intf_pins rx_axis_switch/S01_AXIS]
  connect_bd_intf_net -intf_net cmac_usplus_0_gt_serial_port [get_bd_intf_ports QSFP4X] [get_bd_intf_pins eth100gb/gt_serial_port]
  connect_bd_intf_net -intf_net eth_dma_M_AXI_MM2S [get_bd_intf_pins eth_dma/M_AXI_MM2S] [get_bd_intf_pins tx_mem_dma/S_AXI]
  connect_bd_intf_net -intf_net eth_dma_M_AXI_S2MM [get_bd_intf_pins eth_dma/M_AXI_S2MM] [get_bd_intf_pins rx_mem_dma/S_AXI]
  connect_bd_intf_net -intf_net eth_dma_M_AXI_SG [get_bd_intf_pins eth_dma/M_AXI_SG] [get_bd_intf_pins sg_mem_dma/S_AXI]
  connect_bd_intf_net -intf_net eth_lite_dum4lwip_MDIO [get_bd_intf_pins ethmac_lite/MDIO] [get_bd_intf_pins gig_eth_phy/mdio_pcs_pma]
  connect_bd_intf_net -intf_net gig_ethernet_pcs_pma_0_sfp [get_bd_intf_ports QSFP1X] [get_bd_intf_pins gig_eth_phy/sfp]
  connect_bd_intf_net -intf_net loopback_fifo_M_AXIS [get_bd_intf_pins loopback_fifo/M_AXIS] [get_bd_intf_pins rx_axis_switch/S00_AXIS]
  connect_bd_intf_net -intf_net mem_connect1_M00_AXI [get_bd_intf_pins dcache_connect/M00_AXI] [get_bd_intf_pins hbm_0/SAXI_01]
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
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DC [get_bd_intf_pins dcache_connect/S00_AXI] [get_bd_intf_pins microblaze_0/M_AXI_DC]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins periph_connect/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_IC [get_bd_intf_pins icache_connect/S00_AXI] [get_bd_intf_pins microblaze_0/M_AXI_IC]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]
  connect_bd_intf_net -intf_net periph_connect_M13_AXI [get_bd_intf_pins hbm_0/SAXI_02] [get_bd_intf_pins periph_connect/M13_AXI]
  connect_bd_intf_net -intf_net qsfp0_156mhz_1 [get_bd_intf_ports QSFP4X_CLK] [get_bd_intf_pins eth100gb/gt_ref_clk]
  connect_bd_intf_net -intf_net qsfp1_156mhz_1 [get_bd_intf_ports QSFP1X_CLK] [get_bd_intf_pins gig_eth_phy/gtrefclk_in]
  connect_bd_intf_net -intf_net rx_axis_switch_M01_AXIS [get_bd_intf_pins eth_dma/S_AXIS_S2MM] [get_bd_intf_pins rx_axis_switch/M01_AXIS]
  connect_bd_intf_net -intf_net rx_fifo_M_AXIS [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins rx_fifo/M_AXIS]
  connect_bd_intf_net -intf_net rx_mem_ctr_BRAM_PORTA [get_bd_intf_pins rx_mem/BRAM_PORTA] [get_bd_intf_pins rx_mem_cpu/BRAM_PORTA]
  connect_bd_intf_net -intf_net rx_mem_dma_BRAM_PORTA [get_bd_intf_pins rx_mem/BRAM_PORTB] [get_bd_intf_pins rx_mem_dma/BRAM_PORTA]
  connect_bd_intf_net -intf_net rx_switch_M00_AXIS [get_bd_intf_pins rx_axis_switch/M00_AXIS] [get_bd_intf_pins rx_fifo/S_AXIS]
  connect_bd_intf_net -intf_net sg_mem_dma1_BRAM_PORTA [get_bd_intf_pins sg_mem/BRAM_PORTA] [get_bd_intf_pins sg_mem_cpu/BRAM_PORTA]
  connect_bd_intf_net -intf_net sg_mem_dma_BRAM_PORTA [get_bd_intf_pins sg_mem/BRAM_PORTB] [get_bd_intf_pins sg_mem_dma/BRAM_PORTA]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hbm_0/SAXI_00] [get_bd_intf_pins icache_connect/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI1 [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins periph_connect/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins mdm_1/S_AXI] [get_bd_intf_pins periph_connect/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins periph_connect/M02_AXI] [get_bd_intf_pins tx_rx_ctl_stat/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins periph_connect/M03_AXI] [get_bd_intf_pins tx_axis_switch/S_AXI_CTRL]
  connect_bd_intf_net -intf_net smartconnect_0_M04_AXI [get_bd_intf_pins periph_connect/M04_AXI] [get_bd_intf_pins rx_axis_switch/S_AXI_CTRL]
  connect_bd_intf_net -intf_net smartconnect_0_M05_AXI [get_bd_intf_pins gt_ctl/S_AXI] [get_bd_intf_pins periph_connect/M05_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M06_AXI [get_bd_intf_pins axi_timer_0/S_AXI] [get_bd_intf_pins periph_connect/M06_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M07_AXI [get_bd_intf_pins ethmac_lite/S_AXI] [get_bd_intf_pins periph_connect/M07_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M08_AXI [get_bd_intf_pins periph_connect/M08_AXI] [get_bd_intf_pins tx_mem_cpu/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M09_AXI [get_bd_intf_pins periph_connect/M09_AXI] [get_bd_intf_pins rx_mem_cpu/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M10_AXI [get_bd_intf_pins eth_dma/S_AXI_LITE] [get_bd_intf_pins periph_connect/M10_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M11_AXI [get_bd_intf_pins eth100gb/s_axi] [get_bd_intf_pins periph_connect/M11_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M12_AXI [get_bd_intf_pins periph_connect/M12_AXI] [get_bd_intf_pins sg_mem_cpu/S_AXI]
  connect_bd_intf_net -intf_net tx_fifo_M_AXIS [get_bd_intf_pins tx_axis_switch/S00_AXIS] [get_bd_intf_pins tx_fifo/M_AXIS]
  connect_bd_intf_net -intf_net tx_mem_cpu1_BRAM_PORTA [get_bd_intf_pins tx_mem/BRAM_PORTB] [get_bd_intf_pins tx_mem_dma/BRAM_PORTA]
  connect_bd_intf_net -intf_net tx_switch_M00_AXIS [get_bd_intf_pins loopback_fifo/S_AXIS] [get_bd_intf_pins tx_axis_switch/M00_AXIS]
  connect_bd_intf_net -intf_net tx_switch_M01_AXIS [get_bd_intf_pins eth100gb/axis_tx] [get_bd_intf_pins tx_axis_switch/M01_AXIS]

  # Create port connections
  connect_bd_net -net GT_STATUS_dout [get_bd_pins GT_STATUS/dout] [get_bd_pins gt_ctl/gpio_io_i]
  connect_bd_net -net STAT_RX_STATUS_REG_dout [get_bd_pins STAT_RX_STATUS_REG/dout] [get_bd_pins tx_rx_ctl_stat/gpio2_io_i]
  connect_bd_net -net STAT_TX_STATUS_REG1_dout [get_bd_pins eth100gb/gt_loopback_in] [get_bd_pins gt_loopback/dout]
  connect_bd_net -net axi_ethernetlite_0_ip2intc_irpt [get_bd_pins concat_intc/In2] [get_bd_pins ethmac_lite/ip2intc_irpt]
  connect_bd_net -net axi_gpio_0_gpio2_io_o [get_bd_pins ctl_rx_enable/Din] [get_bd_pins ctl_rx_force_resync/Din] [get_bd_pins ctl_rx_test_pattern/Din] [get_bd_pins tx_rx_ctl_stat/gpio2_io_o]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins ctl_tx_enable/Din] [get_bd_pins ctl_tx_send_idle/Din] [get_bd_pins ctl_tx_send_lfi/Din] [get_bd_pins ctl_tx_send_rfi/Din] [get_bd_pins ctl_tx_test_pattern/Din] [get_bd_pins tx_rx_ctl_stat/gpio_io_o]
  connect_bd_net -net axi_timer_0_interrupt [get_bd_pins axi_timer_0/interrupt] [get_bd_pins concat_intc/In1]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins sys_clk_gen/locked] [get_bd_pins sys_rst_gen/dcm_locked]
  connect_bd_net -net cmac_usplus_0_gt_powergoodout [get_bd_pins GT_STATUS/In0] [get_bd_pins eth100gb/gt_powergoodout] [get_bd_pins gts_pwr_ok/Op1]
  connect_bd_net -net cmac_usplus_0_gt_rxusrclk2 [get_bd_pins eth100gb/gt_rxusrclk2] [get_bd_pins eth100gb/rx_clk] [get_bd_pins eth_dma/m_axi_s2mm_aclk] [get_bd_pins loopback_fifo/m_axis_aclk] [get_bd_pins rx_axis_switch/aclk] [get_bd_pins rx_fifo/s_axis_aclk] [get_bd_pins rx_mem_dma/s_axi_aclk] [get_bd_pins rx_rst_gen/slowest_sync_clk]
  connect_bd_net -net cmac_usplus_0_gt_txusrclk2 [get_bd_pins eth100gb/gt_txusrclk2] [get_bd_pins eth_dma/m_axi_mm2s_aclk] [get_bd_pins loopback_fifo/s_axis_aclk] [get_bd_pins tx_axis_switch/aclk] [get_bd_pins tx_fifo/m_axis_aclk] [get_bd_pins tx_mem_dma/s_axi_aclk] [get_bd_pins tx_rst_gen/slowest_sync_clk]
  connect_bd_net -net cmac_usplus_0_stat_rx_aligned [get_bd_pins STAT_RX_STATUS_REG/In1] [get_bd_pins eth100gb/stat_rx_aligned]
  connect_bd_net -net cmac_usplus_0_stat_rx_aligned_err [get_bd_pins STAT_RX_STATUS_REG/In3] [get_bd_pins eth100gb/stat_rx_aligned_err]
  connect_bd_net -net cmac_usplus_0_stat_rx_bad_preamble [get_bd_pins STAT_RX_STATUS_REG/In10] [get_bd_pins eth100gb/stat_rx_bad_preamble]
  connect_bd_net -net cmac_usplus_0_stat_rx_bad_sfd [get_bd_pins STAT_RX_STATUS_REG/In11] [get_bd_pins eth100gb/stat_rx_bad_sfd]
  connect_bd_net -net cmac_usplus_0_stat_rx_got_signal_os [get_bd_pins STAT_RX_STATUS_REG/In12] [get_bd_pins eth100gb/stat_rx_got_signal_os]
  connect_bd_net -net cmac_usplus_0_stat_rx_hi_ber [get_bd_pins STAT_RX_STATUS_REG/In4] [get_bd_pins eth100gb/stat_rx_hi_ber]
  connect_bd_net -net cmac_usplus_0_stat_rx_internal_local_fault [get_bd_pins STAT_RX_STATUS_REG/In7] [get_bd_pins eth100gb/stat_rx_internal_local_fault]
  connect_bd_net -net cmac_usplus_0_stat_rx_local_fault [get_bd_pins STAT_RX_STATUS_REG/In6] [get_bd_pins eth100gb/stat_rx_local_fault]
  connect_bd_net -net cmac_usplus_0_stat_rx_misaligned [get_bd_pins STAT_RX_STATUS_REG/In2] [get_bd_pins eth100gb/stat_rx_misaligned]
  connect_bd_net -net cmac_usplus_0_stat_rx_received_local_fault [get_bd_pins STAT_RX_STATUS_REG/In8] [get_bd_pins eth100gb/stat_rx_received_local_fault]
  connect_bd_net -net cmac_usplus_0_stat_rx_remote_fault [get_bd_pins STAT_RX_STATUS_REG/In5] [get_bd_pins eth100gb/stat_rx_remote_fault]
  connect_bd_net -net cmac_usplus_0_stat_rx_status [get_bd_pins STAT_RX_STATUS_REG/In0] [get_bd_pins eth100gb/stat_rx_status]
  connect_bd_net -net cmac_usplus_0_stat_rx_test_pattern_mismatch [get_bd_pins STAT_RX_STATUS_REG/In9] [get_bd_pins eth100gb/stat_rx_test_pattern_mismatch]
  connect_bd_net -net cmac_usplus_0_stat_tx_local_fault [get_bd_pins STAT_TX_STATUS_REG/In0] [get_bd_pins eth100gb/stat_tx_local_fault]
  connect_bd_net -net const_gnd_dout [get_bd_pins axi_timer_0/capturetrig0] [get_bd_pins axi_timer_0/capturetrig1] [get_bd_pins axi_timer_0/freeze] [get_bd_pins const_gnd/dout] [get_bd_pins eth100gb/drp_en] [get_bd_pins eth100gb/drp_we] [get_bd_pins eth100gb/pm_tick] [get_bd_pins eth100gb/tx_axis_tuser] [get_bd_pins ethmac_lite/phy_col] [get_bd_pins ethmac_lite/phy_crs] [get_bd_pins gig_eth_phy/configuration_valid] [get_bd_pins gig_eth_phy/gmii_tx_er]
  connect_bd_net -net const_gndx17_dout [get_bd_pins STAT_RX_STATUS_REG/In13] [get_bd_pins const_gndx17/dout]
  connect_bd_net -net const_gndx18_dout [get_bd_pins STAT_TX_STATUS_REG/In1] [get_bd_pins const_gndx31/dout]
  connect_bd_net -net const_gndx28_dout [get_bd_pins GT_STATUS/In1] [get_bd_pins const_gndx28/dout]
  connect_bd_net -net const_gndx32_dout [get_bd_pins const_gndx32/dout] [get_bd_pins hbm_0/AXI_00_WDATA_PARITY] [get_bd_pins hbm_0/AXI_01_WDATA_PARITY] [get_bd_pins hbm_0/AXI_02_WDATA_PARITY]
  connect_bd_net -net const_gndx4_dout [get_bd_pins const_gndx4/dout] [get_bd_pins gig_eth_phy_txd/In1]
  connect_bd_net -net const_gndx56_dout [get_bd_pins const_gndx56/dout] [get_bd_pins eth100gb/tx_preamblein]
  connect_bd_net -net const_gndx5_dout [get_bd_pins const_gndx5/dout] [get_bd_pins gig_eth_phy/configuration_vector] [get_bd_pins gig_eth_phy/phyaddr]
  connect_bd_net -net const_vcc_dout [get_bd_pins const_vcc/dout] [get_bd_pins gig_eth_phy/signal_detect]
  connect_bd_net -net const_vccx64_dout [get_bd_pins const_vccx64/dout] [get_bd_pins tx_fifo/s_axis_tkeep]
  connect_bd_net -net ctl_tx_send_idle_Dout [get_bd_pins ctl_tx_send_idle/Dout] [get_bd_pins eth100gb/ctl_tx_send_idle]
  connect_bd_net -net ctl_tx_send_lfi_Dout [get_bd_pins ctl_tx_send_lfi/Dout] [get_bd_pins eth100gb/ctl_tx_send_lfi]
  connect_bd_net -net ctl_tx_send_rfi_Dout [get_bd_pins ctl_tx_send_rfi/Dout] [get_bd_pins eth100gb/ctl_tx_send_rfi]
  connect_bd_net -net eth_dma_mm2s_introut [get_bd_pins concat_intc/In3] [get_bd_pins eth_dma/mm2s_introut]
  connect_bd_net -net eth_dma_mm2s_prmry_reset_out_n [get_bd_pins eth_dma/mm2s_prmry_reset_out_n] [get_bd_pins tx_mem_dma/s_axi_aresetn]
  connect_bd_net -net eth_dma_s2mm_introut [get_bd_pins concat_intc/In4] [get_bd_pins eth_dma/s2mm_introut]
  connect_bd_net -net eth_dma_s2mm_prmry_reset_out_n [get_bd_pins eth_dma/s2mm_prmry_reset_out_n] [get_bd_pins rx_mem_dma/s_axi_aresetn]
  connect_bd_net -net eth_lite_dum4lwip_phy_tx_data [get_bd_pins ethmac_lite/phy_tx_data] [get_bd_pins gig_eth_phy_txd/In0]
  connect_bd_net -net eth_lite_dum4lwip_phy_tx_en [get_bd_pins ethmac_lite/phy_tx_en] [get_bd_pins gig_eth_phy/gmii_tx_en]
  connect_bd_net -net gig_eth_phy_rxd_Dout [get_bd_pins ethmac_lite/phy_rx_data] [get_bd_pins gig_eth_phy_rxd/Dout]
  connect_bd_net -net gig_eth_phy_txd_dout [get_bd_pins gig_eth_phy/gmii_txd] [get_bd_pins gig_eth_phy_txd/dout]
  connect_bd_net -net gig_eth_phy_userclk_out [get_bd_pins ethmac_lite/phy_rx_clk] [get_bd_pins ethmac_lite/phy_tx_clk] [get_bd_pins gig_eth_phy/userclk_out]
  connect_bd_net -net gig_ethernet_pcs_pma_0_gmii_rx_dv [get_bd_pins ethmac_lite/phy_dv] [get_bd_pins gig_eth_phy/gmii_rx_dv]
  connect_bd_net -net gig_ethernet_pcs_pma_0_gmii_rx_er [get_bd_pins ethmac_lite/phy_rx_er] [get_bd_pins gig_eth_phy/gmii_rx_er]
  connect_bd_net -net gig_ethernet_pcs_pma_0_gmii_rxd [get_bd_pins gig_eth_phy/gmii_rxd] [get_bd_pins gig_eth_phy_rxd/Din]
  connect_bd_net -net gt_ctl_gpio_io_o [get_bd_pins gt_ctl/gpio_io_o] [get_bd_pins gt_loopback0/Din] [get_bd_pins gt_loopback1/Din] [get_bd_pins gt_loopback2/Din] [get_bd_pins gt_loopback3/Din]
  connect_bd_net -net gt_loopback0_Dout [get_bd_pins gt_loopback/In0] [get_bd_pins gt_loopback0/Dout]
  connect_bd_net -net gt_loopback1_Dout [get_bd_pins gt_loopback/In1] [get_bd_pins gt_loopback1/Dout]
  connect_bd_net -net gt_loopback2_Dout [get_bd_pins gt_loopback/In2] [get_bd_pins gt_loopback2/Dout]
  connect_bd_net -net gt_loopback3_Dout [get_bd_pins gt_loopback/In3] [get_bd_pins gt_loopback3/Dout]
  connect_bd_net -net hbm_0_DRAM_0_STAT_CATTRIP [get_bd_ports HBM_CATTRIP] [get_bd_pins hbm_0/DRAM_0_STAT_CATTRIP]
  connect_bd_net -net mdm_1_Interrupt [get_bd_pins concat_intc/In0] [get_bd_pins mdm_1/Interrupt]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rx_rst_gen/mb_debug_sys_rst] [get_bd_pins sys_rst_gen/mb_debug_sys_rst] [get_bd_pins tx_rst_gen/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_combiner_0/aclk] [get_bd_pins dcache_connect/aclk] [get_bd_pins eth100gb/drp_clk] [get_bd_pins eth100gb/init_clk] [get_bd_pins eth100gb/s_axi_aclk] [get_bd_pins eth_dma/m_axi_sg_aclk] [get_bd_pins eth_dma/s_axi_lite_aclk] [get_bd_pins ethmac_lite/s_axi_aclk] [get_bd_pins gt_ctl/s_axi_aclk] [get_bd_pins hbm_0/AXI_00_ACLK] [get_bd_pins hbm_0/AXI_01_ACLK] [get_bd_pins hbm_0/AXI_02_ACLK] [get_bd_pins icache_connect/aclk] [get_bd_pins mdm_1/S_AXI_ACLK] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins periph_connect/aclk] [get_bd_pins rx_axis_switch/s_axi_ctrl_aclk] [get_bd_pins rx_fifo/m_axis_aclk] [get_bd_pins rx_mem_cpu/s_axi_aclk] [get_bd_pins sg_mem_cpu/s_axi_aclk] [get_bd_pins sg_mem_dma/s_axi_aclk] [get_bd_pins sys_clk_gen/clk_out1] [get_bd_pins sys_rst_gen/slowest_sync_clk] [get_bd_pins tx_axis_switch/s_axi_ctrl_aclk] [get_bd_pins tx_fifo/s_axis_aclk] [get_bd_pins tx_mem_cpu/s_axi_aclk] [get_bd_pins tx_rx_ctl_stat/s_axi_aclk]
  connect_bd_net -net resetn_1 [get_bd_ports CPU_RESET_FPGA] [get_bd_pins ext_rstn_inv/Op1] [get_bd_pins hbm_0/APB_0_PRESET_N] [get_bd_pins rx_rst_gen/ext_reset_in] [get_bd_pins sys_rst_gen/ext_reset_in] [get_bd_pins tx_rst_gen/ext_reset_in]
  connect_bd_net -net resetn_inv_0_Res [get_bd_pins eth100gb/gtwiz_reset_rx_datapath] [get_bd_pins eth100gb/gtwiz_reset_tx_datapath] [get_bd_pins eth100gb/sys_reset] [get_bd_pins ext_rstn_inv/Res] [get_bd_pins sys_clk_gen/reset]
  connect_bd_net -net rst_clk_wiz_1_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins sys_rst_gen/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst] [get_bd_pins sys_rst_gen/mb_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_combiner_0/aresetn] [get_bd_pins dcache_connect/aresetn] [get_bd_pins eth_dma/axi_resetn] [get_bd_pins ethmac_lite/s_axi_aresetn] [get_bd_pins gt_ctl/s_axi_aresetn] [get_bd_pins hbm_0/AXI_00_ARESET_N] [get_bd_pins hbm_0/AXI_01_ARESET_N] [get_bd_pins hbm_0/AXI_02_ARESET_N] [get_bd_pins icache_connect/aresetn] [get_bd_pins mdm_1/S_AXI_ARESETN] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins periph_connect/aresetn] [get_bd_pins rx_axis_switch/s_axi_ctrl_aresetn] [get_bd_pins rx_mem_cpu/s_axi_aresetn] [get_bd_pins sg_mem_cpu/s_axi_aresetn] [get_bd_pins sg_mem_dma/s_axi_aresetn] [get_bd_pins sys_rst_gen/peripheral_aresetn] [get_bd_pins tx_axis_switch/s_axi_ctrl_aresetn] [get_bd_pins tx_fifo/s_axis_aresetn] [get_bd_pins tx_mem_cpu/s_axi_aresetn] [get_bd_pins tx_rx_ctl_stat/s_axi_aresetn]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_reset [get_bd_pins eth100gb/core_drp_reset] [get_bd_pins eth100gb/s_axi_sreset] [get_bd_pins gig_eth_phy/reset] [get_bd_pins sys_rst_gen/peripheral_reset]
  connect_bd_net -net rx_rst_gen_peripheral_aresetn [get_bd_pins rx_axis_switch/aresetn] [get_bd_pins rx_fifo/s_axis_aresetn] [get_bd_pins rx_rst_gen/peripheral_aresetn]
  connect_bd_net -net rx_rst_gen_peripheral_reset [get_bd_pins eth100gb/core_rx_reset] [get_bd_pins rx_rst_gen/peripheral_reset]
  connect_bd_net -net stat_tx_local_fault_dout [get_bd_pins STAT_TX_STATUS_REG/dout] [get_bd_pins tx_rx_ctl_stat/gpio_io_i]
  connect_bd_net -net sys_clk_gen_clk_out2 [get_bd_pins gig_eth_phy/independent_clock_bufg] [get_bd_pins sys_clk_gen/clk_out2]
  connect_bd_net -net tx_rst_gen_peripheral_aresetn [get_bd_pins loopback_fifo/s_axis_aresetn] [get_bd_pins tx_axis_switch/aresetn] [get_bd_pins tx_rst_gen/peripheral_aresetn]
  connect_bd_net -net tx_rst_gen_peripheral_reset [get_bd_pins eth100gb/core_tx_reset] [get_bd_pins tx_rst_gen/peripheral_reset]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins hbm_0/APB_0_PCLK] [get_bd_pins hbm_0/HBM_REF_CLK_0] [get_bd_pins memclk_buf/IBUF_OUT]
  connect_bd_net -net util_reduced_logic_0_Res [get_bd_pins gts_pwr_ok/Res] [get_bd_pins rx_rst_gen/dcm_locked] [get_bd_pins tx_rst_gen/dcm_locked]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins hbm_0/apb_complete_0] [get_bd_pins rx_rst_gen/aux_reset_in] [get_bd_pins sys_rst_gen/aux_reset_in] [get_bd_pins tx_rst_gen/aux_reset_in]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins concat_intc/dout] [get_bd_pins microblaze_0_axi_intc/intr]

  # Create address segments
  assign_bd_address -offset 0x02000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces eth_dma/Data_S2MM] [get_bd_addr_segs rx_mem_dma/S_AXI/Mem0] -force
  assign_bd_address -offset 0x03000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces eth_dma/Data_SG] [get_bd_addr_segs sg_mem_dma/S_AXI/Mem0] -force
  assign_bd_address -offset 0x01000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces eth_dma/Data_MM2S] [get_bd_addr_segs tx_mem_dma/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00800400 -range 0x00000080 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_timer_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00400000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00810000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs eth100gb/s_axi/Reg] -force
  assign_bd_address -offset 0x00800C00 -range 0x00000400 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs eth_dma/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x00802000 -range 0x00002000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs ethmac_lite/S_AXI/Reg] -force
  assign_bd_address -offset 0x00800800 -range 0x00000200 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gt_ctl/S_AXI/Reg] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM00] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM00] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM01] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM01] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM02] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM02] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM03] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM03] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM04] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM04] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM05] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM05] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM06] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM06] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM07] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM07] -force
  assign_bd_address -offset 0x00000000 -range 0x00400000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00800000 -range 0x00000080 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs mdm_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x00800200 -range 0x00000200 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_axi_intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x00800600 -range 0x00000080 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs rx_axis_switch/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0x02000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs rx_mem_cpu/S_AXI/Mem0] -force
  assign_bd_address -offset 0x03000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs sg_mem_cpu/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00800500 -range 0x00000080 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs tx_axis_switch/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0x01000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs tx_mem_cpu/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00800A00 -range 0x00000200 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs tx_rx_ctl_stat/S_AXI/Reg] -force


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
