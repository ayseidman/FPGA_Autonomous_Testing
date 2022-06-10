
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:17:59 06/09/2022
-- Design Name:   TestVectorGenerator
-- Module Name:   C:/Xilinx92i/DTSD_LabWork2/TestVectorGenerator_TB.vhd
-- Project Name:  DTSD_LabWork2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TestVectorGenerator
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

ENTITY TestVectorGenerator_TB_vhd IS
END TestVectorGenerator_TB_vhd;

ARCHITECTURE behavior OF TestVectorGenerator_TB_vhd IS 

	
	constant UUT_INP_N : integer := 15;

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT TestVectorGenerator
	generic(UUT_INP_N : integer := 15);
	PORT(
		init : IN std_logic;
		stop : IN std_logic;
		LFSRnCounter : IN std_logic;
		CLK : IN std_logic;          
		uut_input : OUT std_logic_vector(UUT_INP_N-1 downto 0)
		);
	END COMPONENT;


	--Inputs
	SIGNAL init :  std_logic := '0';
	SIGNAL stop :  std_logic := '0';
	SIGNAL LFSRnCounter :  std_logic := '0';
	SIGNAL CLK :  std_logic := '0';

	--Outputs
	SIGNAL uut_input :  std_logic_vector((UUT_INP_N-1) downto 0);
	
	
	constant CLK_PERIOD : time := 100 ns;
	
	
	

	signal check : STD_LOGIC_VECTOR(((2**UUT_INP_N)-1) downto 0) := (others => '0');
	signal control : STD_LOGIC := '0';
	signal finish : STD_LOGIC := '0';

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: TestVectorGenerator 
	GENERIC MAP(UUT_INP_N => UUT_INP_N)
	PORT MAP(
		init => init,
		stop => stop,
		LFSRnCounter => LFSRnCounter,
		CLK => CLK,
		uut_input => uut_input
	);
	
	checker: process(uut_input, init, control)
	begin
			if control = '1' and finish = '0' then
				if check(to_integer(unsigned(uut_input))) = '1' then
					assert False report "ERROR: SAME VALUE REPEATED IN THE SEQUENCE!" severity error;
				end if;
				if init /= '1' then
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

	tb : PROCESS
		variable flag : integer := 0;
	BEGIN
		
	   LFSRnCounter <= '1';
		wait for CLK_PERIOD/20;
		if LFSRnCounter = '0' then -- Test Counter
			report "Counter TB:";
			wait for CLK_PERIOD*4;
			init <= '1';
			wait for CLK_PERIOD;
			control <= '1';
			init <= '0';
			wait for CLK_PERIOD*(2**UUT_INP_N-1);
			control <= '0';
			flag := 0;
			for idx in 0 to ((2**UUT_INP_N)-1) loop
				if check(idx) = '1' then
					flag := flag + 1;
				end if;
			
			end loop;
		
			if flag /= (2**UUT_INP_N) then
					assert False report "ERROR: NOT ALL THE POSSIBILITIES ACHIEVED!" severity error;
					
			end if;
			report "Achieved "& integer'image(flag) & " possibilities from " & integer'image((2**UUT_INP_N)) & " total possibilities.";
			stop <='1';
			finish <= '1';
			wait for CLK_PERIOD*4;
		 
		else
			report "LFSR TB:";
			wait for CLK_PERIOD*4;
			init <= '1';
			wait for CLK_PERIOD;
			control <= '1';
			init <= '0';
			wait for CLK_PERIOD*(2**UUT_INP_N-2);
			control <= '0';
			flag := 0;
			for idx in 0 to ((2**UUT_INP_N)-1) loop
				if check(idx) = '1' then
					flag := flag + 1;
				end if;
			
			end loop;
		
			if flag /= (2**UUT_INP_N)-1 then
					assert False report "ERROR: NOT ALL THE POSSIBILITIES ACHIEVED!" severity error;
			end if;
			report "Achieved "& integer'image(flag) & " possibilities from " & integer'image((2**UUT_INP_N)) & " total possibilities.";

			stop <='1';
			finish <= '1';
			wait for CLK_PERIOD*4;
			
		end if;

		-- Wait 100 ns for global reset to finish

		
		
		
		
		

		-- Place stimulus here

		wait; -- will wait forever
	END PROCESS;

END;
