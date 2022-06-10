
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:48:36 06/10/2022
-- Design Name:   MUX_74HC153N
-- Module Name:   C:/Xilinx92i/DTSD_LabWork2/MUX_74HC153N_TB.vhd
-- Project Name:  DTSD_LabWork2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX_74HC153N
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

ENTITY MUX_74HC153N_TB_vhd IS
END MUX_74HC153N_TB_vhd;

ARCHITECTURE behavior OF MUX_74HC153N_TB_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT MUX_74HC153N
	PORT(
		A : IN std_logic;
		B : IN std_logic;
		IN1 : IN std_logic_vector(3 downto 0);
		IN2 : IN std_logic_vector(3 downto 0);
		nEN1 : IN std_logic;
		nEN2 : IN std_logic;          
		O1 : OUT std_logic;
		O2 : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL A :  std_logic := '0';
	SIGNAL B :  std_logic := '0';
	SIGNAL nEN1 :  std_logic := '0';
	SIGNAL nEN2 :  std_logic := '0';
	SIGNAL IN1 :  std_logic_vector(3 downto 0) := (others=>'0');
	SIGNAL IN2 :  std_logic_vector(3 downto 0) := (others=>'0');

	--Outputs
	SIGNAL O1 :  std_logic;
	SIGNAL O2 :  std_logic;
	
	
	SIGNAL CLK :  std_logic := '0';
	constant CLK_PERIOD : time := 100 ns;
	signal finish : STD_LOGIC := '0';

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: MUX_74HC153N PORT MAP(
		A => A,
		B => B,
		IN1 => IN1,
		IN2 => IN2,
		nEN1 => nEN1,
		nEN2 => nEN2,
		O1 => O1,
		O2 => O2
	);
	
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

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for CLK_PERIOD;
		IN1 <= "0000";
		IN2 <= "0000";
		A <= '0';
		B <= '0';
		nEN1 <= '0';
		nEN2 <= '0';
		
		wait for CLK_PERIOD;
		IN1 <= "0001";
		IN2 <= "0000";
		A <= '0';
		B <= '0';
		nEN1 <= '0';
		nEN2 <= '0';
		
		wait for CLK_PERIOD;
		IN1 <= "0000";
		IN2 <= "0001";
		A <= '0';
		B <= '0';
		nEN1 <= '0';
		nEN2 <= '0';
		
		wait for CLK_PERIOD;
		IN1 <= "0001";
		IN2 <= "0001";
		A <= '0';
		B <= '0';
		nEN1 <= '1';
		nEN2 <= '0';
		
				
		wait for CLK_PERIOD;
		IN1 <= "0001";
		IN2 <= "0001";
		A <= '0';
		B <= '0';
		nEN1 <= '0';
		nEN2 <= '1';
		
		wait for CLK_PERIOD;
		IN1 <= "1000";
		IN2 <= "1111";
		A <= '1';
		B <= '1';
		nEN1 <= '0';
		nEN2 <= '1';
		
		wait for CLK_PERIOD;
		IN1 <= "1111";
		IN2 <= "1000";
		A <= '1';
		B <= '1';
		nEN1 <= '1';
		nEN2 <= '0';
		
		wait for CLK_PERIOD;
		IN1 <= "0100";
		IN2 <= "0000";
		A <= '0';
		B <= '1';
		nEN1 <= '0';
		nEN2 <= '0';
		
		wait for CLK_PERIOD;
		IN1 <= "0000";
		IN2 <= "0100";
		A <= '0';
		B <= '1';
		nEN1 <= '0';
		nEN2 <= '0';
		
		wait for CLK_PERIOD;
		IN1 <= "0010";
		IN2 <= "0000";
		A <= '1';
		B <= '0';
		nEN1 <= '0';
		nEN2 <= '0';
		
		wait for CLK_PERIOD;
		IN1 <= "0000";
		IN2 <= "0010";
		A <= '1';
		B <= '0';
		nEN1 <= '0';
		nEN2 <= '0';
		
		finish <= '1';

		-- Place stimulus here

		wait; -- will wait forever
	END PROCESS;

END;
