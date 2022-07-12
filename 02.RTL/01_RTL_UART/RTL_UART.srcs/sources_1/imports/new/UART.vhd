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
entity UART is
    generic (
        BR_cnfg : integer := 10204     -- Configuration of baudarte = Frq/BR_cnfg
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
end UART;


--ARCHITECTURE-------------------------------------------------------------------------
architecture Behavioral of UART is

--declaration
component UART_RX is
    generic (
        BR_cnfg : integer := BR_cnfg     -- Configuration of baudarte = Frq/BR_cnfg
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           rx : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (3 downto 0);
           rx_od : out STD_LOGIC_VECTOR (7 downto 0);
           rx_ordy : out STD_LOGIC;
           rx_iack : in STD_LOGIC);
end component;

component UART_TX is
    generic (
        BR_cnfg : integer := BR_cnfg     -- Configuration of baudarte = Frq/BR
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           tx : out STD_LOGIC;
           tx_id : in STD_LOGIC_VECTOR (7 downto 0);
           tx_irdy : in STD_LOGIC;
           tx_oack : out STD_LOGIC);
end component;


----------------------------------------------------------------------------------
begin

--Instantiation
UART_RX_inst: UART_RX 
    generic map (
        BR_cnfg => BR_cnfg
    )
    port map (
        clk => clk,
        rst => rst,
        led => led,
        rx => rx,
        rx_od => rx_od,
        rx_ordy => rx_ordy,
        rx_iack => rx_iack
    );
    
UART_TX_inst: UART_TX 
    generic map (
        BR_cnfg => BR_cnfg
    )
    port map (
        clk => clk,
        rst => rst,
        tx => tx,
        tx_id => tx_id,
        tx_irdy => tx_irdy,
        tx_oack => tx_oack
    );
    
end Behavioral;
