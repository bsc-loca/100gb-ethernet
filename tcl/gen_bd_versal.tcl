
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
set scripts_vivado_version 2021.2
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
xilinx.com:ip:axi_timer:2.0\
xilinx.com:ip:axi_uartlite:2.0\
xilinx.com:ip:axis_broadcaster:1.1\
xilinx.com:ip:axis_combiner:1.1\
xilinx.com:ip:bufg_gt:1.0\
xilinx.com:ip:clk_wizard:1.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:ddr4_pl:1.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:axi_ethernetlite:3.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:gig_ethernet_pcs_pma:16.2\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:gt_quad_base:1.1\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:mrmac:1.5\
xilinx.com:ip:emb_mem_gen:1.0\
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:util_ds_buf:2.2\
xilinx.com:ip:versal_cips:3.1\
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

  # Create instance: lmb_mem, and set properties
  set lmb_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:emb_mem_gen:1.0 lmb_mem ]
  set_property -dict [ list \
   CONFIG.MEMORY_PRIMITIVE {URAM} \
   CONFIG.MEMORY_TYPE {True_Dual_Port_RAM} \
   CONFIG.WRITE_MODE_A {NO_CHANGE} \
   CONFIG.WRITE_MODE_B {NO_CHANGE} \
 ] $lmb_mem

  # Create interface connections
  connect_bd_intf_net -intf_net dlmb_bram_if_cntlr_BRAM_PORT [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_mem/BRAM_PORTA]
  connect_bd_intf_net -intf_net ilmb_bram_if_cntlr_BRAM_PORT [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_mem/BRAM_PORTB]
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]

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
  set DDR4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 DDR4 ]

  set ETH_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ETH_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $ETH_CLK

  set ETH_GT [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 ETH_GT ]

  set GIG_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 GIG_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $GIG_CLK

  set GIG_GT [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 GIG_GT ]

  set MEM_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 MEM_CLK ]

  set SYS_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 SYS_CLK ]

  set UART [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 UART ]


  # Create ports
  set CPU_RESET_FPGA [ create_bd_port -dir I -type rst CPU_RESET_FPGA ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $CPU_RESET_FPGA

  # Create instance: axi_timer_0, and set properties
  set axi_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0 ]
  set_property -dict [ list \
   CONFIG.enable_timer2 {1} \
 ] $axi_timer_0

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list \
   CONFIG.C_BAUDRATE {115200} \
 ] $axi_uartlite_0

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]
  set_property -dict [ list \
   CONFIG.M00_TDATA_REMAP {tdata[31:0]} \
   CONFIG.M00_TUSER_REMAP {1'b0} \
   CONFIG.M01_TDATA_REMAP {tdata[63:32]} \
   CONFIG.M01_TUSER_REMAP {1'b0} \
   CONFIG.M02_TDATA_REMAP {tdata[95:64]} \
   CONFIG.M02_TUSER_REMAP {1'b0} \
   CONFIG.M03_TDATA_REMAP {tdata[127:96]} \
   CONFIG.M03_TUSER_REMAP {1'b0} \
   CONFIG.M04_TDATA_REMAP {tdata[159:128]} \
   CONFIG.M04_TUSER_REMAP {1'b0} \
   CONFIG.M05_TDATA_REMAP {tdata[191:160]} \
   CONFIG.M05_TUSER_REMAP {1'b0} \
   CONFIG.M06_TDATA_REMAP {tdata[223:192]} \
   CONFIG.M06_TUSER_REMAP {1'b0} \
   CONFIG.M07_TDATA_REMAP {tdata[255:224]} \
   CONFIG.M07_TUSER_REMAP {1'b0} \
   CONFIG.M08_TDATA_REMAP {tdata[287:256]} \
   CONFIG.M08_TUSER_REMAP {1'b0} \
   CONFIG.M09_TDATA_REMAP {tdata[319:288]} \
   CONFIG.M09_TUSER_REMAP {1'b0} \
   CONFIG.M10_TDATA_REMAP {tdata[351:320]} \
   CONFIG.M10_TUSER_REMAP {1'b0} \
   CONFIG.M11_TDATA_REMAP {tdata[383:352]} \
   CONFIG.M11_TUSER_REMAP {1'b0} \
   CONFIG.M12_TDATA_REMAP {tdata[415:384]} \
   CONFIG.M12_TUSER_REMAP {1'b0} \
   CONFIG.M13_TDATA_REMAP {tdata[447:416]} \
   CONFIG.M13_TUSER_REMAP {1'b0} \
   CONFIG.M14_TDATA_REMAP {tdata[479:448]} \
   CONFIG.M14_TUSER_REMAP {1'b0} \
   CONFIG.M15_TDATA_REMAP {tdata[511:480]} \
   CONFIG.M15_TUSER_REMAP {1'b0} \
   CONFIG.M_TDATA_NUM_BYTES {4} \
   CONFIG.NUM_MI {16} \
   CONFIG.S_TDATA_NUM_BYTES {64} \
 ] $axis_broadcaster_0

  # Create instance: axis_broadcaster_1, and set properties
  set axis_broadcaster_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_1 ]
  set_property -dict [ list \
   CONFIG.M00_TDATA_REMAP {tdata[63:0]} \
   CONFIG.M01_TDATA_REMAP {tdata[127:64]} \
   CONFIG.M02_TDATA_REMAP {tdata[191:128]} \
   CONFIG.M03_TDATA_REMAP {tdata[255:192]} \
   CONFIG.M_TDATA_NUM_BYTES {8} \
   CONFIG.NUM_MI {4} \
   CONFIG.S_TDATA_NUM_BYTES {32} \
 ] $axis_broadcaster_1

  # Create instance: axis_combiner_0, and set properties
  set axis_combiner_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0 ]
  set_property -dict [ list \
   CONFIG.NUM_SI {16} \
 ] $axis_combiner_0

  # Create instance: axis_combiner_1, and set properties
  set axis_combiner_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_1 ]
  set_property -dict [ list \
   CONFIG.NUM_SI {4} \
 ] $axis_combiner_1

  # Create instance: bufg_gt_rxck, and set properties
  set bufg_gt_rxck [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_rxck ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {62500000} \
 ] $bufg_gt_rxck

  # Create instance: bufg_gt_rxck_0, and set properties
  set bufg_gt_rxck_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_rxck_0 ]

  # Create instance: bufg_gt_rxck_1, and set properties
  set bufg_gt_rxck_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_rxck_1 ]

  # Create instance: bufg_gt_rxck_2, and set properties
  set bufg_gt_rxck_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_rxck_2 ]

  # Create instance: bufg_gt_rxck_3, and set properties
  set bufg_gt_rxck_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_rxck_3 ]

  # Create instance: bufg_gt_txck, and set properties
  set bufg_gt_txck [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_txck ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {62500000.0} \
 ] $bufg_gt_txck

  # Create instance: bufg_gt_txck_0, and set properties
  set bufg_gt_txck_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_txck_0 ]

  # Create instance: bufg_gt_txck_1, and set properties
  set bufg_gt_txck_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_txck_1 ]

  # Create instance: bufg_gt_txck_2, and set properties
  set bufg_gt_txck_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_txck_2 ]

  # Create instance: bufg_gt_txck_3, and set properties
  set bufg_gt_txck_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt:1.0 bufg_gt_txck_3 ]

  # Create instance: clk_wizard_0, and set properties
  set clk_wizard_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wizard:1.0 clk_wizard_0 ]
  set_property -dict [ list \
   CONFIG.CLKOUT2_DIVIDE {60.000000} \
   CONFIG.CLKOUT_DRIVES {BUFG,BUFG,BUFG,BUFG,BUFG,BUFG,BUFG} \
   CONFIG.CLKOUT_DYN_PS {None,None,None,None,None,None,None} \
   CONFIG.CLKOUT_GROUPING {Auto,Auto,Auto,Auto,Auto,Auto,Auto} \
   CONFIG.CLKOUT_MATCHED_ROUTING {false,false,false,false,false,false,false} \
   CONFIG.CLKOUT_PORT {clk_out1,clk_out2,clk_out3,clk_out4,clk_out5,clk_out6,clk_out7} \
   CONFIG.CLKOUT_REQUESTED_DUTY_CYCLE {50.000,50.000,50.000,50.000,50.000,50.000,50.000} \
   CONFIG.CLKOUT_REQUESTED_OUT_FREQUENCY {100.000,50.000,100.000,100.000,100.000,100.000,100.000} \
   CONFIG.CLKOUT_REQUESTED_PHASE {0.000,0.000,0.000,0.000,0.000,0.000,0.000} \
   CONFIG.CLKOUT_USED {true,true,false,false,false,false,false} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.USE_LOCKED {true} \
   CONFIG.USE_RESET {true} \
 ] $clk_wizard_0

  # Create instance: concat_gt_rxclk, and set properties
  set concat_gt_rxclk [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_gt_rxclk ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $concat_gt_rxclk

  # Create instance: concat_gt_txclk, and set properties
  set concat_gt_txclk [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_gt_txclk ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $concat_gt_txclk

  # Create instance: concat_intc, and set properties
  set concat_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_intc ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {6} \
 ] $concat_intc

  # Create instance: concat_sys_rst, and set properties
  set concat_sys_rst [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_sys_rst ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $concat_sys_rst

  # Create instance: const_3b001, and set properties
  set const_3b001 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_3b001 ]
  set_property -dict [ list \
   CONFIG.CONST_WIDTH {3} \
 ] $const_3b001

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

  # Create instance: const_gndx32, and set properties
  set const_gndx32 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_gndx32 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {32} \
 ] $const_gndx32

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

  # Create instance: ddr4_pl_0, and set properties
  set ddr4_pl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4_pl:1.0 ddr4_pl_0 ]
  set_property -dict [ list \
   CONFIG.DDR4_ADDR_BIT9 {BA1} \
   CONFIG.DDR4_AxiAddressWidth {33} \
   CONFIG.DDR4_AxiDataWidth {512} \
   CONFIG.DDR4_CASLATENCY {15} \
   CONFIG.DDR4_CASWRITELATENCY {12} \
   CONFIG.DDR4_DATAWIDTH {72} \
   CONFIG.DDR4_ECC {true} \
   CONFIG.DDR4_INPUTCLK_PERIOD {9996} \
   CONFIG.DDR4_INPUT_FREQUENCY {100.040} \
   CONFIG.DDR4_MEMORY_DENSITY {8GB} \
   CONFIG.DDR4_MEMORY_DEVICETYPE {RDIMMs} \
   CONFIG.DDR4_MEMORY_FREQUENCY {1200} \
   CONFIG.DDR4_MEMORY_SPEEDGRADE {DDR4-2400P(15-15-15)} \
   CONFIG.DDR4_MIN_PERIOD {833} \
   CONFIG.DDR4_PARITY_EN {true} \
   CONFIG.DDR4_RCD_DELAY {1} \
   CONFIG.DDR4_SIGNAL_WIDTHS {\
DDR4_DQS_WIDTH 9 DDR4_DM_WIDTH 9 DDR4_ADDR_WIDTH 17 DDR4_CKE_WIDTH 1\
DDR4_CK_WIDTH 1 DDR4_ODT_WIDTH 1 DDR4_LR_WIDTH 1 DDR4_CS_WIDTH 1} \
   CONFIG.DDR4_TCK {833} \
   CONFIG.DDR4_TFAW_nCK {26} \
   CONFIG.DDR4_TRC {44500} \
   CONFIG.DDR4_TRCD {12500} \
   CONFIG.DDR4_TRP {12500} \
   CONFIG.DDR4_TRPMIN {12500} \
   CONFIG.DDR4_TRRD_L {6} \
   CONFIG.DDR4_TWR_nCK {19} \
   CONFIG.DDR4_TXPR {433} \
   CONFIG.DDR4_UI_CLOCK {300000000} \
   CONFIG.DDR4_WRITE_DM_DBI {NO_DM_DBI} \
 ] $ddr4_pl_0

  # Create instance: ddr_rst_gen, and set properties
  set ddr_rst_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 ddr_rst_gen ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $ddr_rst_gen

  # Create instance: eth_dma, and set properties
  set eth_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 eth_dma ]
  set_property -dict [ list \
   CONFIG.c_include_mm2s_dre {1} \
   CONFIG.c_include_s2mm_dre {1} \
   CONFIG.c_include_sg {1} \
   CONFIG.c_m_axi_mm2s_data_width {256} \
   CONFIG.c_m_axis_mm2s_tdata_width {256} \
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
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $ext_rstn_inv

  # Create instance: gig_eth_phy, and set properties
  set gig_eth_phy [ create_bd_cell -type ip -vlnv xilinx.com:ip:gig_ethernet_pcs_pma:16.2 gig_eth_phy ]
  set_property -dict [ list \
   CONFIG.Auto_Negotiation {false} \
   CONFIG.DIFFCLK_BOARD_INTERFACE {Custom} \
   CONFIG.DrpClkRate {50} \
   CONFIG.Ext_Management_Interface {false} \
   CONFIG.GT_Location {X0Y0} \
   CONFIG.GTinEx {true} \
   CONFIG.Management_Interface {true} \
   CONFIG.MaxDataRate {1G} \
   CONFIG.RefClkRate {156.25} \
   CONFIG.RxGmiiClkSrc {TXOUTCLK} \
   CONFIG.SGMII_Mode {10_100_1000} \
   CONFIG.SGMII_PHY_Mode {true} \
   CONFIG.Standard {1000BASEX} \
   CONFIG.SupportLevel {Include_Shared_Logic_in_Example_Design} \
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

  # Create instance: gt_quad_base, and set properties
  set gt_quad_base [ create_bd_cell -type ip -vlnv xilinx.com:ip:gt_quad_base:1.1 gt_quad_base ]
  set_property -dict [ list \
   CONFIG.PORTS_INFO_DICT {\
     LANE_SEL_DICT {PROT0 {RX0 RX1 RX2 RX3 TX0 TX1 TX2 TX3}}\
     GT_TYPE {GTY}\
     REG_CONF_INTF {AXI_LITE}\
     BOARD_PARAMETER {}\
   } \
   CONFIG.QUAD_USAGE {\
     TX_QUAD_CH {TXQuad_0_/gt_quad_base {/gt_quad_base\
ethernet_test_mrmac_0_0_0.IP_CH0,ethernet_test_mrmac_0_0_0.IP_CH1,ethernet_test_mrmac_0_0_0.IP_CH2,ethernet_test_mrmac_0_0_0.IP_CH3\
MSTRCLK 1,0,0,0 IS_CURRENT_QUAD 1}}\
     RX_QUAD_CH {RXQuad_0_/gt_quad_base {/gt_quad_base\
ethernet_test_mrmac_0_0_0.IP_CH0,ethernet_test_mrmac_0_0_0.IP_CH1,ethernet_test_mrmac_0_0_0.IP_CH2,ethernet_test_mrmac_0_0_0.IP_CH3\
MSTRCLK 1,0,0,0 IS_CURRENT_QUAD 1}}\
   } \
   CONFIG.REFCLK_STRING {\
HSCLK0_LCPLLGTREFCLK0 refclk_PROT0_R0_156.25_MHz_unique1 HSCLK1_LCPLLGTREFCLK0\
refclk_PROT0_R0_156.25_MHz_unique1} \
   CONFIG.REG_CONF_INTF {AXI_LITE} \
 ] $gt_quad_base

  # Create instance: gt_quad_base_1, and set properties
  set gt_quad_base_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:gt_quad_base:1.1 gt_quad_base_1 ]
  set_property -dict [ list \
   CONFIG.PORTS_INFO_DICT {\
     LANE_SEL_DICT {PROT0 {RX0 TX0} unconnected {RX1 RX2 RX3 TX1 TX2 TX3}}\
     GT_TYPE {GTY}\
     REG_CONF_INTF {AXI_LITE}\
     BOARD_PARAMETER {}\
   } \
   CONFIG.QUAD_USAGE {\
     TX_QUAD_CH {TXQuad_0_/gt_quad_base_1 {/gt_quad_base_1\
ethernet_test_gig_eth_phy_0_0.IP_CH0,undef,undef,undef MSTRCLK\
1,0,0,0 IS_CURRENT_QUAD 1}}\
     RX_QUAD_CH {RXQuad_0_/gt_quad_base_1 {/gt_quad_base_1\
ethernet_test_gig_eth_phy_0_0.IP_CH0,undef,undef,undef MSTRCLK\
1,0,0,0 IS_CURRENT_QUAD 1}}\
   } \
   CONFIG.REFCLK_STRING {HSCLK0_LCPLLGTREFCLK0 refclk_PROT0_R0_156.25_MHz_unique1} \
   CONFIG.REG_CONF_INTF {AXI_LITE} \
 ] $gt_quad_base_1

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
   CONFIG.C_BSCANID {76547328} \
   CONFIG.C_M_AXI_ADDR_WIDTH {32} \
   CONFIG.C_USE_BSCAN {4} \
   CONFIG.C_USE_UART {1} \
 ] $mdm_1

  # Create instance: mem_connect, and set properties
  set mem_connect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 mem_connect ]
  set_property -dict [ list \
   CONFIG.NUM_CLKS {2} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
 ] $mem_connect

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_TAG_BITS {16} \
   CONFIG.C_CACHE_BYTE_SIZE {16384} \
   CONFIG.C_DCACHE_ADDR_TAG {16} \
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
   CONFIG.C_MMU_ZONES {2} \
   CONFIG.C_M_AXI_D_BUS_EXCEPTION {1} \
   CONFIG.C_M_AXI_I_BUS_EXCEPTION {1} \
   CONFIG.C_OPCODE_0x0_ILLEGAL {1} \
   CONFIG.C_PVR {2} \
   CONFIG.C_UNALIGNED_EXCEPTIONS {1} \
   CONFIG.C_USE_BARREL {1} \
   CONFIG.C_USE_DCACHE {1} \
   CONFIG.C_USE_DIV {1} \
   CONFIG.C_USE_HW_MUL {2} \
   CONFIG.C_USE_ICACHE {1} \
   CONFIG.C_USE_MMU {3} \
   CONFIG.C_USE_MSR_INSTR {1} \
   CONFIG.C_USE_PCMP_INSTR {1} \
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

  # Create instance: mrmac_0, and set properties
  set mrmac_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mrmac:1.5 mrmac_0 ]
  set_property -dict [ list \
   CONFIG.GT_CH0_RX_REFCLK_FREQUENCY_C0 {156.25} \
   CONFIG.GT_CH0_TX_REFCLK_FREQUENCY_C0 {156.25} \
   CONFIG.GT_CH1_RX_REFCLK_FREQUENCY_C0 {156.25} \
   CONFIG.GT_CH1_TX_REFCLK_FREQUENCY_C0 {156.25} \
   CONFIG.GT_CH2_RX_REFCLK_FREQUENCY_C0 {156.25} \
   CONFIG.GT_CH2_TX_REFCLK_FREQUENCY_C0 {156.25} \
   CONFIG.GT_CH3_RX_REFCLK_FREQUENCY_C0 {156.25} \
   CONFIG.GT_CH3_TX_REFCLK_FREQUENCY_C0 {156.25} \
   CONFIG.GT_REF_CLK_FREQ_C0 {156.25} \
   CONFIG.MRMAC_DATA_PATH_INTERFACE_C0 {256b Non-Segmented} \
 ] $mrmac_0

  # Create instance: periph_connect, and set properties
  set periph_connect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 periph_connect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {12} \
   CONFIG.NUM_SI {1} \
 ] $periph_connect

  # Create instance: rx_fifo, and set properties
  set rx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 rx_fifo ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {64} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $rx_fifo

  # Create instance: rx_mem, and set properties
  set rx_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:emb_mem_gen:1.0 rx_mem ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH_A {20} \
   CONFIG.ADDR_WIDTH_B {20} \
   CONFIG.CLOCKING_MODE {Independent_Clock} \
   CONFIG.ENABLE_32BIT_ADDRESS {true} \
   CONFIG.MEMORY_OPTIMIZATION {optimize_memory} \
   CONFIG.MEMORY_PRIMITIVE {BRAM} \
   CONFIG.MEMORY_TYPE {True_Dual_Port_RAM} \
   CONFIG.READ_DATA_WIDTH_A {32} \
   CONFIG.READ_DATA_WIDTH_B {32} \
   CONFIG.USE_EMBEDDED_CONSTRAINT {false} \
   CONFIG.WRITE_DATA_WIDTH_A {32} \
   CONFIG.WRITE_DATA_WIDTH_B {32} \
   CONFIG.WRITE_MODE_A {WRITE_FIRST} \
   CONFIG.WRITE_MODE_B {WRITE_FIRST} \
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
   CONFIG.DATA_WIDTH {256} \
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
  set sg_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:emb_mem_gen:1.0 sg_mem ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH_A {20} \
   CONFIG.ADDR_WIDTH_B {20} \
   CONFIG.CLOCKING_MODE {Common_Clock} \
   CONFIG.ENABLE_32BIT_ADDRESS {true} \
   CONFIG.MEMORY_OPTIMIZATION {optimize_memory} \
   CONFIG.MEMORY_PRIMITIVE {URAM} \
   CONFIG.MEMORY_TYPE {True_Dual_Port_RAM} \
   CONFIG.USE_EMBEDDED_CONSTRAINT {false} \
   CONFIG.WRITE_MODE_A {NO_CHANGE} \
   CONFIG.WRITE_MODE_B {NO_CHANGE} \
 ] $sg_mem

  # Create instance: sg_mem_cpu, and set properties
  set sg_mem_cpu [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 sg_mem_cpu ]
  set_property -dict [ list \
   CONFIG.ECC_TYPE {0} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.SINGLE_PORT_BRAM {1} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
 ] $sg_mem_cpu

  # Create instance: sg_mem_dma, and set properties
  set sg_mem_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 sg_mem_dma ]
  set_property -dict [ list \
   CONFIG.ECC_TYPE {0} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $sg_mem_dma

  # Create instance: sys_rst_gen, and set properties
  set sys_rst_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_rst_gen ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $sys_rst_gen

  # Create instance: tx_fifo, and set properties
  set tx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 tx_fifo ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $tx_fifo

  # Create instance: tx_mem, and set properties
  set tx_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:emb_mem_gen:1.0 tx_mem ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH_A {20} \
   CONFIG.ADDR_WIDTH_B {20} \
   CONFIG.CLOCKING_MODE {Independent_Clock} \
   CONFIG.ENABLE_32BIT_ADDRESS {true} \
   CONFIG.MEMORY_OPTIMIZATION {optimize_memory} \
   CONFIG.MEMORY_PRIMITIVE {BRAM} \
   CONFIG.MEMORY_TYPE {True_Dual_Port_RAM} \
   CONFIG.READ_DATA_WIDTH_A {32} \
   CONFIG.READ_DATA_WIDTH_B {32} \
   CONFIG.USE_EMBEDDED_CONSTRAINT {false} \
   CONFIG.WRITE_DATA_WIDTH_A {32} \
   CONFIG.WRITE_DATA_WIDTH_B {32} \
   CONFIG.WRITE_MODE_A {WRITE_FIRST} \
   CONFIG.WRITE_MODE_B {WRITE_FIRST} \
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
   CONFIG.DATA_WIDTH {256} \
   CONFIG.ECC_TYPE {0} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $tx_mem_dma

  # Create instance: tx_rst_gen, and set properties
  set tx_rst_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 tx_rst_gen ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $tx_rst_gen

  # Create instance: util_ds_buf, and set properties
  set util_ds_buf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $util_ds_buf

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_0 ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $util_ds_buf_0

  # Create instance: versal_cips_0, and set properties
  set versal_cips_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips:3.1 versal_cips_0 ]
  set_property -dict [ list \
   CONFIG.BOOT_MODE {Custom} \
   CONFIG.CLOCK_MODE {REF CLK 33.33 MHz} \
   CONFIG.DDR_MEMORY_MODE {Custom} \
   CONFIG.DESIGN_MODE {0} \
   CONFIG.PS_PMC_CONFIG {\
     CLOCK_MODE {REF CLK 33.33 MHz}\
     DESIGN_MODE {0}\
     PMC_ALT_REF_CLK_FREQMHZ {33.333}\
     PMC_CRP_EFUSE_REF_CTRL_SRCSEL {IRO_CLK/4}\
     PMC_CRP_HSM0_REF_CTRL_FREQMHZ {33.333}\
     PMC_CRP_HSM1_REF_CTRL_FREQMHZ {133.333}\
     PMC_CRP_LSBUS_REF_CTRL_FREQMHZ {100}\
     PMC_CRP_NOC_REF_CTRL_FREQMHZ {960}\
     PMC_CRP_PL0_REF_CTRL_FREQMHZ {100}\
     PMC_CRP_PL5_REF_CTRL_FREQMHZ {400}\
     PMC_PL_ALT_REF_CLK_FREQMHZ {33.333}\
     PS_BOARD_INTERFACE {Custom}\
     PS_NUM_FABRIC_RESETS {0}\
     PS_USE_PMCPL_CLK0 {1}\
     PS_USE_PMCPL_CLK1 {0}\
     PS_USE_PMCPL_CLK2 {0}\
     PS_USE_PMCPL_CLK3 {0}\
     PS_USE_PMCPL_IRO_CLK {1}\
     SMON_ALARMS {Set_Alarms_On}\
     SMON_ENABLE_TEMP_AVERAGING {0}\
     SMON_TEMP_AVERAGING_SAMPLES {0}\
   } \
   CONFIG.PS_PMC_CONFIG_APPLIED {1} \
 ] $versal_cips_0

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN1_D_0_2 [get_bd_intf_ports SYS_CLK] [get_bd_intf_pins clk_wizard_0/CLK_IN1_D]
  connect_bd_intf_net -intf_net CLK_IN_D_1 [get_bd_intf_ports ETH_CLK] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
  connect_bd_intf_net -intf_net SYS_CLK_0_1 [get_bd_intf_ports MEM_CLK] [get_bd_intf_pins ddr4_pl_0/SYS_CLK]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports UART] [get_bd_intf_pins axi_uartlite_0/UART]
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
  connect_bd_intf_net -intf_net axis_broadcaster_1_M00_AXIS [get_bd_intf_pins axis_broadcaster_1/M00_AXIS] [get_bd_intf_pins mrmac_0/axis_tx_port0]
  connect_bd_intf_net -intf_net axis_broadcaster_1_M01_AXIS [get_bd_intf_pins axis_broadcaster_1/M01_AXIS] [get_bd_intf_pins mrmac_0/axis_tx_port1]
  connect_bd_intf_net -intf_net axis_broadcaster_1_M02_AXIS [get_bd_intf_pins axis_broadcaster_1/M02_AXIS] [get_bd_intf_pins mrmac_0/axis_tx_port2]
  connect_bd_intf_net -intf_net axis_broadcaster_1_M03_AXIS [get_bd_intf_pins axis_broadcaster_1/M03_AXIS] [get_bd_intf_pins mrmac_0/axis_tx_port3]
  connect_bd_intf_net -intf_net axis_combiner_0_M_AXIS [get_bd_intf_pins axis_combiner_0/M_AXIS] [get_bd_intf_pins tx_fifo/S_AXIS]
  connect_bd_intf_net -intf_net axis_combiner_1_M_AXIS [get_bd_intf_pins axis_combiner_1/M_AXIS] [get_bd_intf_pins eth_dma/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net ddr4_pl_0_DDR4 [get_bd_intf_ports DDR4] [get_bd_intf_pins ddr4_pl_0/DDR4]
  connect_bd_intf_net -intf_net eth_dma_M_AXIS_MM2S [get_bd_intf_pins axis_broadcaster_1/S_AXIS] [get_bd_intf_pins eth_dma/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net eth_dma_M_AXI_MM2S [get_bd_intf_pins eth_dma/M_AXI_MM2S] [get_bd_intf_pins tx_mem_dma/S_AXI]
  connect_bd_intf_net -intf_net eth_dma_M_AXI_S2MM [get_bd_intf_pins eth_dma/M_AXI_S2MM] [get_bd_intf_pins rx_mem_dma/S_AXI]
  connect_bd_intf_net -intf_net eth_dma_M_AXI_SG [get_bd_intf_pins eth_dma/M_AXI_SG] [get_bd_intf_pins sg_mem_dma/S_AXI]
  connect_bd_intf_net -intf_net eth_lite_dum4lwip_MDIO [get_bd_intf_pins ethmac_lite/MDIO] [get_bd_intf_pins gig_eth_phy/mdio_pcs_pma]
  connect_bd_intf_net -intf_net gig_eth_phy_diff_gt_ref_clock_1 [get_bd_intf_ports GIG_CLK] [get_bd_intf_pins util_ds_buf/CLK_IN_D]
  connect_bd_intf_net -intf_net gig_eth_phy_gt_rx_interface [get_bd_intf_pins gig_eth_phy/gt_rx_interface] [get_bd_intf_pins gt_quad_base_1/RX0_GT_IP_Interface]
  connect_bd_intf_net -intf_net gig_eth_phy_gt_tx_interface [get_bd_intf_pins gig_eth_phy/gt_tx_interface] [get_bd_intf_pins gt_quad_base_1/TX0_GT_IP_Interface]
  connect_bd_intf_net -intf_net gt_quad_base_1_GT_Serial [get_bd_intf_ports GIG_GT] [get_bd_intf_pins gt_quad_base_1/GT_Serial]
  connect_bd_intf_net -intf_net gt_quad_base_GT_Serial [get_bd_intf_ports ETH_GT] [get_bd_intf_pins gt_quad_base/GT_Serial]
  connect_bd_intf_net -intf_net loopback_fifo_M_AXIS [get_bd_intf_pins loopback_fifo/M_AXIS] [get_bd_intf_pins rx_fifo/S_AXIS]
  connect_bd_intf_net -intf_net mem_connect_M00_AXI [get_bd_intf_pins ddr4_pl_0/DDR4_S_AXI] [get_bd_intf_pins mem_connect/M00_AXI]
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
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DC [get_bd_intf_pins mem_connect/S01_AXI] [get_bd_intf_pins microblaze_0/M_AXI_DC]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins periph_connect/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_IC [get_bd_intf_pins mem_connect/S00_AXI] [get_bd_intf_pins microblaze_0/M_AXI_IC]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]
  connect_bd_intf_net -intf_net mrmac_0_axis_rx_port0 [get_bd_intf_pins axis_combiner_1/S00_AXIS] [get_bd_intf_pins mrmac_0/axis_rx_port0]
  connect_bd_intf_net -intf_net mrmac_0_axis_rx_port1 [get_bd_intf_pins axis_combiner_1/S01_AXIS] [get_bd_intf_pins mrmac_0/axis_rx_port1]
  connect_bd_intf_net -intf_net mrmac_0_axis_rx_port2 [get_bd_intf_pins axis_combiner_1/S02_AXIS] [get_bd_intf_pins mrmac_0/axis_rx_port2]
  connect_bd_intf_net -intf_net mrmac_0_axis_rx_port3 [get_bd_intf_pins axis_combiner_1/S03_AXIS] [get_bd_intf_pins mrmac_0/axis_rx_port3]
  connect_bd_intf_net -intf_net mrmac_0_gt_rx_serdes_interface_0 [get_bd_intf_pins gt_quad_base/RX0_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_rx_serdes_interface_0]
  connect_bd_intf_net -intf_net mrmac_0_gt_rx_serdes_interface_1 [get_bd_intf_pins gt_quad_base/RX1_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_rx_serdes_interface_1]
  connect_bd_intf_net -intf_net mrmac_0_gt_rx_serdes_interface_2 [get_bd_intf_pins gt_quad_base/RX2_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_rx_serdes_interface_2]
  connect_bd_intf_net -intf_net mrmac_0_gt_rx_serdes_interface_3 [get_bd_intf_pins gt_quad_base/RX3_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_rx_serdes_interface_3]
  connect_bd_intf_net -intf_net mrmac_0_gt_tx_serdes_interface_0 [get_bd_intf_pins gt_quad_base/TX0_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_tx_serdes_interface_0]
  connect_bd_intf_net -intf_net mrmac_0_gt_tx_serdes_interface_1 [get_bd_intf_pins gt_quad_base/TX1_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_tx_serdes_interface_1]
  connect_bd_intf_net -intf_net mrmac_0_gt_tx_serdes_interface_2 [get_bd_intf_pins gt_quad_base/TX2_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_tx_serdes_interface_2]
  connect_bd_intf_net -intf_net mrmac_0_gt_tx_serdes_interface_3 [get_bd_intf_pins gt_quad_base/TX3_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_tx_serdes_interface_3]
  connect_bd_intf_net -intf_net periph_connect_M02_AXI [get_bd_intf_pins mrmac_0/s_axi] [get_bd_intf_pins periph_connect/M02_AXI]
  connect_bd_intf_net -intf_net periph_connect_M03_AXI [get_bd_intf_pins gt_quad_base/AXI_LITE] [get_bd_intf_pins periph_connect/M03_AXI]
  connect_bd_intf_net -intf_net periph_connect_M04_AXI [get_bd_intf_pins gt_quad_base_1/AXI_LITE] [get_bd_intf_pins periph_connect/M04_AXI]
  connect_bd_intf_net -intf_net periph_connect_M05_AXI [get_bd_intf_pins periph_connect/M05_AXI] [get_bd_intf_pins sg_mem_cpu/S_AXI]
  connect_bd_intf_net -intf_net periph_connect_M11_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins periph_connect/M11_AXI]
  connect_bd_intf_net -intf_net rx_fifo_M_AXIS [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins rx_fifo/M_AXIS]
  connect_bd_intf_net -intf_net rx_mem_cpu_BRAM_PORTA [get_bd_intf_pins rx_mem/BRAM_PORTA] [get_bd_intf_pins rx_mem_cpu/BRAM_PORTA]
  connect_bd_intf_net -intf_net rx_mem_dma_BRAM_PORTA [get_bd_intf_pins rx_mem/BRAM_PORTB] [get_bd_intf_pins rx_mem_dma/BRAM_PORTA]
  connect_bd_intf_net -intf_net sg_mem_cpu_BRAM_PORTA [get_bd_intf_pins sg_mem/BRAM_PORTA] [get_bd_intf_pins sg_mem_cpu/BRAM_PORTA]
  connect_bd_intf_net -intf_net sg_mem_dma_BRAM_PORTA [get_bd_intf_pins sg_mem/BRAM_PORTB] [get_bd_intf_pins sg_mem_dma/BRAM_PORTA]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI1 [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins periph_connect/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins mdm_1/S_AXI] [get_bd_intf_pins periph_connect/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M06_AXI [get_bd_intf_pins axi_timer_0/S_AXI] [get_bd_intf_pins periph_connect/M06_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M07_AXI [get_bd_intf_pins ethmac_lite/S_AXI] [get_bd_intf_pins periph_connect/M07_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M08_AXI [get_bd_intf_pins periph_connect/M08_AXI] [get_bd_intf_pins tx_mem_cpu/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M09_AXI [get_bd_intf_pins periph_connect/M09_AXI] [get_bd_intf_pins rx_mem_cpu/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M10_AXI [get_bd_intf_pins eth_dma/S_AXI_LITE] [get_bd_intf_pins periph_connect/M10_AXI]
  connect_bd_intf_net -intf_net tx_fifo_M_AXIS [get_bd_intf_pins loopback_fifo/S_AXIS] [get_bd_intf_pins tx_fifo/M_AXIS]
  connect_bd_intf_net -intf_net tx_mem_cpu_BRAM_PORTA [get_bd_intf_pins tx_mem/BRAM_PORTA] [get_bd_intf_pins tx_mem_cpu/BRAM_PORTA]
  connect_bd_intf_net -intf_net tx_mem_dma_BRAM_PORTA [get_bd_intf_pins tx_mem/BRAM_PORTB] [get_bd_intf_pins tx_mem_dma/BRAM_PORTA]

  # Create port connections
  connect_bd_net -net axi_ethernetlite_0_ip2intc_irpt [get_bd_pins concat_intc/In2] [get_bd_pins ethmac_lite/ip2intc_irpt]
  connect_bd_net -net axi_timer_0_interrupt [get_bd_pins axi_timer_0/interrupt] [get_bd_pins concat_intc/In1]
  connect_bd_net -net axi_uartlite_0_interrupt [get_bd_pins axi_uartlite_0/interrupt] [get_bd_pins concat_intc/In5]
  connect_bd_net -net bufg_gt_0_usrclk [get_bd_pins bufg_gt_txck/usrclk] [get_bd_pins gig_eth_phy/userclk] [get_bd_pins gt_quad_base_1/ch0_txusrclk]
  connect_bd_net -net bufg_gt_rxck_0_usrclk [get_bd_pins bufg_gt_rxck_0/usrclk] [get_bd_pins gt_quad_base/ch0_rxusrclk] [get_bd_pins mrmac_0/rx_alt_serdes_clk] [get_bd_pins mrmac_0/rx_axi_clk] [get_bd_pins mrmac_0/rx_core_clk] [get_bd_pins mrmac_0/rx_serdes_clk]
  connect_bd_net -net bufg_gt_rxck_1_usrclk [get_bd_pins bufg_gt_rxck_1/usrclk] [get_bd_pins gt_quad_base/ch1_rxusrclk]
  connect_bd_net -net bufg_gt_rxck_2_usrclk [get_bd_pins bufg_gt_rxck_2/usrclk] [get_bd_pins gt_quad_base/ch2_rxusrclk]
  connect_bd_net -net bufg_gt_rxck_3_usrclk [get_bd_pins bufg_gt_rxck_3/usrclk] [get_bd_pins gt_quad_base/ch3_rxusrclk]
  connect_bd_net -net bufg_gt_txck_0_usrclk1 [get_bd_pins bufg_gt_txck_0/usrclk] [get_bd_pins gt_quad_base/ch0_txusrclk] [get_bd_pins mrmac_0/tx_alt_serdes_clk] [get_bd_pins mrmac_0/tx_axi_clk] [get_bd_pins mrmac_0/tx_core_clk]
  connect_bd_net -net bufg_gt_txck_1_usrclk [get_bd_pins bufg_gt_txck_1/usrclk] [get_bd_pins gt_quad_base/ch1_txusrclk]
  connect_bd_net -net bufg_gt_txck_2_usrclk [get_bd_pins bufg_gt_txck_2/usrclk] [get_bd_pins gt_quad_base/ch2_txusrclk]
  connect_bd_net -net bufg_gt_txck_3_usrclk [get_bd_pins bufg_gt_txck_3/usrclk] [get_bd_pins gt_quad_base/ch3_txusrclk]
  connect_bd_net -net bufg_gt_usrclk [get_bd_pins bufg_gt_rxck/usrclk] [get_bd_pins gt_quad_base_1/ch0_rxusrclk]
  connect_bd_net -net calib_comb_Res [get_bd_pins ddr4_pl_0/init_calib_complete] [get_bd_pins ddr_rst_gen/aux_reset_in] [get_bd_pins rx_rst_gen/aux_reset_in] [get_bd_pins sys_rst_gen/aux_reset_in] [get_bd_pins tx_rst_gen/aux_reset_in]
  connect_bd_net -net clk_wizard_0_clk_out2 [get_bd_pins clk_wizard_0/clk_out2] [get_bd_pins ethmac_lite/phy_rx_clk] [get_bd_pins ethmac_lite/phy_tx_clk] [get_bd_pins gig_eth_phy/independent_clock_bufg]
  connect_bd_net -net clk_wizard_0_locked [get_bd_pins clk_wizard_0/locked] [get_bd_pins sys_rst_gen/dcm_locked]
  connect_bd_net -net concat_sys_rst_dout [get_bd_pins concat_sys_rst/dout] [get_bd_pins mrmac_0/gt_reset_all_in] [get_bd_pins mrmac_0/gt_reset_rx_datapath_in] [get_bd_pins mrmac_0/gt_reset_tx_datapath_in] [get_bd_pins mrmac_0/rx_core_reset] [get_bd_pins mrmac_0/rx_serdes_reset] [get_bd_pins mrmac_0/tx_core_reset] [get_bd_pins mrmac_0/tx_serdes_reset]
  connect_bd_net -net const_gnd_dout [get_bd_pins axi_timer_0/capturetrig0] [get_bd_pins axi_timer_0/capturetrig1] [get_bd_pins axi_timer_0/freeze] [get_bd_pins bufg_gt_rxck/gt_bufgtclr] [get_bd_pins bufg_gt_rxck_0/gt_bufgtclr] [get_bd_pins bufg_gt_rxck_1/gt_bufgtclr] [get_bd_pins bufg_gt_rxck_2/gt_bufgtclr] [get_bd_pins bufg_gt_rxck_3/gt_bufgtclr] [get_bd_pins bufg_gt_txck/gt_bufgtclr] [get_bd_pins bufg_gt_txck_0/gt_bufgtclr] [get_bd_pins bufg_gt_txck_1/gt_bufgtclr] [get_bd_pins bufg_gt_txck_2/gt_bufgtclr] [get_bd_pins bufg_gt_txck_3/gt_bufgtclr] [get_bd_pins const_gnd/dout] [get_bd_pins ddr4_pl_0/ddr4_s_axi_ctrl_arvalid] [get_bd_pins ddr4_pl_0/ddr4_s_axi_ctrl_awvalid] [get_bd_pins ddr4_pl_0/ddr4_s_axi_ctrl_bready] [get_bd_pins ddr4_pl_0/ddr4_s_axi_ctrl_rready] [get_bd_pins ddr4_pl_0/ddr4_s_axi_ctrl_wvalid] [get_bd_pins ethmac_lite/phy_col] [get_bd_pins ethmac_lite/phy_crs] [get_bd_pins gig_eth_phy/configuration_valid] [get_bd_pins gig_eth_phy/gmii_tx_er] [get_bd_pins gig_eth_phy/userclk2]
  connect_bd_net -net const_gndx32_dout [get_bd_pins const_gndx32/dout] [get_bd_pins ddr4_pl_0/ddr4_s_axi_ctrl_araddr] [get_bd_pins ddr4_pl_0/ddr4_s_axi_ctrl_awaddr] [get_bd_pins ddr4_pl_0/ddr4_s_axi_ctrl_wdata]
  connect_bd_net -net const_gndx4_dout [get_bd_pins const_gndx4/dout] [get_bd_pins gig_eth_phy_txd/In1] [get_bd_pins mrmac_0/rx_flexif_clk] [get_bd_pins mrmac_0/rx_ts_clk] [get_bd_pins mrmac_0/tx_flexif_clk] [get_bd_pins mrmac_0/tx_ts_clk]
  connect_bd_net -net const_gndx5_dout [get_bd_pins const_gndx5/dout] [get_bd_pins gig_eth_phy/configuration_vector] [get_bd_pins gig_eth_phy/phyaddr]
  connect_bd_net -net const_vcc_dout [get_bd_pins bufg_gt_rxck/gt_bufgtce] [get_bd_pins bufg_gt_rxck/gt_bufgtcemask] [get_bd_pins bufg_gt_rxck/gt_bufgtclrmask] [get_bd_pins bufg_gt_rxck_0/gt_bufgtce] [get_bd_pins bufg_gt_rxck_0/gt_bufgtcemask] [get_bd_pins bufg_gt_rxck_0/gt_bufgtclrmask] [get_bd_pins bufg_gt_rxck_1/gt_bufgtce] [get_bd_pins bufg_gt_rxck_1/gt_bufgtcemask] [get_bd_pins bufg_gt_rxck_1/gt_bufgtclrmask] [get_bd_pins bufg_gt_rxck_2/gt_bufgtce] [get_bd_pins bufg_gt_rxck_2/gt_bufgtcemask] [get_bd_pins bufg_gt_rxck_2/gt_bufgtclrmask] [get_bd_pins bufg_gt_rxck_3/gt_bufgtce] [get_bd_pins bufg_gt_rxck_3/gt_bufgtcemask] [get_bd_pins bufg_gt_rxck_3/gt_bufgtclrmask] [get_bd_pins bufg_gt_txck/gt_bufgtce] [get_bd_pins bufg_gt_txck/gt_bufgtcemask] [get_bd_pins bufg_gt_txck/gt_bufgtclrmask] [get_bd_pins bufg_gt_txck_0/gt_bufgtce] [get_bd_pins bufg_gt_txck_0/gt_bufgtcemask] [get_bd_pins bufg_gt_txck_0/gt_bufgtclrmask] [get_bd_pins bufg_gt_txck_1/gt_bufgtce] [get_bd_pins bufg_gt_txck_1/gt_bufgtcemask] [get_bd_pins bufg_gt_txck_1/gt_bufgtclrmask] [get_bd_pins bufg_gt_txck_2/gt_bufgtce] [get_bd_pins bufg_gt_txck_2/gt_bufgtcemask] [get_bd_pins bufg_gt_txck_2/gt_bufgtclrmask] [get_bd_pins bufg_gt_txck_3/gt_bufgtce] [get_bd_pins bufg_gt_txck_3/gt_bufgtcemask] [get_bd_pins bufg_gt_txck_3/gt_bufgtclrmask] [get_bd_pins const_vcc/dout] [get_bd_pins ddr_rst_gen/dcm_locked] [get_bd_pins gig_eth_phy/signal_detect]
  connect_bd_net -net const_vccx64_dout [get_bd_pins const_vccx64/dout] [get_bd_pins tx_fifo/s_axis_tkeep]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk [get_bd_pins ddr4_pl_0/ddr4_ui_clk] [get_bd_pins ddr_rst_gen/slowest_sync_clk] [get_bd_pins mem_connect/aclk1]
  connect_bd_net -net eth_dma_mm2s_introut [get_bd_pins concat_intc/In3] [get_bd_pins eth_dma/mm2s_introut]
  connect_bd_net -net eth_dma_mm2s_prmry_reset_out_n [get_bd_pins eth_dma/mm2s_prmry_reset_out_n] [get_bd_pins tx_mem_dma/s_axi_aresetn]
  connect_bd_net -net eth_dma_s2mm_introut [get_bd_pins concat_intc/In4] [get_bd_pins eth_dma/s2mm_introut]
  connect_bd_net -net eth_dma_s2mm_prmry_reset_out_n [get_bd_pins eth_dma/s2mm_prmry_reset_out_n] [get_bd_pins rx_mem_dma/s_axi_aresetn]
  connect_bd_net -net eth_lite_dum4lwip_phy_tx_data [get_bd_pins ethmac_lite/phy_tx_data] [get_bd_pins gig_eth_phy_txd/In0]
  connect_bd_net -net eth_lite_dum4lwip_phy_tx_en [get_bd_pins ethmac_lite/phy_tx_en] [get_bd_pins gig_eth_phy/gmii_tx_en]
  connect_bd_net -net gig_eth_phy_rxd_Dout [get_bd_pins ethmac_lite/phy_rx_data] [get_bd_pins gig_eth_phy_rxd/Dout]
  connect_bd_net -net gig_eth_phy_txd_dout [get_bd_pins gig_eth_phy/gmii_txd] [get_bd_pins gig_eth_phy_txd/dout]
  connect_bd_net -net gig_ethernet_pcs_pma_0_gmii_rx_dv [get_bd_pins ethmac_lite/phy_dv] [get_bd_pins gig_eth_phy/gmii_rx_dv]
  connect_bd_net -net gig_ethernet_pcs_pma_0_gmii_rx_er [get_bd_pins ethmac_lite/phy_rx_er] [get_bd_pins gig_eth_phy/gmii_rx_er]
  connect_bd_net -net gig_ethernet_pcs_pma_0_gmii_rxd [get_bd_pins gig_eth_phy/gmii_rxd] [get_bd_pins gig_eth_phy_rxd/Din]
  connect_bd_net -net gt_quad_base_1_ch0_rxoutclk [get_bd_pins bufg_gt_rxck/outclk] [get_bd_pins gig_eth_phy/rxuserclk] [get_bd_pins gig_eth_phy/rxuserclk2] [get_bd_pins gt_quad_base_1/ch0_rxoutclk]
  connect_bd_net -net gt_quad_base_1_ch0_rxprogdivresetdone [get_bd_pins gig_eth_phy/gtwiz_reset_rx_done_in] [get_bd_pins gt_quad_base_1/ch0_rxprogdivresetdone]
  connect_bd_net -net gt_quad_base_1_ch0_txoutclk [get_bd_pins bufg_gt_txck/outclk] [get_bd_pins gt_quad_base_1/ch0_txoutclk]
  connect_bd_net -net gt_quad_base_1_ch0_txprogdivresetdone [get_bd_pins gig_eth_phy/gtwiz_reset_tx_done_in] [get_bd_pins gt_quad_base_1/ch0_txprogdivresetdone]
  connect_bd_net -net gt_quad_base_1_gtpowergood [get_bd_pins gig_eth_phy/gtpowergood_in] [get_bd_pins gig_eth_phy/mmcm_locked] [get_bd_pins gt_quad_base_1/gtpowergood]
  connect_bd_net -net gt_quad_base_ch0_rxoutclk [get_bd_pins axis_combiner_1/aclk] [get_bd_pins bufg_gt_rxck_0/outclk] [get_bd_pins concat_gt_rxclk/In0] [get_bd_pins eth_dma/m_axi_s2mm_aclk] [get_bd_pins gt_quad_base/ch0_rxoutclk] [get_bd_pins loopback_fifo/m_axis_aclk] [get_bd_pins rx_fifo/s_axis_aclk] [get_bd_pins rx_mem_dma/s_axi_aclk] [get_bd_pins rx_rst_gen/slowest_sync_clk]
  connect_bd_net -net gt_quad_base_ch0_txoutclk1 [get_bd_pins axis_broadcaster_1/aclk] [get_bd_pins bufg_gt_txck_0/outclk] [get_bd_pins concat_gt_txclk/In0] [get_bd_pins eth_dma/m_axi_mm2s_aclk] [get_bd_pins gt_quad_base/ch0_txoutclk] [get_bd_pins loopback_fifo/s_axis_aclk] [get_bd_pins tx_fifo/m_axis_aclk] [get_bd_pins tx_mem_dma/s_axi_aclk] [get_bd_pins tx_rst_gen/slowest_sync_clk]
  connect_bd_net -net gt_quad_base_ch1_rxoutclk [get_bd_pins bufg_gt_rxck_1/outclk] [get_bd_pins concat_gt_rxclk/In1] [get_bd_pins gt_quad_base/ch1_rxoutclk]
  connect_bd_net -net gt_quad_base_ch1_txoutclk [get_bd_pins bufg_gt_txck_1/outclk] [get_bd_pins concat_gt_txclk/In1] [get_bd_pins gt_quad_base/ch1_txoutclk]
  connect_bd_net -net gt_quad_base_ch2_rxoutclk [get_bd_pins bufg_gt_rxck_2/outclk] [get_bd_pins concat_gt_rxclk/In2] [get_bd_pins gt_quad_base/ch2_rxoutclk]
  connect_bd_net -net gt_quad_base_ch2_txoutclk [get_bd_pins bufg_gt_txck_2/outclk] [get_bd_pins concat_gt_txclk/In2] [get_bd_pins gt_quad_base/ch2_txoutclk]
  connect_bd_net -net gt_quad_base_ch3_rxoutclk [get_bd_pins bufg_gt_rxck_3/outclk] [get_bd_pins concat_gt_rxclk/In3] [get_bd_pins gt_quad_base/ch3_rxoutclk]
  connect_bd_net -net gt_quad_base_ch3_txoutclk [get_bd_pins bufg_gt_txck_3/outclk] [get_bd_pins concat_gt_txclk/In3] [get_bd_pins gt_quad_base/ch3_txoutclk]
  connect_bd_net -net gt_quad_base_gtpowergood [get_bd_pins gt_quad_base/gtpowergood] [get_bd_pins mrmac_0/gtpowergood_in] [get_bd_pins rx_rst_gen/dcm_locked] [get_bd_pins tx_rst_gen/dcm_locked]
  connect_bd_net -net mdm_1_Interrupt [get_bd_pins concat_intc/In0] [get_bd_pins mdm_1/Interrupt]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins ddr_rst_gen/mb_debug_sys_rst] [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rx_rst_gen/mb_debug_sys_rst] [get_bd_pins sys_rst_gen/mb_debug_sys_rst] [get_bd_pins tx_rst_gen/mb_debug_sys_rst]
  connect_bd_net -net mem_rst_gen_peripheral_aresetn [get_bd_pins ddr4_pl_0/ddr4_aresetn] [get_bd_pins ddr_rst_gen/peripheral_aresetn]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_combiner_0/aclk] [get_bd_pins clk_wizard_0/clk_out1] [get_bd_pins eth_dma/m_axi_sg_aclk] [get_bd_pins eth_dma/s_axi_lite_aclk] [get_bd_pins ethmac_lite/s_axi_aclk] [get_bd_pins gt_quad_base/s_axi_lite_clk] [get_bd_pins gt_quad_base_1/s_axi_lite_clk] [get_bd_pins mdm_1/S_AXI_ACLK] [get_bd_pins mem_connect/aclk] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins mrmac_0/s_axi_aclk] [get_bd_pins periph_connect/aclk] [get_bd_pins rx_fifo/m_axis_aclk] [get_bd_pins rx_mem_cpu/s_axi_aclk] [get_bd_pins sg_mem_cpu/s_axi_aclk] [get_bd_pins sg_mem_dma/s_axi_aclk] [get_bd_pins sys_rst_gen/slowest_sync_clk] [get_bd_pins tx_fifo/s_axis_aclk] [get_bd_pins tx_mem_cpu/s_axi_aclk]
  connect_bd_net -net resetn_1 [get_bd_ports CPU_RESET_FPGA] [get_bd_pins ddr_rst_gen/ext_reset_in] [get_bd_pins ext_rstn_inv/Op1] [get_bd_pins rx_rst_gen/ext_reset_in] [get_bd_pins sys_rst_gen/ext_reset_in] [get_bd_pins tx_rst_gen/ext_reset_in]
  connect_bd_net -net resetn_inv_0_Res [get_bd_pins clk_wizard_0/reset] [get_bd_pins ddr4_pl_0/sys_rst] [get_bd_pins ext_rstn_inv/Res]
  connect_bd_net -net rst_clk_wiz_1_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins sys_rst_gen/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst] [get_bd_pins sys_rst_gen/mb_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_combiner_0/aresetn] [get_bd_pins eth_dma/axi_resetn] [get_bd_pins ethmac_lite/s_axi_aresetn] [get_bd_pins gt_quad_base/s_axi_lite_resetn] [get_bd_pins gt_quad_base_1/s_axi_lite_resetn] [get_bd_pins mdm_1/S_AXI_ARESETN] [get_bd_pins mem_connect/aresetn] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins mrmac_0/s_axi_aresetn] [get_bd_pins periph_connect/aresetn] [get_bd_pins rx_mem_cpu/s_axi_aresetn] [get_bd_pins sg_mem_cpu/s_axi_aresetn] [get_bd_pins sg_mem_dma/s_axi_aresetn] [get_bd_pins sys_rst_gen/peripheral_aresetn] [get_bd_pins tx_fifo/s_axis_aresetn] [get_bd_pins tx_mem_cpu/s_axi_aresetn]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_reset [get_bd_pins concat_sys_rst/In0] [get_bd_pins concat_sys_rst/In1] [get_bd_pins concat_sys_rst/In2] [get_bd_pins concat_sys_rst/In3] [get_bd_pins gig_eth_phy/pma_reset] [get_bd_pins gig_eth_phy/reset] [get_bd_pins sys_rst_gen/peripheral_reset]
  connect_bd_net -net rx_rst_gen_peripheral_aresetn [get_bd_pins axis_combiner_1/aresetn] [get_bd_pins rx_fifo/s_axis_aresetn] [get_bd_pins rx_rst_gen/peripheral_aresetn]
  connect_bd_net -net tx_rst_gen_peripheral_aresetn [get_bd_pins axis_broadcaster_1/aresetn] [get_bd_pins loopback_fifo/s_axis_aresetn] [get_bd_pins tx_rst_gen/peripheral_aresetn]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins gt_quad_base/GT_REFCLK0] [get_bd_pins util_ds_buf_0/IBUF_OUT]
  connect_bd_net -net util_ds_buf_IBUF_OUT [get_bd_pins gt_quad_base_1/GT_REFCLK0] [get_bd_pins util_ds_buf/IBUF_OUT]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins concat_intc/dout] [get_bd_pins microblaze_0_axi_intc/intr]
  connect_bd_net -net xlconstant_dout [get_bd_pins bufg_gt_rxck/gt_bufgtdiv] [get_bd_pins bufg_gt_rxck_0/gt_bufgtdiv] [get_bd_pins bufg_gt_rxck_1/gt_bufgtdiv] [get_bd_pins bufg_gt_rxck_2/gt_bufgtdiv] [get_bd_pins bufg_gt_rxck_3/gt_bufgtdiv] [get_bd_pins bufg_gt_txck/gt_bufgtdiv] [get_bd_pins bufg_gt_txck_0/gt_bufgtdiv] [get_bd_pins bufg_gt_txck_1/gt_bufgtdiv] [get_bd_pins bufg_gt_txck_2/gt_bufgtdiv] [get_bd_pins bufg_gt_txck_3/gt_bufgtdiv] [get_bd_pins const_3b001/dout]

  # Create address segments
  assign_bd_address -offset 0x02000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces eth_dma/Data_S2MM] [get_bd_addr_segs rx_mem_dma/S_AXI/Mem0] -force
  assign_bd_address -offset 0x03000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces eth_dma/Data_SG] [get_bd_addr_segs sg_mem_dma/S_AXI/Mem0] -force
  assign_bd_address -offset 0x01000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces eth_dma/Data_MM2S] [get_bd_addr_segs tx_mem_dma/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00802000 -range 0x00001000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_timer_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x00807000 -range 0x00001000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x80000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs ddr4_pl_0/DDR4_MEMORY_MAP/DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x80000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs ddr4_pl_0/DDR4_MEMORY_MAP/DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x00000000 -range 0x00400000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x0080A000 -range 0x00001000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs eth_dma/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x00808000 -range 0x00002000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs ethmac_lite/S_AXI/Reg] -force
  assign_bd_address -offset 0x00830000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gt_quad_base_1/AXI_LITE/Reg] -force
  assign_bd_address -offset 0x00820000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gt_quad_base/AXI_LITE/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00400000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00800000 -range 0x00001000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs mdm_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x00801000 -range 0x00001000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_axi_intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x00810000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs mrmac_0/s_axi/Reg] -force
  assign_bd_address -offset 0x02000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs rx_mem_cpu/S_AXI/Mem0] -force
  assign_bd_address -offset 0x03000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs sg_mem_cpu/S_AXI/Mem0] -force
  assign_bd_address -offset 0x01000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs tx_mem_cpu/S_AXI/Mem0] -force


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
