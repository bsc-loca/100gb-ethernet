
hw_server -d
# cd ./plnx_proj/
# petalinux-boot --jtag --fpga --kernel

export ELF_TO_RUN="./plnx_proj/images/linux/image.elf"
xsct -interactive ./tcl/run_elf.tcl

#In separate terminal:
# picocom -b 115200 /dev/ttyUSB2

#In booted Petalinux to check Eth driver:
# dmesg | grep eth
# find /proc/device-tree/ -type f -exec head {} + | grep eth
# ifconfig
# ip link
# gunzip </proc/config.gz | grep XILINX
