# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: E:\Projects\MTDS\MTDS.vitis\MTDS_App_system\_ide\scripts\debugger_mtds_app-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source E:\Projects\MTDS\MTDS.vitis\MTDS_App_system\_ide\scripts\debugger_mtds_app-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -filter {jtag_cable_name =~ "Digilent Arty A7-100T 210319B26CF3A" && level==0 && jtag_device_ctx=="jsn-Arty A7-100T-210319B26CF3A-13631093-0"}
fpga -file E:/Projects/MTDS/MTDS.vitis/MTDS_App/_ide/bitstream/download.bit
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw E:/Projects/MTDS/MTDS.vitis/MTDS_Platform/export/MTDS_Platform/hw/TOP_MTDS_wrapper.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow E:/Projects/MTDS/MTDS.vitis/MTDS_App/Debug/MTDS_App.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
