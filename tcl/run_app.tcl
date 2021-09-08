
# script to run bare-metal application via JTAG
# XSCT reference: https://www.xilinx.com/html_docs/xilinx2020_1/vitis_doc/upu1569395223804.html
# XSCT uses Xvfb and thus "ssh -X" should be used for remote run

# ----- Connecting to the board via JTAG, initializing target
# Remote connection case (on remote host with board connected "hw_server -s tcp::3121" should be run with port 3121 enabled in firewall)
# connect -url tcp:192.168.0.14:3121
# Local connection case
connect -url tcp:localhost:3121
# connect
connect -list

# ---- Reading FPGA state
targets
# targets 1
# targets
fpga -boot-status
fpga -config-status
fpga -state

# ---- Programming FPGA
fpga -file ./project/ethernet_test_wrapper.bit
fpga -boot-status
fpga -config-status
fpga -state

# ---- Setting CPU as debug target
targets
# targets 3
# loadhw -hw ./project/ethernet_test_wrapper.xsa
targets -set -nocase -filter {name =~ "*MicroBlaze*0*"}
targets
state
rst -system
after 3000
state

# ---- Loading app
dow    ./xsct_ws/eth_test/Release/eth_test.elf
verify ./xsct_ws/eth_test/Release/eth_test.elf
state
rst
state

# ---- Opening Stdin/Stdout
put ""
put "-----------------------"
put "Please run manually: jtagterminal, and wait for the launched terminal window..."
# jtagterminal -start
# readjtaguart -start

# ---- Running app
put "After that run manually the app: con"
put "Other further actions: state, stop, rst"
put "-----------------------"
put ""
# state
# rst
# state
# con
# state

# ---- Closing Stdin/Stdout
# jtagterminal -stop
# readjtaguart -stop

# ---- Disconnecting
# disconnect
# exit
