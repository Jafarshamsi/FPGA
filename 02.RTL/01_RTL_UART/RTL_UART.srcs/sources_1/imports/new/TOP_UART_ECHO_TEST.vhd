----------------------------------------------------------------------------------
-- Engineer: Jafar Shamsi (fastwalkthrough101@gmail.com)
-- Create Date: 07/11/2022 11:01:17 AM
-- Module Name: UART - Behavioral
-- Description: UART protocol with handshaking interface
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------

--LIBRARY-------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--ENTITY-------------------------------------------------------------------------
entity TOP_UART_ECHO_TEST is
    generic (
        BR_cnfg : integer := 10204     -- Configuration of baudarte = Frq/BR_cnfg
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (3 downto 0);
           rx : in STD_LOGIC;
           tx : out STD_LOGIC);
end TOP_UART_ECHO_TEST;

--ARCHITECTURE-------------------------------------------------------------------------
architecture Behavioral of TOP_UART_ECHO_TEST is

--Intermediate signals
signal RX2TX_d: STD_LOGIC_VECTOR (7 downto 0);
signal RX2TX_rdy: STD_LOGIC;
signal TX2RX_ack: STD_LOGIC;

--declaration
component UART is
    generic (
        BR_cnfg : integer := BR_cnfg     -- Configuration of baudarte = Frq/BR_cnfg
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (3 downto 0);
           -- RX interface
           rx : in STD_LOGIC;
           rx_od : out STD_LOGIC_VECTOR (7 downto 0);
           rx_ordy : out STD_LOGIC;
           rx_iack : in STD_LOGIC;
           -- TX interface
           tx : out STD_LOGIC;
           tx_id : in STD_LOGIC_VECTOR (7 downto 0);
           tx_irdy : in STD_LOGIC;
           tx_oack : out STD_LOGIC);
end component;
begin

--Instantiation
UART_inst: UART
    generic map (
        BR_cnfg => BR_cnfg
    )
    port map (
        clk => clk,
        rst => rst,
        led => led,
        rx => rx,
        rx_od => RX2TX_d,
        rx_ordy => RX2TX_rdy,
        rx_iack => TX2RX_ack,
        tx => tx,
        tx_id => RX2TX_d,
        tx_irdy => RX2TX_rdy,
        tx_oack => TX2RX_ack
    );
    
        --led <= TX2RX_ack&RX2TX_rdy&RX2TX_d(1 downto 0);
end Behavioral;
