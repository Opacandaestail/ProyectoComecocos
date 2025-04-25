----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2024 05:47:34 PM
-- Design Name: 
-- Module Name: Driver_VGA - Behavioral
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

entity Driver_VGA is
    Port ( 
           clk     : in std_logic;
           reset   : in std_logic;
           RGB_in  : in std_logic_vector(11 downto 0);
           
           
           ejeX    : out STD_LOGIC_VECTOR (9 downto 0);
           ejeY    : out STD_LOGIC_VECTOR (9 downto 0);
           Refresh : out STD_LOGIC;
           HS      : out STD_LOGIC;
           VS      : out STD_LOGIC;
           RED     : out STD_LOGIC_VECTOR (3 downto 0);
           GRN     : out STD_LOGIC_VECTOR (3 downto 0);
           BLU     : out STD_LOGIC_VECTOR (3 downto 0));
end Driver_VGA;

architecture Behavioral of Driver_VGA is --Programa para mandar la direccion donde debe de pintar el color recibido

component comparador is
    Generic (NBit           : integer := 8;
             End_Of_Screen  : integer := 10;
             Start_Of_Pulse : integer := 20;
             End_Of_Pulse   : integer := 30;
             End_Of_Line    : integer := 40);
             
    Port ( clk   : in STD_LOGIC;
           reset : in STD_LOGIC;
           data  : in STD_LOGIC_VECTOR (Nbit-1 downto 0);
           
           O1 : out STD_LOGIC;
           O2 : out STD_LOGIC;
           O3 : out STD_LOGIC);
end component;


component contador is
    Generic (Nbit : INTEGER := 2);
    Port (      clk : in STD_LOGIC;
              reset : in STD_LOGIC;
             enable : in STD_LOGIC;
             resets : in STD_LOGIC;
             
                  Q : out STD_LOGIC_VECTOR (Nbit-1 downto 0));
end component;


component gen_color is
Port(
    Blank_H : in std_logic;
    Blank_V : in std_logic;
    RED_in  : in std_logic_vector(3 downto 0);
    Blu_in  : in std_logic_vector(3 downto 0);
    GRN_in  : in std_logic_vector(3 downto 0);
    
    RED     : out std_logic_vector(3 downto 0);
    BLU     : out std_logic_vector(3 downto 0);
    GRN     : out std_logic_vector(3 downto 0)
);
end component;

component frec_pixel is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_pixel : out STD_LOGIC);
end component;


-------- CABLES ---------------------
signal div_frec_s                   : std_logic;
signal O1_out_v, O2_out_v, O3_out_v : std_logic;
signal O1_out_h, O2_out_h, O3_out_h : std_logic;
signal and_enable_cont_v            : std_logic;
signal Qx,Qy                        : std_logic_vector(9 downto 0);
signal RED_s,BLU_s,GRN_s            : std_logic_vector(3 downto 0);
-------------------------------------
begin

div_frec:frec_pixel
port map(
        -- Entradas
        clk       => clk,
        reset     => reset,
        
        -- Salidas
        clk_pixel => div_frec_s
);

contv:contador
generic map(Nbit => 10)
port map(
      -- Entradas
      clk    => clk,
      reset  => reset,
      enable => and_enable_cont_v, 
      resets => O3_out_v,
      
      -- Salidas
      Q      => Qy
      );


conth:contador
generic map(Nbit => 10)
port map(
      -- Entradas
      clk    => clk,
      reset  => reset,
      enable => div_frec_s, 
      resets => and_enable_cont_v,
      
      -- Salidas
      Q      => Qx
);

comph:comparador
generic map(
        Nbit           => 10,
        End_Of_Screen  => 639,
        Start_Of_Pulse => 655,
        End_Of_Pulse   => 751,
        End_Of_Line    => 799
)
port map(
        -- Entradas
        clk   => clk,
        reset => reset,
        data  => Qx,
        
        -- Salidas
        O1 => O1_out_h,
        O2 => O2_out_h,
        O3 => O3_out_h 
);


compv:comparador
generic map(
        Nbit           => 10,
        End_Of_Screen  => 479,
        Start_Of_Pulse => 489,
        End_Of_Pulse   => 491,
        End_Of_Line    => 520
)
port map(
        -- Entradas
        clk   => clk,
        reset => reset,
        data  => Qy,
        
        -- Salidas
        O1 => O1_out_v,
        O2 => O2_out_v,
        O3 => O3_out_v 
);

generador:gen_color
port map(
        -- Entradas
        Blank_h => O1_out_h,
        Blank_v => O1_out_v,
        RED_in  => RED_s,
        BLU_in  => BLU_s,
        GRN_in  => GRN_s,
        
        -- Salidas
        RED     => RED,
        GRN     => GRN,
        BLU     => BLU      
);

-- Puertas logicas internas a nivel superior
and_enable_cont_v <= div_frec_s and O3_out_h;


-- Tasa de refresco
refresh <= O3_out_v;

-- Salida de posiciones
ejeX <= Qx;
ejeY <= Qy;


-- Entrada de colores
RED_s <= RGB_in(11 downto 8);
GRN_s <= RGB_in(7 downto 4);
BLU_s <= RGB_in(3 downto 0);



HS <= O2_out_h;
VS <= O2_out_v;

end Behavioral;
