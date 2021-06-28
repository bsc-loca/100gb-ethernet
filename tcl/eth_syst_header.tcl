
# Script to generate C-header containing hardware definitions for Ethernet core

set bd_tcl [open ./bd/Eth_CMAC_syst/eth_cmac_syst.tcl  r]
set bd_hdr [open ./bd/Eth_CMAC_syst/eth_syst_hwparam.h w]

puts $bd_hdr "#ifndef ETH_HWPAR_H  // prevent circular inclusions"
puts $bd_hdr "#define ETH_HWPAR_H  // by using protection macros"
puts $bd_hdr ""
puts $bd_hdr "enum {"

set comma_first 0
while {[gets $bd_tcl line] >= 0} {

  # extracting some DMA hw definitions
  if      {[string first "set eth_dma" $line] >= 0} {
    while {[string first  {] $eth_dma} $line] <  0} {
      gets $bd_tcl line
      if        {[string first "CONFIG.c_m_axis_mm2s_tdata_width" $line] >= 0} {
        set line [string map  {"CONFIG.c_m_axis_mm2s_tdata_width" "ETH_DMA_AXIS_WIDTH ="} $line]
      } elseif  {[string first "CONFIG.c_mm2s_burst_size"         $line] >= 0} {
        set line [string map  {"CONFIG.c_mm2s_burst_size" "ETH_DMA_MM2S_BURST_SIZE ="}    $line]
      } elseif  {[string first "CONFIG.c_s2mm_burst_size"         $line] >= 0} {
        set line [string map  {"CONFIG.c_s2mm_burst_size" "ETH_DMA_S2MM_BURST_SIZE ="}    $line]
      } else {
        continue
      }
      set line [string map {\{ "" \} "" \\ ","} $line]
      puts $bd_hdr $line
    }
    continue
  }

  # extracting some Ethernet core hw definitions
  if      {[string first "set eth100gb" $line] >= 0} {
    while {[string first  {] $eth100gb} $line] <  0} {
      gets $bd_tcl line
      if        {[string first "CONFIG.RX_MIN_PACKET_LEN" $line] >= 0} {
        set line [string map  {"CONFIG.RX_MIN_PACKET_LEN" "ETH_CORE_MIN_PACK_SIZE ="} $line]
      } elseif  {[string first "CONFIG.RX_MAX_PACKET_LEN" $line] >= 0} {
        set line [string map  {"CONFIG.RX_MAX_PACKET_LEN" "ETH_CORE_MAX_PACK_SIZE ="} $line]
      } else {
        continue
      }
      set line [string map {\{ "" \} "" \\ ","} $line]
      puts $bd_hdr $line
    }
    continue
  }

  # extracting address definitions
  if {[string first "get_bd_addr_segs axi_timer_0" $line] >= 0} {
    set line [string map {"assign_bd_address -offset"   "AXI_TIMER_0_BASEADDR ="}    $line]
    set line [string map {"-range"                    ", AXI_TIMER_0_ADRRANGE ="}    $line]
  } elseif {[string first "get_bd_addr_segs eth100gb" $line] >= 0} {
    set line [string map {"assign_bd_address -offset"   "ETH100GB_BASEADDR ="}       $line]
    set line [string map {"-range"                    ", ETH100GB_ADRRANGE ="}       $line]
  } elseif {[string first "get_bd_addr_segs eth_dma" $line] >= 0} {
    set line [string map {"assign_bd_address -offset"   "ETH_DMA_BASEADDR ="}        $line]
    set line [string map {"-range"                    ", ETH_DMA_ADRRANGE ="}        $line]
  } elseif {[string first "get_bd_addr_segs tx_axis_switch" $line] >= 0} {
    set line [string map {"assign_bd_address -offset"   "TX_AXIS_SWITCH_BASEADDR ="} $line]
    set line [string map {"-range"                    ", TX_AXIS_SWITCH_ADRRANGE ="} $line]
  } elseif {[string first "get_bd_addr_segs rx_axis_switch" $line] >= 0} {
    set line [string map {"assign_bd_address -offset"   "RX_AXIS_SWITCH_BASEADDR ="} $line]
    set line [string map {"-range"                    ", RX_AXIS_SWITCH_ADRRANGE ="} $line]
  } elseif {[string first "get_bd_addr_segs tx_mem_cpu" $line] >= 0} {
    set line [string map {"assign_bd_address -offset"   "TX_MEM_CPU_BASEADDR ="}     $line]
    set line [string map {"-range"                    ", TX_MEM_CPU_ADRRANGE ="}     $line]
  } elseif {[string first "get_bd_addr_segs rx_mem_cpu" $line] >= 0} {
    set line [string map {"assign_bd_address -offset"   "RX_MEM_CPU_BASEADDR ="}     $line]
    set line [string map {"-range"                    ", RX_MEM_CPU_ADRRANGE ="}     $line]
  } elseif {[string first "get_bd_addr_segs sg_mem_cpu" $line] >= 0} {
    set line [string map {"assign_bd_address -offset"   "SG_MEM_CPU_BASEADDR ="}     $line]
    set line [string map {"-range"                    ", SG_MEM_CPU_ADRRANGE ="}     $line]
  } elseif {[string first "get_bd_addr_segs tx_rx_ctl_stat" $line] >= 0} {
    set line [string map {"assign_bd_address -offset"   "TX_RX_CTL_STAT_BASEADDR ="} $line]
    set line [string map {"-range"                    ", TX_RX_CTL_STAT_ADRRANGE ="} $line]
  } elseif {[string first "get_bd_addr_segs gt_ctl" $line] >= 0} {
    set line [string map {"assign_bd_address -offset"   "GT_CTL_BASEADDR ="}         $line]
    set line [string map {"-range"                    ", GT_CTL_ADRRANGE ="}         $line]
  } else {
    continue
  }
  set line [string map {"-target_address_space"  "//"} $line]
  if {$comma_first} {
    puts -nonewline $bd_hdr "  ,"
  } else {
    puts -nonewline $bd_hdr "   "
  }
  puts $bd_hdr $line
  set comma_first 1
}

puts $bd_hdr "};"
puts $bd_hdr "#endif // end of protection macro"

close $bd_tcl
close $bd_hdr
