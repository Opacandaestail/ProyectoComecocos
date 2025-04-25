----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2024 09:34:31 AM
-- Design Name: 
-- Module Name: Gestion_Botones - Behavioral
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

entity Gestion_Botones is
    Port ( udlr_in  : in std_logic_vector(3 downto 0);
           clk      : in std_logic;
           reset    : in std_logic;
           
           udlr_out : out std_logic_vector(3 downto 0));
end Gestion_Botones;

architecture Behavioral of Gestion_Botones is --Programa que evita el one hot en la entrada de los botones
signal udlr_s,p_udlr_s : std_logic_vector(3 downto 0);
begin

udlr_out <= udlr_s;

sinc:process(clk,reset)
begin
    if(reset = '1') then
        udlr_s <= (others => '0');
    elsif(rising_edge(clk)) then
        udlr_s <= p_udlr_s;
    end if;
end process;

comb:process(udlr_s,udlr_in)
begin
    p_udlr_s <= udlr_s;
    
    case udlr_in is
        when "1000" => p_udlr_s <= "1000";
        when "0100" => p_udlr_s <= "0100";
        when "0010" => p_udlr_s <= "0010";
        when "0001" => p_udlr_s <= "0001";
        when others => p_udlr_s <= udlr_s;
    end case;
end process;

end Behavioral;
