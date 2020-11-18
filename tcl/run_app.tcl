
# script to run bare-metal application via JTAG
# XSCT reference: https://www.xilinx.com/html_docs/xilinx2020_1/vitis_doc/upu1569395223804.html

# ----- Connecting to the board via JTAG, initializing target
# Remote connection case (on remote host with board connected "hw_server -s tcp::3121" should be run with port 3121 enabled in firewall)
# connect -url tcp:192.168.0.14:3121
# Local connection case
connect -url tcp:localhost:3121
connect -list

# ---- Reading FPGA state
fpga -boot-status
fpga -config-status
fpga -state
targets

# ---- Programming FPGA
fpga -file ./project/ethernet_test_wrapper.bit
fpga -boot-status
fpga -config-status
fpga -state
targets

# ---- Setting CPU as debug target
targets -set -nocase -filter {name =~ "*MicroBlaze*0*"}
# loadhw -hw ./project/ethernet_test_wrapper.xsa
# targets -set -nocase -filter {name =~ "*MicroBlaze*0*"}
targets
state
rst -system
after 3000
state

# ---- Opening Stdin/Stdout
# jtagterminal -start
readjtaguart -start

# ---- Loading app
dow    ./xsct_ws/eth_test/Release/eth_test.elf
verify ./xsct_ws/eth_test/Release/eth_test.elf
state
rst
state

# ---- Running app
con
state

# ---- Closing Stdin/Stdout
# jtagterminal -stop
# readjtaguart -stop

# ---- Disconnecting
# disconnect
# exit
