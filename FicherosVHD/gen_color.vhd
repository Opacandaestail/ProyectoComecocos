----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2024 05:22:12 PM
-- Design Name: 
-- Module Name: gen_color - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gen_color is
Port(
    Blank_H : in std_logic;
    Blank_V : in std_logic;
    RED_in  : in std_logic_vector(3 downto 0);
    Blu_in  : in std_logic_vector(3 downto 0);
    GRN_in  : in std_logic_vector(3 downto 0);
    
    RED     : out std_logic_vector(3 downto 0);
    BLU     : out std_logic_vector(3 downto 0);
    GRN     : out std_logic_vector(3 downto 0)
);
end gen_color;

architecture Behavioral of gen_color is

begin


gen_color:process(RED_in,GRN_in,BLU_in,Blank_H,Blank_V)
begin
    if(Blank_H = '1' or Blank_V = '1') then
        RED <= (others => '0');
        GRN <= (others => '0');
        BLU <= (others => '0');
    else
        RED <= RED_in;
        GRN <= GRN_in;
        BLU <= BLU_in;
    end if;
    
end process gen_color;


end Behavioral;
