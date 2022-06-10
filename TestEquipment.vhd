----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:59:14 06/08/2022 
-- Design Name: 
-- Module Name:    TestEquipment - Behavioral 
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
USE ieee.numeric_std.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TestEquipment is
	 Generic (UUT_INP_N : integer := 15;
				 NUMBER_OF_TEST_CASE : integer := 100;
				 SIGNATURE_LENGTH : integer := 15;
				 GOOD_SIGNATURE : integer := 1;
				 COUNT_LENGTH : integer := 15;
				 GOOD_COUNT : integer := 1);
    Port ( Start : in  STD_LOGIC;
			  reset : in STD_LOGIC;
			  CLK : in STD_LOGIC;
           Done : out  STD_LOGIC;
           PASS_nFAIL1 : out  STD_LOGIC;
           PASS_nFAIL2 : out  STD_LOGIC;
           uut_input : out  STD_LOGIC_VECTOR(UUT_INP_N-1 downto 0);
           uut_output : in  STD_LOGIC);
end TestEquipment;

architecture Behavioral of TestEquipment is

	component Controller is
		generic (N : integer := 100;
					UUT_INP_N : integer := 15);
		 Port ( start : in  STD_LOGIC;
				  reset : in STD_LOGIC;
				  CLK : in STD_LOGIC;
				  LFSRnCounter : out STD_LOGIC; -- if it is 1, use LFSR to generate Test Inputs, otherwise use counter to exhaustive test.
				  done : out  STD_LOGIC;
				  init : out  STD_LOGIC;
				  stop : out  STD_LOGIC);
	end component;
	
	component SignatureGenerator is
	 Generic (SIGNATURE_LENGTH : integer := 15);
    Port ( init : in  STD_LOGIC;
           stop : in  STD_LOGIC;
			  CLK : in STD_LOGIC;
           uut_output : in  STD_LOGIC;
			  signature : out STD_LOGIC_VECTOR(SIGNATURE_LENGTH-1 downto 0));
	end component;
	
	component CompressionCounter is
	generic( N: integer := 15);
    Port ( init : in  STD_LOGIC;
           stop : in  STD_LOGIC;
			  CLK : in STD_LOGIC;
           uut_output : in  STD_LOGIC;
			  result : out STD_LOGIC_VECTOR(N-1 downto 0));
	end component;
	
	component TestVectorGenerator is
    generic(UUT_INP_N : integer := 15);
    Port ( init : in  STD_LOGIC;
           stop : in  STD_LOGIC;
			  LFSRnCounter : in STD_LOGIC;
			  CLK : in STD_LOGIC;
           uut_input : out  STD_LOGIC_VECTOR (UUT_INP_N-1 downto 0));
	end component;
	
	component Comparator is
	generic(N : integer := 4);
    Port ( A : in  STD_LOGIC_VECTOR (N-1 downto 0);
           B : in  STD_LOGIC_VECTOR (N-1 downto 0);
           Eq : out  STD_LOGIC);
	end component;
	
	signal SIGNATURE_RESULT : STD_LOGIC_VECTOR(SIGNATURE_LENGTH-1 downto 0);

	signal COUNT_RESULT : STD_LOGIC_VECTOR(COUNT_LENGTH-1 downto 0);
	
	signal LFSRnCounter : STD_LOGIC;
	signal init : STD_LOGIC;
	signal stop : STD_LOGIC;
	 
	constant GOOD_SIGNATURE_VEC : STD_LOGIC_VECTOR(SIGNATURE_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(GOOD_SIGNATURE, SIGNATURE_LENGTH));
	constant GOOD_COUNT_VEC : STD_LOGIC_VECTOR(COUNT_LENGTH-1 downto 0) := std_logic_vector(to_unsigned(GOOD_COUNT, COUNT_LENGTH));

begin

	CONTROLLER0: Controller generic map(N => NUMBER_OF_TEST_CASE, UUT_INP_N => UUT_INP_N)
									port map(start => start,
												reset => reset,
												CLK => CLK,
												LFSRnCounter => LFSRnCounter,
												Done => Done,
												init => init,
												stop => stop);
												
	
	TEST_GENERATOR0: TestVectorGenerator generic map(UUT_INP_N => UUT_INP_N)
													 port map(init => init,
																 stop => stop,
																 LFSRnCounter => LFSRnCounter,
																 CLK => CLK,
																 uut_input => uut_input);
																 
	SIGN_GENERATOR0: SignatureGenerator  generic map(SIGNATURE_LENGTH => SIGNATURE_LENGTH)
													 port map(init => init,
																 stop => stop,
																 CLK => CLK,
																 uut_output  => uut_output,
																 signature => SIGNATURE_RESULT);
																 
	COMP_COUNTER0:   CompressionCounter  generic map(N => COUNT_LENGTH)
													 port map(init => init,
																 stop => stop,
																 CLK => CLK,
																 uut_output  => uut_output,
																 result => COUNT_RESULT);

	COMP0: Comparator generic map(N => SIGNATURE_LENGTH)
							port map(A => SIGNATURE_RESULT,
										B => GOOD_SIGNATURE_VEC,
										Eq => PASS_nFAIL1);
										
	COMP1: Comparator generic map(N => COUNT_LENGTH)
							port map(A => COUNT_RESULT,
										B => GOOD_COUNT_VEC,
										Eq => PASS_nFAIL2);
	
end Behavioral;

