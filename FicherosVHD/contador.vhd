----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/04/2024 10:42:59 PM
-- Design Name: 
-- Module Name: contador - Behavioral
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

entity contador is
    Generic (Nbit : INTEGER := 2);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           resets : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (Nbit-1 downto 0));
end contador;

architecture Behavioral of contador is
signal Q_s, Q_p : unsigned(Nbit-1 downto 0);
begin


sinc:process(clk,reset)
begin
    if(reset = '1') then
        Q_s <= (others => '0');
    elsif(rising_edge(clk)) then
        if(resets = '1') then
            Q_s <= (others => '0');
        else
            Q_s <=  Q_p;
        end if;
    end if;
end process sinc;


comb:process(Q_s,enable)
begin
    
    
    if(enable = '1') then
        Q_p <= Q_s + 1;
    else 
        Q_p <= Q_s;
    end if; 
    
end process comb;

Q <= std_logic_vector(Q_s);
end Behavioral;
