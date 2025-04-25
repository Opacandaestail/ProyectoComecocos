----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2024 11:18:35 AM
-- Design Name: 
-- Module Name: Divisor_Digitos - Behavioral
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

entity Divisor_Digitos is
    Port ( Puntos : in STD_LOGIC_vector(7 downto 0);
           Digitos : out STD_LOGIC_VECTOR (11 downto 0));
end Divisor_Digitos;

architecture Behavioral of Divisor_Digitos is
signal Digito1,Digito2,
begin

process(Puntos)
begin

if(Puntos > "11001011"

end process;

end Behavioral;
