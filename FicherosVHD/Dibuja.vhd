----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2024 11:31:01 PM
-- Design Name: 
-- Module Name: Dibuja - Behavioral
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
entity Dibuja is
    Port ( 
          
           EjeX         : in STD_LOGIC_VECTOR (9 downto 0);
           EjeY         : in STD_LOGIC_VECTOR (9 downto 0);
           Dout         : in std_logic_vector (2 downto 0);
           Dout_Sprites : in std_logic_vector (11 downto 0);
           sentido_c    : in std_logic_vector (1 downto 0);
           clk          : in std_logic;
           reset        : in std_logic;
           dout_Datos   : in std_logic_vector(5 downto 0);
           dout_Letras  : in std_logic_vector(11 downto 0);
           dout_Numeros : in std_logic_vector(11 downto 0);
           
           ADDR_Sprites : out std_logic_vector (12 downto 0);
           ADDR         : out std_logic_vector (8 downto 0);
           ADDR_Letras  : out std_logic_vector (12 downto 0);
           ADDR_Numeros : out std_logic_vector (11 downto 0);
           
           RGB          : out std_logic_vector (11 downto 0));
           
end Dibuja;

architecture Behavioral of Dibuja is --Programa que gestiona el color que se pintar� en pantalla

signal Sprite      : std_logic_vector(4 downto 0);
begin

          
ADDR         <=     EjeY(7 downto 4) & EjeX(8 downto 4);


ADDR_Sprites <= "00000" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout = "000" else -- Moneda
                "00001" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout = "001" else -- Pared
                
                "00110" & not(EjeX(3 downto 0) & EjeY(3 downto 0)) when dout = "011" and sentido_c = "01" else -- Mario
                "00010" & EjeY(3 downto 0) & EjeX(3 downto 0)      when dout = "011" and sentido_c = "11" else
                "00110" &  EjeY(3 downto 0) & EjeX(3 downto 0)     when dout = "011" and sentido_c = "10" else
                "00010" & not(EjeX(3 downto 0) & EjeY(3 downto 0)) when dout = "011" and sentido_c = "00" else
                
                "00011" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout = "100" else -- Goomba
                "00100" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout = "101" else -- Champiñon rojo
                "00101" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout = "110" else -- Champiñon verde
                (others => '0');

ADDR_Letras <="00000" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "000001" else   --A
              "00001" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "000010" else   --B
              "00010" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "000011" else   --C
              "00011" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "000100" else   --D
              "00100" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "000101" else   --E
              "00101" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "000110" else   --F
              "00110" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "000111" else   --G
              "00111" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "001000" else   --H
              "01000" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "001001" else   --I
              "01001" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "001010" else   --J
              "01010" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "001011" else   --L
              "01011" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "001100" else   --M
              "01100" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "001101" else   --N
              "01101" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "001110" else   --O
              "01110" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "001111" else   --P
              "01111" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "010000" else   --R
              "10000" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "010001" else   --S
              "10001" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "010010" else   --T
              "10010" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "010011" else   --V
              "10011" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "010100" else   --Z
              "10100" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "010101" else   --:
              "10101" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "100000" else   -- cabeza
              "10110" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "100001" else   -- X
              (others => '0');
              
ADDR_Numeros <= "0000" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "010110" else
                "0001" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "010111" else
                "0010" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "011000" else
                "0011" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "011001" else
                "0100" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "011010" else
                "0101" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "011011" else
                "0110" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "011100" else
                "0111" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "011101" else
                "1000" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "011110" else
                "1001" & EjeY(3 downto 0) & EjeX(3 downto 0) when dout_Datos = "011111" else
                (others => '0');

 
process(Dout,EjeX,EjeY,Dout_Sprites,Dout_Datos,Dout_Letras,Dout_Numeros)
begin
if((unsigned(EjeX) >= 0 and unsigned(ejeX) < 512) and (unsigned(EjeY) >= 0 and unsigned(EjeY) < 256)) then
    case Dout is
    when "010"  => RGB <= "000000000101";-- Vacio
    when others => RGB <= Dout_Sprites;
  end case;
elsif((unsigned(EjeX) >= 0 and unsigned(ejeX) < 512) and (unsigned(EjeY) >= 256 and unsigned(EjeY) < 479)) then
  if   (Dout_Datos > "010101" and Dout_Datos <="011111") then RGB <= Dout_Numeros; 
  elsif(Dout_Datos >= "000001" or Dout_Datos > "011111" ) then RGB <= Dout_Letras;
  else                              RGB <= (others => '1');
  end if;
  else                           
    RGB <= (others => '1');
end if;                        
  end process; 

end Behavioral;