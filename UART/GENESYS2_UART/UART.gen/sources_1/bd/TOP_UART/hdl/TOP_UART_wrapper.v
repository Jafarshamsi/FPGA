//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
//Date        : Mon Apr 11 16:02:18 2022
//Host        : DESKTOP-8HM7LCH running 64-bit major release  (build 9200)
//Command     : generate_target TOP_UART_wrapper.bd
//Design      : TOP_UART_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module TOP_UART_wrapper
   (reset,
    sys_diff_clock_clk_n,
    sys_diff_clock_clk_p,
    usb_uart_rxd,
    usb_uart_txd);
  input reset;
  input sys_diff_clock_clk_n;
  input sys_diff_clock_clk_p;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire reset;
  wire sys_diff_clock_clk_n;
  wire sys_diff_clock_clk_p;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  TOP_UART TOP_UART_i
       (.reset(reset),
        .sys_diff_clock_clk_n(sys_diff_clock_clk_n),
        .sys_diff_clock_clk_p(sys_diff_clock_clk_p),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
