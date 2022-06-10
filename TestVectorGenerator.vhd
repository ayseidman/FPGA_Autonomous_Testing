----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:20:02 06/06/2022 
-- Design Name: 
-- Module Name:    TestVectorGenerator - Behavioral 
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

entity TestVectorGenerator is
    generic(UUT_INP_N : integer := 15);
    Port ( init : in  STD_LOGIC;
           stop : in  STD_LOGIC;
			  LFSRnCounter : in STD_LOGIC;
			  CLK : in STD_LOGIC;
           uut_input : out  STD_LOGIC_VECTOR (UUT_INP_N-1 downto 0));
end TestVectorGenerator;

architecture Behavioral of TestVectorGenerator is

	constant SEED : STD_LOGIC_VECTOR(UUT_INP_N-1 downto 0) := (0 => '1', others => '0');

	component LFSR is
		 Generic(SEQ_LENGTH : integer := 15);
		 Port ( serial_in : in  STD_LOGIC;
				  init : in STD_LOGIC;
				  Seed : in STD_LOGIC_VECTOR(SEQ_LENGTH-1 downto 0); -- Initialize Value
				  stop : in STD_LOGIC;
				  CLK : in STD_LOGIC;
				  output : out  STD_LOGIC_VECTOR(SEQ_LENGTH-1 downto 0));
	end component;
	
	component Counter is
		generic(N : integer := 15);
		 Port ( init : in  STD_LOGIC;
				  stop_nEN : in  STD_LOGIC;
				  CLK : in  STD_LOGIC;
				  Q : out  STD_LOGIC_VECTOR (N-1 downto 0));
	end component;
	
	signal LFSR_output : STD_LOGIC_VECTOR(UUT_INP_N-1 downto 0);
	signal Counter_output : STD_LOGIC_VECTOR(UUT_INP_N-1 downto 0);

begin

	LFSR0: LFSR generic map(SEQ_LENGTH => UUT_INP_N)
					port map(serial_in => '0',
								init => init,
								Seed => SEED,
								stop => stop,
								CLK => CLK,
								output => LFSR_output);
					
	CNT0: Counter generic map(N => UUT_INP_N)
					port map(init => init,
								stop_nEN => stop,
								CLK => CLK,
								Q => Counter_output);
								
	
	uut_input <= Counter_output when LFSRnCounter = '0' else LFSR_output;



end Behavioral;

