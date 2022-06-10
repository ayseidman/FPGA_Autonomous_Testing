----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:44:42 06/06/2022 
-- Design Name: 
-- Module Name:    LFSR - Behavioral 
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

entity LFSR is
	 Generic(SEQ_LENGTH : integer := 15);
    Port ( serial_in : in  STD_LOGIC;
			  init : in STD_LOGIC;
			  Seed : in STD_LOGIC_VECTOR(SEQ_LENGTH-1 downto 0); -- Initialize Value
			  stop : in STD_LOGIC;
			  CLK : in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(SEQ_LENGTH-1 downto 0));
end LFSR;

architecture Behavioral of LFSR is
	constant MAXIMUM_SEQ_LENGTH : integer := 15;
	constant MINIMUM_SEQ_LENGTH : integer := 2;
	
	type STD_ARRAY is array (MINIMUM_SEQ_LENGTH to MAXIMUM_SEQ_LENGTH) of STD_LOGIC_VECTOR(MAXIMUM_SEQ_LENGTH-1 downto 0);
	constant TAP_LOOKUP : STD_ARRAY := ("000000000000011", 
													"000000000000110",
													"000000000001100",
													"000000000010100",
													"000000000110000",
													"000000001100000",
													"000000010110100",
													"000000100010000",
													"000001001000000",
													"000010100000000",
													"000111000001000",
													"001110010000000",
													"011100000000010",
													"110000000000000");
	
	signal REG : STD_LOGIC_VECTOR(SEQ_LENGTH-1 downto 0);
	signal SELECTED_TAPS : STD_LOGIC_VECTOR(SEQ_LENGTH-1 downto 0);
	signal FEEDBACK : STD_LOGIC;
	
	constant TAP_POSITIONS : STD_LOGIC_VECTOR(SEQ_LENGTH-1 downto 0) := TAP_LOOKUP(SEQ_LENGTH)(SEQ_LENGTH-1 downto 0);
	

begin

	process(CLK)
	begin
		if rising_edge(CLK) then
			if init = '1' then
				REG <= Seed;
			elsif stop = '0' then
				REG(SEQ_LENGTH-1 downto 1) <= REG(SEQ_LENGTH-2 downto 0); -- SHIFTING LEFT 
				REG(0) <= FEEDBACK;
			end if;

		end if;
	
	end process;
	
	SELECTED_TAPS <= TAP_POSITIONS AND REG; -- Selecting Corresponding Tap Positions

	
	process(SELECTED_TAPS, serial_in)
		variable xor_result : STD_LOGIC;
	begin
		xor_result := SELECTED_TAPS(0);
		for idx in 1 to SEQ_LENGTH-1 loop
			xor_result := xor_result XOR SELECTED_TAPS(idx);
		end loop;
		
		FEEDBACK <= xor_result XOR serial_in;
		
	end process;
	
	output <= REG;
	
end Behavioral;

