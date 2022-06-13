----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:48:19 06/05/2022 
-- Design Name: 
-- Module Name:    UnitUnderTest - Behavioral 
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

entity UnitUnderTest is
    Port ( inp : in  STD_LOGIC_VECTOR (14 downto 0);
           output : out  STD_LOGIC);
end UnitUnderTest;

architecture Behavioral of UnitUnderTest is

component Counter is
	generic(N : integer := 15);
    Port ( init : in  STD_LOGIC;
           stop_nEN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (N-1 downto 0));
end component;

component MUX_74HC153N is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           IN1 : in  STD_LOGIC_VECTOR (3 downto 0);
           IN2 : in  STD_LOGIC_VECTOR (3 downto 0);
           nEN1 : in  STD_LOGIC;
           nEN2 : in  STD_LOGIC;
           O1 : out  STD_LOGIC;
           O2 : out  STD_LOGIC);
end component;

signal MUX1_IN, MUX2_IN, MUX3_IN, MUX4_IN : STD_LOGIC_VECTOR(3 downto 0);
signal MUX1_OUT, MUX2_OUT, MUX3_OUT, MUX4_OUT : STD_LOGIC;

begin
	
	MUX1_IN <= inp(6 downto 3);
	MUX2_IN <= inp(6 downto 5) & MUX1_OUT & MUX1_OUT;
	MUX3_IN <= inp(13 downto 11) & MUX2_OUT;
	MUX4_IN <= inp(13 downto 12) & MUX3_OUT & MUX3_OUT;

	MODULE1: MUX_74HC153N port map(A => inp(1), 
											 B => inp(0),
											 IN1 => MUX1_IN,
											 IN2 => MUX2_IN,
											 nEN1 => inp(2),
											 nEN2 => inp(7),
											 O1 => MUX1_OUT,
											 O2 => MUX2_OUT);
	
	
	MODULE2: MUX_74HC153N port map(A => inp(9), 
											 B => inp(8),
											 IN1 => MUX3_IN,
											 IN2 => MUX4_IN,
											 nEN1 => inp(10),
											 nEN2 => inp(14),
											 O1 => MUX3_OUT,
											 O2 => MUX4_OUT);
	
	output <= MUX4_OUT;

end Behavioral;

