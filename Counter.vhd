----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:59:36 06/06/2022 
-- Design Name: 
-- Module Name:    Counter - Behavioral 
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
use ieee.numeric_std.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
	generic(N : integer := 15);
    Port ( init : in  STD_LOGIC;
           stop_nEN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (N-1 downto 0));
end Counter;

architecture Behavioral of Counter is
	signal count : unsigned(N-1 downto 0);
begin

	process(CLK)
	begin
		
		if rising_edge(CLK) then
			if init = '1' then
				count <= (others => '0'); -- Synchronous Reset
			elsif stop_nEN = '0' then
				count <= count + 1; -- Count
			end if;
		end if;
	
	end process;

	Q <= std_logic_vector(count);

end Behavioral;

