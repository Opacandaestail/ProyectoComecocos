----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/04/2024 11:36:29 PM
-- Design Name: 
-- Module Name: frec_pixel - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity frec_pixel is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_pixel : out STD_LOGIC);
end frec_pixel;

architecture Behavioral of frec_pixel is
signal cont, cont_s : unsigned(1 downto 0);
begin

process(clk,reset)
begin
    if(reset = '1') then
        cont <= (others => '0');
    elsif(rising_edge(clk)) then
        cont <= cont_s;
    end if;
end process;

process(cont)
begin
    cont_s <= cont + 1;
    
    if(cont = "11") then
        clk_pixel <= '1';
    else 
        clk_pixel <= '0';
    end if;
end process;
end Behavioral;
