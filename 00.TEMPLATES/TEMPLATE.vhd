----------------------------------------------------------------------------------
-- Engineer: Jafar Shamsi (fastwalkthrough101@gmail.com)
-- Module Name: TEMPLATE - Behavioral
-- Description: TEMPLATE for handshaking interface, FSM
----------------------------------------------------------------------------------

--LIBRARY-------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL; -- arithmetic functions with Signed or Unsigned values

--ENTITY-------------------------------------------------------------------------

entity TEMPLATE is
    generic (
        Param : integer := 1     -- generic parameter
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
		   -- handshaking input
           input_id : in STD_LOGIC_VECTOR (7 downto 0);
           input_irdy : in STD_LOGIC;
           input_oack : out STD_LOGIC;
		   -- handshaking output
           output_od : out STD_LOGIC_VECTOR (7 downto 0);
           output_ordy : out STD_LOGIC;
           output_iack : in STD_LOGIC);
end TEMPLATE;


--ARCHITECTURE-------------------------------------------------------------------------

architecture Behavioral of TEMPLATE is


begin

    
end Behavioral;
