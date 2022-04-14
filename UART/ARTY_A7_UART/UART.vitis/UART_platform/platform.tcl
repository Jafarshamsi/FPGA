# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct D:\MYGITHUB\MYCODES\FPGA\IF_UART\UART\UART.vitis\UART_platform\platform.tcl
# 
# OR launch xsct and run below command.
# source D:\MYGITHUB\MYCODES\FPGA\IF_UART\UART\UART.vitis\UART_platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {UART_platform}\
-hw {D:\MYGITHUB\MYCODES\FPGA\IF_UART\UART\TOP_UART_wrapper.xsa}\
-proc {microblaze_0} -os {standalone} -out {D:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.vitis}

platform write
platform generate -domains 
platform active {UART_platform}
platform generate
