############################################################################
##
##   U280 - Master XDC 
##   Source: https://forums.xilinx.com/t5/Alveo-Accelerator-Cards/Alveo-U280-XDC-File-on-Xilinx-site-is-not-correct-U250-amp-U200/m-p/1060242/highlight/true#M982
##
############################################################################
#
# Bitstream Configuration
# ------------------------------------------------------------------------
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

#--------------------------------------------
# On-board system clock
set_property PACKAGE_PIN BJ44 [ get_ports {sysclk0_clk_n} ] ;# Bank  65 VCCO - VCC1V2 Net "SYSCLK0_N" - IO_L12N_T1U_N11_GC_A09_D25_65
set_property IOSTANDARD  LVDS [ get_ports {sysclk0_clk_n} ] ;# Bank  65 VCCO - VCC1V2 Net "SYSCLK0_N" - IO_L12N_T1U_N11_GC_A09_D25_65
set_property PACKAGE_PIN BJ43 [ get_ports {sysclk0_clk_p} ] ;# Bank  65 VCCO - VCC1V2 Net "SYSCLK0_P" - IO_L12P_T1U_N10_GC_A08_D24_65
set_property IOSTANDARD  LVDS [ get_ports {sysclk0_clk_p} ] ;# Bank  65 VCCO - VCC1V2 Net "SYSCLK0_P" - IO_L12P_T1U_N10_GC_A08_D24_65

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
set_property PACKAGE_PIN D32      [get_ports "HBM_CATTRIP"] ;# Bank  75 VCCO - VCC1V8   - IO_L17P_T2U_N8_AD10P_75
set_property IOSTANDARD  LVCMOS18 [get_ports "HBM_CATTRIP"] ;# Bank  75 VCCO - VCC1V8   - IO_L17P_T2U_N8_AD10P_75
set_property PULLTYPE    PULLDOWN [get_ports "HBM_CATTRIP"] ;# Setting HBM_CATTRIP to low by default to avoid the SC shutting down the card

#--------------------------------------------
## Input Clocks and Controls for QSFP28 Port 0
#
## MGT_SI570_CLOCK0   -> MGT Ref Clock 0 156.25MHz Default (Not User re-programmable)
# set_property PACKAGE_PIN T43              [get_ports "MGT_SI570_CLOCK0_N"]                 ;# Bank 134 - MGTREFCLK0N_134
# set_property PACKAGE_PIN T42              [get_ports "MGT_SI570_CLOCK0_P"]                 ;# Bank 134 - MGTREFCLK0P_134
#
## QSFP0_CLOCK        -> MGT Ref Clock 1 User selectable by QSFP0_FS=0 161.132812 MHz and QSFP0_FS=1 156.250MHz; QSFP0_OEB must driven low to enable clock output
# set_property PACKAGE_PIN R41              [get_ports "qsfp0_156mhz_clk_n"]                 ;# Bank 134 - MGTREFCLK1N_134
# set_property PACKAGE_PIN R40              [get_ports "qsfp0_156mhz_clk_p"]                 ;# Bank 134 - MGTREFCLK1P_134
#
## QSFP0_CLOCK control signals
# set_property PACKAGE_PIN G32              [get_ports "QSFP0_FS" ]                          ;# Bank  75 VCCO - VCC1V8 Net "QSFP0_FS"   - IO_L9N_T1L_N5_AD12N_75
# set_property IOSTANDARD  LVCMOS18         [get_ports "QSFP0_FS" ]                          ;# Bank  75 VCCO - VCC1V8 Net "QSFP0_FS"   - IO_L9N_T1L_N5_AD12N_75
# set_property PACKAGE_PIN H32              [get_ports "QSFP0_OEB"]                          ;# Bank  75 VCCO - VCC1V8 Net "QSFP0_OEB"  - IO_L9P_T1L_N4_AD12P_75
# set_property IOSTANDARD  LVCMOS18         [get_ports "QSFP0_OEB"]                          ;# Bank  75 VCCO - VCC1V8 Net "QSFP0_OEB"  - IO_L9P_T1L_N4_AD12P_75
#
## QSFP0 MGTY Interface
# set_property PACKAGE_PIN L54              [get_ports "qsfp0_2x_grx_n[0]"]                        ;# Bank 134 - MGTYRXN0_134
# set_property PACKAGE_PIN K52              [get_ports "qsfp0_2x_grx_n[1]"]                        ;# Bank 134 - MGTYRXN1_134
# set_property PACKAGE_PIN J54              [get_ports "qsfp0_2x_grx_n[2]"]                        ;# Bank 134 - MGTYRXN2_134
# set_property PACKAGE_PIN H52              [get_ports "qsfp0_2x_grx_n[3]"]                        ;# Bank 134 - MGTYRXN3_134
# set_property PACKAGE_PIN L53              [get_ports "qsfp0_2x_grx_p[0]"]                        ;# Bank 134 - MGTYRXP0_134
# set_property PACKAGE_PIN K51              [get_ports "qsfp0_2x_grx_p[1]"]                        ;# Bank 134 - MGTYRXP1_134
# set_property PACKAGE_PIN J53              [get_ports "qsfp0_2x_grx_p[2]"]                        ;# Bank 134 - MGTYRXP2_134
# set_property PACKAGE_PIN H51              [get_ports "qsfp0_2x_grx_p[3]"]                        ;# Bank 134 - MGTYRXP3_134
# set_property PACKAGE_PIN L49              [get_ports "qsfp0_2x_gtx_n[0]"]                        ;# Bank 134 - MGTYTXN0_134
# set_property PACKAGE_PIN L45              [get_ports "qsfp0_2x_gtx_n[1]"]                        ;# Bank 134 - MGTYTXN1_134
# set_property PACKAGE_PIN K47              [get_ports "qsfp0_2x_gtx_n[2]"]                        ;# Bank 134 - MGTYTXN2_134
# set_property PACKAGE_PIN J49              [get_ports "qsfp0_2x_gtx_n[3]"]                        ;# Bank 134 - MGTYTXN3_134
# set_property PACKAGE_PIN L48              [get_ports "qsfp0_2x_gtx_p[0]"]                        ;# Bank 134 - MGTYTXP0_134
# set_property PACKAGE_PIN L44              [get_ports "qsfp0_2x_gtx_p[1]"]                        ;# Bank 134 - MGTYTXP1_134
# set_property PACKAGE_PIN K46              [get_ports "qsfp0_2x_gtx_p[2]"]                        ;# Bank 134 - MGTYTXP2_134
# set_property PACKAGE_PIN J48              [get_ports "qsfp0_2x_gtx_p[3]"]                        ;# Bank 134 - MGTYTXP3_134

#--------------------------------------------
# Input Clocks and Controls for QSFP28 Port 1
#
## MGT_SI570_CLOCK1_N   -> MGT Ref Clock 0 156.25MHz Default (Not User re-programmable)
# set_property PACKAGE_PIN P43              [get_ports "MGT_SI570_CLOCK1_N"]                 ;# Bank 135 - MGTREFCLK0N_135
# set_property PACKAGE_PIN P42              [get_ports "MGT_SI570_CLOCK1_P"]                 ;# Bank 135 - MGTREFCLK0P_135
#
## QSFP1_CLOCK_N        -> MGT Ref Clock 1 User selectable by QSFP1_FS=0 161.132812 MHz and QSFP1_FS=1 156.250MHz; QSFP1_OEB must be low to enable clock output
# set_property PACKAGE_PIN M43              [get_ports "QSFP1_CLOCK_N"]                      ;# Bank 135 - MGTREFCLK1N_135
# set_property PACKAGE_PIN M42              [get_ports "QSFP1_CLOCK_P"]                      ;# Bank 135 - MGTREFCLK1P_135
#
## QSFP1_CLOCK control signals
# set_property PACKAGE_PIN H30              [get_ports "QSFP1_OEB"]                          ;# Bank  75 VCCO - VCC1V8 Net "QSFP1_OEB"  - IO_L8N_T1L_N3_AD5N_75
# set_property IOSTANDARD  LVCMOS18         [get_ports "QSFP1_OEB"]                          ;# Bank  75 VCCO - VCC1V8 Net "QSFP1_OEB"  - IO_L8N_T1L_N3_AD5N_75
# set_property PACKAGE_PIN G33              [get_ports "QSFP1_FS"]                           ;# Bank  75 VCCO - VCC1V8 Net "QSFP1_FS"   - IO_L7N_T1L_N1_QBC_AD13N_75
# set_property IOSTANDARD  LVCMOS18         [get_ports "QSFP1_FS"]                           ;# Bank  75 VCCO - VCC1V8 Net "QSFP1_FS"   - IO_L7N_T1L_N1_QBC_AD13N_75
#
## QSFP1 MGTY Interface
# set_property PACKAGE_PIN G54              [get_ports "QSFP1_RX1_N"]                        ;# Bank 135 - MGTYRXN0_135
# set_property PACKAGE_PIN F52              [get_ports "QSFP1_RX2_N"]                        ;# Bank 135 - MGTYRXN1_135
# set_property PACKAGE_PIN E54              [get_ports "QSFP1_RX3_N"]                        ;# Bank 135 - MGTYRXN2_135
# set_property PACKAGE_PIN D52              [get_ports "QSFP1_RX4_N"]                        ;# Bank 135 - MGTYRXN3_135
# set_property PACKAGE_PIN G53              [get_ports "QSFP1_RX1_P"]                        ;# Bank 135 - MGTYRXP0_135
# set_property PACKAGE_PIN F51              [get_ports "QSFP1_RX2_P"]                        ;# Bank 135 - MGTYRXP1_135
# set_property PACKAGE_PIN E53              [get_ports "QSFP1_RX3_P"]                        ;# Bank 135 - MGTYRXP2_135
# set_property PACKAGE_PIN D51              [get_ports "QSFP1_RX4_P"]                        ;# Bank 135 - MGTYRXP3_135
# set_property PACKAGE_PIN G49              [get_ports "QSFP1_TX1_N"]                        ;# Bank 135 - MGTYTXN0_135
# set_property PACKAGE_PIN E49              [get_ports "QSFP1_TX2_N"]                        ;# Bank 135 - MGTYTXN1_135
# set_property PACKAGE_PIN C49              [get_ports "QSFP1_TX3_N"]                        ;# Bank 135 - MGTYTXN2_135
# set_property PACKAGE_PIN A50              [get_ports "QSFP1_TX4_N"]                        ;# Bank 135 - MGTYTXN3_135
# set_property PACKAGE_PIN G48              [get_ports "QSFP1_TX1_P"]                        ;# Bank 135 - MGTYTXP0_135
# set_property PACKAGE_PIN E48              [get_ports "QSFP1_TX2_P"]                        ;# Bank 135 - MGTYTXP1_135
# set_property PACKAGE_PIN C48              [get_ports "QSFP1_TX3_P"]                        ;# Bank 135 - MGTYTXP2_135
# set_property PACKAGE_PIN A49              [get_ports "QSFP1_TX4_P"]                        ;# Bank 135 - MGTYTXP3_135
