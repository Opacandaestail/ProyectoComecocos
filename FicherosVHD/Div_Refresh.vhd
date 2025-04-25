----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2024 12:15:37 PM
-- Design Name: 
-- Module Name: Div_Refresh - Behavioral
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

entity Div_Refresh is
    Port ( clk         : in STD_LOGIC;
           reset       : in STD_LOGIC;
           refresh     : in STD_LOGIC;
           refresh_div : out STD_LOGIC);
end Div_Refresh;

architecture Behavioral of Div_Refresh is --Programa que relentiza la entrada de los refresh
signal cont,p_cont                 : unsigned(4 downto 0);--Se evita que vaya demasiado rapido
signal p_refresh_divs,refresh_divs : std_logic;
begin

process(clk,reset)
begin
    if(reset = '1') then
        cont           <= (others => '0');
        refresh_divs   <= '0'; 
    elsif(rising_edge(clk)) then
        cont           <= p_cont;
        refresh_divs   <= p_refresh_divs;
    end if;
end process;

process(refresh,cont,refresh_divs)
begin
    p_cont         <= cont;
    p_refresh_divs <= refresh_divs;
    
    if(rising_edge(refresh)) then
        p_cont <= cont+1;
    end if;
    
    if(cont = 9) then
        p_cont         <= (others => '0');
        p_refresh_divs <= '1';
    else 
        p_refresh_divs <= '0';
    end if;
end process;

refresh_div <= refresh_divs;

end Behavioral;
