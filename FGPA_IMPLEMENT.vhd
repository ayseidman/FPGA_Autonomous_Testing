----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:39:59 06/10/2022 
-- Design Name: 
-- Module Name:    FGPA_IMPLEMENT - Behavioral 
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

entity FGPA_IMPLEMENT is
    Port ( Start : in  STD_LOGIC;
			  reset : in STD_LOGIC;
			  reset_clk : in STD_LOGIC;
			  SEL_TEST: in STD_LOGIC_VECTOR(1 downto 0);
			  SEL_TEST_OUT : out STD_LOGIC_VECTOR(1 downto 0);
			  CLK : in STD_LOGIC;
           Done : out  STD_LOGIC;
           PASS_nFAIL1 : out  STD_LOGIC;
           PASS_nFAIL2 : out  STD_LOGIC;
           uut_input : out  STD_LOGIC_VECTOR(14 downto 0);
           uut_output : in  STD_LOGIC);
end FGPA_IMPLEMENT;

architecture Behavioral of FGPA_IMPLEMENT is
	constant UUT_INP_N : integer := 15;
	constant N_TEST : integer := 128;
	
	-- SYSTEM 1
	
	-- LFSR (128) (L=7)
	-- PROBABILITY OF MISS ERROR (ALIASING) (SIGNATURE) = 2^(L-7)/2^L = 2^(-7) = 0.78%
	constant N_TEST_128 : integer := 128;
	constant SIGNATURE_LENGTH_128 : integer := 7;
	constant COUNT_LENGTH_128 : integer := 8; -- MAXIMUM TRANSITION = 2^L+1 >> Counter must be greater log_2((2^L)+1)
	constant GOOD_SIGNATURE_128 : integer := 16#0047#;
	constant GOOD_COUNT_128 : integer := 16#0016#;
	
	
	-- LFSR (8192) (L=13)
	-- PROBABILITY OF MISS ERROR (ALIASING) (SIGNATURE) = 2^(L-7)/2^L = 2^(-7) = 0.78%
	constant N_TEST_8192 : integer := 8192;
	constant SIGNATURE_LENGTH_8192 : integer := 7;
	constant COUNT_LENGTH_8192 : integer := 14; 
	constant GOOD_SIGNATURE_8192 : integer := 16#0077#;
	constant GOOD_COUNT_8192 : integer := 16#0874#;
	
	-- SYSTEM 2
	
	-- Counter (32768) (L=15)
	-- PROBABILITY OF MISS ERROR (ALIASING) (SIGNATURE) = 2^(15-7)/2^15 = 0.78%
	constant N_TEST_ALL : integer := 32768;
	constant SIGNATURE_LENGTH_ALL : integer := 7;
	constant COUNT_LENGTH_ALL : integer := 16;
	constant GOOD_SIGNATURE_ALL : integer := 16#0054#;
	constant GOOD_COUNT_ALL : integer := 16#0220#;
	
	component Debouncing_Button_VHDL is
		port(
		 button: in std_logic;
		 clk: in std_logic;
		 debounced_button: out std_logic
		);
	end component;
		
	component Counter is
		generic(N : integer := 15);
		 Port ( init : in  STD_LOGIC;
				  stop_nEN : in  STD_LOGIC;
				  CLK : in  STD_LOGIC;
				  Q : out  STD_LOGIC_VECTOR (N-1 downto 0));
	end component;
	
	component TestEquipment is
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
	end component;

	SIGNAL Done_128 :  std_logic;
	SIGNAL PASS_nFAIL1_128 :  std_logic;
	SIGNAL PASS_nFAIL2_128 :  std_logic;
	SIGNAL uut_input_128 :  std_logic_vector(14 downto 0);
	
		--Outputs
	SIGNAL Done_8192 :  std_logic;
	SIGNAL PASS_nFAIL1_8192 :  std_logic;
	SIGNAL PASS_nFAIL2_8192 :  std_logic;
	SIGNAL uut_input_8192 :  std_logic_vector(14 downto 0);
	
	
			--Outputs
	SIGNAL Done_ALL :  std_logic;
	SIGNAL PASS_nFAIL1_ALL :  std_logic;
	SIGNAL PASS_nFAIL2_ALL :  std_logic;
	SIGNAL uut_input_ALL :  std_logic_vector(14 downto 0);

	SIGNAL CLK_DIV :  std_logic_vector(15 downto 0);
	
	SIGNAL Reset_stable :  std_logic;
	SIGNAL Start_stable :  std_logic;
	SIGNAL Reset_clk_stable :  std_logic;
begin
	
	BUTTON0: Debouncing_Button_VHDL PORT MAP (
          button => reset,
          clk => CLK,
          debounced_button => Reset_stable
        );
		  
	BUTTON1: Debouncing_Button_VHDL PORT MAP (
          button => start,
          clk => CLK,
          debounced_button => Start_stable
        );
		  
	BUTTON2: Debouncing_Button_VHDL PORT MAP (
          button => Reset_clk,
          clk => CLK,
          debounced_button => Reset_clk_stable
        );
		
	CLOCK_DIV: Counter generic map(N => 16)
	port map(init => Reset_clk_stable,
				stop_nEN => '0',
				CLK => CLK,
				Q => CLK_DIV(15 downto 0));

	SEL_TEST_OUT <= SEL_TEST;

	TEST_GEN_128: TestEquipment 
	GENERIC MAP(UUT_INP_N => UUT_INP_N,
				NUMBER_OF_TEST_CASE => N_TEST_128,
				SIGNATURE_LENGTH => SIGNATURE_LENGTH_128,
				GOOD_SIGNATURE => GOOD_SIGNATURE_128,
				COUNT_LENGTH => COUNT_LENGTH_128,
				GOOD_COUNT => GOOD_COUNT_128)
	PORT MAP(
		Start => Start_stable,
		reset => Reset_stable,
		CLK => CLK_DIV(15),
		Done => Done_128,
		PASS_nFAIL1 => PASS_nFAIL1_128,
		PASS_nFAIL2 => PASS_nFAIL2_128,
		uut_input => uut_input_128,
		uut_output => uut_output
	);
	
	TEST_GEN_8192: TestEquipment 
		GENERIC MAP(UUT_INP_N => UUT_INP_N,
					NUMBER_OF_TEST_CASE => N_TEST_8192,
					SIGNATURE_LENGTH => SIGNATURE_LENGTH_8192,
					GOOD_SIGNATURE => GOOD_SIGNATURE_8192,
					COUNT_LENGTH => COUNT_LENGTH_8192,
					GOOD_COUNT => GOOD_COUNT_8192)
	PORT MAP(
		Start => Start_stable,
		reset => Reset_stable,
		CLK => CLK_DIV(14),
		Done => Done_8192,
		PASS_nFAIL1 => PASS_nFAIL1_8192,
		PASS_nFAIL2 => PASS_nFAIL2_8192,
		uut_input => uut_input_8192,
		uut_output => uut_output
	);
	
	TEST_GEN_ALL: TestEquipment 
		GENERIC MAP(UUT_INP_N => UUT_INP_N,
					NUMBER_OF_TEST_CASE => N_TEST_ALL,
					SIGNATURE_LENGTH => SIGNATURE_LENGTH_ALL,
					GOOD_SIGNATURE => GOOD_SIGNATURE_ALL,
					COUNT_LENGTH => COUNT_LENGTH_ALL,
					GOOD_COUNT => GOOD_COUNT_ALL)
	PORT MAP(
		Start => Start_stable,
		reset => Reset_stable,
		CLK => CLK_DIV(12),
		Done => Done_ALL,
		PASS_nFAIL1 => PASS_nFAIL1_ALL,
		PASS_nFAIL2 => PASS_nFAIL2_ALL,
		uut_input => uut_input_ALL,
		uut_output => uut_output
	);
	
	
	
	uut_input <= uut_input_ALL when SEL_TEST = "11" else
					 uut_input_8192 when SEL_TEST = "10" else
					 uut_input_128 when SEL_TEST = "01" else
					 (others=>'0');
					 
	PASS_nFAIL1 <= PASS_nFAIL1_ALL when SEL_TEST = "11" else
					 PASS_nFAIL1_8192 when SEL_TEST = "10" else
					 PASS_nFAIL1_128 when SEL_TEST = "01" else
					 '0';

	PASS_nFAIL2 <= PASS_nFAIL2_ALL when SEL_TEST = "11" else
					 PASS_nFAIL2_8192 when SEL_TEST = "10" else
					 PASS_nFAIL2_128 when SEL_TEST = "01" else
					 '0';
					 
	Done <= Done_ALL when SEL_TEST = "11" else
					 Done_8192 when SEL_TEST = "10" else
					 Done_128 when SEL_TEST = "01" else
					 '0';

end Behavioral;

