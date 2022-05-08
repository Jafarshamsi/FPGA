# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct E:\Projects\MTDS\MTDS.vitis\MTDS_Platform\platform.tcl
# 
# OR launch xsct and run below command.
# source E:\Projects\MTDS\MTDS.vitis\MTDS_Platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {MTDS_Platform}\
-hw {E:\Projects\MTDS\TOP_MTDS_wrapper.xsa}\
-proc {microblaze_0} -os {standalone} -out {E:/Projects/MTDS/MTDS.vitis}

platform write
platform generate -domains 
platform active {MTDS_Platform}
platform generate
