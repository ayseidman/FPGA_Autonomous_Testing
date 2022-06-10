
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:01:36 06/10/2022
-- Design Name:   TestEquipment
-- Module Name:   C:/Xilinx92i/DTSD_LabWork2/TestEquipment_TB.vhd
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

ENTITY TestEquipment_TB_vhd IS
END TestEquipment_TB_vhd;

ARCHITECTURE behavior OF TestEquipment_TB_vhd IS 

	constant UUT_INP_N : integer := 4;
	constant N_TEST : integer := 16;

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

	--Inputs
	SIGNAL Start :  std_logic := '0';
	SIGNAL reset :  std_logic := '0';
	SIGNAL CLK :  std_logic := '0';
	SIGNAL uut_output :  std_logic := '0';

	--Outputs
	SIGNAL Done :  std_logic;
	SIGNAL PASS_nFAIL1 :  std_logic;
	SIGNAL PASS_nFAIL2 :  std_logic;
	SIGNAL uut_input :  std_logic_vector(UUT_INP_N-1 downto 0);


	
	constant CLK_PERIOD : time := 100 ns;
	
	
	

	signal check : STD_LOGIC_VECTOR(((2**UUT_INP_N)-1) downto 0) := (others => '0');
	signal control : STD_LOGIC := '0';
	signal finish : STD_LOGIC := '0';
	signal sim : STD_LOGIC := '0';

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: TestEquipment 
	GENERIC MAP(UUT_INP_N => UUT_INP_N,
					NUMBER_OF_TEST_CASE => N_TEST,
					SIGNATURE_LENGTH => 15,
					GOOD_SIGNATURE => 1,
					COUNT_LENGTH => 15,
					GOOD_COUNT => 1)
	PORT MAP(
		Start => Start,
		reset => reset,
		CLK => CLK,
		Done => Done,
		PASS_nFAIL1 => PASS_nFAIL1,
		PASS_nFAIL2 => PASS_nFAIL2,
		uut_input => uut_input,
		uut_output => uut_output
	);
	
	checker: process(uut_input, start, control)
	begin
			if control = '1' and done = '0' then
				if check(to_integer(unsigned(uut_input))) = '1' then
					assert False report "ERROR: SAME VALUE REPEATED IN THE SEQUENCE!" severity error;
				end if;
				if start /= '1' then
					check(to_integer(unsigned(uut_input))) <= '1';
				else
					check <= (others => '0');
				end if;
			end if;
	end process;
	
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
	
		
	uut_out : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		if finish = '0' then
			wait until rising_edge(CLK);
			if start = '0' and control = '1' then
				uut_output<= not uut_output;
				
			end if;

		else
			wait;
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
		wait for CLK_PERIOD*20;
		
		
		

		-- Place stimulus here
		
		finish <= '1';
		wait; -- will wait forever
	END PROCESS;

END;
