
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:30:17 06/06/2022
-- Design Name:   Comparator
-- Module Name:   C:/Xilinx92i/DTSD_LabWork2/Comparator_TB.vhd
-- Project Name:  DTSD_LabWork2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Comparator
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

ENTITY Comparator_TB_vhd IS
END Comparator_TB_vhd;

ARCHITECTURE behavior OF Comparator_TB_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	component Comparator is
	generic(N : integer := 4);
    Port ( A : in  STD_LOGIC_VECTOR (N-1 downto 0);
           B : in  STD_LOGIC_VECTOR (N-1 downto 0);
           Eq : out  STD_LOGIC);
	end component;

	--Inputs
	SIGNAL A :  std_logic_vector(7 downto 0) := (others=>'0');
	SIGNAL B :  std_logic_vector(7 downto 0) := (others=>'0');

	--Outputs
	SIGNAL Eq :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: Comparator 
	GENERIC MAP(N => 8)
	PORT MAP(
		A => A,
		B => B,
		Eq => Eq
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		A <= "00000000";
		B <= "00000000";
		wait for 100 ns;
		A <= "11111111";
		B <= "00000000";
		wait for 100 ns;
		A <= "11111111";
		B <= "00000001";
		wait for 100 ns;
		A <= "11110111";
		B <= "11110111";
		-- Place stimulus here

		wait; -- will wait forever
	END PROCESS;

END;
