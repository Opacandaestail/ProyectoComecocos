----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/13/2024 11:46:25 PM
-- Design Name: 
-- Module Name: Gestiona_Puntuacion - Behavioral
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

entity Gestiona_Puntuacion is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           puntos : in STD_LOGIC_vector(7 downto 0);
           ADDR : out STD_LOGIC_VECTOR (8 downto 0);
           Din : out STD_LOGIC_VECTOR (5 downto 0);
           we : out STD_LOGIC_VECTOR (0 downto 0);
           enable : out std_logic);
end Gestiona_Puntuacion;

architecture Behavioral of Gestiona_Puntuacion is --Programa para la gestión de la puntuacion por pantalla
signal ADDRs,p_ADDR            : std_logic_vector(8 downto 0);
signal dins,p_din              : std_logic_vector(5 downto 0);
signal puntos_s                : unsigned(7 downto 0);
signal digito1,digito2,digito3 : unsigned(3 downto 0);
signal cont,p_cont             : unsigned(4 downto 0);
signal p_digito1,p_digito2,p_digito3 : unsigned(3 downto 0);
begin

puntos_s<= unsigned(puntos);
din <= dins;
ADDR <= ADDRs;

sinc:process(clk,reset)
begin

if(reset = '1') then
ADDRs <= (others => '0');
dins  <= (others => '0');
cont  <= (others => '0');
digito1 <= (others => '0');
digito2 <= (others => '0');
digito3 <= (others => '0');
elsif(rising_edge(clk)) then
ADDRs <= p_ADDR;
dins  <= p_din;
cont  <= p_cont;
digito1 <=  p_digito1;
digito2 <=  p_digito2;
digito3 <=  p_digito3;
end if;
end process;


comb:process(puntos_s,ADDRs,dins,cont,digito1,digito2,digito3)
variable puntuacion : unsigned(7 downto 0);
variable digito1_var:unsigned(7 downto 0);
variable digito2_var:unsigned(7 downto 0);
variable digito3_var:unsigned(7 downto 0);
begin
p_digito1 <=  digito1; 
p_digito2 <=  digito2;
p_digito3 <=  digito3;

p_ADDR <= ADDRs;
we <= (others => '0');
enable <= '0';
p_cont <= cont;
p_din  <= dins;
puntuacion  := puntos_s;

digito1_var := (others => '0');
digito2_var := (others => '0');
digito3_var := (others => '0');

if(puntuacion > 0) then
digito3_var:= puntuacion mod 10; -- Calculo el ultimo digito 
puntuacion := puntuacion/10;
end if;

if(puntuacion > 0) then
digito2_var := puntuacion mod 10; -- Calculo el segundo digito 
puntuacion  := puntuacion/10;
end if;

if(puntuacion > 0) then
digito1_var := puntuacion mod 10; -- Calculo el primer digito 
puntuacion  := puntuacion/10;
end if;

p_digito1 <= digito1_var(3 downto 0);
p_digito2 <= digito2_var(3 downto 0);
p_digito3 <= digito3_var(3 downto 0);

if(cont < 2) then
    case digito1 is
    when "0000" => p_din <= "011111";
    when "0001" => p_din <= "010110";
    when "0010" => p_din <= "010111";
    when "0011" => p_din <= "011000";
    when "0100" => p_din <= "011001";
    when "0101" => p_din <= "011010";
    when "0110" => p_din <= "011011";
    when "0111" => p_din <= "011100";
    when "1000" => p_din <= "011101";
    when "1001" => p_din <= "011110";
    when others => p_din <= dins;
    end case;

    p_ADDR <= "0011" & "00010";



elsif(cont = 2 or cont = 6 or cont = 10) then
    we <= (others => '1');
    enable <= '1';

elsif(cont = 4) then

    case digito2 is
    when "0000" => p_din <= "011111";
    when "0001" => p_din <= "010110";
    when "0010" => p_din <= "010111";
    when "0011" => p_din <= "011000";
    when "0100" => p_din <= "011001";
    when "0101" => p_din <= "011010";
    when "0110" => p_din <= "011011";
    when "0111" => p_din <= "011100";
    when "1000" => p_din <= "011101";
    when "1001" => p_din <= "011110";
    when others => p_din <= dins;
    end case;

    p_ADDR <= "0011" & "00011";

elsif(cont = 8) then
case digito3 is
    when "0000" => p_din <= "011111";
    when "0001" => p_din <= "010110";
    when "0010" => p_din <= "010111";
    when "0011" => p_din <= "011000";
    when "0100" => p_din <= "011001";
    when "0101" => p_din <= "011010";
    when "0110" => p_din <= "011011";
    when "0111" => p_din <= "011100";
    when "1000" => p_din <= "011101";
    when "1001" => p_din <= "011110";
    when others => p_din <= dins;
    end case;

    p_ADDR <= "0011" & "00100";
    
elsif(cont = 12) then 
    p_cont <= (others => '0');
    
end if;
 p_cont <= cont +1;
end process;





end Behavioral;
