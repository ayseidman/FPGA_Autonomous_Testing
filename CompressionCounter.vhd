----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:06:04 06/06/2022 
-- Design Name: 
-- Module Name:    CompressionCounter - Behavioral 
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

entity CompressionCounter is
	generic( N: integer := 15);
    Port ( init : in  STD_LOGIC;
           stop : in  STD_LOGIC;
			  CLK : in STD_LOGIC;
           uut_output : in  STD_LOGIC;
			  result : out STD_LOGIC_VECTOR(N-1 downto 0));
end CompressionCounter;

architecture Behavioral of CompressionCounter is

component Counter is
	generic(N : integer := 15);
    Port ( init : in  STD_LOGIC;
           stop_nEN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (N-1 downto 0));
end component;

signal count_en : STD_LOGIC;
signal previous_input : STD_LOGIC;

begin
	-- Count number of Edge Transmission
	
	C1: Counter generic map(N => N)
					port map(init => init,
								stop_nEN => NOT count_en,
								CLK => CLK,
								Q => result);
	
	process(CLK)
	begin
		if rising_edge(CLK) then
			if init = '1' then
				previous_input <= '0'; 
			else
				previous_input <= uut_output;
			end if;	
		end if;
	end process;
	
	process(previous_input, uut_output, stop)
	begin
		if stop = '1' then
			count_en <= '0';
		elsif previous_input /= uut_output then
			count_en <= '1';
		else
			count_en <= '0';
		end if;
	end process;
end Behavioral;

