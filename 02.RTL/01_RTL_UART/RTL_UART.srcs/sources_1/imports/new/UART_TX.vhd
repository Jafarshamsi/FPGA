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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

--ENTITY-------------------------------------------------------------------------
entity UART_TX is
    generic (
        BR_cnfg : integer := 100     -- Configuration of baudarte = Frq/BR
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           tx : out STD_LOGIC;
           tx_id : in STD_LOGIC_VECTOR (7 downto 0);
           tx_irdy : in STD_LOGIC;
           tx_oack : out STD_LOGIC);
end UART_TX;

--ARCHITECTURE-------------------------------------------------------------------------
architecture Behavioral of UART_TX is

--Finit State Machine (FSM)
type tx_state_type is (IDLE_s, TX_s);
signal TX_state_crnt, TX_state_next: tx_state_type;

--Synchronizer Registers (one-FF) for the input signals
signal tx_id_crnt: STD_LOGIC_VECTOR (7 downto 0);
signal tx_irdy_crnt: STD_LOGIC;

--Intermediate Register I/O signal
signal tx_im_crnt, tx_im_next: STD_LOGIC_VECTOR (9 downto 0);
signal BR_cntr_crnt, BR_cntr_next: integer range 0 to BR_cnfg-1;
signal Bit_cntr_crnt, Bit_cntr_next: integer range 0 to 9;

----------------------------------------------------------------------------------
begin

--Register Section
MEM_prc: process(rst, clk)
begin
   if rst='0' then
        tx_id_crnt <= (others => '0');  
        tx_irdy_crnt <= '0';  
        TX_state_crnt <= IDLE_s;
        tx_im_crnt <= (others => '1'); 
        BR_cntr_crnt <= 0; 
        Bit_cntr_crnt <= 0; 
    elsif rising_edge(clk) then
        tx_id_crnt <= tx_id;  
        tx_irdy_crnt <= tx_irdy;    
        TX_state_crnt <= TX_state_next;
        tx_im_crnt <= tx_im_next;
        BR_cntr_crnt <= BR_cntr_next;
        Bit_cntr_crnt <= Bit_cntr_next;
    end if; 
end process;

--Compbinational Section
COM_FSM_prc: process(tx_id_crnt, tx_irdy_crnt, TX_state_crnt, tx_im_crnt, BR_cntr_crnt, Bit_cntr_crnt)

begin
    -- default values of signals (retain previous value)
    TX_state_next <= TX_state_crnt;
    tx_im_next <= tx_im_crnt;
    BR_cntr_next <= BR_cntr_crnt;
    Bit_cntr_next <= Bit_cntr_crnt;
    tx_oack <= '0';
-- mealy FSM	    
     CASE TX_state_crnt IS 
        WHEN IDLE_s =>
            if tx_irdy_crnt = '1' then
               tx_im_next <= '1'&tx_id_crnt&'0';
               tx_oack <= '1';
               TX_state_next <= TX_s;
            end if;
        WHEN TX_s =>
            if BR_cntr_crnt = BR_cnfg-1 then
                if Bit_cntr_crnt = 9 then
                    Bit_cntr_next <= 0;
                    TX_state_next <= IDLE_s;
                else
                    Bit_cntr_next <= Bit_cntr_crnt + 1;
                end if;
                BR_cntr_next <= 0;
                tx_im_next <= '1'&tx_im_crnt(9 downto 1);
            else
                BR_cntr_next <= BR_cntr_crnt + 1;
            end if;
        WHEN OTHERS =>
            TX_state_next <= IDLE_s;
     END CASE;
end process;
tx <= tx_im_crnt(0);
end Behavioral;
