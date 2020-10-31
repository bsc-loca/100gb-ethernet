
# script to run bare-metal application via JTAG
# XSCT reference: https://www.xilinx.com/html_docs/xilinx2020_1/vitis_doc/upu1569395223804.html

# ----- Connecting to the board via JTAG, initializing target
# Remote connection case (on remote host with board connected "hw_server -s tcp::3121" should be run with port 3121 enabled in firewall)
# connect -url tcp:192.168.0.14:3121
# Local connection case
connect -url tcp:localhost:3121
connect -list
targets




# targets -set -nocase -filter {name =~ "APU*"}
# rst -system
# after 3000
# targets -set -nocase -filter {name =~ "APU*"}
# rst -cores
# targets -set -nocase -filter {name =~ "RPU*"}
# rst -cores
# targets -set -nocase -filter {name =~ "PSU*"}
# targets
# state

# # ---- Configuring FPGA
# fpga -file ../vivado/base.bit
# fpga -state

# # ----- Initializing PSU
# # targets -set -nocase -filter {name =~ "APU*"}
# # loadhw -hw ./ws/baseHW/system.hdf
# targets -set -nocase -filter {name =~ "APU*"}
# source ./ws_baremet/base_hdf/psu_init.tcl
# psu_init
# after 1000
# psu_ps_pl_isolation_removal
# after 1000
# psu_ps_pl_reset_config
# targets
# state

# # ---- Activating and initializing core 0 of APU 
# targets -set -nocase -filter {name =~"*A53*0"}
# rst -processor
# dow    ./ws_baremet/hello_baremet/Release/hello_baremet.elf
# verify ./ws_baremet/hello_baremet/Release/hello_baremet.elf
# targets
# state

# # ---- Running app
# # jtagterminal -start
# readjtaguart -start
# con
# # jtagterminal -stop
# # readjtaguart -stop
# targets
# state

# disconnect
# exit
