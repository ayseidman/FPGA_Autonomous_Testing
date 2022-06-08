----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:20:02 06/06/2022 
-- Design Name: 
-- Module Name:    TestVectorGenerator - Behavioral 
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

entity TestVectorGenerator is
    Port ( init : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           uut_input : out  STD_LOGIC_VECTOR (14 downto 0));
end TestVectorGenerator;

architecture Behavioral of TestVectorGenerator is

begin


end Behavioral;

