
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:23:53 06/06/2022
-- Design Name:   Counter
-- Module Name:   C:/Xilinx92i/DTSD_LabWork2/Counter_TB.vhd
-- Project Name:  DTSD_LabWork2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Counter
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

ENTITY Counter_TB_vhd IS
END Counter_TB_vhd;

ARCHITECTURE behavior OF Counter_TB_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	component Counter is
	generic(N : integer := 15);
    Port ( init : in  STD_LOGIC;
           stop_nEN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (N-1 downto 0));
	end component;

	--Inputs
	SIGNAL init :  std_logic := '0';
	SIGNAL stop_nEN :  std_logic := '0';
	SIGNAL CLK :  std_logic := '0';

	--Outputs
	SIGNAL Q :  std_logic_vector(14 downto 0);
	
	constant CLK_PERIOD : time := 100 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: Counter PORT MAP(
		init => init,
		stop_nEN => stop_nEN,
		CLK => CLK,
		Q => Q
	);

	clock : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		CLK <= '0';
		wait for CLK_PERIOD/2;
		CLK <= '1';
		wait for CLK_PERIOD/2;

	END PROCESS;

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		
		wait for CLK_PERIOD;
		init <= '1';
		wait for CLK_PERIOD;
		init <= '0';
		stop_nEN <= '1';
		wait for CLK_PERIOD;
		init <= '0';
		stop_nEN <= '0';
		wait for CLK_PERIOD*20;
		init <= '1';
		wait for CLK_PERIOD;
		stop_nEN <= '1';
		-- Place stimulus here

		wait; -- will wait forever
	END PROCESS;

END;
