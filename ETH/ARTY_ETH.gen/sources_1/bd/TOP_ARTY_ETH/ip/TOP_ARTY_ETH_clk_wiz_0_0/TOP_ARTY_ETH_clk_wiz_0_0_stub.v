// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Fri Apr 29 11:41:39 2022
// Host        : BlueRoseNew running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/ARTY_projects/ARTY_ETH/ARTY_ETH.gen/sources_1/bd/TOP_ARTY_ETH/ip/TOP_ARTY_ETH_clk_wiz_0_0/TOP_ARTY_ETH_clk_wiz_0_0_stub.v
// Design      : TOP_ARTY_ETH_clk_wiz_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module TOP_ARTY_ETH_clk_wiz_0_0(clk_out166, clk_out200, clk_out25, resetn, 
  locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out166,clk_out200,clk_out25,resetn,locked,clk_in1" */;
  output clk_out166;
  output clk_out200;
  output clk_out25;
  input resetn;
  output locked;
  input clk_in1;
endmodule
