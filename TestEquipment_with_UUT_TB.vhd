
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:55:51 06/10/2022
-- Design Name:   TestEquipment
-- Module Name:   C:/Xilinx92i/DTSD_LabWork2/TestEquipment_with_UUT_TB.vhd
-- Project Name:  DTSD_LabWork2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TestEquipment
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
library std;
use std.textio.all;

ENTITY TestEquipment_with_UUT_TB_vhd IS
END TestEquipment_with_UUT_TB_vhd;

ARCHITECTURE behavior OF TestEquipment_with_UUT_TB_vhd IS 

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

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT TestEquipment
	 Generic (UUT_INP_N : integer := 15;
				 NUMBER_OF_TEST_CASE : integer := 100;
				 SIGNATURE_LENGTH : integer := 15;
				 GOOD_SIGNATURE : integer := 1;
				 COUNT_LENGTH : integer := 15;
				 GOOD_COUNT : integer := 1);
	PORT(
		Start : IN std_logic;
		reset : IN std_logic;
		CLK : IN std_logic;
		uut_output : IN std_logic;          
		Done : OUT std_logic;
		PASS_nFAIL1 : OUT std_logic;
		PASS_nFAIL2 : OUT std_logic;
		uut_input : OUT std_logic_vector(UUT_INP_N-1 downto 0)
		);
	END COMPONENT;
	
	component UnitUnderTest is
		 Port ( inp : in  STD_LOGIC_VECTOR (14 downto 0);
				  output : out  STD_LOGIC);
	end component;

	--Inputs
	SIGNAL Start :  std_logic := '0';
	SIGNAL reset :  std_logic := '0';
	SIGNAL CLK :  std_logic := '0';
	SIGNAL uut_output :  std_logic := '0';

	--Outputs
	SIGNAL Done :  std_logic;
	SIGNAL PASS_nFAIL1 :  std_logic;
	SIGNAL PASS_nFAIL2 :  std_logic;
	SIGNAL uut_input :  std_logic_vector(14 downto 0);
	
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
	
	constant CLK_PERIOD : time := 100 ns;
	

	--signal check : STD_LOGIC_VECTOR(((2**UUT_INP_N)-1) downto 0) := (others => '0');
	signal control : STD_LOGIC := '0';
	signal finish : STD_LOGIC := '0';
	signal sim : STD_LOGIC := '0';

BEGIN
	
	TEST_GEN_128: TestEquipment 
		GENERIC MAP(UUT_INP_N => UUT_INP_N,
					NUMBER_OF_TEST_CASE => N_TEST_128,
					SIGNATURE_LENGTH => SIGNATURE_LENGTH_128,
					GOOD_SIGNATURE => GOOD_SIGNATURE_128,
					COUNT_LENGTH => COUNT_LENGTH_128,
					GOOD_COUNT => GOOD_COUNT_128)
	PORT MAP(
		Start => Start,
		reset => reset,
		CLK => CLK,
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
		Start => Start,
		reset => reset,
		CLK => CLK,
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
		Start => Start,
		reset => reset,
		CLK => CLK,
		Done => Done_ALL,
		PASS_nFAIL1 => PASS_nFAIL1_ALL,
		PASS_nFAIL2 => PASS_nFAIL2_ALL,
		uut_input => uut_input_ALL,
		uut_output => uut_output
	);
	
	-- Instantiate the Unit Under Test (UUT)
	uut: UnitUnderTest PORT MAP(inp => uut_input, output => uut_output);
	
	clock : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		if finish = '0' then
			CLK <= '1';
			wait for CLK_PERIOD/2;
			CLK <= '0';
			wait for CLK_PERIOD/2;
		else
			wait;
		end if;
	end process;
	
	PROCESS(Done_128, PASS_nFAIL1_128, PASS_nFAIL2_128, uut_input_128, PASS_nFAIL1_8192, PASS_nFAIL2_8192, uut_input_8192, PASS_nFAIL1_ALL, PASS_nFAIL2_ALL, uut_input_ALL)
	begin
		if N_TEST = 128 then
			Done <= Done_128;
			PASS_nFAIL1 <= PASS_nFAIL1_128;
			PASS_nFAIL2 <= PASS_nFAIL2_128;
			uut_input <= uut_input_128;
		elsif N_TEST = 8192 then
			Done <= Done_8192;
			PASS_nFAIL1 <= PASS_nFAIL1_8192;
			PASS_nFAIL2 <= PASS_nFAIL2_8192;
			uut_input <= uut_input_8192;
		elsif N_TEST = 32768 then
			Done <= Done_ALL;
			PASS_nFAIL1 <= PASS_nFAIL1_ALL;
			PASS_nFAIL2 <= PASS_nFAIL2_ALL;
			uut_input <= uut_input_ALL;
		end if;
	
	end process;
	

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for CLK_PERIOD/20;
		reset <= '1';
		wait for CLK_PERIOD*4;
		reset <= '0';
		wait for CLK_PERIOD;
		start <= '1';
		wait for CLK_PERIOD;
		start <= '0'; -- init state
		wait for CLK_PERIOD;
		-- START SIM
		control <= '1';
		sim <= '1';
		
		wait for CLK_PERIOD*(N_TEST+1);
		
		
		finish <= '1';
		
		-- Place stimulus here

		wait; -- will wait forever
	END PROCESS;
	
	

END;
