----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:04:28 06/06/2022 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
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
use IEEE.math_real.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Controller is
	generic (N : integer := 100;
				UUT_INP_N : integer := 15);
    Port ( start : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           CLK : in STD_LOGIC;
			  LFSRnCounter : out STD_LOGIC; -- if it is 1, use LFSR to generate Test Inputs, otherwise use counter to exhaustive test.
           done : out  STD_LOGIC;
           init : out  STD_LOGIC;
           stop : out  STD_LOGIC);
end Controller;

architecture Behavioral of Controller is

component Counter is
	generic(N : integer := 15);
    Port ( init : in  STD_LOGIC;
           stop_nEN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (N-1 downto 0));
end component;
type STATE_TYPE is (Idle, InitTest, TestExecution, TestDone);
signal current_state : STATE_TYPE;
signal init_temp: STD_LOGIC;
signal enable_counter : STD_LOGIC;
signal Q : STD_LOGIC_VECTOR (UUT_INP_N downto 0);


begin

StateCounter: Counter generic map(N => UUT_INP_N+1)
							 port map(init => init_temp,
										 stop_nEN => NOT enable_counter,
										 CLK => CLK,
										 Q => Q);


state_signals:process(current_state)
begin
	case current_state is
		when Idle => 
			init_temp <= '0';
			done <= '0';
			stop <= '1';
			enable_counter <= '0';
		when InitTest =>
			init_temp <= '1';
			done <= '0';
			stop <= '0';
			enable_counter <= '0';
		when TestExecution => 
			init_temp <= '0';
			done <= '0';
			stop <= '0';
			enable_counter <= '1';
		when TestDone =>
			init_temp <= '0';
			done <= '1';
			stop <= '1';
			enable_counter <= '0';
		when others =>
			init_temp <= '0';
			done <= '0';
			stop <= '1';
			enable_counter <= '0';
		end case;

end process;

state_machine:process(CLK)
begin
	if rising_edge(CLK) then
		if reset = '1' then
			current_state <= Idle;
		else
			case current_state is
				when Idle =>
					if start = '1' then
						current_state <= InitTest;
					else 
						current_state <= Idle;
					end if;
		
				when InitTest =>
					current_state <= TestExecution;
					
				when TestExecution => 
					if Q = N-1 then
						current_state <= TestDone;
					else
						current_state <= TestExecution;
					end if;
				when TestDone =>
					if start = '1' then
						current_state <= InitTest;
					else 
						current_state <= TestDone;
					end if;
				when others =>
					current_state <= Idle;
			end case;
		end if;
	
	end if;
end process;

LFSRnCounter <= '0' when 2 ** UUT_INP_N = N else '1';

 init <= init_temp;
end Behavioral;

