----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2024 06:48:51 PM
-- Design Name: 
-- Module Name: Practica_Completa - Behavioral
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

entity Arquitectura_Superior is
  Port(
        clk     : in std_logic;
        reset   : in std_logic;
        
        -- Botones de entrada de movimiento
        udlr_in: in std_logic_vector(3 downto 0);
           -- udlr_in(3) -> Arriba
           -- udlr_in(2) -> Abajo
           -- udlr_in(1) -> Izquierda
           -- udlr_in(0) -> Derecha
        LED    : out std_logic_vector(3 downto 0);
        RED    : out std_logic_vector(3 downto 0);
        GRN    : out std_logic_vector(3 downto 0);
        BLU    : out std_logic_vector(3 downto 0);
        HS     : out std_logic;
        VS     : out std_logic
   );
end Arquitectura_Superior;

architecture Behavioral of Arquitectura_Superior is

component Genera_Movimiento is
    port (
            reset  : in  std_logic;
            clk    : in  std_logic;                    
            count  : out std_logic_vector (3 downto 0)
  );
end component;


component Gestiona_Vidas is
    Port ( clk   : in STD_LOGIC;
           reset : in STD_LOGIC;
           vidas : in STD_LOGIC_vector(1 downto 0);
           ADDR  : out STD_LOGIC_VECTOR (8 downto 0);
           din   : out STD_LOGIC_VECTOR (5 downto 0);
           we    : out std_logic_vector(0 downto 0);
           enable : out std_logic);
end component;


component NUMEROS IS
  PORT (
            clka : IN STD_LOGIC;
            addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END component;

component LETRAS IS
  PORT (
            clka : IN STD_LOGIC;
            addra : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END component;

component Driver_VGA is
    Port ( 
           clk     : in std_logic;
           reset   : in std_logic;
           RGB_in  : in std_logic_vector(11 downto 0);
           
           ejeX    : out STD_LOGIC_VECTOR (9 downto 0);
           ejeY    : out STD_LOGIC_VECTOR (9 downto 0);
           Refresh : out STD_LOGIC;
           
           HS      : out STD_LOGIC;
           VS      : out STD_LOGIC;
           
           RED    : out STD_LOGIC_VECTOR (3 downto 0);
           GRN    : out STD_LOGIC_VECTOR (3 downto 0);
           BLU    : out STD_LOGIC_VECTOR (3 downto 0));
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


component Dibuja is
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
           
           RGB          : out std_logic_vector (11 downto 0)
);
end component;

 
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


component Memoria_Sprites IS
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END component;

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

component Memoria_Datos IS
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    clkb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    enb   : in std_logic;
    doutb : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
  );
END component;

component Gestion_Botones is
    Port ( udlr_in  : in std_logic_vector(3 downto 0);
           clk      : in std_logic;
           reset    : in std_logic;
           
           udlr_out : out std_logic_vector(3 downto 0));
end component;

component Gestiona_Puntuacion is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           puntos : in STD_LOGIC_vector(7 downto 0);
           ADDR : out STD_LOGIC_VECTOR (8 downto 0);
           Din : out STD_LOGIC_VECTOR (5 downto 0);
           we : out STD_LOGIC_VECTOR (0 downto 0);
           enable : out std_logic);
end component;
------------------------------------------------------------------------
-------------------------------CABLES ---------------------------------
------------------------------------------------------------------------

-- 
signal OrMuerte         : std_logic;
signal FinVida          : std_logic;

-- Memoria para la zona de la pantalla de debajo del tablero de juego
signal dout_Datos       : std_logic_vector(5 downto 0);
signal ADDR_Datos       : std_logic_vector(8 downto 0);
signal we_Datos         : std_logic_vector(0 downto 0);
signal din_Datos        : std_logic_vector(5 downto 0);


signal ADDR_Vidas       : std_logic_vector(8 downto 0);
signal we_Vidas         : std_logic_vector(0 downto 0);
signal din_Vidas        : std_logic_vector(5 downto 0);
signal enable_vidas     : std_logic;


signal ADDR_Puntos      : std_logic_vector(8 downto 0);
signal we_puntos        : std_logic_vector(0 downto 0);
signal din_puntos       : std_logic_vector(5 downto 0);
signal enable_puntos     : std_logic;

-- Memoria de las letras y memoria de los numeros
signal dout_Letras      : std_logic_vector(11 downto 0);
signal ADDR_Letras      : std_logic_vector(12 downto 0);
signal ADDR_Numeros     : std_logic_vector(11 downto 0);
signal dout_Numeros     : std_logic_vector(11 downto 0);


-- Dibujo de los sprites
signal ADDR_Sprites     : std_logic_vector(12 downto 0);
signal Dout_Sprites     : std_logic_vector(11 downto 0);

-- Se�al para la gestion de botones de entrada de movimiento
signal udlr_out         : std_logic_vector(3 downto 0);


-- Divisor de frecuencia del refresh
signal refresh_div      : std_logic;


-- Cables para el Driver_VGA.vhd
signal ejeX_s, ejeY_s   : std_logic_vector(9 downto 0);
signal RGB_s            : std_logic_vector(11 downto 0);
signal Refresh          : std_logic;


-- Cables de la memoria a Dibuja.vhd 
signal ADDR_B           : std_logic_vector(8 downto 0); --  Dibujar         -> Memoria_Tablero
signal Dout_B           : std_logic_vector(2 downto 0); --  Memoria_Tablero -> Dibujar


-- Cables de la memoria a Acceso_Memoria.vhd
signal ADDR_A           : std_logic_vector(8 downto 0);
signal Dout_A           : std_logic_vector(2 downto 0);
signal enable_A         : std_logic;
signal Din_A            : std_logic_vector(2 downto 0);
signal wea_s            : std_logic_vector(0 downto 0);


-- Comecocos
signal ADDR_cs          : std_logic_vector(8 downto 0);
signal enable_mem_cs    : std_logic;
signal we_cs            : std_logic_vector(0 downto 0);
signal donec            : std_logic;
signal Dout_cs          : std_logic_vector(2 downto 0);
signal Din_cs           : std_logic_vector(2 downto 0);
signal sentido_c        : std_logic_vector(1 downto 0);
signal Muerte_c         : std_logic;
signal Puntos_s         : std_logic_vector(7 downto 0);
signal VidaOut_s        : std_logic_vector(1 downto 0);

-- Fantasma 1
signal ADDR_f1s         : std_logic_vector(8 downto 0);
signal enable_mem_f1s   : std_logic;
signal we_f1s           : std_logic_vector(0 downto 0); 
signal donef1           : std_logic;
signal Dout_f1s         : std_logic_vector(2 downto 0);
signal Din_f1s          : std_logic_vector(2 downto 0);
signal sentido_f1       : std_logic_vector(1 downto 0);
signal Muerte_f1        : std_logic;
signal mov              : std_logic_vector(3 downto 0);

-- Fantasma 2
signal ADDR_f2s         : std_logic_vector(8 downto 0);
signal enable_mem_f2s   : std_logic;
signal we_f2s           : std_logic_vector(0 downto 0); 
signal donef2           : std_logic;
signal Dout_f2s         : std_logic_vector(2 downto 0);
signal Din_f2s          : std_logic_vector(2 downto 0);
signal sentido_f2       : std_logic_vector(1 downto 0);
signal Muerte_f2        : std_logic;

begin

LED <= udlr_in;


OrMuerte <= Muerte_c or Muerte_f1 or Muerte_f2;
----------------------------------------------------------------------------------
Gestion_Vidas:Gestiona_Vidas
port map(
    clk    => clk,
    reset  => reset,
    vidas  => VidaOut_s,
    ADDR   => ADDR_Vidas,
    din    => Din_Vidas,
    we     => we_vidas,
    enable => enable_vidas
);

-----------------------------------------------------------------
Movimiento:Genera_Movimiento
port map(
    clk   => clk,
    reset => reset,
    count   => mov
);

----------------------------------------------------------------------------
Memoria_Numeros:Numeros
port map(
        clka  => clk,
        ADDRA => ADDR_Numeros,
        DoutA => Dout_Numeros 
);

--------------------------------------------------------------
Puntuacion:Gestiona_Puntuacion
port map(
    clk => clk,
    reset => reset,
    puntos => Puntos_s,
    ADDR   => ADDR_Puntos,
    Din    => Din_Puntos,
    we     => we_puntos,
    enable => enable_puntos
);

---------------------------------------------------------------
Entrada_Botones:Gestion_botones
port map(
        clk      => clk,
        reset    => reset,
        udlr_in  => udlr_in,
        
        udlr_out => udlr_out
);

-----------------------------------------------------------------
Divisor_Frecuencia:Div_Refresh
port map(
        -- Entradas
        clk        => clk,
        reset      => reset,
        refresh    => refresh,
        
        -- Salidas
        refresh_div => refresh_div
);

----------------------------------------------------------------
Memoria_Letras:Letras
port map(
      clka => clk,
      addra => ADDR_Letras,
      douta => Dout_Letras
);

--------------------------------------------------------------
Datos:Memoria_Datos
port map(
       clka  => clk,
       clkb  => clk,
       ena   => '1',
       wea   => we_Datos,
       addra => ADDR_Datos,
       dina  => Din_Datos,
       web   => (others => '0'),
       ADDRB => ADDR_B,
       dinB  => (others => '0'),
       enb   => '1',
       doutB => dout_Datos
);

----------------------------------------------------------------
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
        addrb => ADDR_B,
        
        -- Salidas
        douta => Dout_A,
        doutb => Dout_B
);

----------------------------------------------------------------
Sprites:Memoria_Sprites
port map(
        clka => clk,
       addra => ADDR_Sprites,
        ena  => '1',
       douta => Dout_Sprites
);

----------------------------------------------------------------
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
                MuerteIn => Ormuerte,
                FinVida  => FinVida,
                mov      => mov(3 downto 2),
                
                -- Salidas
                MuerteOut  => Muerte_f1,
                din        => din_f1s,
                we         => we_f1s,
                enable_mem => enable_mem_f1s,
                ADDR       => ADDR_f1s,
                done       => donef1
);

-----------------------------------------------------------------
Fantasma2:Fantasma
generic map(
                X_s             => "00101",
                Y_s             => "0001",
                codigo_fantasma => "100",
                valor_casilla   => "000"
)
port map(
                -- Entradas
                Move     => donef1,
                reset    => reset,
                clk      => clk,
                dout     => dout_f2s,
                MuerteIn => Ormuerte,
                FinVida  => FinVida,
                mov      => mov(1 downto 0),
                
                -- Salidas
                MuerteOut  => Muerte_f2,
                din        => din_f2s,
                we         => we_f2s,
                enable_mem => enable_mem_f2s,
                ADDR       => ADDR_f2s,
                done       => donef2
);

-----------------------------------------------------------------
come:PacMan    
    Port map(             
           --Entradas
           Move         =>  refresh_div,
           reset        =>  reset,
           clk          =>  clk,
                       
           udlr         =>  udlr_out,
           dout         =>  Dout_cs,
           MuerteIn     => OrMuerte,
           FinVida      => FinVida,
           
           --Salidas
           VidaOut      => VidaOut_s,
           MuerteOut    => Muerte_c,   
           sentido      => sentido_c,
           din          =>  Din_cs, 
           we           =>  we_cs,
                       
           enable_mem   =>  enable_mem_cs,
                       
           ADDR         =>   ADDR_cs,   
           done         =>   donec,
           
           Puntuacion   => Puntos_s
           );    

--------------------------------------------------------------------
Dibujar:Dibuja
port map(
          -- Entradas
          EjeX         => ejeX_s,
          EjeY         => ejeY_s,
          Dout         => Dout_B,
          Dout_Sprites => Dout_Sprites,
          sentido_c    => sentido_c,
          clk => clk,
          reset => reset,  
          dout_Letras => dout_Letras,
          dout_Datos  => dout_Datos,
          dout_Numeros => dout_Numeros,
          
          -- Salidas
          ADDR_Numeros => ADDR_Numeros,
          ADDR_Sprites => ADDR_Sprites,
          ADDR_Letras  => ADDR_Letras,
          ADDR         => ADDR_B,
          RGB          => RGB_s
);

--------------------------------------------------------------------
Driver:Driver_VGA
port map(
           -- Entradas
           clk       => clk,
           reset     => reset,
           RGB_in    => RGB_s,
           
           -- Salidas
           ejeX      => ejeX_s,
           ejeY      => ejeY_s,
           VS        => VS,
           HS        => HS,
           RED       => RED,
           GRN       => GRN,
           BLU       => BLU,
           Refresh   => Refresh
);

---------------------------------------------------------------
Mux_Memoria:Acceso_Memoria
port map(
        -- Entradas
        ADDR_c        => ADDR_cs,
        ADDR_f1       => ADDR_f1s,
        ADDR_f2       => ADDR_f2s,
        
        enable_mem_c  => enable_mem_cs,
        enable_mem_f1 => enable_mem_f1s,
        enable_mem_f2 => enable_mem_f2s,
        
        we_c          => we_cs,
        we_f1         => we_f1s,
        we_f2         => we_f2s,
        
        din_f1        => din_f1s,
        din_f2        => din_f2s,
        din_c         => din_cs,
        
        dout_mem      => Dout_A,
        
        -- Salidas
        ADDR_mem      => ADDR_A,
        Din_mem       => Din_A, 
        we_mem        => wea_s,
        
        Dout_c        => Dout_cs,
        Dout_f1       => Dout_f1s,
        Dout_f2       => Dout_f2s
);

---------------------------------------------------------------------------------------
-- Multiplexor para el acceso a la memoria de debajo del tablero
Din_Datos <= Din_Vidas  when enable_vidas = '1' else
             Din_Puntos when enable_puntos = '1' else
             (others => '0');
             
we_datos <= we_Vidas  when enable_vidas = '1' else
            we_Puntos when enable_puntos = '1' else
            (others => '0'); 
            
ADDR_datos <= ADDR_Vidas  when enable_vidas = '1' else
              ADDr_Puntos when enable_puntos = '1' else
              (others => '0'); 


end Behavioral;