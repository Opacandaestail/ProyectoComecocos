----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2024 05:57:49 PM
-- Design Name: 
-- Module Name: Pacman_Fantasma_AccesoMemoria_tb - Behavioral
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

entity Pacman_Fantasma_AccesoMemoria_tb is
--  Port ( );
end Pacman_Fantasma_AccesoMemoria_tb;

architecture Behavioral of Pacman_Fantasma_AccesoMemoria_tb is

component Acceso_Memoria is
Port(   

        ---------- Comecocos -----------------------------
        ADDR_c       : in std_logic_vector(8 downto 0);
        we_c         : in std_logic_vector(0 downto 0);
        enable_mem_c : in std_logic;
        din_c        : in std_logic_vector(2 downto 0);
        
        dout_c       : out std_logic_vector(2 downto 0);
        --------------------------------------------------
        
        
        ----------- Fantasma 1 ---------------------------
        ADDR_f1       : in std_logic_vector(8 downto 0);
        we_f1         : in std_logic_vector(0 downto 0);
        enable_mem_f1 : in std_logic;
        din_f1        : in std_logic_vector(2 downto 0);
        dout_f1       : out std_logic_vector(2 downto 0);
        --------------------------------------------------
        
        ----------- Fantasma 2 ---------------------------
        ADDR_f2       : in std_logic_vector(8 downto 0);
        we_f2         : in std_logic_vector(0 downto 0);
        enable_mem_f2 : in std_logic;
        din_f2        : in std_logic_vector(2 downto 0);
        dout_f2       : out std_logic_vector(2 downto 0);
        --------------------------------------------------
        
        
        ----------- Memoria ------------------------------
        dout_mem       : in std_logic_vector(2 downto 0); 
        ADDR_mem       : out std_logic_vector(8 downto 0);
        Din_mem        : out std_logic_vector(2 downto 0);
        we_mem         : out std_logic_vector(0 downto 0)
        --------------------------------------------------
       
);           
end component;


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



signal reset : STD_LOGIC;
signal clk : STD_LOGIC := '0';
signal refresh : std_logic := '0';
signal udlr_in : std_logic_vector(3 downto 0);
  -- Cables de la memoria a Acceso_Memoria.vhd
signal ADDR_A           : std_logic_vector(8 downto 0);
signal Dout_A           : std_logic_vector(2 downto 0);
--signal enable_A         : std_logic;
signal Din_A            : std_logic_vector(2 downto 0);
signal wea_s            : std_logic_vector(0 downto 0);


-- Comecocos
signal ADDR_cs          : std_logic_vector(8 downto 0);
signal enable_mem_cs    : std_logic;
signal we_cs            : std_logic_vector(0 downto 0);
signal donec            : std_logic;
signal Dout_cs          : std_logic_vector(2 downto 0);
signal Din_cs           : std_logic_vector(2 downto 0);


-- Fantasma 1
signal ADDR_f1s         : std_logic_vector(8 downto 0);
signal enable_mem_f1s   : std_logic;
signal we_f1s           : std_logic_vector(0 downto 0); 
signal donef1           : std_logic;
signal Dout_f1s         : std_logic_vector(2 downto 0);
signal Din_f1s          : std_logic_vector(2 downto 0);
--signal start            : std_logic;
signal Orcs             : std_logic;  
  
  constant clockPeriod : time := 10 ns; -- EDIT Clock period
  

begin


clk     <= not clk after clockPeriod/2;
refresh <= not refresh after 30*clockPeriod;

--Orcs <= '1' when rising_edge(start) else
--       '1' when Donef1 = '1' else
--       '0';
come:PacMan    
    Port map(             
           --Entradas
           Move         =>  refresh,
           reset        =>  reset,
           clk          =>  clk,
                       
           udlr         =>  udlr_in,
           dout         =>  Dout_cs,
           MuerteIn     =>  '0',
           
           --Salidas   
           din          =>  Din_cs, 
           we           =>  we_cs,
                       
           enable_mem   =>  enable_mem_cs,
                       
           ADDR         =>   ADDR_cs,   
           done         =>   donec
           );    


Tablero:Memoria_Tablero
port map(
        -- Entradas
        clka => clk,
        clkb => clk,
        
        ena => '1',
        
        wea => wea_s,
        web => (others => '0'),
        
        dina => Din_A,
        dinb => (others => '0'),
        
        addra => ADDR_A,
        addrb => (others => '0'),
        
        -- Salidas
        douta => Dout_A
        --doutb => Dout_B
);

Fantasma1:Fantasma
generic map(
                X_s             => "10000",
                Y_s             => "0111",
                codigo_fantasma => "100",
                valor_casilla   => "010"
)
port map(
                -- Entradas
                Move     => donec,
                reset    => reset,
                clk      => clk,
                dout     => dout_f1s,
                MuerteIn => '0',
                FinVida  => '0',
                mov      => (others => '0'),
                
                -- Salidas
                din        => din_f1s,
                we         => we_f1s,
                enable_mem => enable_mem_f1s,
                ADDR       => ADDR_f1s,
                done       => donef1
);

Mux_Memoria:Acceso_Memoria
port map(
        -- Entradas
        ADDR_c        => ADDR_cs,
        ADDR_f1       => ADDR_f1s,
        ADDR_f2       => (others => '0'),
        
        enable_mem_c  => enable_mem_cs,
        enable_mem_f1 => enable_mem_f1s,
        enable_mem_f2 => '0',
        
        we_c          => we_cs,
        we_f1         => we_f1s,
        we_f2         => (others => '0'),
        
        din_f1        => din_f1s,
        din_f2        => (others => '0'),
        din_c         => din_cs,
        
        dout_mem      => Dout_A,
        
        -- Salidas
        ADDR_mem      => ADDR_A,
        Din_mem       => Din_A, 
        we_mem        => wea_s,
        
        Dout_c        => Dout_cs,
        Dout_f1       => Dout_f1s
);



process
begin

reset <= '1';
udlr_in <= (others => '0');
wait for 1*clockPeriod;

reset <= '0';

wait for 3 *clockPeriod;
udlr_in <= "0010";



wait;


end process;

end Behavioral;
