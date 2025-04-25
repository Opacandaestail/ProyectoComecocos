----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2024 02:39:44 PM
-- Design Name: 
-- Module Name: pacman_y_memoria_tb - Behavioral
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

entity pacman_y_memoria_tb is

end pacman_y_memoria_tb;

architecture Behavioral of pacman_y_memoria_tb is

component PacMan
    Port ( 
           --Entradas 
           Move         : in STD_LOGIC;
           reset        : in STD_LOGIC;
           clk          : in STD_LOGIC;
           
           udlr         : in STD_LOGIC_VECTOR (3 downto 0);
           dout         : in STD_LOGIC_VECTOR (2 downto 0);
          
           MuerteIn     : in std_logic;
          
           --Salidas
           VidaOut      : out std_logic_vector(1 downto 0);
           FinVida      : out std_logic;
           MuerteOut    : out std_logic;
           sentido      : out std_logic_vector (1 downto 0);
           din          : out STD_LOGIC_VECTOR (2 downto 0);
           we           : out STD_LOGIC_VECTOR (0 downto 0);
           puntuacion   : out std_logic_vector (7 downto 0);
           
           enable_mem   : out STD_LOGIC;

          
           ADDR         : out STD_LOGIC_VECTOR (8 downto 0);
           done         : out STD_LOGIC);
end component;

component Memoria_Tablero IS
  PORT (
    clka  : IN STD_LOGIC;
    clkb  : IN STD_LOGIC;
    
    ena   : IN STD_LOGIC;
    
    wea   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    web   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    
    dina  : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    dinb  : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    
    addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    
    doutb : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
  );
END component;

component Div_Refresh is
    Port ( clk         : in STD_LOGIC;
           reset       : in STD_LOGIC;
           refresh     : in STD_LOGIC;
           refresh_div : out STD_LOGIC);
end component;

signal refresh_div : std_logic;

constant clockPeriod : time := 10 ns; -- EDIT Clock period

 signal clk : std_logic := '0';
 signal reset : std_logic;
 signal udlr_in : std_logic_vector(3 downto 0);
 signal refresh : std_logic := '0';
 signal we_s   : std_logic_vector(0 downto 0);
 signal din_s  : std_logic_vector(2 downto 0);
 signal addr_s : std_logic_vector(8 downto 0);
 signal dout : std_logic_vector(2 downto 0);
 signal MuerteIn : std_logic;
begin


memoria:Memoria_Tablero
port map(
        clka => clk,
        clkb => clk,
        ena => '1',
        web => (others => '0'),
        wea => we_s,
        dina => din_s,
        dinb => (others => '0'),
        addra => addr_s,
        addrb => (others => '0'),
        
        douta => dout
);


come:PacMan    
    Port map(             
           --Entradas
           Move         =>  refresh_div,
           reset        =>  reset,
           clk          =>  clk,
                       
           udlr         =>  udlr_in,
           dout         =>  Dout,
           MuerteIn     => '0',
           
            -- Salidas
           din          =>  Din_s, 
           we           =>  we_s,
           ADDR         =>   ADDR_s   

           );    


Divisor_Frecuencia:Div_Refresh
port map(
        -- Entradas
        clk        => clk,
        reset      => reset,
        refresh    => refresh,
        
        -- Salidas
        refresh_div => refresh_div
);



clk     <= not clk after clockPeriod/2;
refresh <= not refresh after 30*clockPeriod;

stimuli : process
begin

reset <= '1';
udlr_in <= (others => '0');

wait for 1*clockPeriod;

reset <= '0';
udlr_in <= "0000";
wait for 3*clockPeriod;
udlr_in <= "0000";

--
wait for 35 us;
udlr_in <= "0001";

wait for 20 us;
udlr_in <= "0000";
wait;
end process;



end Behavioral;
