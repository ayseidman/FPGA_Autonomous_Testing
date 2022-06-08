----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:17:10 06/05/2022 
-- Design Name: 
-- Module Name:    MUX4x1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX4x1 is
    Port ( I : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC;
           EN : in  STD_LOGIC;
           SEL : in  STD_LOGIC_VECTOR (1 downto 0));
end MUX4x1;

architecture Behavioral of MUX4x1 is
	signal OUT_TEMP: STD_LOGIC := '0';
begin
	process(I, SEL)
	begin
		case SEL is
			when "00" =>
				OUT_TEMP <= I(0);
			when "01" =>
				OUT_TEMP <= I(1);
			when "10" =>
				OUT_TEMP <= I(2);
			when "11" =>
				OUT_TEMP <= I(3);
			when others =>
				OUT_TEMP <= '0';
		end case;
	end process;
	
	O <= OUT_TEMP when EN = '1' else '0';

end Behavioral;

