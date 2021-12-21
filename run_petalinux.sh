
hw_server -d
# cd ./plnx_proj/
# petalinux-boot --jtag --fpga --kernel

export ELF_TO_RUN="./plnx_proj/images/linux/image.elf"
xsct -interactive ./tcl/run_elf.tcl
