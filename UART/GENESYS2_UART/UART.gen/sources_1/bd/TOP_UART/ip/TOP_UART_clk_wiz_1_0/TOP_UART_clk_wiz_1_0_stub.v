// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Mon Apr 11 16:03:10 2022
// Host        : DESKTOP-8HM7LCH running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_clk_wiz_1_0/TOP_UART_clk_wiz_1_0_stub.v
// Design      : TOP_UART_clk_wiz_1_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module TOP_UART_clk_wiz_1_0(clk_out1, resetn, locked, clk_in1_p, clk_in1_n)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,resetn,locked,clk_in1_p,clk_in1_n" */;
  output clk_out1;
  input resetn;
  output locked;
  input clk_in1_p;
  input clk_in1_n;
endmodule
