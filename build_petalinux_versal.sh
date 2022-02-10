
#If a lack of disk space is met, /tmp/plnx_proj* temporary folders should be removed
petalinux-create --type project --template versal --name plnx_proj
cd ./plnx_proj/
#At this step choosing the only option so far for Ethernet core in PL:
#Subsytem AUTO Hardware Settings -> Ethernet Settings -> Primary Ethernet(manual) -> ethmac_lite
petalinux-config --get-hw-description ../project/ethernet_system_wrapper.xsa
petalinux-build
petalinux-package --boot --u-boot
#The following is needed if choosing EXT4 root filesystem type at petalinux-config GUI step (Image Packaging Configuration)  
petalinux-package --wic
