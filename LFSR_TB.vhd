
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:28:34 06/08/2022
-- Design Name:   LFSR
-- Module Name:   C:/Xilinx92i/DTSD_LabWork2/LFSR_TB.vhd
-- Project Name:  DTSD_LabWork2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LFSR
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

ENTITY LFSR_TB_vhd IS
END LFSR_TB_vhd;

ARCHITECTURE behavior OF LFSR_TB_vhd IS 

	constant SEQ_LENGTH : integer := 4;
	-- Component Declaration for the Unit Under Test (UUT)
	component LFSR is
	 Generic(SEQ_LENGTH : integer := 15);
    Port ( serial_in : in  STD_LOGIC;
			  init : in STD_LOGIC;
			  Seed : in STD_LOGIC_VECTOR(SEQ_LENGTH-1 downto 0); -- Initialize Value
			  stop : in STD_LOGIC;
			  CLK : in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(SEQ_LENGTH-1 downto 0));
	end component;

	--Inputs
	SIGNAL serial_in :  std_logic := '0';
	SIGNAL init :  std_logic := '0';
	SIGNAL CLK :  std_logic := '0';
	SIGNAL Seed :  std_logic_vector(SEQ_LENGTH-1 downto 0) := (others=>'0');
	SIGNAL stop : STD_LOGIC := '0';
	--Outputs
	SIGNAL output :  std_logic_vector(SEQ_LENGTH-1 downto 0);

	constant CLK_PERIOD : time := 100 ns;
	
	
	

	signal check : STD_LOGIC_VECTOR(((2**SEQ_LENGTH)-1) downto 0) := (others => '0');
	signal control : STD_LOGIC := '0';
	signal finish : STD_LOGIC := '0';

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: LFSR 
	GENERIC MAP(SEQ_LENGTH => SEQ_LENGTH)
	PORT MAP(
		serial_in => serial_in,
		init => init,
		Seed => Seed,
		stop => stop,
		CLK => CLK,
		output => output
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

	END PROCESS;
	
	checker: process(output, init, control)
	begin
			if control = '1' and finish = '0' then
				if check(to_integer(unsigned(output))) = '1' then
					assert False report "ERROR: SAME VALUE REPEATED IN THE SEQUENCE!" severity error;
				end if;
				if init /= '1' then
					check(to_integer(unsigned(output))) <= '1';
				else
					check <= (others => '0');
				end if;
			end if;
	end process;
	
	tb : PROCESS
		variable flag : integer := 0;
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for CLK_PERIOD/20;
		init <= '1';
		wait for CLK_PERIOD*3;
		init <= '0';
		wait for CLK_PERIOD;
		init <= '1';
		control <= '1';
		Seed <= (0 => '1', others => '0');
		wait for CLK_PERIOD;
		init <= '0';
		serial_in <= '0';
		wait for CLK_PERIOD*((2**SEQ_LENGTH)-2);
		control <= '0';
		flag := 0;
		for idx in 0 to ((2**SEQ_LENGTH)-1) loop
			if check(idx) = '1' then
				flag := flag + 1;
			end if;
			
		end loop;
		
		if flag /= (2**SEQ_LENGTH)-1 then
				assert False report "ERROR: NOT ALL THE POSSIBILITIES ACHIEVED!" severity error;
		end if;
		
		stop <= '1';
		wait for CLK_PERIOD*((2**SEQ_LENGTH)-2);
		finish <= '1';
		-- Place stimulus here
		report "ALL TESTS PASSED." severity note;
		wait; -- will wait forever
	END PROCESS;

END;
