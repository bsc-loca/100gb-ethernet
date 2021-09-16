############################################################################
##
##   U280 - Master XDC 
##   Source: https://forums.xilinx.com/t5/Alveo-Accelerator-Cards/Alveo-U280-XDC-File-on-Xilinx-site-is-not-correct-U250-amp-U200/m-p/1060242/highlight/true#M982
##
############################################################################
#
#--------------------------------------------
# Create Clock Constraints (whole board)
#
# create_clock -period 10.000 -name sysclk0         [get_ports "SYS_CLK0_P"]
# create_clock -period 10.000 -name sysclk1         [get_ports "SYS_CLK1_P"]
# create_clock -period 10.000 -name sysclk3         [get_ports "SYS_CLK3_P"]
# create_clock -period 10.000 -name pcie_ref_clk0   [get_ports "PCIE_CLK0_P"]
# create_clock -period 10.000 -name async_ref_clk0  [get_ports "SYS_CLK2_P"]
# create_clock -period 10.000 -name pcie_ref_clk1   [get_ports "PCIE_CLK1_P"]
# create_clock -period 10.000 -name async_ref_clk1  [get_ports "SYS_CLK5_P"]
# create_clock -period 6.400  -name gt0refclk0      [get_ports "MGT_SI570_CLOCK0_P"]
# create_clock -period 6.206  -name gt0refclk1      [get_ports "QSFP0_CLOCK_P"]
# create_clock -period 6.400  -name gt1refclk0      [get_ports "MGT_SI570_CLOCK1_P"]
# create_clock -period 6.206  -name gt1refclk1      [get_ports "QSFP1_CLOCK_P"]

#--------------------------------------------
# On-board system clock
# set_property PACKAGE_PIN BJ44 [ get_ports "SYS_CLK_clk_n" ]  ;# Bank  65 VCCO - VCC1V2 Net "SYSCLK0_N" - IO_L12N_T1U_N11_GC_A09_D25_65
# set_property IOSTANDARD  LVDS [ get_ports "SYS_CLK_clk_n" ]  ;# Bank  65 VCCO - VCC1V2 Net "SYSCLK0_N" - IO_L12N_T1U_N11_GC_A09_D25_65
# set_property PACKAGE_PIN BJ43 [ get_ports "SYS_CLK_clk_p" ]  ;# Bank  65 VCCO - VCC1V2 Net "SYSCLK0_P" - IO_L12P_T1U_N10_GC_A08_D24_65
# set_property IOSTANDARD  LVDS [ get_ports "SYS_CLK_clk_p" ]  ;# Bank  65 VCCO - VCC1V2 Net "SYSCLK0_P" - IO_L12P_T1U_N10_GC_A08_D24_65
set_property PACKAGE_PIN BJ6  [ get_ports "SYS_CLK_clk_n" ]  ;# Bank  69 VCCO - VCC1V2 Net "SYSCLK1_N" - IO_L13N_T2L_N1_GC_QBC_69
set_property IOSTANDARD  LVDS [ get_ports "SYS_CLK_clk_n" ]  ;# Bank  69 VCCO - VCC1V2 Net "SYSCLK1_N" - IO_L13N_T2L_N1_GC_QBC_69
set_property PACKAGE_PIN BH6  [ get_ports "SYS_CLK_clk_p" ]  ;# Bank  69 VCCO - VCC1V2 Net "SYSCLK1_P" - IO_L13P_T2L_N0_GC_QBC_69
set_property IOSTANDARD  LVDS [ get_ports "SYS_CLK_clk_p" ]  ;# Bank  69 VCCO - VCC1V2 Net "SYSCLK1_P" - IO_L13P_T2L_N0_GC_QBC_69
# create_clock -period 10.000 -name SYS_CLK [get_ports "SYS_CLK_clk_p"]

#--------------------------------------------
##  CPU_RESET_FPGA Connects to SW1 push button On the top edge of the PCB Assembly, also connects to Satellite Contoller
##                 Desinged to be a active low reset input to the FPGA.
##
set_property PACKAGE_PIN L30      [get_ports "CPU_RESET_FPGA"]  ;# Bank  75 VCCO - VCC1V8   - IO_L2N_T0L_N3_75
set_property IOSTANDARD  LVCMOS18 [get_ports "CPU_RESET_FPGA"]  ;# Bank  75 VCCO - VCC1V8   - IO_L2N_T0L_N3_75

#--------------------------------------------
# HBM Catastrophic Over temperature Output signal to Satellite Controller
#    HBM_CATTRIP Active high indicator to Satellite controller to indicate the HBM has exceeded its maximum allowable temperature.
#                This signal is not a dedicated Ultrascale+ Device output and is a derived signal in RTL. Making the signal Active will shut
#                the Ultrascale+ Device power rails off.
#
# From UG1314 (Alveo U280 Data Center Accelerator Card User Guide):
# WARNING! When creating a design for this card, it is necessary to drive the CATTRIP pin.
# This pin is monitored by the card's satellite controller (SC) and represents the HBM_CATRIP (HBM
# catastrophic temperature failure). When instantiating the HBM IP in your design, the two HBM IP signals,
# DRAM_0_STAT_CATTRIP and DRAM_1_STAT_CATTRIP, must be ORed together and connected to this pin for
# proper card operation. If the pin is undefined it will be pulled High by the card causing the SC to infer a CATRIP
# failure and shut power down to the card.
# If you do not use the HBM IP in your design, you must drive the pin Low to avoid the SC shutting down the card.
# If the pin is undefined and the QSPI is programmed with the MCS file, there is a potential chance that the card
# will continuously power down and reset after the bitstream is loaded. This can result in the card being unusable.
#
set_property PACKAGE_PIN D32      [get_ports "HBM_CATTRIP"]  ;# Bank  75 VCCO - VCC1V8   - IO_L17P_T2U_N8_AD10P_75
set_property IOSTANDARD  LVCMOS18 [get_ports "HBM_CATTRIP"]  ;# Bank  75 VCCO - VCC1V8   - IO_L17P_T2U_N8_AD10P_75
set_property PULLTYPE    PULLDOWN [get_ports "HBM_CATTRIP"]  ;# Setting HBM_CATTRIP to low by default to avoid the SC shutting down the card

#--------------------------------------------
## Input Clocks and Controls for QSFP28 Port 0
#
## MGT_SI570_CLOCK0   -> MGT Ref Clock 0 156.25MHz Default (Not User re-programmable)
# set_property PACKAGE_PIN T43      [get_ports "MGT_SI570_CLOCK0_N"]  ;# Bank 134 - MGTREFCLK0N_134, platform: io_clk_gtyquad_refclk0_00_clk_n
# set_property PACKAGE_PIN T42      [get_ports "MGT_SI570_CLOCK0_P"]  ;# Bank 134 - MGTREFCLK0P_134, platform: io_clk_gtyquad_refclk0_00_clk_p
set_property PACKAGE_PIN T43      [get_ports "QSFP1X_CLK_clk_n"]  ;# Bank 134 - MGTREFCLK0N_134, platform: io_clk_gtyquad_refclk0_00_clk_n
set_property PACKAGE_PIN T42      [get_ports "QSFP1X_CLK_clk_p"]  ;# Bank 134 - MGTREFCLK0P_134, platform: io_clk_gtyquad_refclk0_00_clk_p
create_clock -period 6.400 -name QSFP1X_CLK [get_ports "QSFP1X_CLK_clk_p"]
#
## QSFP0_CLOCK        -> MGT Ref Clock 1 User selectable by QSFP0_FS=0 161.132812 MHz and QSFP0_FS=1 156.250MHz; QSFP0_OEB must driven low to enable clock output
# set_property PACKAGE_PIN R41      [get_ports "QSFP0_CLOCK_N"]  ;# Bank 134 - MGTREFCLK1N_134, platform: io_clk_gtyquad_refclk1_00_clk_n
# set_property PACKAGE_PIN R40      [get_ports "QSFP0_CLOCK_P"]  ;# Bank 134 - MGTREFCLK1P_134, platform: io_clk_gtyquad_refclk1_00_clk_p
#
## QSFP0_CLOCK control signals
# set_property PACKAGE_PIN G32       [get_ports "QSFP0_FS" ]  ;# Bank  75 VCCO - VCC1V8 Net "QSFP0_FS"   - IO_L9N_T1L_N5_AD12N_75, platform: QSFP0_FS[0:0]
# set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP0_FS" ]  ;# Bank  75 VCCO - VCC1V8 Net "QSFP0_FS"   - IO_L9N_T1L_N5_AD12N_75
# set_property PACKAGE_PIN H32       [get_ports "QSFP0_OEB"]  ;# Bank  75 VCCO - VCC1V8 Net "QSFP0_OEB"  - IO_L9P_T1L_N4_AD12P_75, platform: QSFP0_OEB[0:0]
# set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP0_OEB"]  ;# Bank  75 VCCO - VCC1V8 Net "QSFP0_OEB"  - IO_L9P_T1L_N4_AD12P_75
#
## QSFP0 MGTY Interface
# set_property PACKAGE_PIN L54       [get_ports "QSFP0_RX1_N"]  ;# Bank 134 - MGTYRXN0_134, platform: io_gt_gtyquad_00[_grx_n[0]]
# set_property PACKAGE_PIN K52       [get_ports "QSFP0_RX2_N"]  ;# Bank 134 - MGTYRXN1_134, platform: io_gt_gtyquad_00[_grx_n[1]]
# set_property PACKAGE_PIN J54       [get_ports "QSFP0_RX3_N"]  ;# Bank 134 - MGTYRXN2_134, platform: io_gt_gtyquad_00[_grx_n[2]]
# set_property PACKAGE_PIN H52       [get_ports "QSFP0_RX4_N"]  ;# Bank 134 - MGTYRXN3_134, platform: io_gt_gtyquad_00[_grx_n[4]]
# set_property PACKAGE_PIN L53       [get_ports "QSFP0_RX1_P"]  ;# Bank 134 - MGTYRXP0_134, platform: io_gt_gtyquad_00[_grx_p[0]]
# set_property PACKAGE_PIN K51       [get_ports "QSFP0_RX2_P"]  ;# Bank 134 - MGTYRXP1_134, platform: io_gt_gtyquad_00[_grx_p[1]]
# set_property PACKAGE_PIN J53       [get_ports "QSFP0_RX3_P"]  ;# Bank 134 - MGTYRXP2_134, platform: io_gt_gtyquad_00[_grx_p[2]]
# set_property PACKAGE_PIN H51       [get_ports "QSFP0_RX4_P"]  ;# Bank 134 - MGTYRXP3_134, platform: io_gt_gtyquad_00[_grx_p[4]]
# set_property PACKAGE_PIN L49       [get_ports "QSFP0_TX1_N"]  ;# Bank 134 - MGTYTXN0_134, platform: io_gt_gtyquad_00[_gtx_n[0]]
# set_property PACKAGE_PIN L45       [get_ports "QSFP0_TX2_N"]  ;# Bank 134 - MGTYTXN1_134, platform: io_gt_gtyquad_00[_gtx_n[1]]
# set_property PACKAGE_PIN K47       [get_ports "QSFP0_TX3_N"]  ;# Bank 134 - MGTYTXN2_134, platform: io_gt_gtyquad_00[_gtx_n[2]]
# set_property PACKAGE_PIN J49       [get_ports "QSFP0_TX4_N"]  ;# Bank 134 - MGTYTXN3_134, platform: io_gt_gtyquad_00[_gtx_n[3]]
# set_property PACKAGE_PIN L48       [get_ports "QSFP0_TX1_P"]  ;# Bank 134 - MGTYTXP0_134, platform: io_gt_gtyquad_00[_gtx_p[0]]
# set_property PACKAGE_PIN L44       [get_ports "QSFP0_TX2_P"]  ;# Bank 134 - MGTYTXP1_134, platform: io_gt_gtyquad_00[_gtx_p[1]]
# set_property PACKAGE_PIN K46       [get_ports "QSFP0_TX3_P"]  ;# Bank 134 - MGTYTXP2_134, platform: io_gt_gtyquad_00[_gtx_p[2]]
# set_property PACKAGE_PIN J48       [get_ports "QSFP0_TX4_P"]  ;# Bank 134 - MGTYTXP3_134, platform: io_gt_gtyquad_00[_gtx_p[3]]

#--------------------------------------------
# Input Clocks and Controls for QSFP28 Port 1
#
## MGT_SI570_CLOCK1_N   -> MGT Ref Clock 0 156.25MHz Default (Not User re-programmable)
# set_property PACKAGE_PIN P43       [get_ports "MGT_SI570_CLOCK1_N"] ;# Bank 135 - MGTREFCLK0N_135, platform: io_clk_gtyquad_refclk0_01_clk_n
# set_property PACKAGE_PIN P42       [get_ports "MGT_SI570_CLOCK1_P"] ;# Bank 135 - MGTREFCLK0P_135, platform: io_clk_gtyquad_refclk0_01_clk_p
set_property PACKAGE_PIN P43       [get_ports "QSFP4X_CLK_clk_n"] ;# Bank 135 - MGTREFCLK0N_135, platform: io_clk_gtyquad_refclk0_01_clk_n
set_property PACKAGE_PIN P42       [get_ports "QSFP4X_CLK_clk_p"] ;# Bank 135 - MGTREFCLK0P_135, platform: io_clk_gtyquad_refclk0_01_clk_p
# create_clock -period 6.400 -name QSFP4X_CLK [get_ports "QSFP4X_CLK_clk_p"]
#
## QSFP1_CLOCK_N        -> MGT Ref Clock 1 User selectable by QSFP1_FS=0 161.132812 MHz and QSFP1_FS=1 156.250MHz; QSFP1_OEB must be low to enable clock output
# set_property PACKAGE_PIN M43       [get_ports "QSFP1_CLOCK_N"]  ;# Bank 135 - MGTREFCLK1N_135, platform: io_clk_gtyquad_refclk1_01_clk_n
# set_property PACKAGE_PIN M42       [get_ports "QSFP1_CLOCK_P"]  ;# Bank 135 - MGTREFCLK1P_135, platform: io_clk_gtyquad_refclk1_01_clk_p
#
## QSFP1_CLOCK control signals
# set_property PACKAGE_PIN H30       [get_ports "QSFP1_OEB"]  ;# Bank  75 VCCO - VCC1V8 Net "QSFP1_OEB"  - IO_L8N_T1L_N3_AD5N_75     , platform: QSFP1_OEB[0:0]
# set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP1_OEB"]  ;# Bank  75 VCCO - VCC1V8 Net "QSFP1_OEB"  - IO_L8N_T1L_N3_AD5N_75
# set_property PACKAGE_PIN G33       [get_ports "QSFP1_FS"]   ;# Bank  75 VCCO - VCC1V8 Net "QSFP1_FS"   - IO_L7N_T1L_N1_QBC_AD13N_75, platform: QSFP1_FS[0:0]
# set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP1_FS"]   ;# Bank  75 VCCO - VCC1V8 Net "QSFP1_FS"   - IO_L7N_T1L_N1_QBC_AD13N_75
#
## QSFP1 MGTY Interface
# set_property PACKAGE_PIN G54       [get_ports "QSFP1_RX1_N"]  ;# Bank 135 - MGTYRXN0_135, platform: io_gt_gtyquad_01[_grx_n[0]]
# set_property PACKAGE_PIN F52       [get_ports "QSFP1_RX2_N"]  ;# Bank 135 - MGTYRXN1_135, platform: io_gt_gtyquad_01[_grx_n[1]]
# set_property PACKAGE_PIN E54       [get_ports "QSFP1_RX3_N"]  ;# Bank 135 - MGTYRXN2_135, platform: io_gt_gtyquad_01[_grx_n[2]]
# set_property PACKAGE_PIN D52       [get_ports "QSFP1_RX4_N"]  ;# Bank 135 - MGTYRXN3_135, platform: io_gt_gtyquad_01[_grx_n[4]]
# set_property PACKAGE_PIN G53       [get_ports "QSFP1_RX1_P"]  ;# Bank 135 - MGTYRXP0_135, platform: io_gt_gtyquad_01[_grx_p[0]]
# set_property PACKAGE_PIN F51       [get_ports "QSFP1_RX2_P"]  ;# Bank 135 - MGTYRXP1_135, platform: io_gt_gtyquad_01[_grx_p[1]]
# set_property PACKAGE_PIN E53       [get_ports "QSFP1_RX3_P"]  ;# Bank 135 - MGTYRXP2_135, platform: io_gt_gtyquad_01[_grx_p[2]]
# set_property PACKAGE_PIN D51       [get_ports "QSFP1_RX4_P"]  ;# Bank 135 - MGTYRXP3_135, platform: io_gt_gtyquad_01[_grx_p[4]]
# set_property PACKAGE_PIN G49       [get_ports "QSFP1_TX1_N"]  ;# Bank 135 - MGTYTXN0_135, platform: io_gt_gtyquad_01[_gtx_n[0]]
# set_property PACKAGE_PIN E49       [get_ports "QSFP1_TX2_N"]  ;# Bank 135 - MGTYTXN1_135, platform: io_gt_gtyquad_01[_gtx_n[1]]
# set_property PACKAGE_PIN C49       [get_ports "QSFP1_TX3_N"]  ;# Bank 135 - MGTYTXN2_135, platform: io_gt_gtyquad_01[_gtx_n[2]]
# set_property PACKAGE_PIN A50       [get_ports "QSFP1_TX4_N"]  ;# Bank 135 - MGTYTXN3_135, platform: io_gt_gtyquad_01[_gtx_n[3]]
# set_property PACKAGE_PIN G48       [get_ports "QSFP1_TX1_P"]  ;# Bank 135 - MGTYTXP0_135, platform: io_gt_gtyquad_01[_gtx_p[0]]
# set_property PACKAGE_PIN E48       [get_ports "QSFP1_TX2_P"]  ;# Bank 135 - MGTYTXP1_135, platform: io_gt_gtyquad_01[_gtx_p[1]]
# set_property PACKAGE_PIN C48       [get_ports "QSFP1_TX3_P"]  ;# Bank 135 - MGTYTXP2_135, platform: io_gt_gtyquad_01[_gtx_p[2]]
# set_property PACKAGE_PIN A49       [get_ports "QSFP1_TX4_P"]  ;# Bank 135 - MGTYTXP3_135, platform: io_gt_gtyquad_01[_gtx_p[3]]

#--------------------------------------------
# Specifying the placement of QSFP clock domain modules into single SLR to facilitate routing
# https://www.xilinx.com/support/documentation/sw_manuals/xilinx2020_1/ug912-vivado-properties.pdf#page=386
set tx_clk_units [get_cells -of_objects [get_nets -of_objects [get_pins -hierarchical eth100gb/gt_txusrclk2]]]
set rx_clk_units [get_cells -of_objects [get_nets -of_objects [get_pins -hierarchical eth100gb/gt_rxusrclk2]]]
#As clocks are not applied to memories explicitly in BD, include them separately to SLR placement.
set eth_txmem [get_cells -hierarchical tx_mem]
set eth_rxmem [get_cells -hierarchical rx_mem]
#Setting specific SLR to which QSFP are wired since placer may miss it if just "group_name" is applied
set_property USER_SLR_ASSIGNMENT SLR2 [get_cells "$tx_clk_units $rx_clk_units $eth_txmem $eth_rxmem"]

#--------------------------------------------
# Timing constraints for domains crossings, which didn't apply automatically (e.g. for GPIO)
#
set sys_clk [get_clocks -of_objects [get_pins -hierarchical sys_clk_gen/clk_out1 ]]
set tx_clk  [get_clocks -of_objects [get_pins -hierarchical eth100gb/gt_txusrclk2]]
set rx_clk  [get_clocks -of_objects [get_pins -hierarchical eth100gb/gt_rxusrclk2]]
# set_false_path -from $xxx_clk -to $yyy_clk
# controlling resync paths to be less than source clock period
# (-datapath_only to exclude clock paths)
set_max_delay -datapath_only -from $sys_clk -to $tx_clk  [expr [get_property -min period $sys_clk] * 0.9]
set_max_delay -datapath_only -from $sys_clk -to $rx_clk  [expr [get_property -min period $sys_clk] * 0.9]
set_max_delay -datapath_only -from $tx_clk  -to $sys_clk [expr [get_property -min period $tx_clk ] * 0.9]
set_max_delay -datapath_only -from $tx_clk  -to $rx_clk  [expr [get_property -min period $tx_clk ] * 0.9]
set_max_delay -datapath_only -from $rx_clk  -to $sys_clk [expr [get_property -min period $rx_clk ] * 0.9]
set_max_delay -datapath_only -from $rx_clk  -to $tx_clk  [expr [get_property -min period $rx_clk ] * 0.9]
#
# Timing constraints for domains crossings in Ethernet MAC Lite + 1Gb Ethernet PHY (not all CDC present in BD)
set phy_clk [get_clocks -of_objects [get_pins -hierarchical sys_clk_gen/clk_out2     ]]
set txl_clk [get_clocks -of_objects [get_pins -hierarchical gig_eth_phy/userclk_out  ]]
set rxl_clk [get_clocks -of_objects [get_pins -hierarchical gig_eth_phy/rxuserclk_out]]
# Ethernet MAC Lite
set_max_delay -datapath_only -from $sys_clk -to $txl_clk [expr [get_property -min period $sys_clk] * 0.9]
set_max_delay -datapath_only -from $sys_clk -to $rxl_clk [expr [get_property -min period $sys_clk] * 0.9]
set_max_delay -datapath_only -from $txl_clk -to $sys_clk [expr [get_property -min period $txl_clk] * 0.9]
set_max_delay -datapath_only -from $rxl_clk -to $sys_clk [expr [get_property -min period $rxl_clk] * 0.9]
# 1Gb Ethernet PHY
set_max_delay -datapath_only -from $phy_clk -to $txl_clk [expr [get_property -min period $phy_clk] * 0.9]
set_max_delay -datapath_only -from $phy_clk -to $rxl_clk [expr [get_property -min period $phy_clk] * 0.9]
set_max_delay -datapath_only -from $txl_clk -to $phy_clk [expr [get_property -min period $txl_clk] * 0.9]
set_max_delay -datapath_only -from $rxl_clk -to $phy_clk [expr [get_property -min period $rxl_clk] * 0.9]
# both
set_max_delay -datapath_only -from $txl_clk -to $rxl_clk [expr [get_property -min period $txl_clk] * 0.9]
set_max_delay -datapath_only -from $rxl_clk -to $txl_clk [expr [get_property -min period $rxl_clk] * 0.9]

# ------------------------------------------------------------------------
## Bitstream Configuration
set_property CONFIG_VOLTAGE 1.8                        [current_design]
set_property BITSTREAM.CONFIG.CONFIGFALLBACK Enable    [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE           [current_design]
set_property CONFIG_MODE SPIx4                         [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4           [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 85.0          [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN disable [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES        [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup         [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR Yes       [current_design]
