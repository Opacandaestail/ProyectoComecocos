----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2024 11:21:51 PM
-- Design Name: 
-- Module Name: Genera_Movimiento - Behavioral
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

entity Genera_Movimiento is
  port (
    reset  : in  std_logic;
    clk    : in  std_logic;                    
    count  : out std_logic_vector (3 downto 0)
  );
end entity;

architecture Behavioral of Genera_Movimiento is --Programa que genera un movimiento pseudoaleatorio
    signal count_i      : std_logic_vector (3 downto 0);
    signal feedback     : std_logic;

begin
    feedback <= not(count_i(3) xor count_i(2));

    process (reset, clk) 
        begin
        if (reset = '1') then
            count_i <= (others=>'0');
        elsif (rising_edge(clk)) then
            count_i <= count_i(2 downto 0) & feedback;
        end if;
    end process;
    count <= count_i;
end architecture;