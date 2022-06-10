----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:05:18 06/06/2022 
-- Design Name: 
-- Module Name:    SignatureGenerator - Behavioral 
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

entity SignatureGenerator is
	 Generic (SIGNATURE_LENGTH : integer := 15);
    Port ( init : in  STD_LOGIC;
           stop : in  STD_LOGIC;
			  CLK : in STD_LOGIC;
           uut_output : in  STD_LOGIC;
			  signature : out STD_LOGIC_VECTOR(SIGNATURE_LENGTH-1 downto 0));
end SignatureGenerator;

architecture Behavioral of SignatureGenerator is

	constant SEED : STD_LOGIC_VECTOR(SIGNATURE_LENGTH-1 downto 0) := (0 => '1', others => '0');

	component LFSR is
		 Generic(SEQ_LENGTH : integer := 15);
		 Port ( serial_in : in  STD_LOGIC;
				  init : in STD_LOGIC;
				  Seed : in STD_LOGIC_VECTOR(SEQ_LENGTH-1 downto 0); -- Initialize Value
				  stop : in STD_LOGIC;
				  CLK : in STD_LOGIC;
				  output : out  STD_LOGIC_VECTOR(SEQ_LENGTH-1 downto 0));
	end component;

begin

	LFSR0: LFSR generic map(SEQ_LENGTH => SIGNATURE_LENGTH)
					port map(serial_in => uut_output,
								init => init,
								Seed => SEED,
								stop => stop,
								CLK => CLK,
								output => signature);

end Behavioral;

