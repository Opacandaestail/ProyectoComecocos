----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2024 05:25:53 PM
-- Design Name: 
-- Module Name: Fantasma_Y_Memoria_tb - Behavioral
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

entity Fantasma_Y_Memoria_tb is
--  Port ( );
end Fantasma_Y_Memoria_tb;

architecture Behavioral of Fantasma_Y_Memoria_tb is

component Fantasma is
generic	(  X_s	           : unsigned(4 downto 0) := "10000";
	       Y_s	           : unsigned(3 downto 0) :="0111";
	       codigo_fantasma : unsigned(2 downto 0) := "100"; 
	       valor_casilla   : unsigned(2 downto 0) := "010");
	       
port     ( Move         : in STD_LOGIC;
           reset        : in STD_LOGIC;
           clk          : in STD_LOGIC;
           dout         : in STD_LOGIC_VECTOR (2 downto 0);
           MuerteIn     : in std_logic;
           FinVida      : in std_logic;
           mov          : in std_logic_vector(1 downto 0);
           
           MuerteOut    : out std_logic;
           din          : out STD_LOGIC_VECTOR (2 downto 0);
           we           : out STD_LOGIC_VECTOR(0 downto 0);
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


  --signal Move       : STD_LOGIC;
  signal reset      : STD_LOGIC;
  signal clk        : STD_LOGIC := '0';
  signal dout       : STD_LOGIC_VECTOR (2 downto 0);
  signal din        : STD_LOGIC_VECTOR (2 downto 0);
  signal we         : STD_LOGIC_VECTOR(0 downto 0);
  signal enable_mem : STD_LOGIC;
  signal ADDR       : STD_LOGIC_VECTOR (8 downto 0);
  signal done       : STD_LOGIC;
  signal refresh1    : std_logic := '0';
  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin

  
  clk     <= not clk after clockPeriod/2;
  refresh1 <= not refresh1 after 25*clockPeriod;
  
Fantasma1:Fantasma
generic map(
                X_s             => "10000",
                Y_s             => "0111",
                codigo_fantasma => "100",
                valor_casilla   => "010"
)
port map(
                -- Entradas
                Move     => refresh1,
                reset    => reset,
                clk      => clk,
                dout     => dout,
                MuerteIn => '0',
                FinVida  => '0',
                mov      => (others=> '0'),
                
                -- Salidas
                din        => din,
                we         => we,
                ADDR       => ADDR,
                done       => done
);

memoria:Memoria_Tablero
port map(
        clka => clk,
        clkb => clk,
        ena => '1',
        web => (others => '0'),
        wea => we,
        dina => din,
        dinb => (others => '0'),
        addra => addr,
        addrb => (others => '0'),
        
        douta => dout
);

process
begin

    reset <= '1';
    
    wait for 1*clockPeriod;
    reset <= '0';
    wait;
end process;

end Behavioral;
