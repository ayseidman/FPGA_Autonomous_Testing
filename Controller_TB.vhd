
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:16:53 06/08/2022
-- Design Name:   Controller
-- Module Name:   C:/Xilinx92i/DTSD_LabWork2/Controller_TB.vhd
-- Project Name:  DTSD_LabWork2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Controller
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
use IEEE.math_real.all;

ENTITY Controller_TB_vhd IS
END Controller_TB_vhd;

ARCHITECTURE behavior OF Controller_TB_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT Controller
	generic (N : integer := 100;
				UUT_INP_N : integer := 15);
	PORT(
		start : IN std_logic;
		reset : IN std_logic;
		CLK : IN std_logic;          
		LFSRnCounter : OUT std_logic;
		done : OUT std_logic;
		init : OUT std_logic;
		stop : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL start :  std_logic := '0';
	SIGNAL reset : std_logic := '0';
	SIGNAL CLK :  std_logic := '0';

	--Outputs
	SIGNAL LFSRnCounter :  std_logic;
	SIGNAL done :  std_logic;
	SIGNAL init :  std_logic;
	SIGNAL stop :  std_logic;

	constant CLK_PERIOD : time := 100 ns;
	
	constant UUT_INP_N : integer := 15;
	constant N : integer := 10;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: Controller generic map(N => N,
										 UUT_INP_N => UUT_INP_N) 
							PORT MAP(
								start => start,
								reset => reset,
								CLK => CLK,
								LFSRnCounter => LFSRnCounter,
								done => done,
								init => init,
								stop => stop
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
		wait for CLK_PERIOD/20;
		reset <= '1';
		wait for CLK_PERIOD;
		reset <= '0';
		wait for CLK_PERIOD*5;
		start <= '1';
		wait for CLK_PERIOD;
		start <= '0';
		-- Place stimulus here

		wait; -- will wait forever
	END PROCESS;

END;
