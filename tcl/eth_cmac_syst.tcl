# Copyright 2022 Barcelona Supercomputing Center-Centro Nacional de Supercomputación

# Licensed under the Solderpad Hardware License v 2.1 (the "License");
# you may not use this file except in compliance with the License, or, at your option, the Apache License version 2.0.
# You may obtain a copy of the License at
# 
#     http://www.solderpad.org/licenses/SHL-2.1
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Author: Alexander Kropotov, BSC-CNS
# Date: 22.02.2022
# Description: 


# Proc to create BD Eth_CMAC_syst
proc cr_bd_Eth_CMAC_syst { parentCell } {

  global g_root_dir
  global g_board_part
  global g_eth_port
  global g_dma_mem
  global g_saxi_freq
  global g_saxi_prot
  global g_max_dma_addr_width
  global g_init_clk_freq
  # Connect eth_dma to the saxi clk
  global g_dma_axi_clk
  global g_en_eth_loopback
  # CHANGE DESIGN NAME HERE
  set design_name Eth_CMAC_syst

  if {$g_dma_axi_clk && ($g_dma_mem == "hbm" || $g_dma_mem == "ddr" || $g_dma_mem == "sram")} {
    puts "Invalid ethernet configuration. DMA synchronous to saxi_clk is not compatible with hgm, ddr, or sram memory configuration."
    exit 1
  }

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  # Set the reference directory for source file relative paths (by default 
  # the value is script directory path)
  set origin_dir $g_root_dir/bd

  # Use origin directory path location variable, if specified in the tcl shell
  if { [info exists ::origin_dir_loc] } {
     set origin_dir $::origin_dir_loc
  }

  set str_bd_folder [file normalize ${origin_dir}]
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2030 -severity "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_gid_msg -ssname BD::TCL -id 2031 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_gid_msg -ssname BD::TCL -id 2032 -severity "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2033 -severity "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_gid_msg -ssname BD::TCL -id 2034 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files -quiet */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2035 -severity "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_gid_msg -ssname BD::TCL -id 2036 -severity "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_gid_msg -ssname BD::TCL -id 2037 -severity "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  # NOTE - usage of <-dir> will create <$str_bd_folder/$design_name/$design_name.bd>
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_gid_msg -ssname BD::TCL -id 2038 -severity "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\ 
  xilinx.com:ip:xlconcat:2.1\
  xilinx.com:ip:axi_register_slice:2.1\
  xilinx.com:ip:axi_timer:2.0\
  xilinx.com:ip:xlconstant:1.1\
  xilinx.com:ip:xlslice:1.0\
  xilinx.com:ip:axis_data_fifo:2.0\
  xilinx.com:ip:cmac_usplus:3.1\
  xilinx.com:ip:axi_dma:7.1\
  xilinx.com:ip:blk_mem_gen:8.4\
  xilinx.com:ip:util_vector_logic:2.0\
  xilinx.com:ip:axi_gpio:2.0\
  xilinx.com:ip:util_reduced_logic:2.0\
  xilinx.com:ip:axis_switch:1.1\
  xilinx.com:ip:axi_bram_ctrl:4.1\
  xilinx.com:ip:proc_sys_reset:5.0\
  xilinx.com:ip:smartconnect:1.0\
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
if { $g_dma_mem == "hbm" ||
     $g_dma_mem == "ddr" } {
  set m_axi_sg [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_sg ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH $g_max_dma_addr_width \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.NUM_READ_OUTSTANDING {256} \
   CONFIG.NUM_WRITE_OUTSTANDING {256} \
   CONFIG.PROTOCOL {AXI3} \
   ] $m_axi_sg

  set m_axi_rx [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_rx ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH $g_max_dma_addr_width \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {0} \
   CONFIG.NUM_READ_OUTSTANDING {256} \
   CONFIG.NUM_WRITE_OUTSTANDING {256} \
   CONFIG.PROTOCOL {AXI3} \
   CONFIG.READ_WRITE_MODE {WRITE_ONLY} \
   ] $m_axi_rx

  set m_axi_tx [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_tx ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH $g_max_dma_addr_width \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.HAS_BRESP {0} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_WSTRB {0} \
   CONFIG.NUM_READ_OUTSTANDING {256} \
   CONFIG.NUM_WRITE_OUTSTANDING {256} \
   CONFIG.PROTOCOL {AXI3} \
   CONFIG.READ_WRITE_MODE {READ_ONLY} \
   ] $m_axi_tx

  if { ${g_dma_mem} eq "ddr" } {
    set_property -dict [ list \
      CONFIG.DATA_WIDTH  {32} \
      CONFIG.NUM_READ_OUTSTANDING {32} \
      CONFIG.NUM_WRITE_OUTSTANDING {32} \
      CONFIG.PROTOCOL {AXI4} \
    ] [get_bd_intf_ports m_axi_sg]
    
    set_property -dict [ list \
      CONFIG.DATA_WIDTH  {512} \
      CONFIG.NUM_READ_OUTSTANDING {32} \
      CONFIG.NUM_WRITE_OUTSTANDING {32} \
      CONFIG.PROTOCOL {AXI4} \
    ] [get_bd_intf_ports m_axi_rx]
    
    set_property -dict [ list \
      CONFIG.DATA_WIDTH  {512} \
      CONFIG.NUM_READ_OUTSTANDING {32} \
      CONFIG.NUM_WRITE_OUTSTANDING {32} \
      CONFIG.PROTOCOL {AXI4} \
    ] [get_bd_intf_ports m_axi_tx]
  }

} elseif { $g_dma_mem != "sram" } {
  # extracting AXI parameters if a single AXI port is requested
  set AXIProt  [string replace $g_dma_mem   [string first "-" $g_dma_mem] end]
  set AXIWidth [string replace $g_dma_mem 0 [string first "-" $g_dma_mem]    ]
  set m_axi_dma [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_dma ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH $g_max_dma_addr_width \
   CONFIG.DATA_WIDTH $AXIWidth \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.NUM_READ_OUTSTANDING {256} \
   CONFIG.NUM_WRITE_OUTSTANDING {256} \
   CONFIG.PROTOCOL $AXIProt \
   ] $m_axi_dma
}

  set qsfp_4x [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 qsfp_4x ]

  set AXIProt  [string replace $g_saxi_prot   [string first "-" $g_saxi_prot] end]
  set AXIWidth [string replace $g_saxi_prot 0 [string first "-" $g_saxi_prot]    ]
  set s_axi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {22} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH $AXIWidth \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {256} \
   CONFIG.NUM_READ_THREADS {16} \
   CONFIG.NUM_WRITE_OUTSTANDING {256} \
   CONFIG.NUM_WRITE_THREADS {16} \
   CONFIG.PROTOCOL $AXIProt \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $s_axi


  # Create ports
  set intc [ create_bd_port -dir O -from 1 -to 0 intc ]

if { $g_dma_mem == "hbm" ||
     $g_dma_mem == "ddr" } {
  set rx_clk [ create_bd_port -dir O -type clk rx_clk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {m_axi_rx} \
   CONFIG.ASSOCIATED_RESET {rx_rstn} \
 ] $rx_clk
  set rx_rstn [ create_bd_port -dir O -from 0 -to 0 -type rst rx_rstn ]
  set tx_clk [ create_bd_port -dir O -type clk tx_clk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {m_axi_tx} \
   CONFIG.ASSOCIATED_RESET {tx_rstn} \
 ] $tx_clk
  set tx_rstn [ create_bd_port -dir O -from 0 -to 0 -type rst tx_rstn ]
}

if {[string is digit -strict $g_saxi_freq]} {
  set s_axi_clk [ create_bd_port -dir I -type clk -freq_hz $g_saxi_freq s_axi_clk ]
} else {
  set s_axi_clk [ create_bd_port -dir I -type clk s_axi_clk ]
}
if {[string is digit -strict $g_init_clk_freq]} {
  set init_clk  [ create_bd_port -dir I -type clk -freq_hz $g_init_clk_freq init_clk  ]
} else {
  set init_clk  [ create_bd_port -dir I -type clk init_clk  ]
}
  set s_axi_resetn [ create_bd_port -dir I -type rst s_axi_resetn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $s_axi_resetn

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

if { $g_dma_mem == "hbm" ||
     $g_dma_mem == "ddr" } {
  # AXI register slices, by default assuming Multi-SLR crossing (mode 15) for connection of DMA to SDRAM
  # Create instance: axi_reg_slice_rx, and set properties
  set axi_reg_slice_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_reg_slice_rx ]
  set_property -dict [ list \
   CONFIG.REG_AR {15} \
   CONFIG.REG_AW {15} \
   CONFIG.REG_B {15} \
   CONFIG.REG_R {15} \
   CONFIG.REG_W {15} \
   CONFIG.USE_AUTOPIPELINING {1} \
 ] $axi_reg_slice_rx

  # Create instance: axi_reg_slice_tx, and set properties
  set axi_reg_slice_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_reg_slice_tx ]
  set_property -dict [ list \
   CONFIG.REG_AR {15} \
   CONFIG.REG_AW {15} \
   CONFIG.REG_B {15} \
   CONFIG.REG_R {15} \
   CONFIG.REG_W {15} \
   CONFIG.USE_AUTOPIPELINING {1} \
 ] $axi_reg_slice_tx

  # In case of U55C/U250 we have single border SLR crossing (NUM_SLR_CROSSINGS = 1), default mode 15 with Autopipelining causes errors in Vivado-2024.1
  if { $g_board_part == "u55c" ||
       $g_board_part == "u250" } {
    set_property -dict [ list \
      CONFIG.NUM_SLR_CROSSINGS {1} \
      CONFIG.USE_AUTOPIPELINING {0} \
    ] $axi_reg_slice_rx

    set_property -dict [ list \
      CONFIG.NUM_SLR_CROSSINGS {1} \
      CONFIG.USE_AUTOPIPELINING {0} \
    ] $axi_reg_slice_tx
  }
}

  # Create instance: axi_timer_0, and set properties
  set axi_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0 ]
  set_property -dict [ list \
   CONFIG.enable_timer2 {1} \
 ] $axi_timer_0

  # Create instance: concat_intc, and set properties
  set concat_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 concat_intc ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {2} \
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

if { ${g_dma_mem} eq "hbm" } {
  # Create instance: dma_connect_sg, and set properties
  set dma_connect_sg [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 dma_connect_sg ]
  set_property -dict [ list \
   CONFIG.NUM_SI {1} \
  ] $dma_connect_sg

  # Create instance: dma_connect_rx, and set properties
  set dma_connect_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 dma_connect_rx ]
  set_property -dict [ list \
   CONFIG.NUM_SI {1} \
  ] $dma_connect_rx

  # Create instance: dma_connect_tx, and set properties
  set dma_connect_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 dma_connect_tx ]
  set_property -dict [ list \
   CONFIG.NUM_SI {1} \
  ] $dma_connect_tx

} elseif { $g_dma_mem != "ddr" &&
           $g_dma_mem != "sram" } {
  # Create instance of AXI interconnect to combine 3 DMA masters if a single AXI port is requested
  set dma_intconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 dma_intconnect ]
  if {$g_dma_axi_clk} {
    set_property -dict [ list \
     CONFIG.NUM_SI   {3} \
     CONFIG.NUM_CLKS {1} \
    ] $dma_intconnect
  } else {
    set_property -dict [ list \
     CONFIG.NUM_SI   {3} \
     CONFIG.NUM_CLKS {3} \
    ] $dma_intconnect
  }
}

  # Create instance: dma_loopback_fifo, and set properties
  set dma_loopback_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 dma_loopback_fifo ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $dma_loopback_fifo

set eth100gb_init_clk_freq 100
if { [string is digit -strict $g_saxi_freq] && ![string is digit -strict $g_init_clk_freq] && ($g_saxi_freq < 50000000 || $g_saxi_freq > 250000000) } {
  #Create instance: clk_wiz_cmac, and set properties
  set clk_wiz_cmac [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_cmac ]
  #By default we have 100 MHz as output
  set_property -dict [ list \
   CONFIG.OPTIMIZE_CLOCKING_STRUCTURE_EN {true} \
   CONFIG.PRIMITIVE {Auto} \
 ] $clk_wiz_cmac
} elseif { [string is digit -strict $g_init_clk_freq] } {
  set eth100gb_init_clk_freq [expr $g_init_clk_freq/1000000]
} elseif { [string is digit -strict $g_saxi_freq] } {
  set eth100gb_init_clk_freq [expr $g_saxi_freq/1000000]
}

  # Create instance: eth100gb, and set properties
  if { ${g_board_part} eq "u280" } {
    set g_eth100gb_freq "156.25"
    if { ${g_eth_port} eq "qsfp0" } {
      set g_cmac_loc      "CMACE4_X0Y6"
      set g_gt_grp_loc    "X0Y40~X0Y43"
      set g_lane1_loc     "X0Y40"
      set g_lane2_loc     "X0Y41"
      set g_lane3_loc     "X0Y42"
      set g_lane4_loc     "X0Y43"
    }
    if { ${g_eth_port} eq "qsfp1" } {
      # set g_cmac_loc      "CMACE4_X0Y7"
      # using non defualt for QSFP1 CMAC provides better timing
      set g_cmac_loc      "CMACE4_X0Y6"
      set g_gt_grp_loc    "X0Y44~X0Y47"
      set g_lane1_loc     "X0Y44"
      set g_lane2_loc     "X0Y45"
      set g_lane3_loc     "X0Y46"
      set g_lane4_loc     "X0Y47"
    }
  }
  if { ${g_board_part} eq "u250" } {
    set g_eth100gb_freq "156.25"
    if { ${g_eth_port} eq "qsfp0" } {
      # set g_cmac_loc      "CMACE4_X0Y7"
      set g_cmac_loc      "CMACE4_X0Y8"
      set g_gt_grp_loc    "X1Y44~X1Y47"
      set g_lane1_loc     "X1Y44"
      set g_lane2_loc     "X1Y45"
      set g_lane3_loc     "X1Y46"
      set g_lane4_loc     "X1Y47"
    }
    if { ${g_eth_port} eq "qsfp1" } {
      # set g_cmac_loc      "CMACE4_X0Y6"
      set g_cmac_loc      "CMACE4_X0Y7"
      set g_gt_grp_loc    "X1Y40~X1Y43"
      set g_lane1_loc     "X1Y40"
      set g_lane2_loc     "X1Y41"
      set g_lane3_loc     "X1Y42"
      set g_lane4_loc     "X1Y43"
    }
  }
  if { ${g_board_part} eq "u55c" } {
    set g_eth100gb_freq "161.1328125"
    if { ${g_eth_port} eq "qsfp0" } {
      set g_cmac_loc      "CMACE4_X0Y3"
      set g_gt_grp_loc    "X0Y24~X0Y27"
      set g_lane1_loc     "X0Y24"
      set g_lane2_loc     "X0Y25"
      set g_lane3_loc     "X0Y26"
      set g_lane4_loc     "X0Y27"
    }
    if { ${g_eth_port} eq "qsfp1" } {
      set g_cmac_loc      "CMACE4_X0Y4"
      set g_gt_grp_loc    "X0Y28~X0Y31"
      set g_lane1_loc     "X0Y28"
      set g_lane2_loc     "X0Y29"
      set g_lane3_loc     "X0Y30"
      set g_lane4_loc     "X0Y31"
    }
  }
  set eth100gb [ create_bd_cell -type ip -vlnv xilinx.com:ip:cmac_usplus:3.1 eth100gb ]
  set_property -dict [ list \
   CONFIG.ADD_GT_CNRL_STS_PORTS {0} \
   CONFIG.CMAC_CAUI4_MODE {1} \
   CONFIG.CMAC_CORE_SELECT $g_cmac_loc \
   CONFIG.DIFFCLK_BOARD_INTERFACE {Custom} \
   CONFIG.ENABLE_AXI_INTERFACE {1} \
   CONFIG.ENABLE_PIPELINE_REG {0} \
   CONFIG.ENABLE_TIME_STAMPING {0} \
   CONFIG.ETHERNET_BOARD_INTERFACE {Custom} \
   CONFIG.GT_GROUP_SELECT $g_gt_grp_loc \
   CONFIG.GT_REF_CLK_FREQ $g_eth100gb_freq \
   CONFIG.GT_RX_BUFFER_BYPASS {0} \
   CONFIG.INCLUDE_AUTO_NEG_LT_LOGIC {0} \
   CONFIG.INCLUDE_RS_FEC {1} \
   CONFIG.INCLUDE_STATISTICS_COUNTERS {1} \
   CONFIG.LANE10_GT_LOC {NA} \
   CONFIG.LANE1_GT_LOC $g_lane1_loc \
   CONFIG.LANE2_GT_LOC $g_lane2_loc \
   CONFIG.LANE3_GT_LOC $g_lane3_loc \
   CONFIG.LANE4_GT_LOC $g_lane4_loc \
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
   CONFIG.GT_DRP_CLK $eth100gb_init_clk_freq \
 ] $eth100gb
  set_property USER_COMMENTS.comment_3 "https://www.xilinx.com/support/documentation/ip_documentation/l_ethernet/v3_1/pg211-50g-ethernet.pdf#page=26" [get_bd_intf_pins /eth100gb/axis_rx]
  set_property USER_COMMENTS.comment_2 "https://www.xilinx.com/support/documentation/ip_documentation/l_ethernet/v3_1/pg211-50g-ethernet.pdf#page=23" [get_bd_intf_pins /eth100gb/axis_tx]
  set_property USER_COMMENTS.comment_1 "http://www.xilinx.com/support/documentation/ip_documentation/cmac_usplus/v3_1/pg203-cmac-usplus.pdf#page=117
http://www.xilinx.com/support/documentation/user_guides/ug578-ultrascale-gty-transceivers.pdf#page=88" [get_bd_pins /eth100gb/gt_loopback_in]
  set_property USER_COMMENTS.comment_4 "https://www.xilinx.com/support/documentation/user_guides/ug578-ultrascale-gty-transceivers.pdf#page=88" [get_bd_pins /eth100gb/gt_loopback_in]

  set g_refport_freq [format {%0.0f} [expr {$g_eth100gb_freq*1000000}] ]
  puts "PORT FREQUENCY: $g_refport_freq"
  set qsfp_refck [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 qsfp_refck ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ $g_refport_freq \
   ] $qsfp_refck

  # Create instance: eth_dma, and set properties
  set eth_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 eth_dma ]
  set_property -dict [ list \
   CONFIG.c_addr_width $g_max_dma_addr_width \
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

  if {$g_dma_axi_clk} {
    set rx_clk_conv [create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter: rx_clk_conv]
    set tx_clk_conv [create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter: tx_clk_conv]
    set dma_mm2s_reset [create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset: dma_mm2s_reset]
    set dma_s2mm_reset [create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset: dma_s2mm_reset]
  }

  # Create instance: tx_axis_switch, and set properties
  set tx_axis_switch [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 tx_axis_switch ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_S00_CONNECTIVITY {1} \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {2} \
   CONFIG.ROUTING_MODE {1} \
 ] $tx_axis_switch

  # Create instance: rx_axis_switch, and set properties
  set rx_axis_switch [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 rx_axis_switch ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {2} \
   CONFIG.ROUTING_MODE {1} \
 ] $rx_axis_switch

if {[info exists g_en_eth_loopback] &&
                $g_en_eth_loopback != "0"} {
  # Create instance: eth_loopback_fifo, and set properties
  set eth_loopback_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 eth_loopback_fifo ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.IS_ACLK_ASYNC {1} \
 ] $eth_loopback_fifo

  connect_bd_intf_net [get_bd_intf_pins eth_loopback_fifo/M_AXIS] [get_bd_intf_pins tx_axis_switch/S00_AXIS]
  connect_bd_intf_net [get_bd_intf_pins eth_loopback_fifo/S_AXIS] [get_bd_intf_pins rx_axis_switch/M00_AXIS]

  connect_bd_net [get_bd_pins eth100gb/gt_rxusrclk2] [get_bd_pins eth_loopback_fifo/s_axis_aclk]
  connect_bd_net [get_bd_pins eth100gb/gt_txusrclk2] [get_bd_pins eth_loopback_fifo/m_axis_aclk]
  connect_bd_net [get_bd_pins eth_dma/s2mm_prmry_reset_out_n] [get_bd_pins eth_loopback_fifo/s_axis_aresetn]
}

if { ${g_dma_mem} eq "sram" } {
  # Create instance: eth_rx_mem, and set properties
  set eth_rx_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 eth_rx_mem ]
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
 ] $eth_rx_mem

  # Create instance: eth_sg_mem, and set properties
  set eth_sg_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 eth_sg_mem ]
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
 ] $eth_sg_mem

  # Create instance: eth_tx_mem, and set properties
  set eth_tx_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 eth_tx_mem ]
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
 ] $eth_tx_mem
}

  # Create instance: ext_rstn_inv, and set properties
  set ext_rstn_inv [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 ext_rstn_inv ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
 ] $ext_rstn_inv

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

if { ${g_dma_mem} eq "sram" } {
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
}

if { ${g_dma_mem} ne "sram" } {
  # Create instance: rx_fifo, and set depth enough to withstand data accumulation for low-speed cache-coherent connection
  set rx_fifo [ create_bd_cell -type ip -vlnv bsc:eth:eth_rx_fifo_wrapper:1.0 rx_fifo ]
  set_property -dict [ list \
   CONFIG.FRAME_QUEUE_LEN {4096} \
 ] $rx_fifo

  # Create instance: tx_fifo, and set properties
  set tx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 tx_fifo ]
  set_property USER_COMMENTS.comment_5 "FIFO depth is set to 256 to fit CMAC max packet 150 x 64bytes = 9600 bytes.
But functionality is fine for at least depth 128 (in non-packet mode)." [get_bd_cells /tx_fifo]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {256} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.IS_ACLK_ASYNC {0} \
 ] $tx_fifo
}

  # Create instance: periph_connect, and set properties
  set periph_connect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 periph_connect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {10} \
   CONFIG.NUM_SI {1} \
 ] $periph_connect
if { ${g_dma_mem} ne "sram" } {
  set_property -dict [list CONFIG.NUM_MI {7}] [get_bd_cells periph_connect]
}

  # Create instance: rx_rst_gen, and set properties
  set rx_rst_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rx_rst_gen ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $rx_rst_gen

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
  connect_bd_intf_net [get_bd_intf_ports qsfp_4x] [get_bd_intf_pins eth100gb/gt_serial_port]
  connect_bd_intf_net [get_bd_intf_pins dma_loopback_fifo/M_AXIS] [get_bd_intf_pins rx_axis_switch/S00_AXIS]
  connect_bd_intf_net [get_bd_intf_ports qsfp_refck] [get_bd_intf_pins eth100gb/gt_ref_clk]
  connect_bd_intf_net [get_bd_intf_pins eth100gb/s_axi] [get_bd_intf_pins periph_connect/M00_AXI]
  connect_bd_intf_net [get_bd_intf_pins eth_dma/S_AXI_LITE] [get_bd_intf_pins periph_connect/M01_AXI]
  connect_bd_intf_net [get_bd_intf_pins periph_connect/M02_AXI] [get_bd_intf_pins tx_rx_ctl_stat/S_AXI]
  connect_bd_intf_net [get_bd_intf_pins periph_connect/M03_AXI] [get_bd_intf_pins tx_axis_switch/S_AXI_CTRL]
  connect_bd_intf_net [get_bd_intf_pins periph_connect/M04_AXI] [get_bd_intf_pins rx_axis_switch/S_AXI_CTRL]
  connect_bd_intf_net [get_bd_intf_pins gt_ctl/S_AXI] [get_bd_intf_pins periph_connect/M05_AXI]
  connect_bd_intf_net [get_bd_intf_pins axi_timer_0/S_AXI] [get_bd_intf_pins periph_connect/M06_AXI]
  connect_bd_intf_net [get_bd_intf_pins dma_loopback_fifo/S_AXIS] [get_bd_intf_pins tx_axis_switch/M00_AXIS]
if { $g_dma_axi_clk } {
  connect_bd_intf_net [get_bd_intf_pins rx_axis_switch/M01_AXIS] [get_bd_intf_pins rx_clk_conv/S_AXIS]
  connect_bd_intf_net [get_bd_intf_pins rx_clk_conv/M_AXIS] [get_bd_intf_pins eth_dma/S_AXIS_S2MM]
  connect_bd_intf_net [get_bd_intf_pins tx_clk_conv/M_AXIS] [get_bd_intf_pins tx_axis_switch/S01_AXIS]
  connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXIS_MM2S] [get_bd_intf_pins tx_clk_conv/S_AXIS]
} else {
  connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXIS_MM2S] [get_bd_intf_pins tx_axis_switch/S01_AXIS]
  connect_bd_intf_net [get_bd_intf_pins eth_dma/S_AXIS_S2MM] [get_bd_intf_pins rx_axis_switch/M01_AXIS]
}
if { ${g_dma_mem} eq "sram" } {
  connect_bd_intf_net [get_bd_intf_pins eth_tx_mem/BRAM_PORTA] [get_bd_intf_pins tx_mem_cpu/BRAM_PORTA]
  connect_bd_intf_net [get_bd_intf_pins eth100gb/axis_rx] [get_bd_intf_pins rx_axis_switch/S01_AXIS]
  connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXI_MM2S] [get_bd_intf_pins tx_mem_dma/S_AXI]
  connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXI_S2MM] [get_bd_intf_pins rx_mem_dma/S_AXI]
  connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXI_SG] [get_bd_intf_pins sg_mem_dma/S_AXI]
  connect_bd_intf_net [get_bd_intf_pins eth_rx_mem/BRAM_PORTA] [get_bd_intf_pins rx_mem_cpu/BRAM_PORTA]
  connect_bd_intf_net [get_bd_intf_pins eth_rx_mem/BRAM_PORTB] [get_bd_intf_pins rx_mem_dma/BRAM_PORTA]
  connect_bd_intf_net [get_bd_intf_ports s_axi] [get_bd_intf_pins periph_connect/S00_AXI]
  connect_bd_intf_net [get_bd_intf_pins eth_sg_mem/BRAM_PORTA] [get_bd_intf_pins sg_mem_cpu/BRAM_PORTA]
  connect_bd_intf_net [get_bd_intf_pins eth_sg_mem/BRAM_PORTB] [get_bd_intf_pins sg_mem_dma/BRAM_PORTA]
  connect_bd_intf_net [get_bd_intf_pins periph_connect/M07_AXI] [get_bd_intf_pins sg_mem_cpu/S_AXI]
  connect_bd_intf_net [get_bd_intf_pins periph_connect/M08_AXI] [get_bd_intf_pins tx_mem_cpu/S_AXI]
  connect_bd_intf_net [get_bd_intf_pins periph_connect/M09_AXI] [get_bd_intf_pins rx_mem_cpu/S_AXI]
  connect_bd_intf_net [get_bd_intf_pins eth_tx_mem/BRAM_PORTB] [get_bd_intf_pins tx_mem_dma/BRAM_PORTA]
  connect_bd_intf_net [get_bd_intf_pins eth100gb/axis_tx] [get_bd_intf_pins tx_axis_switch/M01_AXIS]
} else {
  connect_bd_intf_net [get_bd_intf_pins eth100gb/axis_rx] [get_bd_intf_pins rx_fifo/rx]
  connect_bd_intf_net [get_bd_intf_pins rx_axis_switch/S01_AXIS] [get_bd_intf_pins rx_fifo/so]
  connect_bd_intf_net [get_bd_intf_ports s_axi] [get_bd_intf_pins periph_connect/S00_AXI]
  connect_bd_intf_net [get_bd_intf_pins tx_axis_switch/M01_AXIS] [get_bd_intf_pins tx_fifo/S_AXIS]
  connect_bd_intf_net [get_bd_intf_pins eth100gb/axis_tx] [get_bd_intf_pins tx_fifo/M_AXIS]
  if { $g_dma_mem == "hbm" } {
  connect_bd_intf_net [get_bd_intf_pins axi_reg_slice_rx/M_AXI] [get_bd_intf_ports m_axi_rx]
  connect_bd_intf_net [get_bd_intf_pins axi_reg_slice_tx/M_AXI] [get_bd_intf_ports m_axi_tx]
  connect_bd_intf_net [get_bd_intf_pins dma_connect_sg/M00_AXI] [get_bd_intf_ports m_axi_sg]
  connect_bd_intf_net [get_bd_intf_pins dma_connect_sg/S00_AXI] [get_bd_intf_pins eth_dma/M_AXI_SG]
  connect_bd_intf_net [get_bd_intf_pins dma_connect_rx/M00_AXI] [get_bd_intf_pins axi_reg_slice_rx/S_AXI] 
  connect_bd_intf_net [get_bd_intf_pins dma_connect_rx/S00_AXI] [get_bd_intf_pins eth_dma/M_AXI_S2MM]
  connect_bd_intf_net [get_bd_intf_pins dma_connect_tx/M00_AXI] [get_bd_intf_pins axi_reg_slice_tx/S_AXI] 
  connect_bd_intf_net [get_bd_intf_pins dma_connect_tx/S00_AXI] [get_bd_intf_pins eth_dma/M_AXI_MM2S]
  } elseif { $g_dma_mem == "ddr" } {
  connect_bd_intf_net [get_bd_intf_pins axi_reg_slice_rx/M_AXI] [get_bd_intf_ports m_axi_rx]
  connect_bd_intf_net [get_bd_intf_pins axi_reg_slice_tx/M_AXI] [get_bd_intf_ports m_axi_tx]
  connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXI_SG]       [get_bd_intf_ports m_axi_sg]
  connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXI_S2MM]     [get_bd_intf_pins axi_reg_slice_rx/S_AXI] 
  connect_bd_intf_net [get_bd_intf_pins eth_dma/M_AXI_MM2S]     [get_bd_intf_pins axi_reg_slice_tx/S_AXI]
  } else {
  connect_bd_intf_net [get_bd_intf_pins dma_intconnect/M00_AXI] [get_bd_intf_ports m_axi_dma]
  connect_bd_intf_net [get_bd_intf_pins dma_intconnect/S00_AXI] [get_bd_intf_pins eth_dma/M_AXI_SG]
  connect_bd_intf_net [get_bd_intf_pins dma_intconnect/S01_AXI] [get_bd_intf_pins eth_dma/M_AXI_S2MM]
  connect_bd_intf_net [get_bd_intf_pins dma_intconnect/S02_AXI] [get_bd_intf_pins eth_dma/M_AXI_MM2S]
  }
}

  # Create port connections
  connect_bd_net [get_bd_pins GT_STATUS/dout] [get_bd_pins gt_ctl/gpio_io_i]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/dout] [get_bd_pins tx_rx_ctl_stat/gpio2_io_i]
  connect_bd_net [get_bd_pins eth100gb/gt_loopback_in] [get_bd_pins gt_loopback/dout]
  connect_bd_net [get_bd_pins ctl_rx_enable/Din] [get_bd_pins ctl_rx_force_resync/Din] [get_bd_pins ctl_rx_test_pattern/Din] [get_bd_pins tx_rx_ctl_stat/gpio2_io_o]
  connect_bd_net [get_bd_pins ctl_tx_enable/Din] [get_bd_pins ctl_tx_send_idle/Din] [get_bd_pins ctl_tx_send_lfi/Din] [get_bd_pins ctl_tx_send_rfi/Din] [get_bd_pins ctl_tx_test_pattern/Din] [get_bd_pins tx_rx_ctl_stat/gpio_io_o]
  connect_bd_net [get_bd_pins GT_STATUS/In0] [get_bd_pins eth100gb/gt_powergoodout] [get_bd_pins gts_pwr_ok/Op1]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In1] [get_bd_pins eth100gb/stat_rx_aligned]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In3] [get_bd_pins eth100gb/stat_rx_aligned_err]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In10] [get_bd_pins eth100gb/stat_rx_bad_preamble]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In11] [get_bd_pins eth100gb/stat_rx_bad_sfd]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In12] [get_bd_pins eth100gb/stat_rx_got_signal_os]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In4] [get_bd_pins eth100gb/stat_rx_hi_ber]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In7] [get_bd_pins eth100gb/stat_rx_internal_local_fault]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In6] [get_bd_pins eth100gb/stat_rx_local_fault]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In2] [get_bd_pins eth100gb/stat_rx_misaligned]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In8] [get_bd_pins eth100gb/stat_rx_received_local_fault]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In5] [get_bd_pins eth100gb/stat_rx_remote_fault]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In0] [get_bd_pins eth100gb/stat_rx_status]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In9] [get_bd_pins eth100gb/stat_rx_test_pattern_mismatch]
  connect_bd_net [get_bd_pins STAT_TX_STATUS_REG/In0] [get_bd_pins eth100gb/stat_tx_local_fault]
  connect_bd_net [get_bd_ports intc] [get_bd_pins concat_intc/dout]
  connect_bd_net [get_bd_pins axi_timer_0/capturetrig0] [get_bd_pins axi_timer_0/capturetrig1] [get_bd_pins axi_timer_0/freeze] [get_bd_pins const_gnd/dout] [get_bd_pins eth100gb/drp_en] [get_bd_pins eth100gb/drp_we] [get_bd_pins eth100gb/pm_tick] [get_bd_pins eth100gb/tx_axis_tuser]
  connect_bd_net [get_bd_pins STAT_RX_STATUS_REG/In13] [get_bd_pins const_gndx17/dout]
  connect_bd_net [get_bd_pins STAT_TX_STATUS_REG/In1] [get_bd_pins const_gndx31/dout]
  connect_bd_net [get_bd_pins GT_STATUS/In1] [get_bd_pins const_gndx28/dout]
  connect_bd_net [get_bd_pins const_gndx56/dout] [get_bd_pins eth100gb/tx_preamblein]
  connect_bd_net [get_bd_pins ctl_tx_send_idle/Dout] [get_bd_pins eth100gb/ctl_tx_send_idle]
  connect_bd_net [get_bd_pins ctl_tx_send_lfi/Dout] [get_bd_pins eth100gb/ctl_tx_send_lfi]
  connect_bd_net [get_bd_pins ctl_tx_send_rfi/Dout] [get_bd_pins eth100gb/ctl_tx_send_rfi]
  connect_bd_net [get_bd_pins concat_intc/In0] [get_bd_pins eth_dma/mm2s_introut]
  connect_bd_net [get_bd_pins concat_intc/In1] [get_bd_pins eth_dma/s2mm_introut]
  connect_bd_net [get_bd_pins gt_ctl/gpio_io_o] [get_bd_pins gt_loopback0/Din] [get_bd_pins gt_loopback1/Din] [get_bd_pins gt_loopback2/Din] [get_bd_pins gt_loopback3/Din]
  connect_bd_net [get_bd_pins gt_loopback/In0] [get_bd_pins gt_loopback0/Dout]
  connect_bd_net [get_bd_pins gt_loopback/In1] [get_bd_pins gt_loopback1/Dout]
  connect_bd_net [get_bd_pins gt_loopback/In2] [get_bd_pins gt_loopback2/Dout]
  connect_bd_net [get_bd_pins gt_loopback/In3] [get_bd_pins gt_loopback3/Dout]
  connect_bd_net [get_bd_pins STAT_TX_STATUS_REG/dout] [get_bd_pins tx_rx_ctl_stat/gpio_io_i]
  connect_bd_net [get_bd_pins gts_pwr_ok/Res] [get_bd_pins rx_rst_gen/dcm_locked] [get_bd_pins tx_rst_gen/dcm_locked]
  connect_bd_net [get_bd_pins eth100gb/core_drp_reset] [get_bd_pins eth100gb/core_rx_reset] [get_bd_pins eth100gb/core_tx_reset] [get_bd_pins eth100gb/gtwiz_reset_rx_datapath] [get_bd_pins eth100gb/gtwiz_reset_tx_datapath] [get_bd_pins eth100gb/s_axi_sreset] [get_bd_pins eth100gb/sys_reset] [get_bd_pins ext_rstn_inv/Res] [get_bd_pins rx_rst_gen/mb_debug_sys_rst] [get_bd_pins tx_rst_gen/mb_debug_sys_rst]
if { ${g_dma_mem} eq "sram" } {
  connect_bd_net [get_bd_ports s_axi_clk] [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins eth100gb/s_axi_aclk] [get_bd_pins eth_dma/m_axi_sg_aclk] [get_bd_pins eth_dma/s_axi_lite_aclk] [get_bd_pins gt_ctl/s_axi_aclk] [get_bd_pins periph_connect/aclk] [get_bd_pins rx_axis_switch/s_axi_ctrl_aclk] [get_bd_pins rx_mem_cpu/s_axi_aclk] [get_bd_pins sg_mem_cpu/s_axi_aclk] [get_bd_pins sg_mem_dma/s_axi_aclk] [get_bd_pins tx_axis_switch/s_axi_ctrl_aclk] [get_bd_pins tx_mem_cpu/s_axi_aclk] [get_bd_pins tx_rx_ctl_stat/s_axi_aclk]
  connect_bd_net [get_bd_pins dma_loopback_fifo/m_axis_aclk] [get_bd_pins eth100gb/gt_rxusrclk2] [get_bd_pins eth100gb/rx_clk] [get_bd_pins eth_dma/m_axi_s2mm_aclk] [get_bd_pins rx_axis_switch/aclk] [get_bd_pins rx_mem_dma/s_axi_aclk] [get_bd_pins rx_rst_gen/slowest_sync_clk]
  connect_bd_net [get_bd_pins dma_loopback_fifo/s_axis_aclk] [get_bd_pins eth100gb/gt_txusrclk2] [get_bd_pins eth_dma/m_axi_mm2s_aclk] [get_bd_pins tx_axis_switch/aclk] [get_bd_pins tx_mem_dma/s_axi_aclk] [get_bd_pins tx_rst_gen/slowest_sync_clk]
  connect_bd_net [get_bd_pins dma_loopback_fifo/s_axis_aresetn] [get_bd_pins eth_dma/mm2s_prmry_reset_out_n] [get_bd_pins tx_axis_switch/aresetn] [get_bd_pins tx_mem_dma/s_axi_aresetn]
  connect_bd_net [get_bd_pins eth_dma/s2mm_prmry_reset_out_n] [get_bd_pins rx_axis_switch/aresetn] [get_bd_pins rx_mem_dma/s_axi_aresetn]
  connect_bd_net [get_bd_ports s_axi_resetn] [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins eth_dma/axi_resetn] [get_bd_pins ext_rstn_inv/Op1] [get_bd_pins gt_ctl/s_axi_aresetn] [get_bd_pins periph_connect/aresetn] [get_bd_pins rx_axis_switch/s_axi_ctrl_aresetn] [get_bd_pins rx_mem_cpu/s_axi_aresetn] [get_bd_pins rx_rst_gen/aux_reset_in] [get_bd_pins rx_rst_gen/ext_reset_in] [get_bd_pins sg_mem_cpu/s_axi_aresetn] [get_bd_pins sg_mem_dma/s_axi_aresetn] [get_bd_pins tx_axis_switch/s_axi_ctrl_aresetn] [get_bd_pins tx_mem_cpu/s_axi_aresetn] [get_bd_pins tx_rst_gen/aux_reset_in] [get_bd_pins tx_rst_gen/ext_reset_in] [get_bd_pins tx_rx_ctl_stat/s_axi_aresetn]
} else {
  connect_bd_net [get_bd_ports s_axi_clk] [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins eth100gb/s_axi_aclk] [get_bd_pins eth_dma/m_axi_sg_aclk] [get_bd_pins eth_dma/s_axi_lite_aclk] [get_bd_pins gt_ctl/s_axi_aclk] [get_bd_pins periph_connect/aclk] [get_bd_pins rx_axis_switch/s_axi_ctrl_aclk] [get_bd_pins tx_axis_switch/s_axi_ctrl_aclk] [get_bd_pins tx_rx_ctl_stat/s_axi_aclk]
  connect_bd_net [get_bd_pins dma_loopback_fifo/m_axis_aclk] [get_bd_pins eth100gb/gt_rxusrclk2] [get_bd_pins eth100gb/rx_clk] [get_bd_pins eth_loopback_fifo/s_axis_aclk] [get_bd_pins rx_axis_switch/aclk] [get_bd_pins rx_fifo/clk] [get_bd_pins rx_rst_gen/slowest_sync_clk]
  connect_bd_net [get_bd_pins dma_loopback_fifo/s_axis_aclk] [get_bd_pins eth100gb/gt_txusrclk2] [get_bd_pins eth_loopback_fifo/m_axis_aclk] [get_bd_pins tx_axis_switch/aclk] [get_bd_pins tx_fifo/s_axis_aclk] [get_bd_pins tx_rst_gen/slowest_sync_clk]
  connect_bd_net [get_bd_ports s_axi_resetn] [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins eth_dma/axi_resetn] [get_bd_pins ext_rstn_inv/Op1] [get_bd_pins gt_ctl/s_axi_aresetn] [get_bd_pins periph_connect/aresetn] [get_bd_pins rx_axis_switch/s_axi_ctrl_aresetn] [get_bd_pins rx_rst_gen/aux_reset_in] [get_bd_pins rx_rst_gen/ext_reset_in] [get_bd_pins tx_axis_switch/s_axi_ctrl_aresetn] [get_bd_pins tx_rst_gen/aux_reset_in] [get_bd_pins tx_rst_gen/ext_reset_in] [get_bd_pins tx_rx_ctl_stat/s_axi_aresetni]
  if { $g_dma_axi_clk } {
    connect_bd_net [get_bd_ports s_axi_clk] [get_bd_pins eth_dma/m_axi_mm2s_aclk] [get_bd_pins eth_dma/m_axi_s2mm_aclk] [get_bd_pins rx_clk_conv/m_axis_aclk] [get_bd_pins tx_clk_conv/s_axis_aclk]
    connect_bd_net [get_bd_pins eth100gb/gt_rxusrclk2] [get_bd_pins rx_clk_conv/s_axis_aclk] [get_bd_pins dma_s2mm_reset/slowest_sync_clk]
    connect_bd_net [get_bd_pins eth100gb/gt_txusrclk2] [get_bd_pins tx_clk_conv/m_axis_aclk] [get_bd_pins dma_mm2s_reset/slowest_sync_clk]
    connect_bd_net [get_bd_pins eth_dma/s2mm_prmry_reset_out_n] [get_bd_pins dma_s2mm_reset/ext_reset_in]
    connect_bd_net [get_bd_pins eth_dma/mm2s_prmry_reset_out_n] [get_bd_pins dma_mm2s_reset/ext_reset_in]
    connect_bd_net [get_bd_pins dma_mm2s_reset/peripheral_aresetn] [get_bd_pins dma_loopback_fifo/s_axis_aresetn] [get_bd_pins tx_axis_switch/aresetn] [get_bd_pins tx_fifo/s_axis_aresetn] [get_bd_pins tx_clk_conv/m_axis_aresetn]
    connect_bd_net [get_bd_pins dma_s2mm_reset/peripheral_aresetn] [get_bd_pins eth_loopback_fifo/s_axis_aresetn] [get_bd_pins rx_axis_switch/aresetn] [get_bd_pins rx_fifo/rstn] [get_bd_pins rx_clk_conv/s_axis_aresetn]
    connect_bd_net  [get_bd_ports s_axi_resetn] [get_bd_pins rx_clk_conv/m_axis_aresetn] [get_bd_pins tx_clk_conv/s_axis_aresetn]
  } else {
    connect_bd_net [get_bd_pins eth100gb/gt_rxusrclk2] [get_bd_pins eth_dma/m_axi_s2mm_aclk]
    connect_bd_net [get_bd_pins eth100gb/gt_txusrclk2] [get_bd_pins eth_dma/m_axi_mm2s_aclk]
    connect_bd_net [get_bd_pins dma_loopback_fifo/s_axis_aresetn] [get_bd_pins eth_dma/mm2s_prmry_reset_out_n] [get_bd_pins tx_axis_switch/aresetn] [get_bd_pins tx_fifo/s_axis_aresetn]
    connect_bd_net [get_bd_pins eth_dma/s2mm_prmry_reset_out_n] [get_bd_pins eth_loopback_fifo/s_axis_aresetn] [get_bd_pins rx_axis_switch/aresetn] [get_bd_pins rx_fifo/rstn]
  }

  if { $g_dma_mem == "hbm" ||
       $g_dma_mem == "ddr" } {
  connect_bd_net [get_bd_ports rx_rstn] [get_bd_pins rx_rst_gen/peripheral_aresetn]
  connect_bd_net [get_bd_ports tx_rstn] [get_bd_pins tx_rst_gen/peripheral_aresetn]
  connect_bd_net [get_bd_pins axi_reg_slice_rx/aclk]    [get_bd_pins eth_dma/m_axi_s2mm_aclk] [get_bd_ports rx_clk]
  connect_bd_net [get_bd_pins axi_reg_slice_tx/aclk]    [get_bd_pins eth_dma/m_axi_mm2s_aclk] [get_bd_ports tx_clk]
  connect_bd_net [get_bd_pins axi_reg_slice_rx/aresetn] [get_bd_pins eth_dma/s2mm_prmry_reset_out_n]
  connect_bd_net [get_bd_pins axi_reg_slice_tx/aresetn] [get_bd_pins eth_dma/mm2s_prmry_reset_out_n]
  } else {
  connect_bd_net [get_bd_pins dma_intconnect/aclk]    [get_bd_pins eth_dma/m_axi_sg_aclk]
  if {!$g_dma_axi_clk} {
    connect_bd_net [get_bd_pins dma_intconnect/aclk1]   [get_bd_pins eth_dma/m_axi_s2mm_aclk]
    connect_bd_net [get_bd_pins dma_intconnect/aclk2]   [get_bd_pins eth_dma/m_axi_mm2s_aclk]
  }
  connect_bd_net [get_bd_pins dma_intconnect/aresetn] [get_bd_pins eth_dma/axi_resetn]
  }
  if { ${g_dma_mem} eq "hbm" } {
  connect_bd_net [get_bd_pins dma_connect_sg/aresetn] [get_bd_pins eth_dma/axi_resetn]
  connect_bd_net [get_bd_pins dma_connect_rx/aresetn] [get_bd_pins eth_dma/s2mm_prmry_reset_out_n]
  connect_bd_net [get_bd_pins dma_connect_tx/aresetn] [get_bd_pins eth_dma/mm2s_prmry_reset_out_n]
  connect_bd_net [get_bd_pins dma_connect_sg/aclk]    [get_bd_pins eth_dma/m_axi_sg_aclk]
  connect_bd_net [get_bd_pins dma_connect_rx/aclk]    [get_bd_pins eth_dma/m_axi_s2mm_aclk]
  connect_bd_net [get_bd_pins dma_connect_tx/aclk]    [get_bd_pins eth_dma/m_axi_mm2s_aclk]
  }
}

# drp_clk and init_clk inputs of CMAC require frequency in range 50...250 MHz
if { [string is digit -strict $g_saxi_freq] && ![string is digit -strict $g_init_clk_freq] } {
if { $g_saxi_freq < 50000000 || $g_saxi_freq > 250000000 } {
  connect_bd_net [get_bd_ports s_axi_clk] [get_bd_pins clk_wiz_cmac/clk_in1]
  connect_bd_net [get_bd_pins clk_wiz_cmac/clk_out1] [get_bd_pins eth100gb/drp_clk] [get_bd_pins eth100gb/init_clk]
} else {
  connect_bd_net [get_bd_ports s_axi_clk] [get_bd_pins eth100gb/drp_clk] [get_bd_pins eth100gb/init_clk]
}
} else {
  connect_bd_net [get_bd_ports init_clk]  [get_bd_pins eth100gb/drp_clk] [get_bd_pins eth100gb/init_clk]
}

  # Create address segments
  assign_bd_address -offset 0x00005000 -range 0x00001000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs axi_timer_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x00010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs eth100gb/s_axi/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs eth_dma/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x00003000 -range 0x00001000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs gt_ctl/S_AXI/Reg] -force
  assign_bd_address -offset 0x00002000 -range 0x00001000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs rx_axis_switch/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0x00001000 -range 0x00001000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs tx_axis_switch/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0x00004000 -range 0x00001000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs tx_rx_ctl_stat/S_AXI/Reg] -force
if { ${g_dma_mem} eq "sram" } {
  assign_bd_address -offset 0x00000000 -range 0x00080000 -target_address_space [get_bd_addr_spaces eth_dma/Data_S2MM] [get_bd_addr_segs rx_mem_dma/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x00040000 -target_address_space [get_bd_addr_spaces eth_dma/Data_SG] [get_bd_addr_segs sg_mem_dma/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x00080000 -target_address_space [get_bd_addr_spaces eth_dma/Data_MM2S] [get_bd_addr_segs tx_mem_dma/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00200000 -range 0x00080000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs rx_mem_cpu/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00300000 -range 0x00040000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs sg_mem_cpu/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00100000 -range 0x00080000 -target_address_space [get_bd_addr_spaces s_axi] [get_bd_addr_segs tx_mem_cpu/S_AXI/Mem0] -force
} elseif { $g_dma_mem == "hbm" ||
           $g_dma_mem == "ddr" } {
  assign_bd_address -offset 0x00000000 -range [expr (1 << $g_max_dma_addr_width)] -target_address_space [get_bd_addr_spaces eth_dma/Data_MM2S] [get_bd_addr_segs m_axi_tx/Reg] -force
  assign_bd_address -offset 0x00000000 -range [expr (1 << $g_max_dma_addr_width)] -target_address_space [get_bd_addr_spaces eth_dma/Data_S2MM] [get_bd_addr_segs m_axi_rx/Reg] -force
  assign_bd_address -offset 0x00000000 -range [expr (1 << $g_max_dma_addr_width)] -target_address_space [get_bd_addr_spaces eth_dma/Data_SG]   [get_bd_addr_segs m_axi_sg/Reg] -force
} else {
  assign_bd_address -offset 0x00000000 -range [expr (1 << $g_max_dma_addr_width)] -target_address_space [get_bd_addr_spaces eth_dma/Data_MM2S] [get_bd_addr_segs m_axi_dma/Reg] -force
  assign_bd_address -offset 0x00000000 -range [expr (1 << $g_max_dma_addr_width)] -target_address_space [get_bd_addr_spaces eth_dma/Data_S2MM] [get_bd_addr_segs m_axi_dma/Reg] -force
  assign_bd_address -offset 0x00000000 -range [expr (1 << $g_max_dma_addr_width)] -target_address_space [get_bd_addr_spaces eth_dma/Data_SG]   [get_bd_addr_segs m_axi_dma/Reg] -force
}


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name 
}
# End of cr_bd_Eth_CMAC_syst()

cr_bd_Eth_CMAC_syst ""
