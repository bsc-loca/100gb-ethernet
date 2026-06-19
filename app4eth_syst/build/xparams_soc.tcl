
# Script to generate C-header containing hardware definitions for SOC

# If SOC is based on OpenPiton, possible locations of device xml file
set fl_xml [lindex [glob -nocomplain  "../../../../accelerator/piton/design/xilinx/alveou280/devices_*.xml" "../../../../../../../../xilinx/alveou280/devices_*.xml"] 0]
# If SOC is based on Vec_Path_Finding, possible locations of device HDL file
set fl_svh [lindex [glob -nocomplain  "../../../../../src/include/sam.svh"] 0]
set fl_hdr "./xparams_soc.h"
if {[file exists $fl_xml]} {
puts "----- Extracting SOC definitions to `$fl_hdr` from OpenPiton device xml `$fl_xml`"
set dv_xml [open $fl_xml r]
set bd_hdr [open $fl_hdr w]

puts $bd_hdr "// SOC (OpenPiton) hw parameters from $fl_xml"
puts $bd_hdr "#ifndef XPARAMS_SOC_H  // prevent circular inclusions"
puts $bd_hdr "#define XPARAMS_SOC_H  // by using protection macros"

puts $bd_hdr "enum {"

while {[gets $dv_xml line] >= 0} {
  # extracting whole Ethernet subsystem address definitions
  if      {[string first "<name>net</name>" $line] >= 0} {
    while {[string first "</port>"          $line] <  0} {
      gets $dv_xml line
      if        {[string first "<base>"     $line] >= 0} {
        set line [string map  {"<base>"  "ETH_SYST_BASEADDR = "}  $line]
        set line [string map  {"</base>" ","}                     $line]
      } else {
        continue
      }
      puts $bd_hdr $line
    }
  }
  # extracting cached SDRAM address definitions
  if      {[string first "<name>mem</name>" $line] >= 0} {
    while {[string first "</port>"          $line] <  0} {
      gets $dv_xml line
      if        {[string first "<base>"     $line] >= 0} {
        set line [string map  {"<base>"  "DRAM_CACHE_BASEADDR = "}  $line]
        set line [string map  {"</base>" ","}                 $line]
      } elseif  {[string first "<length>"   $line] >= 0} {
        set line [string map  {"<length>" "DRAM_CACHE_ADRRANGE = "} $line]
        set line [string map  {"</length>" ","}               $line]
      } else {
        continue
      }
      puts $bd_hdr $line
    }
  }
  # extracting uncached SDRAM address definitions
  if      {[string first "<name>dma_pool</name>" $line] >= 0} {
    while {[string first "</port>"               $line] <  0} {
      gets $dv_xml line
      if        {[string first "<base>"          $line] >= 0} {
        set line [string map  {"<base>"  "DRAM_UNCACHE_BASEADDR = "}  $line]
        set line [string map  {"</base>" ","}                         $line]
      } elseif  {[string first "<length>"        $line] >= 0} {
        set line [string map  {"<length>" "DRAM_UNCACHE_ADRRANGE = "} $line]
        set line [string map  {"</length>" ","}                       $line]
      } else {
        continue
      }
      puts $bd_hdr $line
    }
  }
}
puts $bd_hdr "        DRAM_BASEADDR = 0x0 // DRAM base address in CPU address space"

puts $bd_hdr "};"
puts $bd_hdr "#endif // end of protection macro"

close $bd_hdr
close $dv_xml
} elseif {[file exists $fl_svh]} {
  puts "----- Extracting SOC definitions to `$fl_hdr` from Vec_Path_Finding device HDL file `$fl_svh`"
  set dv_svh [open $fl_svh r]
  set bd_hdr [open $fl_hdr w]

  puts $bd_hdr "// SOC (Vec_Path_Finding) hw parameters from $fl_svh" 
  puts $bd_hdr "#ifndef XPARAMS_SOC_H  // prevent circular inclusions"
  puts $bd_hdr "#define XPARAMS_SOC_H  // by using protection macros"

  puts $bd_hdr "enum {"

  while {[gets $dv_svh line] >= 0} {
    # extracting whole Ethernet subsystem address definitions
    if {[string first "ETHERNET_BASE_ADDR" $line] >= 0} {
      set line [string map  {"_" ""}  $line]
      set line [string map  {"`define ETHERNETBASEADDR"  "   ETH_SYST_BASEADDR = "}  $line]
      set line [string map  {"48'h" "0x"}  $line]
      puts $bd_hdr $line
    }
    # extracting cached SDRAM address definitions
    if {[string first "DRAM_C_BASE_ADDR" $line] >= 0} {
      set line [string map  {"_" ""}  $line]
      set line [string map  {"`define DRAMCBASEADDR"  "  ,DRAM_CACHE_BASEADDR = "}  $line]
      set line [string map  {"48'h" "0x"}  $line]
      puts $bd_hdr $line
    }
    if {[string first "DRAM_C_REGION_SIZE" $line] >= 0} {
      set line [string map  {"_" ""}  $line]
      set line [string map  {"`define DRAMCREGIONSIZE" "  ,DRAM_CACHE_ADRRANGE = "} $line]
      set line [string map  {"48'h" "0x"}  $line]
      puts $bd_hdr $line
    }
    # extracting uncached SDRAM address definitions
    if {[string first "MTILE0_DRAM_AXI_BASE_ADDR" $line] >= 0} {
      set line [string map  {"_" ""}  $line]
      set line [string map  {"`define MTILE0DRAMAXIBASEADDR"  "  ,DRAM_UNCACHE_BASEADDR = "}  $line]
      set line [string map  {"48'h" "0x"}  $line]
      puts $bd_hdr $line
    }
    if {[string first "MTILE0_DRAM_AXI_REGION_SIZE" $line] >= 0} {
      set line [string map  {"_" ""}  $line]
      set line [string map  {"`define MTILE0DRAMAXIREGIONSIZE" "  ,DRAM_UNCACHE_ADRRANGE = "} $line]
      set line [string map  {"48'h" "0x"}  $line]
      puts $bd_hdr $line
    }
  }
  puts $bd_hdr "  ,DRAM_BASEADDR = 0x0 // DRAM base address in CPU address space"

  puts $bd_hdr "};"
  puts $bd_hdr "#endif // end of protection macro"

  close $bd_hdr
  close $dv_svh
} else {
  puts "----- OpenPiton device xml file `$fl_xml` and VPF device HDL file `$fl_svh` don't exist, hence leaving SOC definitions `$fl_hdr` as is"
}
