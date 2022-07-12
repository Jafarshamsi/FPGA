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
--use IEEE.NUMERIC_STD.ALL;

--ENTITY-------------------------------------------------------------------------
entity UART_RX is
    generic (
        BR_cnfg : integer := 100     -- Configuration of baudarte = Frq/BR
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (3 downto 0);
           rx : in STD_LOGIC;
           rx_od : out STD_LOGIC_VECTOR (7 downto 0);
           rx_ordy : out STD_LOGIC;
           rx_iack : in STD_LOGIC);
end UART_RX;

--ARCHITECTURE-------------------------------------------------------------------------
architecture Behavioral of UART_RX is

--Finit State Machine (FSM)
type rx_state_type is (IDLE_s, RX_s, RDY_s);
signal RX_state_crnt, RX_state_next: rx_state_type;

--Synchronizer Registers (one-FF) for the input signals
signal rx_crnt: STD_LOGIC;
signal rx_iack_crnt: STD_LOGIC;
signal rx_im_crnt, rx_im_next: STD_LOGIC_VECTOR (7 downto 0);
signal BR_cntr_crnt, BR_cntr_next: integer range 0 to BR_cnfg-1;
signal Bit_cntr_crnt, Bit_cntr_next: integer range 0 to 7;
----------------------------------------------------------------------------------
begin
--Register Section
MEM_prc: process(rst, clk)
begin
   if rst='0' then
        rx_crnt <= '0';  
        rx_iack_crnt <= '0';
        RX_state_crnt <= IDLE_s;  
        rx_im_crnt <= (others => '1'); 
        BR_cntr_crnt <= 0; 
        Bit_cntr_crnt <= 0; 
    elsif rising_edge(clk) then
        rx_crnt <= rx;  
        rx_iack_crnt <= rx_iack;    
        RX_state_crnt <= RX_state_next;
        rx_im_crnt <= rx_im_next;
        BR_cntr_crnt <= BR_cntr_next;
        Bit_cntr_crnt <= Bit_cntr_next;
    end if; 
end process;

--Compbinational Section
COM_FSM_prc: process(rx_crnt, rx_iack_crnt, RX_state_crnt, Bit_cntr_crnt, BR_cntr_crnt, rx_im_crnt)

begin
    -- default values of signals (retain previous value)
    RX_state_next <= RX_state_crnt;
    rx_im_next <= rx_im_crnt;
    BR_cntr_next <= BR_cntr_crnt;
    Bit_cntr_next <= Bit_cntr_crnt;
    rx_ordy <= '0';
-- mealy FSM	    
     CASE RX_state_crnt IS 
        WHEN IDLE_s =>
            if rx_crnt = '0' then
               if BR_cntr_crnt = BR_cnfg/2 then
                  BR_cntr_next <= 0;
                  RX_state_next <= RX_s;
               else
                  BR_cntr_next <= BR_cntr_crnt + 1;
               end if;
            end if;
        WHEN RX_s =>
            if BR_cntr_crnt = BR_cnfg-1 then
                if Bit_cntr_crnt = 7 then
                    Bit_cntr_next <= 0;
                    RX_state_next <= RDY_s;
                else
                    Bit_cntr_next <= Bit_cntr_crnt + 1;
                end if;
                BR_cntr_next <= 0;
                rx_im_next <= rx_crnt&rx_im_crnt(7 downto 1);
            else
                BR_cntr_next <= BR_cntr_crnt + 1;
            end if;
        WHEN RDY_s =>
            if BR_cntr_crnt = BR_cnfg-1 then
                if rx_iack_crnt = '1' then
                    BR_cntr_next <= 0;
                    RX_state_next <= IDLE_s;
                else
                    rx_ordy <= '1';
                end if;
            else
                BR_cntr_next <= BR_cntr_crnt + 1;
            end if;
        WHEN OTHERS =>
            RX_state_next <= IDLE_s;
     END CASE;
end process;
rx_od <= rx_im_crnt;
   with RX_state_crnt select
                    led <= b"0001" when IDLE_s,
                           b"0010" when RX_s,
                           b"0011" when RDY_s,
                           b"0100" when others;
end Behavioral;
