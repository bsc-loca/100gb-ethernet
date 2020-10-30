############################################################################
##
##   U280 - Master XDC 
##   Source: https://forums.xilinx.com/t5/Alveo-Accelerator-Cards/Alveo-U280-XDC-File-on-Xilinx-site-is-not-correct-U250-amp-U200/td-p/1060200
##
############################################################################
#
# Bitstream Configuration
# ------------------------------------------------------------------------
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property BITSTREAM.CONFIG.CONFIGFALLBACK Enable [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 85.0 [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN disable [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR Yes [current_design]
# ------------------------------------------------------------------------
set_property PACKAGE_PIN BF21     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L24N_T3U_N11_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L24N_T3U_N11_67
set_property PACKAGE_PIN BF22     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L24P_T3U_N10_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L24P_T3U_N10_67
set_property PACKAGE_PIN BH22     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L23N_T3U_N9_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L23N_T3U_N9_67
set_property PACKAGE_PIN BG22     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L23P_T3U_N8_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L23P_T3U_N8_67
set_property PACKAGE_PIN BJ21     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L22N_T3U_N7_DBC_AD0N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L22N_T3U_N7_DBC_AD0N_67
set_property PACKAGE_PIN BH21     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L22P_T3U_N6_DBC_AD0P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L22P_T3U_N6_DBC_AD0P_67
set_property PACKAGE_PIN BK21     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L21N_T3L_N5_AD8N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L21N_T3L_N5_AD8N_67
set_property PACKAGE_PIN BJ22     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L21P_T3L_N4_AD8P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L21P_T3L_N4_AD8P_67
set_property PACKAGE_PIN BK23     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L20N_T3L_N3_AD1N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L20N_T3L_N3_AD1N_67
set_property PACKAGE_PIN BK24     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L20P_T3L_N2_AD1P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L20P_T3L_N2_AD1P_67
set_property PACKAGE_PIN BL22     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L19N_T3L_N1_DBC_AD9N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L19N_T3L_N1_DBC_AD9N_67
set_property PACKAGE_PIN BL23     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L19P_T3L_N0_DBC_AD9P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L19P_T3L_N0_DBC_AD9P_67
set_property PACKAGE_PIN BG23     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_T3U_N12_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_T3U_N12_67
set_property PACKAGE_PIN BF23     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_T2U_N12_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_T2U_N12_67
set_property PACKAGE_PIN BH24     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L18N_T2U_N11_AD2N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L18N_T2U_N11_AD2N_67
set_property PACKAGE_PIN BG24     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L18P_T2U_N10_AD2P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L18P_T2U_N10_AD2P_67
set_property PACKAGE_PIN BG25     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L17N_T2U_N9_AD10N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L17N_T2U_N9_AD10N_67
set_property PACKAGE_PIN BF25     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L17P_T2U_N8_AD10P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L17P_T2U_N8_AD10P_67
set_property PACKAGE_PIN BF26     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L16N_T2U_N7_QBC_AD3N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L16N_T2U_N7_QBC_AD3N_67
set_property PACKAGE_PIN BF27     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L16P_T2U_N6_QBC_AD3P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L16P_T2U_N6_QBC_AD3P_67
set_property PACKAGE_PIN BG27     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L15N_T2L_N5_AD11N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L15N_T2L_N5_AD11N_67
set_property PACKAGE_PIN BG28     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L15P_T2L_N4_AD11P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L15P_T2L_N4_AD11P_67
set_property PACKAGE_PIN BJ23     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L14N_T2L_N3_GC_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L14N_T2L_N3_GC_67
set_property PACKAGE_PIN BJ24     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L14P_T2L_N2_GC_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L14P_T2L_N2_GC_67
set_property PACKAGE_PIN BH25     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L13N_T2L_N1_GC_QBC_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L13N_T2L_N1_GC_QBC_67
set_property PACKAGE_PIN BH26       [get_ports "PCIE_PERST_LS"] ;# Bank  67 VCCO - VCC1V8   - IO_L13P_T2L_N0_GC_QBC_67
set_property IOSTANDARD  LVCMOS18  [get_ports "PCIE_PERST_LS"] ;# Bank  67 VCCO - VCC1V8   - IO_L13P_T2L_N0_GC_QBC_67
set_property PACKAGE_PIN BJ27     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L12N_T1U_N11_GC_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L12N_T1U_N11_GC_67
set_property PACKAGE_PIN BH27     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L12P_T1U_N10_GC_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L12P_T1U_N10_GC_67
set_property PACKAGE_PIN BK25     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L11N_T1U_N9_GC_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L11N_T1U_N9_GC_67
set_property PACKAGE_PIN BJ26     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L11P_T1U_N8_GC_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L11P_T1U_N8_GC_67
set_property PACKAGE_PIN BL25     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L10N_T1U_N7_QBC_AD4N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L10N_T1U_N7_QBC_AD4N_67
set_property PACKAGE_PIN BK26     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L10P_T1U_N6_QBC_AD4P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L10P_T1U_N6_QBC_AD4P_67
set_property PACKAGE_PIN BK28     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L9N_T1L_N5_AD12N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L9N_T1L_N5_AD12N_67
set_property PACKAGE_PIN BJ28     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L9P_T1L_N4_AD12P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L9P_T1L_N4_AD12P_67
set_property PACKAGE_PIN BL26     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L8N_T1L_N3_AD5N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L8N_T1L_N3_AD5N_67
set_property PACKAGE_PIN BL27     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L8P_T1L_N2_AD5P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L8P_T1L_N2_AD5P_67
set_property PACKAGE_PIN BM27     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L7N_T1L_N1_QBC_AD13N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L7N_T1L_N1_QBC_AD13N_67
set_property PACKAGE_PIN BL28     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L7P_T1L_N0_QBC_AD13P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L7P_T1L_N0_QBC_AD13P_67
set_property PACKAGE_PIN BN27     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_T1U_N12_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_T1U_N12_67
set_property PACKAGE_PIN BP27     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_T0U_N12_VRP_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_T0U_N12_VRP_67
set_property PACKAGE_PIN BN22     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L6N_T0U_N11_AD6N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L6N_T0U_N11_AD6N_67
set_property PACKAGE_PIN BM22     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L6P_T0U_N10_AD6P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L6P_T0U_N10_AD6P_67
set_property PACKAGE_PIN BM23     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L5N_T0U_N9_AD14N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L5N_T0U_N9_AD14N_67
set_property PACKAGE_PIN BM24     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L5P_T0U_N8_AD14P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L5P_T0U_N8_AD14P_67
set_property PACKAGE_PIN BN25     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L4N_T0U_N7_DBC_AD7N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L4N_T0U_N7_DBC_AD7N_67
set_property PACKAGE_PIN BM25     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L4P_T0U_N6_DBC_AD7P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L4P_T0U_N6_DBC_AD7P_67
set_property PACKAGE_PIN BP24     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L3N_T0L_N5_AD15N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L3N_T0L_N5_AD15N_67
set_property PACKAGE_PIN BN24     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L3P_T0L_N4_AD15P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L3P_T0L_N4_AD15P_67
set_property PACKAGE_PIN BP26     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L2N_T0L_N3_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L2N_T0L_N3_67
set_property PACKAGE_PIN BN26     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L2P_T0L_N2_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L2P_T0L_N2_67
set_property PACKAGE_PIN BP22     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L1N_T0L_N1_DBC_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L1N_T0L_N1_DBC_67
set_property PACKAGE_PIN BP23     [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L1P_T0L_N0_DBC_67
set_property IOSTANDARD  LVCMOS18 [get_ports "No Connect"] ;# Bank  67 VCCO - VCC1V8   - IO_L1P_T0L_N0_DBC_67
set_property PACKAGE_PIN BE51         [get_ports "DDR4_C0_DQ42"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L24N_T3U_N11_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ42"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L24N_T3U_N11_66
set_property PACKAGE_PIN BD51         [get_ports "DDR4_C0_DQ43"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L24P_T3U_N10_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ43"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L24P_T3U_N10_66
set_property PACKAGE_PIN BE50         [get_ports "DDR4_C0_DQ40"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L23N_T3U_N9_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ40"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L23N_T3U_N9_66
set_property PACKAGE_PIN BE49         [get_ports "DDR4_C0_DQ41"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L23P_T3U_N8_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ41"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L23P_T3U_N8_66
set_property PACKAGE_PIN BF48            [get_ports "DDR4_C0_DQS_C10"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L22N_T3U_N7_DBC_AD0N_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C10"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L22N_T3U_N7_DBC_AD0N_66
set_property PACKAGE_PIN BF47            [get_ports "DDR4_C0_DQS_T10"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L22P_T3U_N6_DBC_AD0P_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T10"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L22P_T3U_N6_DBC_AD0P_66
set_property PACKAGE_PIN BF52         [get_ports "DDR4_C0_DQ44"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L21N_T3L_N5_AD8N_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ44"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L21N_T3L_N5_AD8N_66
set_property PACKAGE_PIN BF51         [get_ports "DDR4_C0_DQ45"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L21P_T3L_N4_AD8P_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ45"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L21P_T3L_N4_AD8P_66
set_property PACKAGE_PIN BG50         [get_ports "DDR4_C0_DQ46"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L20N_T3L_N3_AD1N_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ46"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L20N_T3L_N3_AD1N_66
set_property PACKAGE_PIN BF50         [get_ports "DDR4_C0_DQ47"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L20P_T3L_N2_AD1P_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ47"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L20P_T3L_N2_AD1P_66
set_property PACKAGE_PIN BG49            [get_ports "DDR4_C0_DQS_C11"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L19N_T3L_N1_DBC_AD9N_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C11"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L19N_T3L_N1_DBC_AD9N_66
set_property PACKAGE_PIN BG48            [get_ports "DDR4_C0_DQS_T11"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L19P_T3L_N0_DBC_AD9P_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T11"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L19P_T3L_N0_DBC_AD9P_66
set_property PACKAGE_PIN BG47     [get_ports "No Connect"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_T3U_N12_66
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_T3U_N12_66
set_property PACKAGE_PIN BF53     [get_ports "No Connect"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_T2U_N12_66
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_T2U_N12_66
set_property PACKAGE_PIN BE54         [get_ports "DDR4_C0_DQ67"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L18N_T2U_N11_AD2N_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ67"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L18N_T2U_N11_AD2N_66
set_property PACKAGE_PIN BE53         [get_ports "DDR4_C0_DQ66"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L18P_T2U_N10_AD2P_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ66"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L18P_T2U_N10_AD2P_66
set_property PACKAGE_PIN BG54         [get_ports "DDR4_C0_DQ64"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L17N_T2U_N9_AD10N_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ64"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L17N_T2U_N9_AD10N_66
set_property PACKAGE_PIN BG53         [get_ports "DDR4_C0_DQ65"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L17P_T2U_N8_AD10P_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ65"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L17P_T2U_N8_AD10P_66
set_property PACKAGE_PIN BJ54            [get_ports "DDR4_C0_DQS_C16"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L16N_T2U_N7_QBC_AD3N_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C16"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L16N_T2U_N7_QBC_AD3N_66
set_property PACKAGE_PIN BH54            [get_ports "DDR4_C0_DQS_T16"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L16P_T2U_N6_QBC_AD3P_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T16"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L16P_T2U_N6_QBC_AD3P_66
set_property PACKAGE_PIN BK54         [get_ports "DDR4_C0_DQ70"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L15N_T2L_N5_AD11N_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ70"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L15N_T2L_N5_AD11N_66
set_property PACKAGE_PIN BK53         [get_ports "DDR4_C0_DQ71"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L15P_T2L_N4_AD11P_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ71"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L15P_T2L_N4_AD11P_66
set_property PACKAGE_PIN BH52         [get_ports "DDR4_C0_DQ68"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L14N_T2L_N3_GC_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ68"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L14N_T2L_N3_GC_66
set_property PACKAGE_PIN BG52         [get_ports "DDR4_C0_DQ69"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L14P_T2L_N2_GC_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ69"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L14P_T2L_N2_GC_66
set_property PACKAGE_PIN BJ53            [get_ports "DDR4_C0_DQS_C17"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L13N_T2L_N1_GC_QBC_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C17"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L13N_T2L_N1_GC_QBC_66
set_property PACKAGE_PIN BJ52            [get_ports "DDR4_C0_DQS_T17"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L13P_T2L_N0_GC_QBC_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T17"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L13P_T2L_N0_GC_QBC_66
set_property PACKAGE_PIN BH50         [get_ports "DDR4_C0_DQ48"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L12N_T1U_N11_GC_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ48"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L12N_T1U_N11_GC_66
set_property PACKAGE_PIN BH49         [get_ports "DDR4_C0_DQ51"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L12P_T1U_N10_GC_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ51"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L12P_T1U_N10_GC_66
set_property PACKAGE_PIN BJ51         [get_ports "DDR4_C0_DQ49"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L11N_T1U_N9_GC_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ49"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L11N_T1U_N9_GC_66
set_property PACKAGE_PIN BH51         [get_ports "DDR4_C0_DQ50"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L11P_T1U_N8_GC_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ50"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L11P_T1U_N8_GC_66
set_property PACKAGE_PIN BJ47            [get_ports "DDR4_C0_DQS_C12"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L10N_T1U_N7_QBC_AD4N_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C12"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L10N_T1U_N7_QBC_AD4N_66
set_property PACKAGE_PIN BH47            [get_ports "DDR4_C0_DQS_T12"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L10P_T1U_N6_QBC_AD4P_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T12"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L10P_T1U_N6_QBC_AD4P_66
set_property PACKAGE_PIN BJ49         [get_ports "DDR4_C0_DQ54"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L9N_T1L_N5_AD12N_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ54"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L9N_T1L_N5_AD12N_66
set_property PACKAGE_PIN BJ48         [get_ports "DDR4_C0_DQ55"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L9P_T1L_N4_AD12P_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ55"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L9P_T1L_N4_AD12P_66
set_property PACKAGE_PIN BK51         [get_ports "DDR4_C0_DQ53"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L8N_T1L_N3_AD5N_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ53"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L8N_T1L_N3_AD5N_66
set_property PACKAGE_PIN BK50         [get_ports "DDR4_C0_DQ52"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L8P_T1L_N2_AD5P_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ52"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L8P_T1L_N2_AD5P_66
set_property PACKAGE_PIN BK49            [get_ports "DDR4_C0_DQS_C13"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L7N_T1L_N1_QBC_AD13N_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C13"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L7N_T1L_N1_QBC_AD13N_66
set_property PACKAGE_PIN BK48            [get_ports "DDR4_C0_DQS_T13"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L7P_T1L_N0_QBC_AD13P_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T13"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L7P_T1L_N0_QBC_AD13P_66
set_property PACKAGE_PIN BL48         [get_ports "No Connect"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_T1U_N12_66
set_property IOSTANDARD  LVCMOS12     [get_ports "No Connect"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_T1U_N12_66
set_property PACKAGE_PIN BL50         [get_ports "VRP_61"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_T0U_N12_VRP_66
set_property IOSTANDARD  POD12_DCI    [get_ports "VRP_61"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_T0U_N12_VRP_66
set_property PACKAGE_PIN BL53         [get_ports "DDR4_C0_DQ33"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L6N_T0U_N11_AD6N_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ33"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L6N_T0U_N11_AD6N_66
set_property PACKAGE_PIN BL52         [get_ports "DDR4_C0_DQ34"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L6P_T0U_N10_AD6P_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ34"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L6P_T0U_N10_AD6P_66
set_property PACKAGE_PIN BM52         [get_ports "DDR4_C0_DQ32"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L5N_T0U_N9_AD14N_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ32"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L5N_T0U_N9_AD14N_66
set_property PACKAGE_PIN BL51         [get_ports "DDR4_C0_DQ35"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L5P_T0U_N8_AD14P_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ35"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L5P_T0U_N8_AD14P_66
set_property PACKAGE_PIN BM50            [get_ports "DDR4_C0_DQS_C8"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L4N_T0U_N7_DBC_AD7N_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C8"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L4N_T0U_N7_DBC_AD7N_66
set_property PACKAGE_PIN BM49            [get_ports "DDR4_C0_DQS_T8"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L4P_T0U_N6_DBC_AD7P_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T8"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L4P_T0U_N6_DBC_AD7P_66
set_property PACKAGE_PIN BN49         [get_ports "DDR4_C0_DQ38"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L3N_T0L_N5_AD15N_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ38"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L3N_T0L_N5_AD15N_66
set_property PACKAGE_PIN BM48         [get_ports "DDR4_C0_DQ39"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L3P_T0L_N4_AD15P_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ39"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L3P_T0L_N4_AD15P_66
set_property PACKAGE_PIN BN51         [get_ports "DDR4_C0_DQ37"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L2N_T0L_N3_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ37"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L2N_T0L_N3_66
set_property PACKAGE_PIN BN50         [get_ports "DDR4_C0_DQ36"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L2P_T0L_N2_66
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ36"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L2P_T0L_N2_66
set_property PACKAGE_PIN BP49            [get_ports "DDR4_C0_DQS_C9"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L1N_T0L_N1_DBC_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C9"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L1N_T0L_N1_DBC_66
set_property PACKAGE_PIN BP48            [get_ports "DDR4_C0_DQS_T9"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L1P_T0L_N0_DBC_66
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T9"] ;# Bank  66 VCCO - VCC1V2_TOP - IO_L1P_T0L_N0_DBC_66
set_property PACKAGE_PIN BE44         [get_ports "DDR4_C0_ADR13"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L24N_T3U_N11_DOUT_CSO_B_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR13"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L24N_T3U_N11_DOUT_CSO_B_65
set_property PACKAGE_PIN BE43         [get_ports "DDR4_C0_ADR14"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L24P_T3U_N10_EMCCLK_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR14"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L24P_T3U_N10_EMCCLK_65
set_property PACKAGE_PIN BD42         [get_ports "DDR4_C0_CS_B2"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L23N_T3U_N9_PERSTN1_I2C_SDA_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_CS_B2"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L23N_T3U_N9_PERSTN1_I2C_SDA_65
set_property PACKAGE_PIN BC42         [get_ports "DDR4_C0_ALERT_B"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L23P_T3U_N8_I2C_SCLK_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ALERT_B"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L23P_T3U_N8_I2C_SCLK_65
set_property PACKAGE_PIN BE46         [get_ports "DDR4_C0_ODT1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L22N_T3U_N7_DBC_AD0N_D05_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ODT1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L22N_T3U_N7_DBC_AD0N_D05_65
set_property PACKAGE_PIN BE45         [get_ports "DDR4_C0_CS_B1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L22P_T3U_N6_DBC_AD0P_D04_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_CS_B1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L22P_T3U_N6_DBC_AD0P_D04_65
set_property PACKAGE_PIN BF43         [get_ports "DDR4_C0_ADR5"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L21N_T3L_N5_AD8N_D07_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR5"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L21N_T3L_N5_AD8N_D07_65
set_property PACKAGE_PIN BF42         [get_ports "DDR4_C0_ADR3"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L21P_T3L_N4_AD8P_D06_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR3"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L21P_T3L_N4_AD8P_D06_65
set_property PACKAGE_PIN BF46         [get_ports "DDR4_C0_ADR0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L20N_T3L_N3_AD1N_D09_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L20N_T3L_N3_AD1N_D09_65
set_property PACKAGE_PIN BF45         [get_ports "DDR4_C0_PAR"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L20P_T3L_N2_AD1P_D08_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_PAR"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L20P_T3L_N2_AD1P_D08_65
set_property PACKAGE_PIN BE41         [get_ports "DDR4_C0_BG1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L19N_T3L_N1_DBC_AD9N_D11_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_BG1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L19N_T3L_N1_DBC_AD9N_D11_65
set_property PACKAGE_PIN BD41         [get_ports "DDR4_C0_ADR11"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L19P_T3L_N0_DBC_AD9P_D10_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR11"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L19P_T3L_N0_DBC_AD9P_D10_65
set_property PACKAGE_PIN BF41         [get_ports "DDR4_C0_BG0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_T3U_N12_PERSTN0_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_BG0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_T3U_N12_PERSTN0_65
set_property PACKAGE_PIN BH41         [get_ports "DDR4_C0_ACT_B"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_T2U_N12_CSI_ADV_B_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ACT_B"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_T2U_N12_CSI_ADV_B_65
set_property PACKAGE_PIN BG45         [get_ports "DDR4_C0_ADR10"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L18N_T2U_N11_AD2N_D13_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR10"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L18N_T2U_N11_AD2N_D13_65
set_property PACKAGE_PIN BG44         [get_ports "DDR4_C0_ODT0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L18P_T2U_N10_AD2P_D12_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ODT0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L18P_T2U_N10_AD2P_D12_65
set_property PACKAGE_PIN BG43         [get_ports "DDR4_C0_ADR1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L17N_T2U_N9_AD10N_D15_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L17N_T2U_N9_AD10N_D15_65
set_property PACKAGE_PIN BG42         [get_ports "DDR4_C0_ADR6"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L17P_T2U_N8_AD10P_D14_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR6"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L17P_T2U_N8_AD10P_D14_65
set_property PACKAGE_PIN BJ46         [get_ports "DDR4_C0_CK_C0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L16N_T2U_N7_QBC_AD3N_A01_D17_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_CK_C0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L16N_T2U_N7_QBC_AD3N_A01_D17_65
set_property PACKAGE_PIN BH46         [get_ports "DDR4_C0_CK_T0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L16P_T2U_N6_QBC_AD3P_A00_D16_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_CK_T0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L16P_T2U_N6_QBC_AD3P_A00_D16_65
set_property PACKAGE_PIN BK41         [get_ports "DDR4_C0_CK_C1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L15N_T2L_N5_AD11N_A03_D19_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_CK_C1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L15N_T2L_N5_AD11N_A03_D19_65
set_property PACKAGE_PIN BJ41         [get_ports "DDR4_C0_CK_T1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L15P_T2L_N4_AD11P_A02_D18_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_CK_T1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L15P_T2L_N4_AD11P_A02_D18_65
set_property PACKAGE_PIN BH45         [get_ports "DDR4_C0_BA0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L14N_T2L_N3_GC_A05_D21_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_BA0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L14N_T2L_N3_GC_A05_D21_65
set_property PACKAGE_PIN BH44         [get_ports "DDR4_C0_ADR16"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L14P_T2L_N2_GC_A04_D20_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR16"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L14P_T2L_N2_GC_A04_D20_65
set_property PACKAGE_PIN BJ42         [get_ports "DDR4_C0_CKE1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L13N_T2L_N1_GC_QBC_A07_D23_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_CKE1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L13N_T2L_N1_GC_QBC_A07_D23_65
set_property PACKAGE_PIN BH42         [get_ports "DDR4_C0_CKE0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L13P_T2L_N0_GC_QBC_A06_D22_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_CKE0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L13P_T2L_N0_GC_QBC_A06_D22_65

# -- renaming pins according wrapper ports names given by Vivado
# set_property PACKAGE_PIN BJ44         [get_ports "SYSCLK0_N"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L12N_T1U_N11_GC_A09_D25_65
# set_property IOSTANDARD  DIFF_SSTL12_DCI [get_ports "SYSCLK0_N"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L12N_T1U_N11_GC_A09_D25_65
# set_property PACKAGE_PIN BJ43         [get_ports "SYSCLK0_P"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L12P_T1U_N10_GC_A08_D24_65
# set_property IOSTANDARD  DIFF_SSTL12_DCI [get_ports "SYSCLK0_P"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L12P_T1U_N10_GC_A08_D24_65

set_property PACKAGE_PIN BJ44            [get_ports "sysclk0_clk_n"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L12N_T1U_N11_GC_A09_D25_65
set_property IOSTANDARD  DIFF_SSTL12_DCI [get_ports "sysclk0_clk_n"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L12N_T1U_N11_GC_A09_D25_65
set_property PACKAGE_PIN BJ43            [get_ports "sysclk0_clk_p"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L12P_T1U_N10_GC_A08_D24_65
set_property IOSTANDARD  DIFF_SSTL12_DCI [get_ports "sysclk0_clk_p"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L12P_T1U_N10_GC_A08_D24_65
# ---------------------------

set_property PACKAGE_PIN BK44         [get_ports "DDR4_C0_CS_B3"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L11N_T1U_N9_GC_A11_D27_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_CS_B3"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L11N_T1U_N9_GC_A11_D27_65
set_property PACKAGE_PIN BK43         [get_ports "DDR4_C0_ADR8"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L11P_T1U_N8_GC_A10_D26_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR8"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L11P_T1U_N8_GC_A10_D26_65
set_property PACKAGE_PIN BK46         [get_ports "DDR4_C0_CS_B0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L10N_T1U_N7_QBC_AD4N_A13_D29_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_CS_B0"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L10N_T1U_N7_QBC_AD4N_A13_D29_65
set_property PACKAGE_PIN BK45         [get_ports "DDR4_C0_ADR2"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L10P_T1U_N6_QBC_AD4P_A12_D28_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR2"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L10P_T1U_N6_QBC_AD4P_A12_D28_65
set_property PACKAGE_PIN BL43         [get_ports "DDR4_C0_ADR7"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L9N_T1L_N5_AD12N_A15_D31_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR7"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L9N_T1L_N5_AD12N_A15_D31_65
set_property PACKAGE_PIN BL42         [get_ports "DDR4_C0_ADR12"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L9P_T1L_N4_AD12P_A14_D30_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR12"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L9P_T1L_N4_AD12P_A14_D30_65
set_property PACKAGE_PIN BL46         [get_ports "DDR4_C0_ADR15"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L8N_T1L_N3_AD5N_A17_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR15"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L8N_T1L_N3_AD5N_A17_65
set_property PACKAGE_PIN BL45         [get_ports "DDR4_C0_ADR4"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L8P_T1L_N2_AD5P_A16_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR4"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L8P_T1L_N2_AD5P_A16_65
set_property PACKAGE_PIN BM47         [get_ports "DDR4_C0_BA1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L7N_T1L_N1_QBC_AD13N_A19_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_BA1"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L7N_T1L_N1_QBC_AD13N_A19_65
set_property PACKAGE_PIN BL47         [get_ports "DDR4_C0_ADR17"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L7P_T1L_N0_QBC_AD13P_A18_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR17"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L7P_T1L_N0_QBC_AD13P_A18_65
set_property PACKAGE_PIN BM42         [get_ports "DDR4_C0_ADR9"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_T1U_N12_SMBALERT_65
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_ADR9"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_T1U_N12_SMBALERT_65
set_property PACKAGE_PIN BM43       [get_ports "VRP_63"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_T0U_N12_VRP_A28_65
set_property IOSTANDARD  POD12_DCI  [get_ports "VRP_63"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_T0U_N12_VRP_A28_65
set_property PACKAGE_PIN BN45         [get_ports "DDR4_C0_DQ57"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L6N_T0U_N11_AD6N_A21_65
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ57"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L6N_T0U_N11_AD6N_A21_65
set_property PACKAGE_PIN BM45         [get_ports "DDR4_C0_DQ59"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L6P_T0U_N10_AD6P_A20_65
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ59"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L6P_T0U_N10_AD6P_A20_65
set_property PACKAGE_PIN BN44         [get_ports "DDR4_C0_DQ56"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L5N_T0U_N9_AD14N_A23_65
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ56"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L5N_T0U_N9_AD14N_A23_65
set_property PACKAGE_PIN BM44         [get_ports "DDR4_C0_DQ58"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L5P_T0U_N8_AD14P_A22_65
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ58"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L5P_T0U_N8_AD14P_A22_65
set_property PACKAGE_PIN BP46            [get_ports "DDR4_C0_DQS_C14"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L4N_T0U_N7_DBC_AD7N_A25_65
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C14"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L4N_T0U_N7_DBC_AD7N_A25_65
set_property PACKAGE_PIN BN46            [get_ports "DDR4_C0_DQS_T14"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L4P_T0U_N6_DBC_AD7P_A24_65
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T14"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L4P_T0U_N6_DBC_AD7P_A24_65
set_property PACKAGE_PIN BP44         [get_ports "DDR4_C0_DQ61"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L3N_T0L_N5_AD15N_A27_65
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ61"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L3N_T0L_N5_AD15N_A27_65
set_property PACKAGE_PIN BP43         [get_ports "DDR4_C0_DQ60"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L3P_T0L_N4_AD15P_A26_65
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ60"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L3P_T0L_N4_AD15P_A26_65
set_property PACKAGE_PIN BP47         [get_ports "DDR4_C0_DQ63"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L2N_T0L_N3_FWE_FCS2_B_65
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ63"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L2N_T0L_N3_FWE_FCS2_B_65
set_property PACKAGE_PIN BN47         [get_ports "DDR4_C0_DQ62"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L2P_T0L_N2_FOE_B_65
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ62"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L2P_T0L_N2_FOE_B_65
set_property PACKAGE_PIN BP42            [get_ports "DDR4_C0_DQS_C15"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L1N_T0L_N1_DBC_RS1_65
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C15"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L1N_T0L_N1_DBC_RS1_65
set_property PACKAGE_PIN BN42            [get_ports "DDR4_C0_DQS_T15"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L1P_T0L_N0_DBC_RS0_65
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T15"] ;# Bank  65 VCCO - VCC1V2_TOP - IO_L1P_T0L_N0_DBC_RS0_65
set_property PACKAGE_PIN BJ31         [get_ports "DDR4_C0_DQ8"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L24N_T3U_N11_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ8"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L24N_T3U_N11_64
set_property PACKAGE_PIN BH31         [get_ports "DDR4_C0_DQ9"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L24P_T3U_N10_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ9"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L24P_T3U_N10_64
set_property PACKAGE_PIN BF33         [get_ports "DDR4_C0_DQ11"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L23N_T3U_N9_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ11"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L23N_T3U_N9_64
set_property PACKAGE_PIN BF32         [get_ports "DDR4_C0_DQ10"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L23P_T3U_N8_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ10"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L23P_T3U_N8_64
set_property PACKAGE_PIN BK30            [get_ports "DDR4_C0_DQS_C2"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L22N_T3U_N7_DBC_AD0N_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C2"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L22N_T3U_N7_DBC_AD0N_64
set_property PACKAGE_PIN BJ29            [get_ports "DDR4_C0_DQS_T2"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L22P_T3U_N6_DBC_AD0P_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T2"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L22P_T3U_N6_DBC_AD0P_64
set_property PACKAGE_PIN BG32         [get_ports "DDR4_C0_DQ15"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L21N_T3L_N5_AD8N_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ15"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L21N_T3L_N5_AD8N_64
set_property PACKAGE_PIN BF31         [get_ports "DDR4_C0_DQ14"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L21P_T3L_N4_AD8P_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ14"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L21P_T3L_N4_AD8P_64
set_property PACKAGE_PIN BH30         [get_ports "DDR4_C0_DQ13"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L20N_T3L_N3_AD1N_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ13"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L20N_T3L_N3_AD1N_64
set_property PACKAGE_PIN BH29         [get_ports "DDR4_C0_DQ12"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L20P_T3L_N2_AD1P_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ12"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L20P_T3L_N2_AD1P_64
set_property PACKAGE_PIN BG30            [get_ports "DDR4_C0_DQS_C3"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L19N_T3L_N1_DBC_AD9N_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C3"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L19N_T3L_N1_DBC_AD9N_64
set_property PACKAGE_PIN BG29            [get_ports "DDR4_C0_DQS_T3"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L19P_T3L_N0_DBC_AD9P_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T3"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L19P_T3L_N0_DBC_AD9P_64
set_property PACKAGE_PIN BK29         [get_ports "DDR4_C0_EVENT_B"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_T3U_N12_64
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C0_EVENT_B"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_T3U_N12_64
set_property PACKAGE_PIN BG33         [get_ports "DDR4_C0_RESET_N"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_T2U_N12_64
set_property IOSTANDARD  LVCMOS12     [get_ports "DDR4_C0_RESET_N"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_T2U_N12_64
set_property PACKAGE_PIN BH35         [get_ports "DDR4_C0_DQ25"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L18N_T2U_N11_AD2N_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ25"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L18N_T2U_N11_AD2N_64
set_property PACKAGE_PIN BH34         [get_ports "DDR4_C0_DQ24"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L18P_T2U_N10_AD2P_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ24"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L18P_T2U_N10_AD2P_64
set_property PACKAGE_PIN BF36         [get_ports "DDR4_C0_DQ27"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L17N_T2U_N9_AD10N_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ27"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L17N_T2U_N9_AD10N_64
set_property PACKAGE_PIN BF35         [get_ports "DDR4_C0_DQ26"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L17P_T2U_N8_AD10P_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ26"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L17P_T2U_N8_AD10P_64
set_property PACKAGE_PIN BK35            [get_ports "DDR4_C0_DQS_C6"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L16N_T2U_N7_QBC_AD3N_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C6"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L16N_T2U_N7_QBC_AD3N_64
set_property PACKAGE_PIN BK34            [get_ports "DDR4_C0_DQS_T6"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L16P_T2U_N6_QBC_AD3P_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T6"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L16P_T2U_N6_QBC_AD3P_64
set_property PACKAGE_PIN BG35         [get_ports "DDR4_C0_DQ31"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L15N_T2L_N5_AD11N_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ31"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L15N_T2L_N5_AD11N_64
set_property PACKAGE_PIN BG34         [get_ports "DDR4_C0_DQ30"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L15P_T2L_N4_AD11P_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ30"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L15P_T2L_N4_AD11P_64
set_property PACKAGE_PIN BJ34         [get_ports "DDR4_C0_DQ29"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L14N_T2L_N3_GC_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ29"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L14N_T2L_N3_GC_64
set_property PACKAGE_PIN BJ33         [get_ports "DDR4_C0_DQ28"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L14P_T2L_N2_GC_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ28"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L14P_T2L_N2_GC_64
set_property PACKAGE_PIN BJ32            [get_ports "DDR4_C0_DQS_C7"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L13N_T2L_N1_GC_QBC_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C7"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L13N_T2L_N1_GC_QBC_64
set_property PACKAGE_PIN BH32            [get_ports "DDR4_C0_DQS_T7"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L13P_T2L_N0_GC_QBC_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T7"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L13P_T2L_N0_GC_QBC_64
set_property PACKAGE_PIN BL33         [get_ports "DDR4_C0_DQ19"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L12N_T1U_N11_GC_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ19"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L12N_T1U_N11_GC_64
set_property PACKAGE_PIN BK33         [get_ports "DDR4_C0_DQ18"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L12P_T1U_N10_GC_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ18"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L12P_T1U_N10_GC_64
set_property PACKAGE_PIN BL31         [get_ports "DDR4_C0_DQ17"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L11N_T1U_N9_GC_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ17"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L11N_T1U_N9_GC_64
set_property PACKAGE_PIN BK31         [get_ports "DDR4_C0_DQ16"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L11P_T1U_N8_GC_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ16"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L11P_T1U_N8_GC_64
set_property PACKAGE_PIN BM35            [get_ports "DDR4_C0_DQS_C4"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L10N_T1U_N7_QBC_AD4N_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C4"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L10N_T1U_N7_QBC_AD4N_64
set_property PACKAGE_PIN BL35            [get_ports "DDR4_C0_DQS_T4"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L10P_T1U_N6_QBC_AD4P_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T4"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L10P_T1U_N6_QBC_AD4P_64
set_property PACKAGE_PIN BM33         [get_ports "DDR4_C0_DQ21"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L9N_T1L_N5_AD12N_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ21"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L9N_T1L_N5_AD12N_64
set_property PACKAGE_PIN BL32         [get_ports "DDR4_C0_DQ20"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L9P_T1L_N4_AD12P_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ20"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L9P_T1L_N4_AD12P_64
set_property PACKAGE_PIN BP34         [get_ports "DDR4_C0_DQ23"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L8N_T1L_N3_AD5N_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ23"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L8N_T1L_N3_AD5N_64
set_property PACKAGE_PIN BN34         [get_ports "DDR4_C0_DQ22"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L8P_T1L_N2_AD5P_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ22"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L8P_T1L_N2_AD5P_64
set_property PACKAGE_PIN BN35            [get_ports "DDR4_C0_DQS_C5"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L7N_T1L_N1_QBC_AD13N_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C5"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L7N_T1L_N1_QBC_AD13N_64
set_property PACKAGE_PIN BM34            [get_ports "DDR4_C0_DQS_T5"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L7P_T1L_N0_QBC_AD13P_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T5"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L7P_T1L_N0_QBC_AD13P_64
set_property PACKAGE_PIN BP33     [get_ports "No Connect"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_T1U_N12_64
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_T1U_N12_64
set_property PACKAGE_PIN BM32       [get_ports "VRP_62"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_T0U_N12_VRP_64
set_property IOSTANDARD  POD12_DCI  [get_ports "VRP_62"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_T0U_N12_VRP_64
set_property PACKAGE_PIN BP32         [get_ports "DDR4_C0_DQ1"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L6N_T0U_N11_AD6N_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ1"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L6N_T0U_N11_AD6N_64
set_property PACKAGE_PIN BN32         [get_ports "DDR4_C0_DQ0"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L6P_T0U_N10_AD6P_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ0"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L6P_T0U_N10_AD6P_64
set_property PACKAGE_PIN BM30         [get_ports "DDR4_C0_DQ3"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L5N_T0U_N9_AD14N_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ3"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L5N_T0U_N9_AD14N_64
set_property PACKAGE_PIN BL30         [get_ports "DDR4_C0_DQ2"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L5P_T0U_N8_AD14P_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ2"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L5P_T0U_N8_AD14P_64
set_property PACKAGE_PIN BN30            [get_ports "DDR4_C0_DQS_C0"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L4N_T0U_N7_DBC_AD7N_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C0"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L4N_T0U_N7_DBC_AD7N_64
set_property PACKAGE_PIN BN29            [get_ports "DDR4_C0_DQS_T0"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L4P_T0U_N6_DBC_AD7P_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T0"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L4P_T0U_N6_DBC_AD7P_64
set_property PACKAGE_PIN BP31         [get_ports "DDR4_C0_DQ6"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L3N_T0L_N5_AD15N_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ6"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L3N_T0L_N5_AD15N_64
set_property PACKAGE_PIN BN31         [get_ports "DDR4_C0_DQ7"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L3P_T0L_N4_AD15P_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ7"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L3P_T0L_N4_AD15P_64
set_property PACKAGE_PIN BP29         [get_ports "DDR4_C0_DQ4"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L2N_T0L_N3_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ4"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L2N_T0L_N3_64
set_property PACKAGE_PIN BP28         [get_ports "DDR4_C0_DQ5"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L2P_T0L_N2_64
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C0_DQ5"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L2P_T0L_N2_64
set_property PACKAGE_PIN BM29            [get_ports "DDR4_C0_DQS_C1"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L1N_T0L_N1_DBC_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_C1"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L1N_T0L_N1_DBC_64
set_property PACKAGE_PIN BM28            [get_ports "DDR4_C0_DQS_T1"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L1P_T0L_N0_DBC_64
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C0_DQS_T1"] ;# Bank  64 VCCO - VCC1V2_TOP - IO_L1P_T0L_N0_DBC_64
set_property PACKAGE_PIN A16      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L24N_T3U_N11_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L24N_T3U_N11_71
set_property PACKAGE_PIN B16      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L24P_T3U_N10_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L24P_T3U_N10_71
set_property PACKAGE_PIN A18      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L23N_T3U_N9_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L23N_T3U_N9_71
set_property PACKAGE_PIN A19      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L23P_T3U_N8_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L23P_T3U_N8_71
set_property PACKAGE_PIN A20      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L22N_T3U_N7_DBC_AD0N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L22N_T3U_N7_DBC_AD0N_71
set_property PACKAGE_PIN A21      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L22P_T3U_N6_DBC_AD0P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L22P_T3U_N6_DBC_AD0P_71
set_property PACKAGE_PIN B17      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L21N_T3L_N5_AD8N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L21N_T3L_N5_AD8N_71
set_property PACKAGE_PIN B18      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L21P_T3L_N4_AD8P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L21P_T3L_N4_AD8P_71
set_property PACKAGE_PIN B20      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L20N_T3L_N3_AD1N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L20N_T3L_N3_AD1N_71
set_property PACKAGE_PIN B21      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L20P_T3L_N2_AD1P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L20P_T3L_N2_AD1P_71
set_property PACKAGE_PIN C17      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L19N_T3L_N1_DBC_AD9N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L19N_T3L_N1_DBC_AD9N_71
set_property PACKAGE_PIN C18      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L19P_T3L_N0_DBC_AD9P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L19P_T3L_N0_DBC_AD9P_71
set_property PACKAGE_PIN C19      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_T3U_N12_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_T3U_N12_71
set_property PACKAGE_PIN C20      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_T2U_N12_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_T2U_N12_71
set_property PACKAGE_PIN D19      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L18N_T2U_N11_AD2N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L18N_T2U_N11_AD2N_71
set_property PACKAGE_PIN D20      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L18P_T2U_N10_AD2P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L18P_T2U_N10_AD2P_71
set_property PACKAGE_PIN D16      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L17N_T2U_N9_AD10N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L17N_T2U_N9_AD10N_71
set_property PACKAGE_PIN D17      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L17P_T2U_N8_AD10P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L17P_T2U_N8_AD10P_71
set_property PACKAGE_PIN D21      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L16N_T2U_N7_QBC_AD3N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L16N_T2U_N7_QBC_AD3N_71
set_property PACKAGE_PIN E21      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L16P_T2U_N6_QBC_AD3P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L16P_T2U_N6_QBC_AD3P_71
set_property PACKAGE_PIN E16      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L15N_T2L_N5_AD11N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L15N_T2L_N5_AD11N_71
set_property PACKAGE_PIN F16      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L15P_T2L_N4_AD11P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L15P_T2L_N4_AD11P_71
set_property PACKAGE_PIN E18      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L14N_T2L_N3_GC_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L14N_T2L_N3_GC_71
set_property PACKAGE_PIN E19      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L14P_T2L_N2_GC_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L14P_T2L_N2_GC_71
set_property PACKAGE_PIN E17      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L13N_T2L_N1_GC_QBC_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L13N_T2L_N1_GC_QBC_71
set_property PACKAGE_PIN F18      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L13P_T2L_N0_GC_QBC_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L13P_T2L_N0_GC_QBC_71
set_property PACKAGE_PIN F19      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L12N_T1U_N11_GC_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L12N_T1U_N11_GC_71
set_property PACKAGE_PIN F20      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L12P_T1U_N10_GC_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L12P_T1U_N10_GC_71
set_property PACKAGE_PIN G17      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L11N_T1U_N9_GC_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L11N_T1U_N9_GC_71
set_property PACKAGE_PIN G18      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L11P_T1U_N8_GC_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L11P_T1U_N8_GC_71
set_property PACKAGE_PIN F21      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L10N_T1U_N7_QBC_AD4N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L10N_T1U_N7_QBC_AD4N_71
set_property PACKAGE_PIN G21      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L10P_T1U_N6_QBC_AD4P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L10P_T1U_N6_QBC_AD4P_71
set_property PACKAGE_PIN H18      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L9N_T1L_N5_AD12N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L9N_T1L_N5_AD12N_71
set_property PACKAGE_PIN H19      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L9P_T1L_N4_AD12P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L9P_T1L_N4_AD12P_71
set_property PACKAGE_PIN G20      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L8N_T1L_N3_AD5N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L8N_T1L_N3_AD5N_71
set_property PACKAGE_PIN H20      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L8P_T1L_N2_AD5P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L8P_T1L_N2_AD5P_71
set_property PACKAGE_PIN G16      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L7N_T1L_N1_QBC_AD13N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L7N_T1L_N1_QBC_AD13N_71
set_property PACKAGE_PIN H17      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L7P_T1L_N0_QBC_AD13P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L7P_T1L_N0_QBC_AD13P_71
set_property PACKAGE_PIN J16      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_T1U_N12_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_T1U_N12_71
set_property PACKAGE_PIN J17      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_T0U_N12_VRP_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_T0U_N12_VRP_71
set_property PACKAGE_PIN J19      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L6N_T0U_N11_AD6N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L6N_T0U_N11_AD6N_71
set_property PACKAGE_PIN J20      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L6P_T0U_N10_AD6P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L6P_T0U_N10_AD6P_71
set_property PACKAGE_PIN J21      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L5N_T0U_N9_AD14N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L5N_T0U_N9_AD14N_71
set_property PACKAGE_PIN K21      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L5P_T0U_N8_AD14P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L5P_T0U_N8_AD14P_71
set_property PACKAGE_PIN K18      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L4N_T0U_N7_DBC_AD7N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L4N_T0U_N7_DBC_AD7N_71
set_property PACKAGE_PIN K19      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L4P_T0U_N6_DBC_AD7P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L4P_T0U_N6_DBC_AD7P_71
set_property PACKAGE_PIN L20      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L3N_T0L_N5_AD15N_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L3N_T0L_N5_AD15N_71
set_property PACKAGE_PIN L21      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L3P_T0L_N4_AD15P_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L3P_T0L_N4_AD15P_71
set_property PACKAGE_PIN L18      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L2N_T0L_N3_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L2N_T0L_N3_71
set_property PACKAGE_PIN L19      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L2P_T0L_N2_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L2P_T0L_N2_71
set_property PACKAGE_PIN K16      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L1N_T0L_N1_DBC_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L1N_T0L_N1_DBC_71
set_property PACKAGE_PIN K17      [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L1P_T0L_N0_DBC_71
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  71 VCCO - VCCO_71_F17 - IO_L1P_T0L_N0_DBC_71
set_property PACKAGE_PIN A8           [get_ports "DDR4_C1_DQ3"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L24N_T3U_N11_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ3"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L24N_T3U_N11_70
set_property PACKAGE_PIN A9           [get_ports "DDR4_C1_DQ2"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L24P_T3U_N10_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ2"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L24P_T3U_N10_70
set_property PACKAGE_PIN A10          [get_ports "DDR4_C1_DQ1"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L23N_T3U_N9_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ1"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L23N_T3U_N9_70
set_property PACKAGE_PIN A11          [get_ports "DDR4_C1_DQ0"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L23P_T3U_N8_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ0"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L23P_T3U_N8_70
set_property PACKAGE_PIN A13             [get_ports "DDR4_C1_DQS_C0"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L22N_T3U_N7_DBC_AD0N_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C0"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L22N_T3U_N7_DBC_AD0N_70
set_property PACKAGE_PIN B13             [get_ports "DDR4_C1_DQS_T0"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L22P_T3U_N6_DBC_AD0P_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T0"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L22P_T3U_N6_DBC_AD0P_70
set_property PACKAGE_PIN B12          [get_ports "DDR4_C1_DQ4"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L21N_T3L_N5_AD8N_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ4"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L21N_T3L_N5_AD8N_70
set_property PACKAGE_PIN C12          [get_ports "DDR4_C1_DQ6"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L21P_T3L_N4_AD8P_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ6"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L21P_T3L_N4_AD8P_70
set_property PACKAGE_PIN B10          [get_ports "DDR4_C1_DQ5"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L20N_T3L_N3_AD1N_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ5"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L20N_T3L_N3_AD1N_70
set_property PACKAGE_PIN B11          [get_ports "DDR4_C1_DQ7"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L20P_T3L_N2_AD1P_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ7"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L20P_T3L_N2_AD1P_70
set_property PACKAGE_PIN C9              [get_ports "DDR4_C1_DQS_C1"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L19N_T3L_N1_DBC_AD9N_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C1"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L19N_T3L_N1_DBC_AD9N_70
set_property PACKAGE_PIN C10             [get_ports "DDR4_C1_DQS_T1"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L19P_T3L_N0_DBC_AD9P_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T1"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L19P_T3L_N0_DBC_AD9P_70
set_property PACKAGE_PIN C13      [get_ports "No Connect"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_T3U_N12_70
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_T3U_N12_70
set_property PACKAGE_PIN C14      [get_ports "No Connect"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_T2U_N12_70
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_T2U_N12_70
set_property PACKAGE_PIN A14          [get_ports "DDR4_C1_DQ27"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L18N_T2U_N11_AD2N_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ27"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L18N_T2U_N11_AD2N_70
set_property PACKAGE_PIN A15          [get_ports "DDR4_C1_DQ25"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L18P_T2U_N10_AD2P_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ25"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L18P_T2U_N10_AD2P_70
set_property PACKAGE_PIN B15          [get_ports "DDR4_C1_DQ24"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L17N_T2U_N9_AD10N_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ24"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L17N_T2U_N9_AD10N_70
set_property PACKAGE_PIN C15          [get_ports "DDR4_C1_DQ26"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L17P_T2U_N8_AD10P_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ26"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L17P_T2U_N8_AD10P_70
set_property PACKAGE_PIN D14             [get_ports "DDR4_C1_DQS_C6"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L16N_T2U_N7_QBC_AD3N_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C6"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L16N_T2U_N7_QBC_AD3N_70
set_property PACKAGE_PIN D15             [get_ports "DDR4_C1_DQS_T6"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L16P_T2U_N6_QBC_AD3P_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T6"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L16P_T2U_N6_QBC_AD3P_70
set_property PACKAGE_PIN E14          [get_ports "DDR4_C1_DQ29"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L15N_T2L_N5_AD11N_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ29"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L15N_T2L_N5_AD11N_70
set_property PACKAGE_PIN F15          [get_ports "DDR4_C1_DQ31"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L15P_T2L_N4_AD11P_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ31"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L15P_T2L_N4_AD11P_70
set_property PACKAGE_PIN F13          [get_ports "DDR4_C1_DQ28"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L14N_T2L_N3_GC_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ28"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L14N_T2L_N3_GC_70
set_property PACKAGE_PIN F14          [get_ports "DDR4_C1_DQ30"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L14P_T2L_N2_GC_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ30"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L14P_T2L_N2_GC_70
set_property PACKAGE_PIN D12             [get_ports "DDR4_C1_DQS_C7"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L13N_T2L_N1_GC_QBC_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C7"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L13N_T2L_N1_GC_QBC_70
set_property PACKAGE_PIN E13             [get_ports "DDR4_C1_DQS_T7"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L13P_T2L_N0_GC_QBC_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T7"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L13P_T2L_N0_GC_QBC_70
set_property PACKAGE_PIN E11          [get_ports "DDR4_C1_DQ8"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L12N_T1U_N11_GC_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ8"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L12N_T1U_N11_GC_70
set_property PACKAGE_PIN F11          [get_ports "DDR4_C1_DQ11"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L12P_T1U_N10_GC_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ11"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L12P_T1U_N10_GC_70
set_property PACKAGE_PIN D11          [get_ports "DDR4_C1_DQ9"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L11N_T1U_N9_GC_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ9"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L11N_T1U_N9_GC_70
set_property PACKAGE_PIN E12          [get_ports "DDR4_C1_DQ10"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L11P_T1U_N8_GC_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ10"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L11P_T1U_N8_GC_70
set_property PACKAGE_PIN D9              [get_ports "DDR4_C1_DQS_C2"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L10N_T1U_N7_QBC_AD4N_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C2"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L10N_T1U_N7_QBC_AD4N_70
set_property PACKAGE_PIN D10             [get_ports "DDR4_C1_DQS_T2"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L10P_T1U_N6_QBC_AD4P_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T2"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L10P_T1U_N6_QBC_AD4P_70
set_property PACKAGE_PIN E9           [get_ports "DDR4_C1_DQ13"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L9N_T1L_N5_AD12N_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ13"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L9N_T1L_N5_AD12N_70
set_property PACKAGE_PIN F9           [get_ports "DDR4_C1_DQ14"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L9P_T1L_N4_AD12P_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ14"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L9P_T1L_N4_AD12P_70
set_property PACKAGE_PIN F10          [get_ports "DDR4_C1_DQ12"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L8N_T1L_N3_AD5N_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ12"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L8N_T1L_N3_AD5N_70
set_property PACKAGE_PIN G11          [get_ports "DDR4_C1_DQ15"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L8P_T1L_N2_AD5P_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ15"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L8P_T1L_N2_AD5P_70
set_property PACKAGE_PIN G10             [get_ports "DDR4_C1_DQS_C3"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L7N_T1L_N1_QBC_AD13N_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C3"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L7N_T1L_N1_QBC_AD13N_70
set_property PACKAGE_PIN H10             [get_ports "DDR4_C1_DQS_T3"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L7P_T1L_N0_QBC_AD13P_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T3"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L7P_T1L_N0_QBC_AD13P_70
set_property PACKAGE_PIN H9       [get_ports "No Connect"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_T1U_N12_70
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_T1U_N12_70
set_property PACKAGE_PIN G12        [get_ports "VRP_74"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_T0U_N12_VRP_70
set_property IOSTANDARD  POD12_DCI  [get_ports "VRP_74"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_T0U_N12_VRP_70
set_property PACKAGE_PIN G13          [get_ports "DDR4_C1_DQ17"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L6N_T0U_N11_AD6N_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ17"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L6N_T0U_N11_AD6N_70
set_property PACKAGE_PIN H14          [get_ports "DDR4_C1_DQ19"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L6P_T0U_N10_AD6P_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ19"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L6P_T0U_N10_AD6P_70
set_property PACKAGE_PIN H12          [get_ports "DDR4_C1_DQ16"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L5N_T0U_N9_AD14N_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ16"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L5N_T0U_N9_AD14N_70
set_property PACKAGE_PIN H13          [get_ports "DDR4_C1_DQ18"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L5P_T0U_N8_AD14P_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ18"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L5P_T0U_N8_AD14P_70
set_property PACKAGE_PIN G15             [get_ports "DDR4_C1_DQS_C4"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L4N_T0U_N7_DBC_AD7N_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C4"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L4N_T0U_N7_DBC_AD7N_70
set_property PACKAGE_PIN H15             [get_ports "DDR4_C1_DQS_T4"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L4P_T0U_N6_DBC_AD7P_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T4"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L4P_T0U_N6_DBC_AD7P_70
set_property PACKAGE_PIN J11          [get_ports "DDR4_C1_DQ20"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L3N_T0L_N5_AD15N_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ20"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L3N_T0L_N5_AD15N_70
set_property PACKAGE_PIN J12          [get_ports "DDR4_C1_DQ21"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L3P_T0L_N4_AD15P_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ21"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L3P_T0L_N4_AD15P_70
set_property PACKAGE_PIN J14          [get_ports "DDR4_C1_DQ23"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L2N_T0L_N3_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ23"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L2N_T0L_N3_70
set_property PACKAGE_PIN J15          [get_ports "DDR4_C1_DQ22"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L2P_T0L_N2_70
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ22"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L2P_T0L_N2_70
set_property PACKAGE_PIN K13             [get_ports "DDR4_C1_DQS_C5"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L1N_T0L_N1_DBC_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C5"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L1N_T0L_N1_DBC_70
set_property PACKAGE_PIN K14             [get_ports "DDR4_C1_DQS_T5"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L1P_T0L_N0_DBC_70
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T5"] ;# Bank  70 VCCO - VCC1V2_BTM - IO_L1P_T0L_N0_DBC_70
set_property PACKAGE_PIN BF1          [get_ports "DDR4_C1_CKE1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L24N_T3U_N11_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_CKE1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L24N_T3U_N11_69
set_property PACKAGE_PIN BE1          [get_ports "DDR4_C1_CKE0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L24P_T3U_N10_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_CKE0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L24P_T3U_N10_69
set_property PACKAGE_PIN BE3          [get_ports "DDR4_C1_ADR4"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L23N_T3U_N9_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR4"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L23N_T3U_N9_69
set_property PACKAGE_PIN BE4          [get_ports "DDR4_C1_ADR11"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L23P_T3U_N8_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR11"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L23P_T3U_N8_69
set_property PACKAGE_PIN BE5          [get_ports "DDR4_C1_ADR6"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L22N_T3U_N7_DBC_AD0N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR6"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L22N_T3U_N7_DBC_AD0N_69
set_property PACKAGE_PIN BE6          [get_ports "DDR4_C1_ADR5"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L22P_T3U_N6_DBC_AD0P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR5"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L22P_T3U_N6_DBC_AD0P_69
set_property PACKAGE_PIN BF2          [get_ports "DDR4_C1_BG1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L21N_T3L_N5_AD8N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_BG1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L21N_T3L_N5_AD8N_69
set_property PACKAGE_PIN BF3          [get_ports "DDR4_C1_BG0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L21P_T3L_N4_AD8P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_BG0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L21P_T3L_N4_AD8P_69
set_property PACKAGE_PIN BG2          [get_ports "DDR4_C1_ADR9"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L20N_T3L_N3_AD1N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR9"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L20N_T3L_N3_AD1N_69
set_property PACKAGE_PIN BG3          [get_ports "DDR4_C1_ACT_B"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L20P_T3L_N2_AD1P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ACT_B"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L20P_T3L_N2_AD1P_69
set_property PACKAGE_PIN BG4          [get_ports "DDR4_C1_CS_B3"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L19N_T3L_N1_DBC_AD9N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_CS_B3"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L19N_T3L_N1_DBC_AD9N_69
set_property PACKAGE_PIN BG5          [get_ports "DDR4_C1_CS_B2"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L19P_T3L_N0_DBC_AD9P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_CS_B2"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L19P_T3L_N0_DBC_AD9P_69
set_property PACKAGE_PIN BF5          [get_ports "DDR4_C1_ADR3"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_T3U_N12_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR3"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_T3U_N12_69
set_property PACKAGE_PIN BF6          [get_ports "DDR4_C1_ADR2"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_T2U_N12_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR2"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_T2U_N12_69
set_property PACKAGE_PIN BF7          [get_ports "DDR4_C1_ADR0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L18N_T2U_N11_AD2N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L18N_T2U_N11_AD2N_69
set_property PACKAGE_PIN BF8          [get_ports "DDR4_C1_ADR16"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L18P_T2U_N10_AD2P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR16"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L18P_T2U_N10_AD2P_69
set_property PACKAGE_PIN BG7          [get_ports "DDR4_C1_ADR7"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L17N_T2U_N9_AD10N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR7"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L17N_T2U_N9_AD10N_69
set_property PACKAGE_PIN BG8          [get_ports "DDR4_C1_BA0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L17P_T2U_N8_AD10P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_BA0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L17P_T2U_N8_AD10P_69
set_property PACKAGE_PIN BJ7          [get_ports "DDR4_C1_CK_C1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L16N_T2U_N7_QBC_AD3N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_CK_C1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L16N_T2U_N7_QBC_AD3N_69
set_property PACKAGE_PIN BH7          [get_ports "DDR4_C1_CK_T1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L16P_T2U_N6_QBC_AD3P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_CK_T1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L16P_T2U_N6_QBC_AD3P_69
set_property PACKAGE_PIN BK8          [get_ports "DDR4_C1_ADR14"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L15N_T2L_N5_AD11N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR14"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L15N_T2L_N5_AD11N_69
set_property PACKAGE_PIN BJ8          [get_ports "DDR4_C1_ADR10"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L15P_T2L_N4_AD11P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR10"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L15P_T2L_N4_AD11P_69
set_property PACKAGE_PIN BH4          [get_ports "DDR4_C1_ODT1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L14N_T2L_N3_GC_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ODT1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L14N_T2L_N3_GC_69
set_property PACKAGE_PIN BH5          [get_ports "DDR4_C1_CS_B1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L14P_T2L_N2_GC_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_CS_B1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L14P_T2L_N2_GC_69
set_property PACKAGE_PIN BJ6              [get_ports "SYSCLK1_N"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L13N_T2L_N1_GC_QBC_69
set_property IOSTANDARD  DIFF_SSTL12_DCI  [get_ports "SYSCLK1_N"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L13N_T2L_N1_GC_QBC_69
set_property PACKAGE_PIN BH6              [get_ports "SYSCLK1_P"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L13P_T2L_N0_GC_QBC_69
set_property IOSTANDARD  DIFF_SSTL12_DCI  [get_ports "SYSCLK1_P"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L13P_T2L_N0_GC_QBC_69
set_property PACKAGE_PIN BK4          [get_ports "DDR4_C1_BA1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L12N_T1U_N11_GC_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_BA1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L12N_T1U_N11_GC_69
set_property PACKAGE_PIN BK5          [get_ports "DDR4_C1_ADR13"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L12P_T1U_N10_GC_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR13"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L12P_T1U_N10_GC_69
set_property PACKAGE_PIN BK3          [get_ports "DDR4_C1_ALERT_B"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L11N_T1U_N9_GC_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ALERT_B"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L11N_T1U_N9_GC_69
set_property PACKAGE_PIN BJ4          [get_ports "DDR4_C1_ADR15"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L11P_T1U_N8_GC_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR15"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L11P_T1U_N8_GC_69
set_property PACKAGE_PIN BJ2          [get_ports "DDR4_C1_CK_C0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L10N_T1U_N7_QBC_AD4N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_CK_C0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L10N_T1U_N7_QBC_AD4N_69
set_property PACKAGE_PIN BJ3          [get_ports "DDR4_C1_CK_T0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L10P_T1U_N6_QBC_AD4P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_CK_T0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L10P_T1U_N6_QBC_AD4P_69
set_property PACKAGE_PIN BH1          [get_ports "DDR4_C1_PAR"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L9N_T1L_N5_AD12N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_PAR"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L9N_T1L_N5_AD12N_69
set_property PACKAGE_PIN BH2          [get_ports "DDR4_C1_ODT0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L9P_T1L_N4_AD12P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ODT0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L9P_T1L_N4_AD12P_69
set_property PACKAGE_PIN BK1          [get_ports "DDR4_C1_ADR1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L8N_T1L_N3_AD5N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR1"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L8N_T1L_N3_AD5N_69
set_property PACKAGE_PIN BJ1          [get_ports "DDR4_C1_ADR8"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L8P_T1L_N2_AD5P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR8"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L8P_T1L_N2_AD5P_69
set_property PACKAGE_PIN BL2          [get_ports "DDR4_C1_ADR12"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L7N_T1L_N1_QBC_AD13N_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR12"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L7N_T1L_N1_QBC_AD13N_69
set_property PACKAGE_PIN BL3          [get_ports "DDR4_C1_CS_B0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L7P_T1L_N0_QBC_AD13P_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_CS_B0"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L7P_T1L_N0_QBC_AD13P_69
set_property PACKAGE_PIN BK6          [get_ports "DDR4_C1_ADR17"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_T1U_N12_69
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_ADR17"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_T1U_N12_69
set_property PACKAGE_PIN BL5          [get_ports "VRP_72"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_T0U_N12_VRP_69
set_property IOSTANDARD  POD12_DCI    [get_ports "VRP_72"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_T0U_N12_VRP_69
set_property PACKAGE_PIN BM3          [get_ports "DDR4_C1_DQ32"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L6N_T0U_N11_AD6N_69
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ32"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L6N_T0U_N11_AD6N_69
set_property PACKAGE_PIN BM4          [get_ports "DDR4_C1_DQ33"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L6P_T0U_N10_AD6P_69
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ33"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L6P_T0U_N10_AD6P_69
set_property PACKAGE_PIN BM5          [get_ports "DDR4_C1_DQ34"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L5N_T0U_N9_AD14N_69
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ34"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L5N_T0U_N9_AD14N_69
set_property PACKAGE_PIN BL6          [get_ports "DDR4_C1_DQ35"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L5P_T0U_N8_AD14P_69
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ35"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L5P_T0U_N8_AD14P_69
set_property PACKAGE_PIN BM7             [get_ports "DDR4_C1_DQS_C8"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L4N_T0U_N7_DBC_AD7N_69
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C8"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L4N_T0U_N7_DBC_AD7N_69
set_property PACKAGE_PIN BL7             [get_ports "DDR4_C1_DQS_T8"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L4P_T0U_N6_DBC_AD7P_69
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T8"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L4P_T0U_N6_DBC_AD7P_69
set_property PACKAGE_PIN BN4          [get_ports "DDR4_C1_DQ36"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L3N_T0L_N5_AD15N_69
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ36"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L3N_T0L_N5_AD15N_69
set_property PACKAGE_PIN BN5          [get_ports "DDR4_C1_DQ37"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L3P_T0L_N4_AD15P_69
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ37"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L3P_T0L_N4_AD15P_69
set_property PACKAGE_PIN BN6          [get_ports "DDR4_C1_DQ38"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L2N_T0L_N3_69
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ38"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L2N_T0L_N3_69
set_property PACKAGE_PIN BN7          [get_ports "DDR4_C1_DQ39"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L2P_T0L_N2_69
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ39"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L2P_T0L_N2_69
set_property PACKAGE_PIN BP6             [get_ports "DDR4_C1_DQS_C9"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L1N_T0L_N1_DBC_69
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C9"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L1N_T0L_N1_DBC_69
set_property PACKAGE_PIN BP7             [get_ports "DDR4_C1_DQS_T9"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L1P_T0L_N0_DBC_69
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T9"] ;# Bank  69 VCCO - VCC1V2_BTM - IO_L1P_T0L_N0_DBC_69
set_property PACKAGE_PIN BE9          [get_ports "DDR4_C1_DQ65"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L24N_T3U_N11_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ65"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L24N_T3U_N11_68
set_property PACKAGE_PIN BE10         [get_ports "DDR4_C1_DQ67"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L24P_T3U_N10_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ67"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L24P_T3U_N10_68
set_property PACKAGE_PIN BF10         [get_ports "DDR4_C1_DQ66"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L23N_T3U_N9_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ66"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L23N_T3U_N9_68
set_property PACKAGE_PIN BE11         [get_ports "DDR4_C1_DQ64"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L23P_T3U_N8_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ64"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L23P_T3U_N8_68
set_property PACKAGE_PIN BF11            [get_ports "DDR4_C1_DQS_C16"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L22N_T3U_N7_DBC_AD0N_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C16"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L22N_T3U_N7_DBC_AD0N_68
set_property PACKAGE_PIN BF12            [get_ports "DDR4_C1_DQS_T16"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L22P_T3U_N6_DBC_AD0P_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T16"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L22P_T3U_N6_DBC_AD0P_68
set_property PACKAGE_PIN BG9          [get_ports "DDR4_C1_DQ71"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L21N_T3L_N5_AD8N_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ71"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L21N_T3L_N5_AD8N_68
set_property PACKAGE_PIN BG10         [get_ports "DDR4_C1_DQ69"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L21P_T3L_N4_AD8P_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ69"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L21P_T3L_N4_AD8P_68
set_property PACKAGE_PIN BG12         [get_ports "DDR4_C1_DQ70"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L20N_T3L_N3_AD1N_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ70"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L20N_T3L_N3_AD1N_68
set_property PACKAGE_PIN BG13         [get_ports "DDR4_C1_DQ68"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L20P_T3L_N2_AD1P_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ68"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L20P_T3L_N2_AD1P_68
set_property PACKAGE_PIN BH9             [get_ports "DDR4_C1_DQS_C17"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L19N_T3L_N1_DBC_AD9N_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C17"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L19N_T3L_N1_DBC_AD9N_68
set_property PACKAGE_PIN BH10            [get_ports "DDR4_C1_DQS_T17"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L19P_T3L_N0_DBC_AD9P_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T17"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L19P_T3L_N0_DBC_AD9P_68
set_property PACKAGE_PIN BH11         [get_ports "DDR4_C1_EVENT_B"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_T3U_N12_68
set_property IOSTANDARD  SSTL12_DCI   [get_ports "DDR4_C1_EVENT_B"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_T3U_N12_68
set_property PACKAGE_PIN BH12         [get_ports "DDR4_C1_RESET_N"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_T2U_N12_68
set_property IOSTANDARD  LVCMOS12     [get_ports "DDR4_C1_RESET_N"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_T2U_N12_68
set_property PACKAGE_PIN BH14         [get_ports "DDR4_C1_DQ59"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L18N_T2U_N11_AD2N_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ59"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L18N_T2U_N11_AD2N_68
set_property PACKAGE_PIN BH15         [get_ports "DDR4_C1_DQ58"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L18P_T2U_N10_AD2P_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ58"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L18P_T2U_N10_AD2P_68
set_property PACKAGE_PIN BJ12         [get_ports "DDR4_C1_DQ57"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L17N_T2U_N9_AD10N_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ57"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L17N_T2U_N9_AD10N_68
set_property PACKAGE_PIN BJ13         [get_ports "DDR4_C1_DQ56"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L17P_T2U_N8_AD10P_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ56"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L17P_T2U_N8_AD10P_68
set_property PACKAGE_PIN BK13            [get_ports "DDR4_C1_DQS_C14"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L16N_T2U_N7_QBC_AD3N_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C14"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L16N_T2U_N7_QBC_AD3N_68
set_property PACKAGE_PIN BJ14            [get_ports "DDR4_C1_DQS_T14"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L16P_T2U_N6_QBC_AD3P_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T14"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L16P_T2U_N6_QBC_AD3P_68
set_property PACKAGE_PIN BK14         [get_ports "DDR4_C1_DQ60"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L15N_T2L_N5_AD11N_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ60"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L15N_T2L_N5_AD11N_68
set_property PACKAGE_PIN BK15         [get_ports "DDR4_C1_DQ61"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L15P_T2L_N4_AD11P_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ61"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L15P_T2L_N4_AD11P_68
set_property PACKAGE_PIN BL12         [get_ports "DDR4_C1_DQ62"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L14N_T2L_N3_GC_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ62"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L14N_T2L_N3_GC_68
set_property PACKAGE_PIN BL13         [get_ports "DDR4_C1_DQ63"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L14P_T2L_N2_GC_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ63"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L14P_T2L_N2_GC_68
set_property PACKAGE_PIN BK11            [get_ports "DDR4_C1_DQS_C15"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L13N_T2L_N1_GC_QBC_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C15"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L13N_T2L_N1_GC_QBC_68
set_property PACKAGE_PIN BJ11            [get_ports "DDR4_C1_DQS_T15"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L13P_T2L_N0_GC_QBC_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T15"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L13P_T2L_N0_GC_QBC_68
set_property PACKAGE_PIN BK9          [get_ports "DDR4_C1_DQ41"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L12N_T1U_N11_GC_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ41"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L12N_T1U_N11_GC_68
set_property PACKAGE_PIN BJ9          [get_ports "DDR4_C1_DQ40"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L12P_T1U_N10_GC_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ40"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L12P_T1U_N10_GC_68
set_property PACKAGE_PIN BL10         [get_ports "DDR4_C1_DQ43"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L11N_T1U_N9_GC_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ43"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L11N_T1U_N9_GC_68
set_property PACKAGE_PIN BK10         [get_ports "DDR4_C1_DQ42"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L11P_T1U_N8_GC_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ42"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L11P_T1U_N8_GC_68
set_property PACKAGE_PIN BM8             [get_ports "DDR4_C1_DQS_C10"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L10N_T1U_N7_QBC_AD4N_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C10"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L10N_T1U_N7_QBC_AD4N_68
set_property PACKAGE_PIN BL8             [get_ports "DDR4_C1_DQS_T10"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L10P_T1U_N6_QBC_AD4P_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T10"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L10P_T1U_N6_QBC_AD4P_68
set_property PACKAGE_PIN BN9          [get_ports "DDR4_C1_DQ45"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L9N_T1L_N5_AD12N_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ45"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L9N_T1L_N5_AD12N_68
set_property PACKAGE_PIN BM9          [get_ports "DDR4_C1_DQ44"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L9P_T1L_N4_AD12P_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ44"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L9P_T1L_N4_AD12P_68
set_property PACKAGE_PIN BN10         [get_ports "DDR4_C1_DQ46"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L8N_T1L_N3_AD5N_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ46"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L8N_T1L_N3_AD5N_68
set_property PACKAGE_PIN BM10         [get_ports "DDR4_C1_DQ47"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L8P_T1L_N2_AD5P_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ47"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L8P_T1L_N2_AD5P_68
set_property PACKAGE_PIN BP8             [get_ports "DDR4_C1_DQS_C11"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L7N_T1L_N1_QBC_AD13N_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C11"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L7N_T1L_N1_QBC_AD13N_68
set_property PACKAGE_PIN BP9             [get_ports "DDR4_C1_DQS_T11"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L7P_T1L_N0_QBC_AD13P_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T11"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L7P_T1L_N0_QBC_AD13P_68
set_property PACKAGE_PIN BL11     [get_ports "No Connect"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_T1U_N12_68
set_property IOSTANDARD  LVCMOS12 [get_ports "No Connect"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_T1U_N12_68
set_property PACKAGE_PIN BN11       [get_ports "VRP_73"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_T0U_N12_VRP_68
set_property IOSTANDARD  POD12_DCI  [get_ports "VRP_73"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_T0U_N12_VRP_68
set_property PACKAGE_PIN BM15         [get_ports "DDR4_C1_DQ48"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L6N_T0U_N11_AD6N_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ48"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L6N_T0U_N11_AD6N_68
set_property PACKAGE_PIN BL15         [get_ports "DDR4_C1_DQ50"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L6P_T0U_N10_AD6P_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ50"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L6P_T0U_N10_AD6P_68
set_property PACKAGE_PIN BM13         [get_ports "DDR4_C1_DQ51"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L5N_T0U_N9_AD14N_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ51"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L5N_T0U_N9_AD14N_68
set_property PACKAGE_PIN BM14         [get_ports "DDR4_C1_DQ49"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L5P_T0U_N8_AD14P_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ49"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L5P_T0U_N8_AD14P_68
set_property PACKAGE_PIN BN14            [get_ports "DDR4_C1_DQS_C12"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L4N_T0U_N7_DBC_AD7N_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C12"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L4N_T0U_N7_DBC_AD7N_68
set_property PACKAGE_PIN BN15            [get_ports "DDR4_C1_DQS_T12"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L4P_T0U_N6_DBC_AD7P_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T12"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L4P_T0U_N6_DBC_AD7P_68
set_property PACKAGE_PIN BN12         [get_ports "DDR4_C1_DQ52"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L3N_T0L_N5_AD15N_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ52"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L3N_T0L_N5_AD15N_68
set_property PACKAGE_PIN BM12         [get_ports "DDR4_C1_DQ53"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L3P_T0L_N4_AD15P_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ53"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L3P_T0L_N4_AD15P_68
set_property PACKAGE_PIN BP13         [get_ports "DDR4_C1_DQ54"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L2N_T0L_N3_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ54"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L2N_T0L_N3_68
set_property PACKAGE_PIN BP14         [get_ports "DDR4_C1_DQ55"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L2P_T0L_N2_68
set_property IOSTANDARD  POD12_DCI    [get_ports "DDR4_C1_DQ55"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L2P_T0L_N2_68
set_property PACKAGE_PIN BP11            [get_ports "DDR4_C1_DQS_C13"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L1N_T0L_N1_DBC_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_C13"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L1N_T0L_N1_DBC_68
set_property PACKAGE_PIN BP12            [get_ports "DDR4_C1_DQS_T13"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L1P_T0L_N0_DBC_68
set_property IOSTANDARD  DIFF_POD12_DCI  [get_ports "DDR4_C1_DQS_T13"] ;# Bank  68 VCCO - VCC1V2_BTM - IO_L1P_T0L_N0_DBC_68
set_property PACKAGE_PIN A28       [get_ports "USB_UART_TX"] ;# Bank  75 VCCO - VCC1V8   - IO_L24N_T3U_N11_75
set_property IOSTANDARD  POD12_DCI [get_ports "USB_UART_TX"] ;# Bank  75 VCCO - VCC1V8   - IO_L24N_T3U_N11_75
set_property PACKAGE_PIN B28       [get_ports "SYSMON_SDA"] ;# Bank  75 VCCO - VCC1V8   - IO_L24P_T3U_N10_75
set_property IOSTANDARD  LVCMOS18  [get_ports "SYSMON_SDA"] ;# Bank  75 VCCO - VCC1V8   - IO_L24P_T3U_N10_75
set_property PACKAGE_PIN A30       [get_ports "SYSMON_SCL"] ;# Bank  75 VCCO - VCC1V8   - IO_L23N_T3U_N9_75
set_property IOSTANDARD  LVCMOS18  [get_ports "SYSMON_SCL"] ;# Bank  75 VCCO - VCC1V8   - IO_L23N_T3U_N9_75
set_property PACKAGE_PIN A29       [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L23P_T3U_N8_75
set_property IOSTANDARD  LVCMOS18  [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L23P_T3U_N8_75
set_property PACKAGE_PIN A31       [get_ports "QSFP0_MODSELL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L22N_T3U_N7_DBC_AD0N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP0_MODSELL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L22N_T3U_N7_DBC_AD0N_75
set_property PACKAGE_PIN B30       [get_ports "QSFP0_RESETL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L22P_T3U_N6_DBC_AD0P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP0_RESETL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L22P_T3U_N6_DBC_AD0P_75
set_property PACKAGE_PIN A33       [get_ports "QSFP0_MODPRSL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L21N_T3L_N5_AD8N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP0_MODPRSL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L21N_T3L_N5_AD8N_75
set_property PACKAGE_PIN B32       [get_ports "QSFP0_INTL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L21P_T3L_N4_AD8P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP0_INTL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L21P_T3L_N4_AD8P_75
set_property PACKAGE_PIN C29       [get_ports "QSFP0_LPMODE_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L20N_T3L_N3_AD1N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP0_LPMODE_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L20N_T3L_N3_AD1N_75
set_property PACKAGE_PIN C28       [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L20P_T3L_N2_AD1P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L20P_T3L_N2_AD1P_75
set_property PACKAGE_PIN B31       [get_ports "I2C_MAIN_RESET_B_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L19N_T3L_N1_DBC_AD9N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "I2C_MAIN_RESET_B_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L19N_T3L_N1_DBC_AD9N_75
set_property PACKAGE_PIN C30       [get_ports "I2C_FPGA_SCL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L19P_T3L_N0_DBC_AD9P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "I2C_FPGA_SCL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L19P_T3L_N0_DBC_AD9P_75
set_property PACKAGE_PIN B33       [get_ports "USB_UART_RX"] ;# Bank  75 VCCO - VCC1V8   - IO_T3U_N12_75
set_property IOSTANDARD  LVCMOS18  [get_ports "USB_UART_RX"] ;# Bank  75 VCCO - VCC1V8   - IO_T3U_N12_75
set_property PACKAGE_PIN C33       [get_ports "I2C_FPGA_SDA_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_T2U_N12_75
set_property IOSTANDARD  LVCMOS18  [get_ports "I2C_FPGA_SDA_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_T2U_N12_75
set_property PACKAGE_PIN D29       [get_ports "FPGA_TXD_MSP"] ;# Bank  75 VCCO - VCC1V8   - IO_L18N_T2U_N11_AD2N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "FPGA_TXD_MSP"] ;# Bank  75 VCCO - VCC1V8   - IO_L18N_T2U_N11_AD2N_75
set_property PACKAGE_PIN E28       [get_ports "FPGA_RXD_MSP"] ;# Bank  75 VCCO - VCC1V8   - IO_L18P_T2U_N10_AD2P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "FPGA_RXD_MSP"] ;# Bank  75 VCCO - VCC1V8   - IO_L18P_T2U_N10_AD2P_75
set_property PACKAGE_PIN C32       [get_ports "STATUS_LED0_FPGA"] ;# Bank  75 VCCO - VCC1V8   - IO_L17N_T2U_N9_AD10N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "STATUS_LED0_FPGA"] ;# Bank  75 VCCO - VCC1V8   - IO_L17N_T2U_N9_AD10N_75
set_property PACKAGE_PIN D32       [get_ports "HBM_CATTRIP"] ;# Bank  75 VCCO - VCC1V8   - IO_L17P_T2U_N8_AD10P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "HBM_CATTRIP"] ;# Bank  75 VCCO - VCC1V8   - IO_L17P_T2U_N8_AD10P_75
set_property PACKAGE_PIN D31       [get_ports "IIC_MUX0_INTB_FPGA"] ;# Bank  75 VCCO - VCC1V8   - IO_L16N_T2U_N7_QBC_AD3N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "IIC_MUX0_INTB_FPGA"] ;# Bank  75 VCCO - VCC1V8   - IO_L16N_T2U_N7_QBC_AD3N_75
set_property PACKAGE_PIN D30       [get_ports "QSFP1_MODSELL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L16P_T2U_N6_QBC_AD3P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP1_MODSELL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L16P_T2U_N6_QBC_AD3P_75
set_property PACKAGE_PIN E33       [get_ports "QSFP1_RESETL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L15N_T2L_N5_AD11N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP1_RESETL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L15N_T2L_N5_AD11N_75
set_property PACKAGE_PIN F33       [get_ports "QSFP1_MODPRSL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L15P_T2L_N4_AD11P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP1_MODPRSL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L15P_T2L_N4_AD11P_75
set_property PACKAGE_PIN E29       [get_ports "QSFP1_INTL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L14N_T2L_N3_GC_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP1_INTL_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L14N_T2L_N3_GC_75
set_property PACKAGE_PIN F29       [get_ports "QSFP1_LPMODE_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L14P_T2L_N2_GC_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP1_LPMODE_LS"] ;# Bank  75 VCCO - VCC1V8   - IO_L14P_T2L_N2_GC_75
set_property PACKAGE_PIN E32       [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L13N_T2L_N1_GC_QBC_75
set_property IOSTANDARD  LVCMOS18  [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L13N_T2L_N1_GC_QBC_75
set_property PACKAGE_PIN E31       [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L13P_T2L_N0_GC_QBC_75
set_property IOSTANDARD  LVCMOS18  [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L13P_T2L_N0_GC_QBC_75
set_property PACKAGE_PIN F30         [get_ports "USER_SI570_CLOCK_N"] ;# Bank  75 VCCO - VCC1V8   - IO_L12N_T1U_N11_GC_75
set_property IOSTANDARD  DIFF_SSTL12 [get_ports "USER_SI570_CLOCK_N"] ;# Bank  75 VCCO - VCC1V8   - IO_L12N_T1U_N11_GC_75
set_property PACKAGE_PIN G30         [get_ports "USER_SI570_CLOCK_P"] ;# Bank  75 VCCO - VCC1V8   - IO_L12P_T1U_N10_GC_75
set_property IOSTANDARD  DIFF_SSTL12 [get_ports "USER_SI570_CLOCK_P"] ;# Bank  75 VCCO - VCC1V8   - IO_L12P_T1U_N10_GC_75
set_property PACKAGE_PIN F31         [get_ports "SYSCLK3_N"] ;# Bank  75 VCCO - VCC1V8   - IO_L11N_T1U_N9_GC_75
set_property IOSTANDARD  DIFF_SSTL12 [get_ports "SYSCLK3_N"] ;# Bank  75 VCCO - VCC1V8   - IO_L11N_T1U_N9_GC_75
set_property PACKAGE_PIN G31         [get_ports "SYSCLK3_P"] ;# Bank  75 VCCO - VCC1V8   - IO_L11P_T1U_N8_GC_75
set_property IOSTANDARD  DIFF_SSTL12 [get_ports "SYSCLK3_P"] ;# Bank  75 VCCO - VCC1V8   - IO_L11P_T1U_N8_GC_75
set_property PACKAGE_PIN F28       [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L10N_T1U_N7_QBC_AD4N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L10N_T1U_N7_QBC_AD4N_75
set_property PACKAGE_PIN G28       [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L10P_T1U_N6_QBC_AD4P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L10P_T1U_N6_QBC_AD4P_75
set_property PACKAGE_PIN G32       [get_ports "QSFP0_FS"] ;# Bank  75 VCCO - VCC1V8   - IO_L9N_T1L_N5_AD12N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP0_FS"] ;# Bank  75 VCCO - VCC1V8   - IO_L9N_T1L_N5_AD12N_75
set_property PACKAGE_PIN H32       [get_ports "QSFP0_OEB"] ;# Bank  75 VCCO - VCC1V8   - IO_L9P_T1L_N4_AD12P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP0_OEB"] ;# Bank  75 VCCO - VCC1V8   - IO_L9P_T1L_N4_AD12P_75
set_property PACKAGE_PIN H30       [get_ports "QSFP1_OEB"] ;# Bank  75 VCCO - VCC1V8   - IO_L8N_T1L_N3_AD5N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP1_OEB"] ;# Bank  75 VCCO - VCC1V8   - IO_L8N_T1L_N3_AD5N_75
set_property PACKAGE_PIN H29       [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L8P_T1L_N2_AD5P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L8P_T1L_N2_AD5P_75
set_property PACKAGE_PIN G33       [get_ports "QSFP1_FS"] ;# Bank  75 VCCO - VCC1V8   - IO_L7N_T1L_N1_QBC_AD13N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "QSFP1_FS"] ;# Bank  75 VCCO - VCC1V8   - IO_L7N_T1L_N1_QBC_AD13N_75
set_property PACKAGE_PIN H33       [get_ports "DDR4_RESET_GATE"] ;# Bank  75 VCCO - VCC1V8   - IO_L7P_T1L_N0_QBC_AD13P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "DDR4_RESET_GATE"] ;# Bank  75 VCCO - VCC1V8   - IO_L7P_T1L_N0_QBC_AD13P_75
set_property PACKAGE_PIN H28       [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_T1U_N12_75
set_property IOSTANDARD  LVCMOS18  [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_T1U_N12_75
set_property PACKAGE_PIN K28       [get_ports "GPIO_MSP0"] ;# Bank  75 VCCO - VCC1V8   - IO_T0U_N12_VRP_75
set_property IOSTANDARD  LVCMOS18  [get_ports "GPIO_MSP0"] ;# Bank  75 VCCO - VCC1V8   - IO_T0U_N12_VRP_75
set_property PACKAGE_PIN J29       [get_ports "GPIO_MSP1"] ;# Bank  75 VCCO - VCC1V8   - IO_L6N_T0U_N11_AD6N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "GPIO_MSP1"] ;# Bank  75 VCCO - VCC1V8   - IO_L6N_T0U_N11_AD6N_75
set_property PACKAGE_PIN K29       [get_ports "GPIO_MSP2"] ;# Bank  75 VCCO - VCC1V8   - IO_L6P_T0U_N10_AD6P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "GPIO_MSP2"] ;# Bank  75 VCCO - VCC1V8   - IO_L6P_T0U_N10_AD6P_75
set_property PACKAGE_PIN J31       [get_ports "GPIO_MSP3"] ;# Bank  75 VCCO - VCC1V8   - IO_L5N_T0U_N9_AD14N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "GPIO_MSP3"] ;# Bank  75 VCCO - VCC1V8   - IO_L5N_T0U_N9_AD14N_75
set_property PACKAGE_PIN J30       [get_ports "SW_DP0"] ;# Bank  75 VCCO - VCC1V8   - IO_L5P_T0U_N8_AD14P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "SW_DP0"] ;# Bank  75 VCCO - VCC1V8   - IO_L5P_T0U_N8_AD14P_75
set_property PACKAGE_PIN J32       [get_ports "SW_DP1"] ;# Bank  75 VCCO - VCC1V8   - IO_L4N_T0U_N7_DBC_AD7N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "SW_DP1"] ;# Bank  75 VCCO - VCC1V8   - IO_L4N_T0U_N7_DBC_AD7N_75
set_property PACKAGE_PIN K32       [get_ports "SW_DP2"] ;# Bank  75 VCCO - VCC1V8   - IO_L4P_T0U_N6_DBC_AD7P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "SW_DP2"] ;# Bank  75 VCCO - VCC1V8   - IO_L4P_T0U_N6_DBC_AD7P_75
set_property PACKAGE_PIN K31       [get_ports "SW_DP3"] ;# Bank  75 VCCO - VCC1V8   - IO_L3N_T0L_N5_AD15N_75
set_property IOSTANDARD  LVCMOS18  [get_ports "SW_DP3"] ;# Bank  75 VCCO - VCC1V8   - IO_L3N_T0L_N5_AD15N_75
set_property PACKAGE_PIN L31       [get_ports "N32064223"] ;# Bank  75 VCCO - VCC1V8   - IO_L3P_T0L_N4_AD15P_75
set_property IOSTANDARD  LVCMOS18  [get_ports "N32064223"] ;# Bank  75 VCCO - VCC1V8   - IO_L3P_T0L_N4_AD15P_75
set_property PACKAGE_PIN L30       [get_ports "CPU_RESET"] ;# Bank  75 VCCO - VCC1V8   - IO_L2N_T0L_N3_75
set_property IOSTANDARD  LVCMOS18  [get_ports "CPU_RESET"] ;# Bank  75 VCCO - VCC1V8   - IO_L2N_T0L_N3_75
set_property PACKAGE_PIN L29       [get_ports "SW_SET1_FPGA"] ;# Bank  75 VCCO - VCC1V8   - IO_L2P_T0L_N2_75
set_property IOSTANDARD  LVCMOS18  [get_ports "SW_SET1_FPGA"] ;# Bank  75 VCCO - VCC1V8   - IO_L2P_T0L_N2_75
set_property PACKAGE_PIN K33       [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L1N_T0L_N1_DBC_75
set_property IOSTANDARD  LVCMOS18  [get_ports "No Connect"] ;# Bank  75 VCCO - VCC1V8   - IO_L1N_T0L_N1_DBC_75
set_property PACKAGE_PIN L33       [get_ports "TESTCLK_OUT"] ;# Bank  75 VCCO - VCC1V8   - IO_L1P_T0L_N0_DBC_75
set_property IOSTANDARD  LVCMOS18  [get_ports "TESTCLK_OUT"] ;# Bank  75 VCCO - VCC1V8   - IO_L1P_T0L_N0_DBC_75
set_property PACKAGE_PIN A35       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L24N_T3U_N11_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L24N_T3U_N11_74
set_property PACKAGE_PIN A34       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L24P_T3U_N10_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L24P_T3U_N10_74
set_property PACKAGE_PIN A36       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L23N_T3U_N9_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L23N_T3U_N9_74
set_property PACKAGE_PIN B35       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L23P_T3U_N8_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L23P_T3U_N8_74
set_property PACKAGE_PIN A38       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L22N_T3U_N7_DBC_AD0N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L22N_T3U_N7_DBC_AD0N_74
set_property PACKAGE_PIN B37       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L22P_T3U_N6_DBC_AD0P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L22P_T3U_N6_DBC_AD0P_74
set_property PACKAGE_PIN B36       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L21N_T3L_N5_AD8N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L21N_T3L_N5_AD8N_74
set_property PACKAGE_PIN C35       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L21P_T3L_N4_AD8P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L21P_T3L_N4_AD8P_74
set_property PACKAGE_PIN B38       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L20N_T3L_N3_AD1N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L20N_T3L_N3_AD1N_74
set_property PACKAGE_PIN C37       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L20P_T3L_N2_AD1P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L20P_T3L_N2_AD1P_74
set_property PACKAGE_PIN C34       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L19N_T3L_N1_DBC_AD9N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L19N_T3L_N1_DBC_AD9N_74
set_property PACKAGE_PIN D34       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L19P_T3L_N0_DBC_AD9P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L19P_T3L_N0_DBC_AD9P_74
set_property PACKAGE_PIN C38       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_T3U_N12_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_T3U_N12_74
set_property PACKAGE_PIN C39       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_T2U_N12_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_T2U_N12_74
set_property PACKAGE_PIN D37       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L18N_T2U_N11_AD2N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L18N_T2U_N11_AD2N_74
set_property PACKAGE_PIN E36       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L18P_T2U_N10_AD2P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L18P_T2U_N10_AD2P_74
set_property PACKAGE_PIN E34       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L17N_T2U_N9_AD10N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L17N_T2U_N9_AD10N_74
set_property PACKAGE_PIN F34       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L17P_T2U_N8_AD10P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L17P_T2U_N8_AD10P_74
set_property PACKAGE_PIN D39       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L16N_T2U_N7_QBC_AD3N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L16N_T2U_N7_QBC_AD3N_74
set_property PACKAGE_PIN E39       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L16P_T2U_N6_QBC_AD3P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L16P_T2U_N6_QBC_AD3P_74
set_property PACKAGE_PIN D36       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L15N_T2L_N5_AD11N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L15N_T2L_N5_AD11N_74
set_property PACKAGE_PIN D35       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L15P_T2L_N4_AD11P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L15P_T2L_N4_AD11P_74
set_property PACKAGE_PIN E38       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L14N_T2L_N3_GC_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L14N_T2L_N3_GC_74
set_property PACKAGE_PIN E37       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L14P_T2L_N2_GC_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L14P_T2L_N2_GC_74
set_property PACKAGE_PIN F36       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L13N_T2L_N1_GC_QBC_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L13N_T2L_N1_GC_QBC_74
set_property PACKAGE_PIN F35       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L13P_T2L_N0_GC_QBC_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L13P_T2L_N0_GC_QBC_74
set_property PACKAGE_PIN F38       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L12N_T1U_N11_GC_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L12N_T1U_N11_GC_74
set_property PACKAGE_PIN G37       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L12P_T1U_N10_GC_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L12P_T1U_N10_GC_74
set_property PACKAGE_PIN G36       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L11N_T1U_N9_GC_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L11N_T1U_N9_GC_74
set_property PACKAGE_PIN G35       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L11P_T1U_N8_GC_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L11P_T1U_N8_GC_74
set_property PACKAGE_PIN F39       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L10N_T1U_N7_QBC_AD4N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L10N_T1U_N7_QBC_AD4N_74
set_property PACKAGE_PIN G38       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L10P_T1U_N6_QBC_AD4P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L10P_T1U_N6_QBC_AD4P_74
set_property PACKAGE_PIN H35       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L9N_T1L_N5_AD12N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L9N_T1L_N5_AD12N_74
set_property PACKAGE_PIN H34       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L9P_T1L_N4_AD12P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L9P_T1L_N4_AD12P_74
set_property PACKAGE_PIN H38       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L8N_T1L_N3_AD5N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L8N_T1L_N3_AD5N_74
set_property PACKAGE_PIN H37       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L8P_T1L_N2_AD5P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L8P_T1L_N2_AD5P_74
set_property PACKAGE_PIN H39       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L7N_T1L_N1_QBC_AD13N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L7N_T1L_N1_QBC_AD13N_74
set_property PACKAGE_PIN J39       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L7P_T1L_N0_QBC_AD13P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L7P_T1L_N0_QBC_AD13P_74
set_property PACKAGE_PIN J34       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_T1U_N12_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_T1U_N12_74
set_property PACKAGE_PIN J35       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_T0U_N12_VRP_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_T0U_N12_VRP_74
set_property PACKAGE_PIN J37       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L6N_T0U_N11_AD6N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L6N_T0U_N11_AD6N_74
set_property PACKAGE_PIN K37       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L6P_T0U_N10_AD6P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L6P_T0U_N10_AD6P_74
set_property PACKAGE_PIN K34       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L5N_T0U_N9_AD14N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L5N_T0U_N9_AD14N_74
set_property PACKAGE_PIN L34       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L5P_T0U_N8_AD14P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L5P_T0U_N8_AD14P_74
set_property PACKAGE_PIN K38       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L4N_T0U_N7_DBC_AD7N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L4N_T0U_N7_DBC_AD7N_74
set_property PACKAGE_PIN L38       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L4P_T0U_N6_DBC_AD7P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L4P_T0U_N6_DBC_AD7P_74
set_property PACKAGE_PIN J36       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L3N_T0L_N5_AD15N_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L3N_T0L_N5_AD15N_74
set_property PACKAGE_PIN K36       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L3P_T0L_N4_AD15P_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L3P_T0L_N4_AD15P_74
set_property PACKAGE_PIN K39       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L2N_T0L_N3_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L2N_T0L_N3_74
set_property PACKAGE_PIN L39       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L2P_T0L_N2_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L2P_T0L_N2_74
set_property PACKAGE_PIN L36       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L1N_T0L_N1_DBC_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L1N_T0L_N1_DBC_74
set_property PACKAGE_PIN L35       [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L1P_T0L_N0_DBC_74
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  74 VCCO - VCCO_74_G34 - IO_L1P_T0L_N0_DBC_74
set_property PACKAGE_PIN A40       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L24N_T3U_N11_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L24N_T3U_N11_73
set_property PACKAGE_PIN A39       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L24P_T3U_N10_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L24P_T3U_N10_73
set_property PACKAGE_PIN B42       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L23N_T3U_N9_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L23N_T3U_N9_73
set_property PACKAGE_PIN B41       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L23P_T3U_N8_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L23P_T3U_N8_73
set_property PACKAGE_PIN A41       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L22N_T3U_N7_DBC_AD0N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L22N_T3U_N7_DBC_AD0N_73
set_property PACKAGE_PIN B40       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L22P_T3U_N6_DBC_AD0P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L22P_T3U_N6_DBC_AD0P_73
set_property PACKAGE_PIN D41       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L21N_T3L_N5_AD8N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L21N_T3L_N5_AD8N_73
set_property PACKAGE_PIN E41       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L21P_T3L_N4_AD8P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L21P_T3L_N4_AD8P_73
set_property PACKAGE_PIN C40       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L20N_T3L_N3_AD1N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L20N_T3L_N3_AD1N_73
set_property PACKAGE_PIN D40       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L20P_T3L_N2_AD1P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L20P_T3L_N2_AD1P_73
set_property PACKAGE_PIN F41       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L19N_T3L_N1_DBC_AD9N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L19N_T3L_N1_DBC_AD9N_73
set_property PACKAGE_PIN F40       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L19P_T3L_N0_DBC_AD9P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L19P_T3L_N0_DBC_AD9P_73
set_property PACKAGE_PIN C42       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_T3U_N12_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_T3U_N12_73
set_property PACKAGE_PIN B43       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_T2U_N12_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_T2U_N12_73
set_property PACKAGE_PIN A44       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L18N_T2U_N11_AD2N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L18N_T2U_N11_AD2N_73
set_property PACKAGE_PIN A43       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L18P_T2U_N10_AD2P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L18P_T2U_N10_AD2P_73
set_property PACKAGE_PIN B45       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L17N_T2U_N9_AD10N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L17N_T2U_N9_AD10N_73
set_property PACKAGE_PIN C44       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L17P_T2U_N8_AD10P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L17P_T2U_N8_AD10P_73
set_property PACKAGE_PIN A46       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L16N_T2U_N7_QBC_AD3N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L16N_T2U_N7_QBC_AD3N_73
set_property PACKAGE_PIN A45       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L16P_T2U_N6_QBC_AD3P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L16P_T2U_N6_QBC_AD3P_73
set_property PACKAGE_PIN B46       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L15N_T2L_N5_AD11N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L15N_T2L_N5_AD11N_73
set_property PACKAGE_PIN C45       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L15P_T2L_N4_AD11P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L15P_T2L_N4_AD11P_73
set_property PACKAGE_PIN C43       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L14N_T2L_N3_GC_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L14N_T2L_N3_GC_73
set_property PACKAGE_PIN D42       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L14P_T2L_N2_GC_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L14P_T2L_N2_GC_73
set_property PACKAGE_PIN E43       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L13N_T2L_N1_GC_QBC_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L13N_T2L_N1_GC_QBC_73
set_property PACKAGE_PIN E42       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L13P_T2L_N0_GC_QBC_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L13P_T2L_N0_GC_QBC_73
set_property PACKAGE_PIN D45       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L12N_T1U_N11_GC_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L12N_T1U_N11_GC_73
set_property PACKAGE_PIN D44       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L12P_T1U_N10_GC_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L12P_T1U_N10_GC_73
set_property PACKAGE_PIN E44       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L11N_T1U_N9_GC_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L11N_T1U_N9_GC_73
set_property PACKAGE_PIN F44       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L11P_T1U_N8_GC_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L11P_T1U_N8_GC_73
set_property PACKAGE_PIN D46       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L10N_T1U_N7_QBC_AD4N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L10N_T1U_N7_QBC_AD4N_73
set_property PACKAGE_PIN E46       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L10P_T1U_N6_QBC_AD4P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L10P_T1U_N6_QBC_AD4P_73
set_property PACKAGE_PIN G45       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L9N_T1L_N5_AD12N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L9N_T1L_N5_AD12N_73
set_property PACKAGE_PIN H45       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L9P_T1L_N4_AD12P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L9P_T1L_N4_AD12P_73
set_property PACKAGE_PIN F46       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L8N_T1L_N3_AD5N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L8N_T1L_N3_AD5N_73
set_property PACKAGE_PIN F45       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L8P_T1L_N2_AD5P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L8P_T1L_N2_AD5P_73
set_property PACKAGE_PIN H44       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L7N_T1L_N1_QBC_AD13N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L7N_T1L_N1_QBC_AD13N_73
set_property PACKAGE_PIN J44       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L7P_T1L_N0_QBC_AD13P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L7P_T1L_N0_QBC_AD13P_73
set_property PACKAGE_PIN G46       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_T1U_N12_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_T1U_N12_73
set_property PACKAGE_PIN F43       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_T0U_N12_VRP_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_T0U_N12_VRP_73
set_property PACKAGE_PIN G43       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L6N_T0U_N11_AD6N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L6N_T0U_N11_AD6N_73
set_property PACKAGE_PIN H43       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L6P_T0U_N10_AD6P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L6P_T0U_N10_AD6P_73
set_property PACKAGE_PIN G42       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L5N_T0U_N9_AD14N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L5N_T0U_N9_AD14N_73
set_property PACKAGE_PIN G41       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L5P_T0U_N8_AD14P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L5P_T0U_N8_AD14P_73
set_property PACKAGE_PIN G40       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L4N_T0U_N7_DBC_AD7N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L4N_T0U_N7_DBC_AD7N_73
set_property PACKAGE_PIN H40       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L4P_T0U_N6_DBC_AD7P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L4P_T0U_N6_DBC_AD7P_73
set_property PACKAGE_PIN J41       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L3N_T0L_N5_AD15N_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L3N_T0L_N5_AD15N_73
set_property PACKAGE_PIN J40       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L3P_T0L_N4_AD15P_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L3P_T0L_N4_AD15P_73
set_property PACKAGE_PIN H42       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L2N_T0L_N3_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L2N_T0L_N3_73
set_property PACKAGE_PIN J42       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L2P_T0L_N2_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L2P_T0L_N2_73
set_property PACKAGE_PIN K42       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L1N_T0L_N1_DBC_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L1N_T0L_N1_DBC_73
set_property PACKAGE_PIN K41       [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L1P_T0L_N0_DBC_73
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  73 VCCO - VCCO_73_E40 - IO_L1P_T0L_N0_DBC_73
set_property PACKAGE_PIN A24       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L24N_T3U_N11_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L24N_T3U_N11_72
set_property PACKAGE_PIN A25       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L24P_T3U_N10_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L24P_T3U_N10_72
set_property PACKAGE_PIN A26       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L23N_T3U_N9_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L23N_T3U_N9_72
set_property PACKAGE_PIN B27       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L23P_T3U_N8_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L23P_T3U_N8_72
set_property PACKAGE_PIN A23       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L22N_T3U_N7_DBC_AD0N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L22N_T3U_N7_DBC_AD0N_72
set_property PACKAGE_PIN B23       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L22P_T3U_N6_DBC_AD0P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L22P_T3U_N6_DBC_AD0P_72
set_property PACKAGE_PIN B25       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L21N_T3L_N5_AD8N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L21N_T3L_N5_AD8N_72
set_property PACKAGE_PIN B26       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L21P_T3L_N4_AD8P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L21P_T3L_N4_AD8P_72
set_property PACKAGE_PIN C24       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L20N_T3L_N3_AD1N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L20N_T3L_N3_AD1N_72
set_property PACKAGE_PIN C25       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L20P_T3L_N2_AD1P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L20P_T3L_N2_AD1P_72
set_property PACKAGE_PIN B22       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L19N_T3L_N1_DBC_AD9N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L19N_T3L_N1_DBC_AD9N_72
set_property PACKAGE_PIN C23       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L19P_T3L_N0_DBC_AD9P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L19P_T3L_N0_DBC_AD9P_72
set_property PACKAGE_PIN C22       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_T3U_N12_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_T3U_N12_72
set_property PACKAGE_PIN C27       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_T2U_N12_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_T2U_N12_72
set_property PACKAGE_PIN D27       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L18N_T2U_N11_AD2N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L18N_T2U_N11_AD2N_72
set_property PACKAGE_PIN E27       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L18P_T2U_N10_AD2P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L18P_T2U_N10_AD2P_72
set_property PACKAGE_PIN D26       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L17N_T2U_N9_AD10N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L17N_T2U_N9_AD10N_72
set_property PACKAGE_PIN E26       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L17P_T2U_N8_AD10P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L17P_T2U_N8_AD10P_72
set_property PACKAGE_PIN D24       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L16N_T2U_N7_QBC_AD3N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L16N_T2U_N7_QBC_AD3N_72
set_property PACKAGE_PIN D25       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L16P_T2U_N6_QBC_AD3P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L16P_T2U_N6_QBC_AD3P_72
set_property PACKAGE_PIN D22       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L15N_T2L_N5_AD11N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L15N_T2L_N5_AD11N_72
set_property PACKAGE_PIN E22       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L15P_T2L_N4_AD11P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L15P_T2L_N4_AD11P_72
set_property PACKAGE_PIN F25       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L14N_T2L_N3_GC_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L14N_T2L_N3_GC_72
set_property PACKAGE_PIN F26       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L14P_T2L_N2_GC_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L14P_T2L_N2_GC_72
set_property PACKAGE_PIN E23       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L13N_T2L_N1_GC_QBC_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L13N_T2L_N1_GC_QBC_72
set_property PACKAGE_PIN E24       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L13P_T2L_N0_GC_QBC_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L13P_T2L_N0_GC_QBC_72
set_property PACKAGE_PIN G25       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L12N_T1U_N11_GC_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L12N_T1U_N11_GC_72
set_property PACKAGE_PIN G26       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L12P_T1U_N10_GC_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L12P_T1U_N10_GC_72
set_property PACKAGE_PIN F23       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L11N_T1U_N9_GC_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L11N_T1U_N9_GC_72
set_property PACKAGE_PIN F24       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L11P_T1U_N8_GC_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L11P_T1U_N8_GC_72
set_property PACKAGE_PIN G22       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L10N_T1U_N7_QBC_AD4N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L10N_T1U_N7_QBC_AD4N_72
set_property PACKAGE_PIN G23       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L10P_T1U_N6_QBC_AD4P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L10P_T1U_N6_QBC_AD4P_72
set_property PACKAGE_PIN G27       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L9N_T1L_N5_AD12N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L9N_T1L_N5_AD12N_72
set_property PACKAGE_PIN H27       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L9P_T1L_N4_AD12P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L9P_T1L_N4_AD12P_72
set_property PACKAGE_PIN H22       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L8N_T1L_N3_AD5N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L8N_T1L_N3_AD5N_72
set_property PACKAGE_PIN J22       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L8P_T1L_N2_AD5P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L8P_T1L_N2_AD5P_72
set_property PACKAGE_PIN H23       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L7N_T1L_N1_QBC_AD13N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L7N_T1L_N1_QBC_AD13N_72
set_property PACKAGE_PIN H24       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L7P_T1L_N0_QBC_AD13P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L7P_T1L_N0_QBC_AD13P_72
set_property PACKAGE_PIN H25       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_T1U_N12_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_T1U_N12_72
set_property PACKAGE_PIN J24       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_T0U_N12_VRP_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_T0U_N12_VRP_72
set_property PACKAGE_PIN J25       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L6N_T0U_N11_AD6N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L6N_T0U_N11_AD6N_72
set_property PACKAGE_PIN J26       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L6P_T0U_N10_AD6P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L6P_T0U_N10_AD6P_72
set_property PACKAGE_PIN J27       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L5N_T0U_N9_AD14N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L5N_T0U_N9_AD14N_72
set_property PACKAGE_PIN K27       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L5P_T0U_N8_AD14P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L5P_T0U_N8_AD14P_72
set_property PACKAGE_PIN K22       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L4N_T0U_N7_DBC_AD7N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L4N_T0U_N7_DBC_AD7N_72
set_property PACKAGE_PIN L23       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L4P_T0U_N6_DBC_AD7P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L4P_T0U_N6_DBC_AD7P_72
set_property PACKAGE_PIN K23       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L3N_T0L_N5_AD15N_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L3N_T0L_N5_AD15N_72
set_property PACKAGE_PIN K24       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L3P_T0L_N4_AD15P_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L3P_T0L_N4_AD15P_72
set_property PACKAGE_PIN K26       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L2N_T0L_N3_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L2N_T0L_N3_72
set_property PACKAGE_PIN L26       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L2P_T0L_N2_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L2P_T0L_N2_72
set_property PACKAGE_PIN L24       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L1N_T0L_N1_DBC_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L1N_T0L_N1_DBC_72
set_property PACKAGE_PIN L25       [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L1P_T0L_N0_DBC_72
set_property IOSTANDARD  LVCMOS12  [get_ports "No Connect"] ;# Bank  72 VCCO - VCCO_72_F27 - IO_L1P_T0L_N0_DBC_72
set_property PACKAGE_PIN AV43      [get_ports "No Connect"] ;# Bank 124 - MGTREFCLK0N_124
set_property PACKAGE_PIN AV42      [get_ports "No Connect"] ;# Bank 124 - MGTREFCLK0P_124
set_property PACKAGE_PIN AT43      [get_ports "No Connect"] ;# Bank 124 - MGTREFCLK1N_124
set_property PACKAGE_PIN AT42      [get_ports "No Connect"] ;# Bank 124 - MGTREFCLK1P_124
set_property PACKAGE_PIN BC54      [get_ports "GND"] ;# Bank 124 - MGTYRXN0_124
set_property PACKAGE_PIN BB52      [get_ports "GND"] ;# Bank 124 - MGTYRXN1_124
set_property PACKAGE_PIN BA54      [get_ports "GND"] ;# Bank 124 - MGTYRXN2_124
set_property PACKAGE_PIN BA50      [get_ports "GND"] ;# Bank 124 - MGTYRXN3_124
set_property PACKAGE_PIN BC53      [get_ports "GND"] ;# Bank 124 - MGTYRXP0_124
set_property PACKAGE_PIN BB51      [get_ports "GND"] ;# Bank 124 - MGTYRXP1_124
set_property PACKAGE_PIN BA53      [get_ports "GND"] ;# Bank 124 - MGTYRXP2_124
set_property PACKAGE_PIN BA49      [get_ports "GND"] ;# Bank 124 - MGTYRXP3_124
set_property PACKAGE_PIN BC49      [get_ports "No Connect"] ;# Bank 124 - MGTYTXN0_124
set_property PACKAGE_PIN BC45      [get_ports "No Connect"] ;# Bank 124 - MGTYTXN1_124
set_property PACKAGE_PIN BB47      [get_ports "No Connect"] ;# Bank 124 - MGTYTXN2_124
set_property PACKAGE_PIN BA45      [get_ports "No Connect"] ;# Bank 124 - MGTYTXN3_124
set_property PACKAGE_PIN BC48      [get_ports "No Connect"] ;# Bank 124 - MGTYTXP0_124
set_property PACKAGE_PIN BC44      [get_ports "No Connect"] ;# Bank 124 - MGTYTXP1_124
set_property PACKAGE_PIN BB46      [get_ports "No Connect"] ;# Bank 124 - MGTYTXP2_124
set_property PACKAGE_PIN BA44      [get_ports "No Connect"] ;# Bank 124 - MGTYTXP3_124
set_property PACKAGE_PIN AR41      [get_ports "No Connect"] ;# Bank 125 - MGTREFCLK0N_125
set_property PACKAGE_PIN AR40      [get_ports "No Connect"] ;# Bank 125 - MGTREFCLK0P_125
set_property PACKAGE_PIN AP43      [get_ports "No Connect"] ;# Bank 125 - MGTREFCLK1N_125
set_property PACKAGE_PIN AP42      [get_ports "No Connect"] ;# Bank 125 - MGTREFCLK1P_125
set_property PACKAGE_PIN AU41      [get_ports "GND"] ;# Bank 125 - MGTRREF_LS
set_property PACKAGE_PIN AY52      [get_ports "GND"] ;# Bank 125 - MGTYRXN0_125
set_property PACKAGE_PIN AW54      [get_ports "GND"] ;# Bank 125 - MGTYRXN1_125
set_property PACKAGE_PIN AW50      [get_ports "GND"] ;# Bank 125 - MGTYRXN2_125
set_property PACKAGE_PIN AV52      [get_ports "GND"] ;# Bank 125 - MGTYRXN3_125
set_property PACKAGE_PIN AY51      [get_ports "GND"] ;# Bank 125 - MGTYRXP0_125
set_property PACKAGE_PIN AW53      [get_ports "GND"] ;# Bank 125 - MGTYRXP1_125
set_property PACKAGE_PIN AW49      [get_ports "GND"] ;# Bank 125 - MGTYRXP2_125
set_property PACKAGE_PIN AV51      [get_ports "GND"] ;# Bank 125 - MGTYRXP3_125
set_property PACKAGE_PIN AY47      [get_ports "No Connect"] ;# Bank 125 - MGTYTXN0_125
set_property PACKAGE_PIN AW45      [get_ports "No Connect"] ;# Bank 125 - MGTYTXN1_125
set_property PACKAGE_PIN AV47      [get_ports "No Connect"] ;# Bank 125 - MGTYTXN2_125
set_property PACKAGE_PIN AU45      [get_ports "No Connect"] ;# Bank 125 - MGTYTXN3_125
set_property PACKAGE_PIN AY46      [get_ports "No Connect"] ;# Bank 125 - MGTYTXP0_125
set_property PACKAGE_PIN AW44      [get_ports "No Connect"] ;# Bank 125 - MGTYTXP1_125
set_property PACKAGE_PIN AV46      [get_ports "No Connect"] ;# Bank 125 - MGTYTXP2_125
set_property PACKAGE_PIN AU44      [get_ports "No Connect"] ;# Bank 125 - MGTYTXP3_125
set_property PACKAGE_PIN AN41      [get_ports "No Connect"] ;# Bank 126 - MGTREFCLK0N_126
set_property PACKAGE_PIN AN40      [get_ports "No Connect"] ;# Bank 126 - MGTREFCLK0P_126
set_property PACKAGE_PIN AM43      [get_ports "No Connect"] ;# Bank 126 - MGTREFCLK1N_126
set_property PACKAGE_PIN AM42      [get_ports "No Connect"] ;# Bank 126 - MGTREFCLK1P_126
set_property PACKAGE_PIN AU54      [get_ports "GND"] ;# Bank 126 - MGTYRXN0_126
set_property PACKAGE_PIN AT52      [get_ports "GND"] ;# Bank 126 - MGTYRXN1_126
set_property PACKAGE_PIN AR54      [get_ports "GND"] ;# Bank 126 - MGTYRXN2_126
set_property PACKAGE_PIN AP52      [get_ports "GND"] ;# Bank 126 - MGTYRXN3_126
set_property PACKAGE_PIN AU53      [get_ports "GND"] ;# Bank 126 - MGTYRXP0_126
set_property PACKAGE_PIN AT51      [get_ports "GND"] ;# Bank 126 - MGTYRXP1_126
set_property PACKAGE_PIN AR53      [get_ports "GND"] ;# Bank 126 - MGTYRXP2_126
set_property PACKAGE_PIN AP51      [get_ports "GND"] ;# Bank 126 - MGTYRXP3_126
set_property PACKAGE_PIN AU49      [get_ports "No Connect"] ;# Bank 126 - MGTYTXN0_126
set_property PACKAGE_PIN AT47      [get_ports "No Connect"] ;# Bank 126 - MGTYTXN1_126
set_property PACKAGE_PIN AR49      [get_ports "No Connect"] ;# Bank 126 - MGTYTXN2_126
set_property PACKAGE_PIN AR45      [get_ports "No Connect"] ;# Bank 126 - MGTYTXN3_126
set_property PACKAGE_PIN AU48      [get_ports "No Connect"] ;# Bank 126 - MGTYTXP0_126
set_property PACKAGE_PIN AT46      [get_ports "No Connect"] ;# Bank 126 - MGTYTXP1_126
set_property PACKAGE_PIN AR48      [get_ports "No Connect"] ;# Bank 126 - MGTYTXP2_126
set_property PACKAGE_PIN AR44      [get_ports "No Connect"] ;# Bank 126 - MGTYTXP3_126
set_property PACKAGE_PIN AL41      [get_ports "No Connect"] ;# Bank 127 - MGTREFCLK0N_127
set_property PACKAGE_PIN AL40      [get_ports "No Connect"] ;# Bank 127 - MGTREFCLK0P_127
set_property PACKAGE_PIN AK43      [get_ports "No Connect"] ;# Bank 127 - MGTREFCLK1N_127
set_property PACKAGE_PIN AK42      [get_ports "No Connect"] ;# Bank 127 - MGTREFCLK1P_127
set_property PACKAGE_PIN AN54      [get_ports "GND"] ;# Bank 127 - MGTYRXN0_127
set_property PACKAGE_PIN AN50      [get_ports "GND"] ;# Bank 127 - MGTYRXN1_127
set_property PACKAGE_PIN AM52      [get_ports "GND"] ;# Bank 127 - MGTYRXN2_127
set_property PACKAGE_PIN AL54      [get_ports "GND"] ;# Bank 127 - MGTYRXN3_127
set_property PACKAGE_PIN AN53      [get_ports "GND"] ;# Bank 127 - MGTYRXP0_127
set_property PACKAGE_PIN AN49      [get_ports "GND"] ;# Bank 127 - MGTYRXP1_127
set_property PACKAGE_PIN AM51      [get_ports "GND"] ;# Bank 127 - MGTYRXP2_127
set_property PACKAGE_PIN AL53      [get_ports "GND"] ;# Bank 127 - MGTYRXP3_127
set_property PACKAGE_PIN AP47      [get_ports "No Connect"] ;# Bank 127 - MGTYTXN0_127
set_property PACKAGE_PIN AN45      [get_ports "No Connect"] ;# Bank 127 - MGTYTXN1_127
set_property PACKAGE_PIN AM47      [get_ports "No Connect"] ;# Bank 127 - MGTYTXN2_127
set_property PACKAGE_PIN AL45      [get_ports "No Connect"] ;# Bank 127 - MGTYTXN3_127
set_property PACKAGE_PIN AP46      [get_ports "No Connect"] ;# Bank 127 - MGTYTXP0_127
set_property PACKAGE_PIN AN44      [get_ports "No Connect"] ;# Bank 127 - MGTYTXP1_127
set_property PACKAGE_PIN AM46      [get_ports "No Connect"] ;# Bank 127 - MGTYTXP2_127
set_property PACKAGE_PIN AL44      [get_ports "No Connect"] ;# Bank 127 - MGTYTXP3_127
set_property PACKAGE_PIN AJ41      [get_ports "No Connect"] ;# Bank 128 - MGTREFCLK0N_128
set_property PACKAGE_PIN AJ40      [get_ports "No Connect"] ;# Bank 128 - MGTREFCLK0P_128
set_property PACKAGE_PIN AH43      [get_ports "No Connect"] ;# Bank 128 - MGTREFCLK1N_128
set_property PACKAGE_PIN AH42      [get_ports "No Connect"] ;# Bank 128 - MGTREFCLK1P_128
set_property PACKAGE_PIN AL50      [get_ports "GND"] ;# Bank 128 - MGTYRXN0_128
set_property PACKAGE_PIN AK52      [get_ports "GND"] ;# Bank 128 - MGTYRXN1_128
set_property PACKAGE_PIN AJ54      [get_ports "GND"] ;# Bank 128 - MGTYRXN2_128
set_property PACKAGE_PIN AH52      [get_ports "GND"] ;# Bank 128 - MGTYRXN3_128
set_property PACKAGE_PIN AL49      [get_ports "GND"] ;# Bank 128 - MGTYRXP0_128
set_property PACKAGE_PIN AK51      [get_ports "GND"] ;# Bank 128 - MGTYRXP1_128
set_property PACKAGE_PIN AJ53      [get_ports "GND"] ;# Bank 128 - MGTYRXP2_128
set_property PACKAGE_PIN AH51      [get_ports "GND"] ;# Bank 128 - MGTYRXP3_128
set_property PACKAGE_PIN AK47      [get_ports "No Connect"] ;# Bank 128 - MGTYTXN0_128
set_property PACKAGE_PIN AJ49      [get_ports "No Connect"] ;# Bank 128 - MGTYTXN1_128
set_property PACKAGE_PIN AJ45      [get_ports "No Connect"] ;# Bank 128 - MGTYTXN2_128
set_property PACKAGE_PIN AH47      [get_ports "No Connect"] ;# Bank 128 - MGTYTXN3_128
set_property PACKAGE_PIN AK46      [get_ports "No Connect"] ;# Bank 128 - MGTYTXP0_128
set_property PACKAGE_PIN AJ48      [get_ports "No Connect"] ;# Bank 128 - MGTYTXP1_128
set_property PACKAGE_PIN AJ44      [get_ports "No Connect"] ;# Bank 128 - MGTYTXP2_128
set_property PACKAGE_PIN AH46      [get_ports "No Connect"] ;# Bank 128 - MGTYTXP3_128
set_property PACKAGE_PIN AG41      [get_ports "No Connect"] ;# Bank 129 - MGTREFCLK0N_129
set_property PACKAGE_PIN AG40      [get_ports "No Connect"] ;# Bank 129 - MGTREFCLK0P_129
set_property PACKAGE_PIN AF43      [get_ports "No Connect"] ;# Bank 129 - MGTREFCLK1N_129
set_property PACKAGE_PIN AF42      [get_ports "No Connect"] ;# Bank 129 - MGTREFCLK1P_129
set_property PACKAGE_PIN AE41      [get_ports "GND"] ;# Bank 129 - MGTRREF_LC
set_property PACKAGE_PIN AG54      [get_ports "GND"] ;# Bank 129 - MGTYRXN0_129
set_property PACKAGE_PIN AF52      [get_ports "GND"] ;# Bank 129 - MGTYRXN1_129
set_property PACKAGE_PIN AE54      [get_ports "GND"] ;# Bank 129 - MGTYRXN2_129
set_property PACKAGE_PIN AE50      [get_ports "GND"] ;# Bank 129 - MGTYRXN3_129
set_property PACKAGE_PIN AG53      [get_ports "GND"] ;# Bank 129 - MGTYRXP0_129
set_property PACKAGE_PIN AF51      [get_ports "GND"] ;# Bank 129 - MGTYRXP1_129
set_property PACKAGE_PIN AE53      [get_ports "GND"] ;# Bank 129 - MGTYRXP2_129
set_property PACKAGE_PIN AE49      [get_ports "GND"] ;# Bank 129 - MGTYRXP3_129
set_property PACKAGE_PIN AG49      [get_ports "No Connect"] ;# Bank 129 - MGTYTXN0_129
set_property PACKAGE_PIN AG45      [get_ports "No Connect"] ;# Bank 129 - MGTYTXN1_129
set_property PACKAGE_PIN AF47      [get_ports "No Connect"] ;# Bank 129 - MGTYTXN2_129
set_property PACKAGE_PIN AE45      [get_ports "No Connect"] ;# Bank 129 - MGTYTXN3_129
set_property PACKAGE_PIN AG48      [get_ports "No Connect"] ;# Bank 129 - MGTYTXP0_129
set_property PACKAGE_PIN AG44      [get_ports "No Connect"] ;# Bank 129 - MGTYTXP1_129
set_property PACKAGE_PIN AF46      [get_ports "No Connect"] ;# Bank 129 - MGTYTXP2_129
set_property PACKAGE_PIN AE44      [get_ports "No Connect"] ;# Bank 129 - MGTYTXP3_129
set_property PACKAGE_PIN AD43      [get_ports "No Connect"] ;# Bank 130 - MGTREFCLK0N_130
set_property PACKAGE_PIN AD42      [get_ports "No Connect"] ;# Bank 130 - MGTREFCLK0P_130
set_property PACKAGE_PIN AC41      [get_ports "No Connect"] ;# Bank 130 - MGTREFCLK1N_130
set_property PACKAGE_PIN AC40      [get_ports "No Connect"] ;# Bank 130 - MGTREFCLK1P_130
set_property PACKAGE_PIN AD52      [get_ports "GND"] ;# Bank 130 - MGTYRXN0_130
set_property PACKAGE_PIN AC54      [get_ports "GND"] ;# Bank 130 - MGTYRXN1_130
set_property PACKAGE_PIN AC50      [get_ports "GND"] ;# Bank 130 - MGTYRXN2_130
set_property PACKAGE_PIN AB52      [get_ports "GND"] ;# Bank 130 - MGTYRXN3_130
set_property PACKAGE_PIN AD51      [get_ports "GND"] ;# Bank 130 - MGTYRXP0_130
set_property PACKAGE_PIN AC53      [get_ports "GND"] ;# Bank 130 - MGTYRXP1_130
set_property PACKAGE_PIN AC49      [get_ports "GND"] ;# Bank 130 - MGTYRXP2_130
set_property PACKAGE_PIN AB51      [get_ports "GND"] ;# Bank 130 - MGTYRXP3_130
set_property PACKAGE_PIN AD47      [get_ports "No Connect"] ;# Bank 130 - MGTYTXN0_130
set_property PACKAGE_PIN AC45      [get_ports "No Connect"] ;# Bank 130 - MGTYTXN1_130
set_property PACKAGE_PIN AB47      [get_ports "No Connect"] ;# Bank 130 - MGTYTXN2_130
set_property PACKAGE_PIN AA49      [get_ports "No Connect"] ;# Bank 130 - MGTYTXN3_130
set_property PACKAGE_PIN AD46      [get_ports "No Connect"] ;# Bank 130 - MGTYTXP0_130
set_property PACKAGE_PIN AC44      [get_ports "No Connect"] ;# Bank 130 - MGTYTXP1_130
set_property PACKAGE_PIN AB46      [get_ports "No Connect"] ;# Bank 130 - MGTYTXP2_130
set_property PACKAGE_PIN AA48      [get_ports "No Connect"] ;# Bank 130 - MGTYTXP3_130
set_property PACKAGE_PIN AB43      [get_ports "No Connect"] ;# Bank 131 - MGTREFCLK0N_131
set_property PACKAGE_PIN AB42      [get_ports "No Connect"] ;# Bank 131 - MGTREFCLK0P_131
set_property PACKAGE_PIN AA41      [get_ports "No Connect"] ;# Bank 131 - MGTREFCLK1N_131
set_property PACKAGE_PIN AA40      [get_ports "No Connect"] ;# Bank 131 - MGTREFCLK1P_131
set_property PACKAGE_PIN AA54      [get_ports "GND"] ;# Bank 131 - MGTYRXN0_131
set_property PACKAGE_PIN Y52       [get_ports "GND"] ;# Bank 131 - MGTYRXN1_131
set_property PACKAGE_PIN W54       [get_ports "GND"] ;# Bank 131 - MGTYRXN2_131
set_property PACKAGE_PIN V52       [get_ports "GND"] ;# Bank 131 - MGTYRXN3_131
set_property PACKAGE_PIN AA53      [get_ports "GND"] ;# Bank 131 - MGTYRXP0_131
set_property PACKAGE_PIN Y51       [get_ports "GND"] ;# Bank 131 - MGTYRXP1_131
set_property PACKAGE_PIN W53       [get_ports "GND"] ;# Bank 131 - MGTYRXP2_131
set_property PACKAGE_PIN V51       [get_ports "GND"] ;# Bank 131 - MGTYRXP3_131
set_property PACKAGE_PIN AA45      [get_ports "No Connect"] ;# Bank 131 - MGTYTXN0_131
set_property PACKAGE_PIN Y47       [get_ports "No Connect"] ;# Bank 131 - MGTYTXN1_131
set_property PACKAGE_PIN W49       [get_ports "No Connect"] ;# Bank 131 - MGTYTXN2_131
set_property PACKAGE_PIN W45       [get_ports "No Connect"] ;# Bank 131 - MGTYTXN3_131
set_property PACKAGE_PIN AA44      [get_ports "No Connect"] ;# Bank 131 - MGTYTXP0_131
set_property PACKAGE_PIN Y46       [get_ports "No Connect"] ;# Bank 131 - MGTYTXP1_131
set_property PACKAGE_PIN W48       [get_ports "No Connect"] ;# Bank 131 - MGTYTXP2_131
set_property PACKAGE_PIN W44       [get_ports "No Connect"] ;# Bank 131 - MGTYTXP3_131
set_property PACKAGE_PIN Y43       [get_ports "No Connect"] ;# Bank 132 - MGTREFCLK0N_132
set_property PACKAGE_PIN Y42       [get_ports "No Connect"] ;# Bank 132 - MGTREFCLK0P_132
set_property PACKAGE_PIN W41       [get_ports "No Connect"] ;# Bank 132 - MGTREFCLK1N_132
set_property PACKAGE_PIN W40       [get_ports "No Connect"] ;# Bank 132 - MGTREFCLK1P_132
set_property PACKAGE_PIN U54       [get_ports "GND"] ;# Bank 132 - MGTYRXN0_132
set_property PACKAGE_PIN U50       [get_ports "GND"] ;# Bank 132 - MGTYRXN1_132
set_property PACKAGE_PIN T52       [get_ports "GND"] ;# Bank 132 - MGTYRXN2_132
set_property PACKAGE_PIN R54       [get_ports "GND"] ;# Bank 132 - MGTYRXN3_132
set_property PACKAGE_PIN U53       [get_ports "GND"] ;# Bank 132 - MGTYRXP0_132
set_property PACKAGE_PIN U49       [get_ports "GND"] ;# Bank 132 - MGTYRXP1_132
set_property PACKAGE_PIN T51       [get_ports "GND"] ;# Bank 132 - MGTYRXP2_132
set_property PACKAGE_PIN R53       [get_ports "GND"] ;# Bank 132 - MGTYRXP3_132
set_property PACKAGE_PIN V47       [get_ports "No Connect"] ;# Bank 132 - MGTYTXN0_132
set_property PACKAGE_PIN U45       [get_ports "No Connect"] ;# Bank 132 - MGTYTXN1_132
set_property PACKAGE_PIN T47       [get_ports "No Connect"] ;# Bank 132 - MGTYTXN2_132
set_property PACKAGE_PIN R45       [get_ports "No Connect"] ;# Bank 132 - MGTYTXN3_132
set_property PACKAGE_PIN V46       [get_ports "No Connect"] ;# Bank 132 - MGTYTXP0_132
set_property PACKAGE_PIN U44       [get_ports "No Connect"] ;# Bank 132 - MGTYTXP1_132
set_property PACKAGE_PIN T46       [get_ports "No Connect"] ;# Bank 132 - MGTYTXP2_132
set_property PACKAGE_PIN R44       [get_ports "No Connect"] ;# Bank 132 - MGTYTXP3_132
set_property PACKAGE_PIN V43       [get_ports "No Connect"] ;# Bank 133 - MGTREFCLK0N_133
set_property PACKAGE_PIN V42       [get_ports "No Connect"] ;# Bank 133 - MGTREFCLK0P_133
set_property PACKAGE_PIN U41       [get_ports "No Connect"] ;# Bank 133 - MGTREFCLK1N_133
set_property PACKAGE_PIN U40       [get_ports "No Connect"] ;# Bank 133 - MGTREFCLK1P_133
set_property PACKAGE_PIN N41       [get_ports "N38370065"] ;# Bank 133 - MGTRREF_LN
set_property PACKAGE_PIN R50       [get_ports "GND"] ;# Bank 133 - MGTYRXN0_133
set_property PACKAGE_PIN P52       [get_ports "GND"] ;# Bank 133 - MGTYRXN1_133
set_property PACKAGE_PIN N54       [get_ports "GND"] ;# Bank 133 - MGTYRXN2_133
set_property PACKAGE_PIN M52       [get_ports "GND"] ;# Bank 133 - MGTYRXN3_133
set_property PACKAGE_PIN R49       [get_ports "GND"] ;# Bank 133 - MGTYRXP0_133
set_property PACKAGE_PIN P51       [get_ports "GND"] ;# Bank 133 - MGTYRXP1_133
set_property PACKAGE_PIN N53       [get_ports "GND"] ;# Bank 133 - MGTYRXP2_133
set_property PACKAGE_PIN M51       [get_ports "GND"] ;# Bank 133 - MGTYRXP3_133
set_property PACKAGE_PIN P47       [get_ports "No Connect"] ;# Bank 133 - MGTYTXN0_133
set_property PACKAGE_PIN N49       [get_ports "No Connect"] ;# Bank 133 - MGTYTXN1_133
set_property PACKAGE_PIN N45       [get_ports "No Connect"] ;# Bank 133 - MGTYTXN2_133
set_property PACKAGE_PIN M47       [get_ports "No Connect"] ;# Bank 133 - MGTYTXN3_133
set_property PACKAGE_PIN P46       [get_ports "No Connect"] ;# Bank 133 - MGTYTXP0_133
set_property PACKAGE_PIN N48       [get_ports "No Connect"] ;# Bank 133 - MGTYTXP1_133
set_property PACKAGE_PIN N44       [get_ports "No Connect"] ;# Bank 133 - MGTYTXP2_133
set_property PACKAGE_PIN M46       [get_ports "No Connect"] ;# Bank 133 - MGTYTXP3_133
set_property PACKAGE_PIN T43       [get_ports "MGT_SI570_CLOCK0_C_N"] ;# Bank 134 - MGTREFCLK0N_134
set_property PACKAGE_PIN T42       [get_ports "MGT_SI570_CLOCK0_C_P"] ;# Bank 134 - MGTREFCLK0P_134
set_property PACKAGE_PIN R41       [get_ports "QSFP0_CLOCK_N"] ;# Bank 134 - MGTREFCLK1N_134
set_property PACKAGE_PIN R40       [get_ports "QSFP0_CLOCK_P"] ;# Bank 134 - MGTREFCLK1P_134
set_property PACKAGE_PIN L54       [get_ports "QSFP0_RX1_N"] ;# Bank 134 - MGTYRXN0_134
set_property PACKAGE_PIN K52       [get_ports "QSFP0_RX2_N"] ;# Bank 134 - MGTYRXN1_134
set_property PACKAGE_PIN J54       [get_ports "QSFP0_RX3_N"] ;# Bank 134 - MGTYRXN2_134
set_property PACKAGE_PIN H52       [get_ports "QSFP0_RX4_N"] ;# Bank 134 - MGTYRXN3_134
set_property PACKAGE_PIN L53       [get_ports "QSFP0_RX1_P"] ;# Bank 134 - MGTYRXP0_134
set_property PACKAGE_PIN K51       [get_ports "QSFP0_RX2_P"] ;# Bank 134 - MGTYRXP1_134
set_property PACKAGE_PIN J53       [get_ports "QSFP0_RX3_P"] ;# Bank 134 - MGTYRXP2_134
set_property PACKAGE_PIN H51       [get_ports "QSFP0_RX4_P"] ;# Bank 134 - MGTYRXP3_134
set_property PACKAGE_PIN L49       [get_ports "QSFP0_TX1_N"] ;# Bank 134 - MGTYTXN0_134
set_property PACKAGE_PIN L45       [get_ports "QSFP0_TX2_N"] ;# Bank 134 - MGTYTXN1_134
set_property PACKAGE_PIN K47       [get_ports "QSFP0_TX3_N"] ;# Bank 134 - MGTYTXN2_134
set_property PACKAGE_PIN J49       [get_ports "QSFP0_TX4_N"] ;# Bank 134 - MGTYTXN3_134
set_property PACKAGE_PIN L48       [get_ports "QSFP0_TX1_P"] ;# Bank 134 - MGTYTXP0_134
set_property PACKAGE_PIN L44       [get_ports "QSFP0_TX2_P"] ;# Bank 134 - MGTYTXP1_134
set_property PACKAGE_PIN K46       [get_ports "QSFP0_TX3_P"] ;# Bank 134 - MGTYTXP2_134
set_property PACKAGE_PIN J48       [get_ports "QSFP0_TX4_P"] ;# Bank 134 - MGTYTXP3_134
set_property PACKAGE_PIN P43       [get_ports "MGT_SI570_CLOCK1_C_N"] ;# Bank 135 - MGTREFCLK0N_135
set_property PACKAGE_PIN P42       [get_ports "MGT_SI570_CLOCK1_C_P"] ;# Bank 135 - MGTREFCLK0P_135
set_property PACKAGE_PIN M43       [get_ports "QSFP1_CLOCK_N"] ;# Bank 135 - MGTREFCLK1N_135
set_property PACKAGE_PIN M42       [get_ports "QSFP1_CLOCK_P"] ;# Bank 135 - MGTREFCLK1P_135
set_property PACKAGE_PIN G54       [get_ports "QSFP1_RX1_N"] ;# Bank 135 - MGTYRXN0_135
set_property PACKAGE_PIN F52       [get_ports "QSFP1_RX2_N"] ;# Bank 135 - MGTYRXN1_135
set_property PACKAGE_PIN E54       [get_ports "QSFP1_RX3_N"] ;# Bank 135 - MGTYRXN2_135
set_property PACKAGE_PIN D52       [get_ports "QSFP1_RX4_N"] ;# Bank 135 - MGTYRXN3_135
set_property PACKAGE_PIN G53       [get_ports "QSFP1_RX1_P"] ;# Bank 135 - MGTYRXP0_135
set_property PACKAGE_PIN F51       [get_ports "QSFP1_RX2_P"] ;# Bank 135 - MGTYRXP1_135
set_property PACKAGE_PIN E53       [get_ports "QSFP1_RX3_P"] ;# Bank 135 - MGTYRXP2_135
set_property PACKAGE_PIN D51       [get_ports "QSFP1_RX4_P"] ;# Bank 135 - MGTYRXP3_135
set_property PACKAGE_PIN G49       [get_ports "QSFP1_TX1_N"] ;# Bank 135 - MGTYTXN0_135
set_property PACKAGE_PIN E49       [get_ports "QSFP1_TX2_N"] ;# Bank 135 - MGTYTXN1_135
set_property PACKAGE_PIN C49       [get_ports "QSFP1_TX3_N"] ;# Bank 135 - MGTYTXN2_135
set_property PACKAGE_PIN A50       [get_ports "QSFP1_TX4_N"] ;# Bank 135 - MGTYTXN3_135
set_property PACKAGE_PIN G48       [get_ports "QSFP1_TX1_P"] ;# Bank 135 - MGTYTXP0_135
set_property PACKAGE_PIN E48       [get_ports "QSFP1_TX2_P"] ;# Bank 135 - MGTYTXP1_135
set_property PACKAGE_PIN C48       [get_ports "QSFP1_TX3_P"] ;# Bank 135 - MGTYTXP2_135
set_property PACKAGE_PIN A49       [get_ports "QSFP1_TX4_P"] ;# Bank 135 - MGTYTXP3_135
set_property PACKAGE_PIN AV12      [get_ports "No Connect"] ;# Bank 224 - MGTREFCLK0N_224
set_property PACKAGE_PIN AV13      [get_ports "No Connect"] ;# Bank 224 - MGTREFCLK0P_224
set_property PACKAGE_PIN AT12      [get_ports "No Connect"] ;# Bank 224 - MGTREFCLK1N_224
set_property PACKAGE_PIN AT13      [get_ports "No Connect"] ;# Bank 224 - MGTREFCLK1P_224
set_property PACKAGE_PIN BC1       [get_ports "PEX_RX15_N"] ;# Bank 224 - MGTYRXN0_224
set_property PACKAGE_PIN BB3       [get_ports "PEX_RX14_N"] ;# Bank 224 - MGTYRXN1_224
set_property PACKAGE_PIN BA1       [get_ports "PEX_RX13_N"] ;# Bank 224 - MGTYRXN2_224
set_property PACKAGE_PIN BA5       [get_ports "PEX_RX12_N"] ;# Bank 224 - MGTYRXN3_224
set_property PACKAGE_PIN BC2       [get_ports "PEX_RX15_P"] ;# Bank 224 - MGTYRXP0_224
set_property PACKAGE_PIN BB4       [get_ports "PEX_RX14_P"] ;# Bank 224 - MGTYRXP1_224
set_property PACKAGE_PIN BA2       [get_ports "PEX_RX13_P"] ;# Bank 224 - MGTYRXP2_224
set_property PACKAGE_PIN BA6       [get_ports "PEX_RX12_P"] ;# Bank 224 - MGTYRXP3_224
set_property PACKAGE_PIN BC6       [get_ports "PEX_TX15_N"] ;# Bank 224 - MGTYTXN0_224
set_property PACKAGE_PIN BC10      [get_ports "PEX_TX14_N"] ;# Bank 224 - MGTYTXN1_224
set_property PACKAGE_PIN BB8       [get_ports "PEX_TX13_N"] ;# Bank 224 - MGTYTXN2_224
set_property PACKAGE_PIN BA10      [get_ports "PEX_TX12_N"] ;# Bank 224 - MGTYTXN3_224
set_property PACKAGE_PIN BC7       [get_ports "PEX_TX15_P"] ;# Bank 224 - MGTYTXP0_224
set_property PACKAGE_PIN BC11      [get_ports "PEX_TX14_P"] ;# Bank 224 - MGTYTXP1_224
set_property PACKAGE_PIN BB9       [get_ports "PEX_TX13_P"] ;# Bank 224 - MGTYTXP2_224
set_property PACKAGE_PIN BA11      [get_ports "PEX_TX12_P"] ;# Bank 224 - MGTYTXP3_224
set_property PACKAGE_PIN AR14      [get_ports "PCIE_CLK1_N"] ;# Bank 225 - MGTREFCLK0N_225
set_property PACKAGE_PIN AR15      [get_ports "PCIE_CLK1_P"] ;# Bank 225 - MGTREFCLK0P_225
set_property PACKAGE_PIN AP12      [get_ports "SYSCLK5_N"] ;# Bank 225 - MGTREFCLK1N_225
set_property PACKAGE_PIN AP13      [get_ports "SYSCLK5_P"] ;# Bank 225 - MGTREFCLK1P_225
set_property PACKAGE_PIN AU14      [get_ports "N301382400"] ;# Bank 225 - MGTRREF_RS
set_property PACKAGE_PIN AY3       [get_ports "PEX_RX11_N"] ;# Bank 225 - MGTYRXN0_225
set_property PACKAGE_PIN AW1       [get_ports "PEX_RX10_N"] ;# Bank 225 - MGTYRXN1_225
set_property PACKAGE_PIN AW5       [get_ports "PEX_RX9_N"] ;# Bank 225 - MGTYRXN2_225
set_property PACKAGE_PIN AV3       [get_ports "PEX_RX8_N"] ;# Bank 225 - MGTYRXN3_225
set_property PACKAGE_PIN AY4       [get_ports "PEX_RX11_P"] ;# Bank 225 - MGTYRXP0_225
set_property PACKAGE_PIN AW2       [get_ports "PEX_RX10_P"] ;# Bank 225 - MGTYRXP1_225
set_property PACKAGE_PIN AW6       [get_ports "PEX_RX9_P"] ;# Bank 225 - MGTYRXP2_225
set_property PACKAGE_PIN AV4       [get_ports "PEX_RX8_P"] ;# Bank 225 - MGTYRXP3_225
set_property PACKAGE_PIN AY8       [get_ports "PEX_TX11_N"] ;# Bank 225 - MGTYTXN0_225
set_property PACKAGE_PIN AW10      [get_ports "PEX_TX10_N"] ;# Bank 225 - MGTYTXN1_225
set_property PACKAGE_PIN AV8       [get_ports "PEX_TX9_N"] ;# Bank 225 - MGTYTXN2_225
set_property PACKAGE_PIN AU6       [get_ports "PEX_TX8_N"] ;# Bank 225 - MGTYTXN3_225
set_property PACKAGE_PIN AY9       [get_ports "PEX_TX11_P"] ;# Bank 225 - MGTYTXP0_225
set_property PACKAGE_PIN AW11      [get_ports "PEX_TX10_P"] ;# Bank 225 - MGTYTXP1_225
set_property PACKAGE_PIN AV9       [get_ports "PEX_TX9_P"] ;# Bank 225 - MGTYTXP2_225
set_property PACKAGE_PIN AU7       [get_ports "PEX_TX8_P"] ;# Bank 225 - MGTYTXP3_225
set_property PACKAGE_PIN AN14      [get_ports "No Connect"] ;# Bank 226 - MGTREFCLK0N_226
set_property PACKAGE_PIN AN15      [get_ports "No Connect"] ;# Bank 226 - MGTREFCLK0P_226
set_property PACKAGE_PIN AM12      [get_ports "No Connect"] ;# Bank 226 - MGTREFCLK1N_226
set_property PACKAGE_PIN AM13      [get_ports "No Connect"] ;# Bank 226 - MGTREFCLK1P_226
set_property PACKAGE_PIN AU1       [get_ports "PEX_RX7_N"] ;# Bank 226 - MGTYRXN0_226
set_property PACKAGE_PIN AT3       [get_ports "PEX_RX6_N"] ;# Bank 226 - MGTYRXN1_226
set_property PACKAGE_PIN AR1       [get_ports "PEX_RX5_N"] ;# Bank 226 - MGTYRXN2_226
set_property PACKAGE_PIN AP3       [get_ports "PEX_RX4_N"] ;# Bank 226 - MGTYRXN3_226
set_property PACKAGE_PIN AU2       [get_ports "PEX_RX7_P"] ;# Bank 226 - MGTYRXP0_226
set_property PACKAGE_PIN AT4       [get_ports "PEX_RX6_P"] ;# Bank 226 - MGTYRXP1_226
set_property PACKAGE_PIN AR2       [get_ports "PEX_RX5_P"] ;# Bank 226 - MGTYRXP2_226
set_property PACKAGE_PIN AP4       [get_ports "PEX_RX4_P"] ;# Bank 226 - MGTYRXP3_226
set_property PACKAGE_PIN AU10      [get_ports "PEX_TX7_N"] ;# Bank 226 - MGTYTXN0_226
set_property PACKAGE_PIN AT8       [get_ports "PEX_TX6_N"] ;# Bank 226 - MGTYTXN1_226
set_property PACKAGE_PIN AR6       [get_ports "PEX_TX5_N"] ;# Bank 226 - MGTYTXN2_226
set_property PACKAGE_PIN AR10      [get_ports "PEX_TX4_N"] ;# Bank 226 - MGTYTXN3_226
set_property PACKAGE_PIN AU11      [get_ports "PEX_TX7_P"] ;# Bank 226 - MGTYTXP0_226
set_property PACKAGE_PIN AT9       [get_ports "PEX_TX6_P"] ;# Bank 226 - MGTYTXP1_226
set_property PACKAGE_PIN AR7       [get_ports "PEX_TX5_P"] ;# Bank 226 - MGTYTXP2_226
set_property PACKAGE_PIN AR11      [get_ports "PEX_TX4_P"] ;# Bank 226 - MGTYTXP3_226
set_property PACKAGE_PIN AL14      [get_ports "PCIE_CLK0_N"] ;# Bank 227 - MGTREFCLK0N_227
set_property PACKAGE_PIN AL15      [get_ports "PCIE_CLK0_P"] ;# Bank 227 - MGTREFCLK0P_227
set_property PACKAGE_PIN AK12      [get_ports "SYSCLK2_N"] ;# Bank 227 - MGTREFCLK1N_227
set_property PACKAGE_PIN AK13      [get_ports "SYSCLK2_P"] ;# Bank 227 - MGTREFCLK1P_227
set_property PACKAGE_PIN AN1       [get_ports "PEX_RX3_N"] ;# Bank 227 - MGTYRXN0_227
set_property PACKAGE_PIN AN5       [get_ports "PEX_RX2_N"] ;# Bank 227 - MGTYRXN1_227
set_property PACKAGE_PIN AM3       [get_ports "PEX_RX1_N"] ;# Bank 227 - MGTYRXN2_227
set_property PACKAGE_PIN AL1       [get_ports "PEX_RX0_N"] ;# Bank 227 - MGTYRXN3_227
set_property PACKAGE_PIN AN2       [get_ports "PEX_RX3_P"] ;# Bank 227 - MGTYRXP0_227
set_property PACKAGE_PIN AN6       [get_ports "PEX_RX2_P"] ;# Bank 227 - MGTYRXP1_227
set_property PACKAGE_PIN AM4       [get_ports "PEX_RX1_P"] ;# Bank 227 - MGTYRXP2_227
set_property PACKAGE_PIN AL2       [get_ports "PEX_RX0_P"] ;# Bank 227 - MGTYRXP3_227
set_property PACKAGE_PIN AP8       [get_ports "PEX_TX3_N"] ;# Bank 227 - MGTYTXN0_227
set_property PACKAGE_PIN AN10      [get_ports "PEX_TX2_N"] ;# Bank 227 - MGTYTXN1_227
set_property PACKAGE_PIN AM8       [get_ports "PEX_TX1_N"] ;# Bank 227 - MGTYTXN2_227
set_property PACKAGE_PIN AL10      [get_ports "PEX_TX0_N"] ;# Bank 227 - MGTYTXN3_227
set_property PACKAGE_PIN AP9       [get_ports "PEX_TX3_P"] ;# Bank 227 - MGTYTXP0_227
set_property PACKAGE_PIN AN11      [get_ports "PEX_TX2_P"] ;# Bank 227 - MGTYTXP1_227
set_property PACKAGE_PIN AM9       [get_ports "PEX_TX1_P"] ;# Bank 227 - MGTYTXP2_227
set_property PACKAGE_PIN AL11      [get_ports "PEX_TX0_P"] ;# Bank 227 - MGTYTXP3_227
set_property PACKAGE_PIN AJ14      [get_ports "No Connect"] ;# Bank 228 - MGTREFCLK0N_228
set_property PACKAGE_PIN AJ15      [get_ports "No Connect"] ;# Bank 228 - MGTREFCLK0P_228
set_property PACKAGE_PIN AH12      [get_ports "No Connect"] ;# Bank 228 - MGTREFCLK1N_228
set_property PACKAGE_PIN AH13      [get_ports "No Connect"] ;# Bank 228 - MGTREFCLK1P_228
set_property PACKAGE_PIN AL5       [get_ports "GND"] ;# Bank 228 - MGTYRXN0_228
set_property PACKAGE_PIN AK3       [get_ports "GND"] ;# Bank 228 - MGTYRXN1_228
set_property PACKAGE_PIN AJ1       [get_ports "GND"] ;# Bank 228 - MGTYRXN2_228
set_property PACKAGE_PIN AH3       [get_ports "GND"] ;# Bank 228 - MGTYRXN3_228
set_property PACKAGE_PIN AL6       [get_ports "GND"] ;# Bank 228 - MGTYRXP0_228
set_property PACKAGE_PIN AK4       [get_ports "GND"] ;# Bank 228 - MGTYRXP1_228
set_property PACKAGE_PIN AJ2       [get_ports "GND"] ;# Bank 228 - MGTYRXP2_228
set_property PACKAGE_PIN AH4       [get_ports "GND"] ;# Bank 228 - MGTYRXP3_228
set_property PACKAGE_PIN AK8       [get_ports "No Connect"] ;# Bank 228 - MGTYTXN0_228
set_property PACKAGE_PIN AJ6       [get_ports "No Connect"] ;# Bank 228 - MGTYTXN1_228
set_property PACKAGE_PIN AJ10      [get_ports "No Connect"] ;# Bank 228 - MGTYTXN2_228
set_property PACKAGE_PIN AH8       [get_ports "No Connect"] ;# Bank 228 - MGTYTXN3_228
set_property PACKAGE_PIN AK9       [get_ports "No Connect"] ;# Bank 228 - MGTYTXP0_228
set_property PACKAGE_PIN AJ7       [get_ports "No Connect"] ;# Bank 228 - MGTYTXP1_228
set_property PACKAGE_PIN AJ11      [get_ports "No Connect"] ;# Bank 228 - MGTYTXP2_228
set_property PACKAGE_PIN AH9       [get_ports "No Connect"] ;# Bank 228 - MGTYTXP3_228
set_property PACKAGE_PIN AG14      [get_ports "No Connect"] ;# Bank 229 - MGTREFCLK0N_229
set_property PACKAGE_PIN AG15      [get_ports "No Connect"] ;# Bank 229 - MGTREFCLK0P_229
set_property PACKAGE_PIN AF12      [get_ports "No Connect"] ;# Bank 229 - MGTREFCLK1N_229
set_property PACKAGE_PIN AF13      [get_ports "No Connect"] ;# Bank 229 - MGTREFCLK1P_229
set_property PACKAGE_PIN AE14      [get_ports "GND"] ;# Bank 229 - MGTRREF_RC
set_property PACKAGE_PIN AG1       [get_ports "GND"] ;# Bank 229 - MGTYRXN0_229
set_property PACKAGE_PIN AF3       [get_ports "GND"] ;# Bank 229 - MGTYRXN1_229
set_property PACKAGE_PIN AE1       [get_ports "GND"] ;# Bank 229 - MGTYRXN2_229
set_property PACKAGE_PIN AE5       [get_ports "GND"] ;# Bank 229 - MGTYRXN3_229
set_property PACKAGE_PIN AG2       [get_ports "GND"] ;# Bank 229 - MGTYRXP0_229
set_property PACKAGE_PIN AF4       [get_ports "GND"] ;# Bank 229 - MGTYRXP1_229
set_property PACKAGE_PIN AE2       [get_ports "GND"] ;# Bank 229 - MGTYRXP2_229
set_property PACKAGE_PIN AE6       [get_ports "GND"] ;# Bank 229 - MGTYRXP3_229
set_property PACKAGE_PIN AG6       [get_ports "No Connect"] ;# Bank 229 - MGTYTXN0_229
set_property PACKAGE_PIN AG10      [get_ports "No Connect"] ;# Bank 229 - MGTYTXN1_229
set_property PACKAGE_PIN AF8       [get_ports "No Connect"] ;# Bank 229 - MGTYTXN2_229
set_property PACKAGE_PIN AE10      [get_ports "No Connect"] ;# Bank 229 - MGTYTXN3_229
set_property PACKAGE_PIN AG7       [get_ports "No Connect"] ;# Bank 229 - MGTYTXP0_229
set_property PACKAGE_PIN AG11      [get_ports "No Connect"] ;# Bank 229 - MGTYTXP1_229
set_property PACKAGE_PIN AF9       [get_ports "No Connect"] ;# Bank 229 - MGTYTXP2_229
set_property PACKAGE_PIN AE11      [get_ports "No Connect"] ;# Bank 229 - MGTYTXP3_229
set_property PACKAGE_PIN AD12      [get_ports "No Connect"] ;# Bank 230 - MGTREFCLK0N_230
set_property PACKAGE_PIN AD13      [get_ports "No Connect"] ;# Bank 230 - MGTREFCLK0P_230
set_property PACKAGE_PIN AC14      [get_ports "No Connect"] ;# Bank 230 - MGTREFCLK1N_230
set_property PACKAGE_PIN AC15      [get_ports "No Connect"] ;# Bank 230 - MGTREFCLK1P_230
set_property PACKAGE_PIN AD3       [get_ports "GND"] ;# Bank 230 - MGTYRXN0_230
set_property PACKAGE_PIN AC1       [get_ports "GND"] ;# Bank 230 - MGTYRXN1_230
set_property PACKAGE_PIN AC5       [get_ports "GND"] ;# Bank 230 - MGTYRXN2_230
set_property PACKAGE_PIN AB3       [get_ports "GND"] ;# Bank 230 - MGTYRXN3_230
set_property PACKAGE_PIN AD4       [get_ports "GND"] ;# Bank 230 - MGTYRXP0_230
set_property PACKAGE_PIN AC2       [get_ports "GND"] ;# Bank 230 - MGTYRXP1_230
set_property PACKAGE_PIN AC6       [get_ports "GND"] ;# Bank 230 - MGTYRXP2_230
set_property PACKAGE_PIN AB4       [get_ports "GND"] ;# Bank 230 - MGTYRXP3_230
set_property PACKAGE_PIN AD8       [get_ports "No Connect"] ;# Bank 230 - MGTYTXN0_230
set_property PACKAGE_PIN AC10      [get_ports "No Connect"] ;# Bank 230 - MGTYTXN1_230
set_property PACKAGE_PIN AB8       [get_ports "No Connect"] ;# Bank 230 - MGTYTXN2_230
set_property PACKAGE_PIN AA6       [get_ports "No Connect"] ;# Bank 230 - MGTYTXN3_230
set_property PACKAGE_PIN AD9       [get_ports "No Connect"] ;# Bank 230 - MGTYTXP0_230
set_property PACKAGE_PIN AC11      [get_ports "No Connect"] ;# Bank 230 - MGTYTXP1_230
set_property PACKAGE_PIN AB9       [get_ports "No Connect"] ;# Bank 230 - MGTYTXP2_230
set_property PACKAGE_PIN AA7       [get_ports "No Connect"] ;# Bank 230 - MGTYTXP3_230
set_property PACKAGE_PIN AB12      [get_ports "No Connect"] ;# Bank 231 - MGTREFCLK0N_231
set_property PACKAGE_PIN AB13      [get_ports "No Connect"] ;# Bank 231 - MGTREFCLK0P_231
set_property PACKAGE_PIN AA14      [get_ports "No Connect"] ;# Bank 231 - MGTREFCLK1N_231
set_property PACKAGE_PIN AA15      [get_ports "No Connect"] ;# Bank 231 - MGTREFCLK1P_231
set_property PACKAGE_PIN AA1       [get_ports "GND"] ;# Bank 231 - MGTYRXN0_231
set_property PACKAGE_PIN Y3        [get_ports "GND"] ;# Bank 231 - MGTYRXN1_231
set_property PACKAGE_PIN W1        [get_ports "GND"] ;# Bank 231 - MGTYRXN2_231
set_property PACKAGE_PIN V3        [get_ports "GND"] ;# Bank 231 - MGTYRXN3_231
set_property PACKAGE_PIN AA2       [get_ports "GND"] ;# Bank 231 - MGTYRXP0_231
set_property PACKAGE_PIN Y4        [get_ports "GND"] ;# Bank 231 - MGTYRXP1_231
set_property PACKAGE_PIN W2        [get_ports "GND"] ;# Bank 231 - MGTYRXP2_231
set_property PACKAGE_PIN V4        [get_ports "GND"] ;# Bank 231 - MGTYRXP3_231
set_property PACKAGE_PIN AA10      [get_ports "No Connect"] ;# Bank 231 - MGTYTXN0_231
set_property PACKAGE_PIN Y8        [get_ports "No Connect"] ;# Bank 231 - MGTYTXN1_231
set_property PACKAGE_PIN W6        [get_ports "No Connect"] ;# Bank 231 - MGTYTXN2_231
set_property PACKAGE_PIN W10       [get_ports "No Connect"] ;# Bank 231 - MGTYTXN3_231
set_property PACKAGE_PIN AA11      [get_ports "No Connect"] ;# Bank 231 - MGTYTXP0_231
set_property PACKAGE_PIN Y9        [get_ports "No Connect"] ;# Bank 231 - MGTYTXP1_231
set_property PACKAGE_PIN W7        [get_ports "No Connect"] ;# Bank 231 - MGTYTXP2_231
set_property PACKAGE_PIN W11       [get_ports "No Connect"] ;# Bank 231 - MGTYTXP3_231
set_property PACKAGE_PIN Y12       [get_ports "No Connect"] ;# Bank 232 - MGTREFCLK0N_232
set_property PACKAGE_PIN Y13       [get_ports "No Connect"] ;# Bank 232 - MGTREFCLK0P_232
set_property PACKAGE_PIN W14       [get_ports "No Connect"] ;# Bank 232 - MGTREFCLK1N_232
set_property PACKAGE_PIN W15       [get_ports "No Connect"] ;# Bank 232 - MGTREFCLK1P_232
set_property PACKAGE_PIN U1        [get_ports "GND"] ;# Bank 232 - MGTYRXN0_232
set_property PACKAGE_PIN U5        [get_ports "GND"] ;# Bank 232 - MGTYRXN1_232
set_property PACKAGE_PIN T3        [get_ports "GND"] ;# Bank 232 - MGTYRXN2_232
set_property PACKAGE_PIN R1        [get_ports "GND"] ;# Bank 232 - MGTYRXN3_232
set_property PACKAGE_PIN U2        [get_ports "GND"] ;# Bank 232 - MGTYRXP0_232
set_property PACKAGE_PIN U6        [get_ports "GND"] ;# Bank 232 - MGTYRXP1_232
set_property PACKAGE_PIN T4        [get_ports "GND"] ;# Bank 232 - MGTYRXP2_232
set_property PACKAGE_PIN R2        [get_ports "GND"] ;# Bank 232 - MGTYRXP3_232
set_property PACKAGE_PIN V8        [get_ports "No Connect"] ;# Bank 232 - MGTYTXN0_232
set_property PACKAGE_PIN U10       [get_ports "No Connect"] ;# Bank 232 - MGTYTXN1_232
set_property PACKAGE_PIN T8        [get_ports "No Connect"] ;# Bank 232 - MGTYTXN2_232
set_property PACKAGE_PIN R10       [get_ports "No Connect"] ;# Bank 232 - MGTYTXN3_232
set_property PACKAGE_PIN V9        [get_ports "No Connect"] ;# Bank 232 - MGTYTXP0_232
set_property PACKAGE_PIN U11       [get_ports "No Connect"] ;# Bank 232 - MGTYTXP1_232
set_property PACKAGE_PIN T9        [get_ports "No Connect"] ;# Bank 232 - MGTYTXP2_232
set_property PACKAGE_PIN R11       [get_ports "No Connect"] ;# Bank 232 - MGTYTXP3_232
set_property PACKAGE_PIN V12       [get_ports "No Connect"] ;# Bank 233 - MGTREFCLK0N_233
set_property PACKAGE_PIN V13       [get_ports "No Connect"] ;# Bank 233 - MGTREFCLK0P_233
set_property PACKAGE_PIN U14       [get_ports "No Connect"] ;# Bank 233 - MGTREFCLK1N_233
set_property PACKAGE_PIN U15       [get_ports "No Connect"] ;# Bank 233 - MGTREFCLK1P_233
set_property PACKAGE_PIN N14       [get_ports "GND"] ;# Bank 233 - MGTRREF_RN
set_property PACKAGE_PIN R5        [get_ports "GND"] ;# Bank 233 - MGTYRXN0_233
set_property PACKAGE_PIN P3        [get_ports "GND"] ;# Bank 233 - MGTYRXN1_233
set_property PACKAGE_PIN N1        [get_ports "GND"] ;# Bank 233 - MGTYRXN2_233
set_property PACKAGE_PIN M3        [get_ports "GND"] ;# Bank 233 - MGTYRXN3_233
set_property PACKAGE_PIN R6        [get_ports "GND"] ;# Bank 233 - MGTYRXP0_233
set_property PACKAGE_PIN P4        [get_ports "GND"] ;# Bank 233 - MGTYRXP1_233
set_property PACKAGE_PIN N2        [get_ports "GND"] ;# Bank 233 - MGTYRXP2_233
set_property PACKAGE_PIN M4        [get_ports "GND"] ;# Bank 233 - MGTYRXP3_233
set_property PACKAGE_PIN P8        [get_ports "No Connect"] ;# Bank 233 - MGTYTXN0_233
set_property PACKAGE_PIN N6        [get_ports "No Connect"] ;# Bank 233 - MGTYTXN1_233
set_property PACKAGE_PIN N10       [get_ports "No Connect"] ;# Bank 233 - MGTYTXN2_233
set_property PACKAGE_PIN M8        [get_ports "No Connect"] ;# Bank 233 - MGTYTXN3_233
set_property PACKAGE_PIN P9        [get_ports "No Connect"] ;# Bank 233 - MGTYTXP0_233
set_property PACKAGE_PIN N7        [get_ports "No Connect"] ;# Bank 233 - MGTYTXP1_233
set_property PACKAGE_PIN N11       [get_ports "No Connect"] ;# Bank 233 - MGTYTXP2_233
set_property PACKAGE_PIN M9        [get_ports "No Connect"] ;# Bank 233 - MGTYTXP3_233
set_property PACKAGE_PIN T12       [get_ports "No Connect"] ;# Bank 234 - MGTREFCLK0N_234
set_property PACKAGE_PIN T13       [get_ports "No Connect"] ;# Bank 234 - MGTREFCLK0P_234
set_property PACKAGE_PIN R14       [get_ports "No Connect"] ;# Bank 234 - MGTREFCLK1N_234
set_property PACKAGE_PIN R15       [get_ports "No Connect"] ;# Bank 234 - MGTREFCLK1P_234
set_property PACKAGE_PIN L1        [get_ports "GND"] ;# Bank 234 - MGTYRXN0_234
set_property PACKAGE_PIN K3        [get_ports "GND"] ;# Bank 234 - MGTYRXN1_234
set_property PACKAGE_PIN J1        [get_ports "GND"] ;# Bank 234 - MGTYRXN2_234
set_property PACKAGE_PIN H3        [get_ports "GND"] ;# Bank 234 - MGTYRXN3_234
set_property PACKAGE_PIN L2        [get_ports "GND"] ;# Bank 234 - MGTYRXP0_234
set_property PACKAGE_PIN K4        [get_ports "GND"] ;# Bank 234 - MGTYRXP1_234
set_property PACKAGE_PIN J2        [get_ports "GND"] ;# Bank 234 - MGTYRXP2_234
set_property PACKAGE_PIN H4        [get_ports "GND"] ;# Bank 234 - MGTYRXP3_234
set_property PACKAGE_PIN L6        [get_ports "No Connect"] ;# Bank 234 - MGTYTXN0_234
set_property PACKAGE_PIN L10       [get_ports "No Connect"] ;# Bank 234 - MGTYTXN1_234
set_property PACKAGE_PIN K8        [get_ports "No Connect"] ;# Bank 234 - MGTYTXN2_234
set_property PACKAGE_PIN J6        [get_ports "No Connect"] ;# Bank 234 - MGTYTXN3_234
set_property PACKAGE_PIN L7        [get_ports "No Connect"] ;# Bank 234 - MGTYTXP0_234
set_property PACKAGE_PIN L11       [get_ports "No Connect"] ;# Bank 234 - MGTYTXP1_234
set_property PACKAGE_PIN K9        [get_ports "No Connect"] ;# Bank 234 - MGTYTXP2_234
set_property PACKAGE_PIN J7        [get_ports "No Connect"] ;# Bank 234 - MGTYTXP3_234
set_property PACKAGE_PIN P12       [get_ports "No Connect"] ;# Bank 235 - MGTREFCLK0N_235
set_property PACKAGE_PIN P13       [get_ports "No Connect"] ;# Bank 235 - MGTREFCLK0P_235
set_property PACKAGE_PIN M12       [get_ports "No Connect"] ;# Bank 235 - MGTREFCLK1N_235
set_property PACKAGE_PIN M13       [get_ports "No Connect"] ;# Bank 235 - MGTREFCLK1P_235
set_property PACKAGE_PIN G1        [get_ports "GND"] ;# Bank 235 - MGTYRXN0_235
set_property PACKAGE_PIN F3        [get_ports "GND"] ;# Bank 235 - MGTYRXN1_235
set_property PACKAGE_PIN E1        [get_ports "GND"] ;# Bank 235 - MGTYRXN2_235
set_property PACKAGE_PIN D3        [get_ports "GND"] ;# Bank 235 - MGTYRXN3_235
set_property PACKAGE_PIN G2        [get_ports "GND"] ;# Bank 235 - MGTYRXP0_235
set_property PACKAGE_PIN F4        [get_ports "GND"] ;# Bank 235 - MGTYRXP1_235
set_property PACKAGE_PIN E2        [get_ports "GND"] ;# Bank 235 - MGTYRXP2_235
set_property PACKAGE_PIN D4        [get_ports "GND"] ;# Bank 235 - MGTYRXP3_235
set_property PACKAGE_PIN G6        [get_ports "No Connect"] ;# Bank 235 - MGTYTXN0_235
set_property PACKAGE_PIN E6        [get_ports "No Connect"] ;# Bank 235 - MGTYTXN1_235
set_property PACKAGE_PIN C6        [get_ports "No Connect"] ;# Bank 235 - MGTYTXN2_235
set_property PACKAGE_PIN A5        [get_ports "No Connect"] ;# Bank 235 - MGTYTXN3_235
set_property PACKAGE_PIN G7        [get_ports "No Connect"] ;# Bank 235 - MGTYTXP0_235
set_property PACKAGE_PIN E7        [get_ports "No Connect"] ;# Bank 235 - MGTYTXP1_235
set_property PACKAGE_PIN C7        [get_ports "No Connect"] ;# Bank 235 - MGTYTXP2_235
set_property PACKAGE_PIN A6        [get_ports "No Connect"] ;# Bank 235 - MGTYTXP3_235
