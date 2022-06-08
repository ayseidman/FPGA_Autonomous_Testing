----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:35:52 06/05/2022 
-- Design Name: 
-- Module Name:    74HC153N - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_74HC153N is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           IN1 : in  STD_LOGIC_VECTOR (3 downto 0);
           IN2 : in  STD_LOGIC_VECTOR (3 downto 0);
           nEN1 : in  STD_LOGIC;
           nEN2 : in  STD_LOGIC;
           O1 : out  STD_LOGIC;
           O2 : out  STD_LOGIC);
end MUX_74HC153N;

architecture Behavioral of MUX_74HC153N is

	component MUX4x1 is
    Port ( I : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC;
           EN : in  STD_LOGIC;
           SEL : in  STD_LOGIC_VECTOR (1 downto 0));
	end component;
	signal SEL : STD_LOGIC_VECTOR (1 downto 0);
begin
	
	SEL <= B & A;
	
	MUX1: MUX4x1 port map(IN1, O1, NOT nEN1, SEL);
	MUX2: MUX4x1 port map(IN2, O2, NOT nEN2, SEL);

end Behavioral;

