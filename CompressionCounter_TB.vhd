
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:42:39 06/06/2022
-- Design Name:   CompressionCounter
-- Module Name:   C:/Xilinx92i/DTSD_LabWork2/CompressionCounter_TB.vhd
-- Project Name:  DTSD_LabWork2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CompressionCounter
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

ENTITY CompressionCounter_TB_vhd IS
END CompressionCounter_TB_vhd;

ARCHITECTURE behavior OF CompressionCounter_TB_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT CompressionCounter
	GENERIC(N : integer := 15);
	PORT(
		init : IN std_logic;
		stop : IN std_logic;
		CLK : IN std_logic;
		uut_output : IN std_logic;          
		result : OUT std_logic_vector(14 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL init :  std_logic := '0';
	SIGNAL stop :  std_logic := '0';
	SIGNAL CLK :  std_logic := '0';
	SIGNAL uut_output :  std_logic := '0';

	--Outputs
	SIGNAL result :  std_logic_vector(14 downto 0);
	
	constant CLK_PERIOD : time := 100 ns;
	SIGNAL SIM_EN : STD_LOGIC := '0';
BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: CompressionCounter 
	GENERIC MAP( N=> 15)
	PORT MAP(
		init => init,
		stop => stop,
		CLK => CLK,
		uut_output => uut_output,
		result => result
	);

	
	clock : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		CLK <= '1';
		wait for CLK_PERIOD/2;
		CLK <= '0';
		wait for CLK_PERIOD/2;

	END PROCESS;






	tb : PROCESS
	BEGIN
		wait for CLK_PERIOD/10;
		-- Wait 100 ns for global reset to finish
		SIM_EN <= '1';
		wait for CLK_PERIOD;
		init <= '1';
		wait for CLK_PERIOD;
		init <= '0';
		stop <= '1';
		wait for CLK_PERIOD;
		init <= '0';
		stop <= '0';
		uut_output <= '1';
		wait for CLK_PERIOD;
		uut_output <= '0';
		wait for CLK_PERIOD;
		uut_output <= '0';
		wait for CLK_PERIOD;
		uut_output <= '1';
		wait for CLK_PERIOD;
		uut_output <= '0';
		wait for CLK_PERIOD;
		uut_output <= '1';
		wait for CLK_PERIOD;
		stop <= '1';
		wait for CLK_PERIOD*2;
		stop <= '0';
		init <= '1';
		wait for CLK_PERIOD;
		stop <= '0';
		init <= '0';
		wait for CLK_PERIOD;
		stop <= '0';
		init <= '0';
		uut_output <= '0';
		wait for CLK_PERIOD;
		uut_output <= '1';
		wait for CLK_PERIOD;
		uut_output <= '0';
		wait for CLK_PERIOD;
		uut_output <= '1';
		wait for CLK_PERIOD;
		uut_output <= '0';
		wait for CLK_PERIOD;
		uut_output <= '1';
		wait for CLK_PERIOD;
		uut_output <= '0';
		wait for CLK_PERIOD;
		uut_output <= '1';
		wait for CLK_PERIOD;
		uut_output <= '0';
		wait for CLK_PERIOD;
		uut_output <= '1';
		wait for CLK_PERIOD;
		uut_output <= '0';
		wait for CLK_PERIOD;
		uut_output <= '1';
		wait for CLK_PERIOD;
		uut_output <= '0';
		wait for CLK_PERIOD;
		uut_output <= '1';
		wait for CLK_PERIOD;
		uut_output <= '0';
		wait for CLK_PERIOD;
		uut_output <= '1';
		wait for CLK_PERIOD;
		uut_output <= '0';
		stop <= '1';
		wait for CLK_PERIOD;
		uut_output <= '1';
		wait for CLK_PERIOD;
		-- Place stimulus here

		wait; -- will wait forever
	END PROCESS;

END;
