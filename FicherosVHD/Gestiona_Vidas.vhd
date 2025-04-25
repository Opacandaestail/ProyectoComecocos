----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2024 02:20:59 PM
-- Design Name: 
-- Module Name: Gestiona_Vidas - Behavioral
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

entity Gestiona_Vidas is
    Port ( clk   : in STD_LOGIC;
           reset : in STD_LOGIC;
           vidas : in STD_LOGIC_vector(1 downto 0);
           ADDR  : out STD_LOGIC_VECTOR (8 downto 0);
           din   : out STD_LOGIC_VECTOR (5 downto 0);
           we    : out std_logic_vector(0 downto 0);
           enable : out std_logic);
end Gestiona_Vidas;

architecture Behavioral of Gestiona_Vidas is --Programa para la gestion de las vidas por pantalla
signal dins,p_din   : std_logic_vector(5 downto 0);
signal cont, p_cont : unsigned(2 downto 0);
begin

din  <= dins;
ADDR <= "0010" & "10000";

sinc:process(clk,reset)
begin


if(reset = '1') then
    dins  <= (others => '0');
    cont  <= (others => '0');
elsif(rising_edge(clk)) then
    dins  <= p_din;
    cont  <= p_cont;
end if;
end process;

comb:process(dins,vidas,cont)
begin

p_din  <= dins ;
p_cont <= cont +1;
we <= (others => '0');
enable <= '0';


case vidas is
    when "11"   => p_din <= "011000";
    when "10"   => p_din <= "010111";
    when "01"   => p_din <= "010110";
    when others => p_din <= "011111";
end case;

if(cont = 4) then
    we <= (others => '1');
    enable <= '1';
elsif(cont  >= 5) then
    p_cont <= (others => '0');
end if;

end process;

end Behavioral;
