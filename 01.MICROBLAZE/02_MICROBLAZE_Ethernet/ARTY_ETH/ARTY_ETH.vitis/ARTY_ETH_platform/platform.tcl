# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct E:\ARTY_projects\ARTY_ETH\ARTY_ETH.vitis\ARTY_ETH_platform\platform.tcl
# 
# OR launch xsct and run below command.
# source E:\ARTY_projects\ARTY_ETH\ARTY_ETH.vitis\ARTY_ETH_platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {ARTY_ETH_platform}\
-hw {E:\ARTY_projects\ARTY_ETH\TOP_ARTY_ETH_wrapper.xsa}\
-proc {microblaze_0} -os {standalone} -out {E:/ARTY_projects/ARTY_ETH/ARTY_ETH.vitis}

platform write
platform generate -domains 
platform active {ARTY_ETH_platform}
bsp reload
bsp setlib -name lwip211 -ver 1.6
bsp config phy_link_speed "CONFIG_LINKSPEED100"
bsp write
bsp reload
catch {bsp regenerate}
platform generate
