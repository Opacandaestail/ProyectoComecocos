----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2024 08:35:17 PM
-- Design Name: 
-- Module Name: PacMan2 - Behavioral
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

entity PacMan is
 port     (
           Move         : in STD_LOGIC;
           reset        : in STD_LOGIC;
           clk          : in STD_LOGIC;
           udlr         : in STD_LOGIC_VECTOR (3 downto 0);
           dout         : in STD_LOGIC_VECTOR (2 downto 0);
           MuerteIn     : in std_logic;
           
           VidaOut      : out std_logic_vector(1 downto 0);
           MuerteOut    : out std_logic;
           sentido      : out std_logic_vector(1 downto 0);
           din          : out STD_LOGIC_VECTOR (2 downto 0);
           we           : out STD_LOGIC_VECTOR(0 downto 0);
           enable_mem   : out STD_LOGIC;
           puntuacion   : out std_logic_vector(7 downto 0);
           ADDR         : out STD_LOGIC_VECTOR (8 downto 0);
           FinVida      : out std_logic;
           done         : out STD_LOGIC);
end PacMan;

architecture Behavioral of PacMan is--Programa con la máquina de estados del pacman

type estados   is (Reposo, Leer_Casilla_Deseada, Comprobar_Casilla_Deseada, Leer_Casilla_Siguiente,
                   Comprobar_Casilla_Siguiente, Actualizar_Posicion, Ocupar_Casilla, Vaciar_Casilla,Muerte,FinJuego);

type direccion is (Arriba,Abajo,Izquierda,Derecha);

signal dir_actual,p_dir_actual   : direccion;
signal dir_deseada,p_dir_deseada : direccion; 

signal p_estado, estado          : estados;

signal sentido_s,p_sentido       : std_logic_vector(1 downto 0);

signal p_ADDR_s,ADDR_s           : unsigned(8 downto 0);

signal p_posy,posy               : unsigned(3 downto 0);
signal p_posx,posx               : unsigned(4 downto 0);

signal p_cont,cont               : unsigned(3 downto 0);

signal p_din_s,din_s             : std_logic_vector(2 downto 0);

signal p_puntos,puntos           : unsigned(7 downto 0); 

signal p_enable_mem_s,enable_mem_s   : std_logic;

signal p_start_s,Start_s : std_logic;

signal p_cont_start,cont_start : unsigned(3 downto 0);

signal p_aux,aux : std_logic; -- Para asegurar una unica ejecucion del if inicial

-- Vidas
signal p_vida, vida : unsigned(1 downto 0);
signal cont_muerte, p_cont_muerte : unsigned ( 3 downto 0);

signal Fin, p_Fin: std_logic;

begin



sentido <= sentido_s;
ADDR       <= std_logic_vector(ADDR_s);
din        <= din_s;
enable_mem <= enable_mem_s;
puntuacion <= std_logic_vector(puntos);
vidaout <= std_logic_vector(vida);

sinc:process(clk,reset)
begin
    if(reset = '1') then
        estado      <= reposo;
        dir_actual  <= Derecha;
        dir_deseada <= Derecha;
        posx        <= "10000";
        posy        <= "1010" ;
        ADDR_s      <= (others => '0');
        cont        <= (others => '0');
        din_s       <= (others => '0');
        puntos      <= (others => '0');
        enable_mem_s<= '0';
        cont_Start <= (others => '0');
        aux <= '1';
        sentido_s <= "00";
        Start_s <= '0';
        vida <= "11";
        cont_muerte <= (others => '0');
        Fin    <= '0';

    elsif(rising_edge(clk)) then
        estado       <= p_estado;
        dir_actual   <= p_dir_actual;
        dir_deseada  <= p_dir_deseada;
        posx         <= p_posx;
        posy         <= p_posy;
        ADDR_s       <= p_ADDR_s;
        cont         <= p_cont;
        din_s        <= p_din_s;
        puntos       <= p_puntos;
        enable_mem_s <= p_enable_mem_s;
        cont_start   <= p_cont_start;
        aux          <= p_aux;
        start_s      <= p_start_s;
        sentido_s    <= p_sentido;
        vida         <= p_vida;
        cont_muerte  <= p_cont_muerte;
        Fin          <= p_Fin;
    end if;
end process sinc;


comb:process(estado,Move,posx,posy,ADDR_s,dir_actual,cont,din_s,enable_mem_s,cont_start,Start_s,aux,puntos,
              dir_deseada,udlr,dout,sentido_s,vida, MuerteIn,cont_Muerte,Fin)
begin
    p_sentido    <= sentido_s;
    p_cont_start <= cont_start;
    p_start_s    <= start_s;
    p_aux        <= aux;
    p_vida       <= vida;
    FinVida      <= '0';
    p_cont_muerte <= cont_Muerte;
    p_Fin         <= Fin;
    if(Move = '1' and aux = '1') then
        p_cont_start <= cont_start + 1;
        p_Start_s <= '0';   
        
        if (cont_start = 9) then
            p_Start_s <= '1';
            p_aux <= '0';
        end if;
    end if;
    
    
    case dir_actual is
    when Arriba    => p_sentido <= "00";
    when Abajo     => p_sentido <= "01";
    when Izquierda => p_sentido <= "10";
    when Derecha   => p_sentido <= "11";
    end case;
    
    p_estado         <= estado;
    we               <= (others => '0');
    p_enable_mem_s   <= enable_mem_s;
    done             <= '0';
    MuerteOut        <= '0';
    p_din_s          <= din_s;
    p_posx           <= posx;
    p_posy           <= posy;
    p_ADDR_s         <= ADDR_s;
    p_dir_actual     <= dir_actual;
    p_cont           <= cont;
    p_puntos         <= puntos;
    p_dir_deseada    <= dir_deseada;


if(estado /= Muerte) then
    case udlr is
    when "1000" => p_dir_deseada <= Arriba;
    when "0100" => p_dir_deseada <= Abajo;
    when "0010" => p_dir_deseada <= Izquierda;
    when "0001" => p_dir_deseada <= Derecha;
    when others => p_dir_deseada <= dir_deseada;
    end case;
end if;   

if(MuerteIn = '1') then
p_estado <= Muerte;
p_enable_mem_s <= '1';
p_cont <= (others => '0');
end if;
 --------------------------------------------------------------------------------------------------
    case estado is
    
    when Reposo =>

        if(Move = '1' and Start_s = '1' and MuerteIn = '0') then
            p_estado <= Leer_Casilla_Deseada;
            p_enable_mem_s <= '1';
        end if;
       
    ---------------------------------------------------------------------------------------------
    
    when Leer_Casilla_Deseada =>
        case dir_deseada is
            when Arriba    => p_ADDR_s <= (posy-1) & posx;
            when Abajo     => p_ADDR_s <= (posy+1) & posx;
            when Izquierda => p_ADDR_s <= (posy)   & (posx-1);
            when Derecha   => p_ADDR_s <= (posy)   & (posx+1);
            when others    => p_ADDR_s <= ADDR_s;
        end case;
        
 
        
        p_cont <= cont+1;
        
        if(cont = 3) then
            p_estado <= Comprobar_Casilla_Deseada;
            p_cont   <=(others=>'0');
        end if;

    --------------------------------------------------------------------------------------------------
    
    when Comprobar_Casilla_Deseada =>

   
         p_cont <= cont+1;
        
        if(cont = 2) then
            if(dout = "001") then -- Hay una pared
                p_estado <= Leer_Casilla_Siguiente; -- Leo que hay hacia donde iba el comecocos
             
            elsif(dout = "100") then -- Hay un fantasma
                MuerteOut <= '1';
                p_estado  <= Muerte;
             
            else                     -- Hay una bola o vacio
                p_estado     <= Actualizar_Posicion; 
                p_dir_actual <= dir_deseada;
            end if;
            p_cont   <=(others=>'0');
        end if;
    -------------------------------------------------------------------------------------------------------
    
    when Leer_Casilla_Siguiente => 
        
        case dir_actual is
            when Arriba    => p_ADDR_s <= (posy-1) & posx;
            when Abajo     => p_ADDR_s <= (posy+1) & posx;
            when Izquierda => p_ADDR_s <= (posy)   & (posx-1);
            when Derecha   => p_ADDR_s <= (posy)   & (posx+1);
            when others    => p_ADDR_s <= ADDR_s; 
        end case;
        
        p_cont <= cont+1;
        
        if(cont = 3) then
            p_estado <= Comprobar_Casilla_Siguiente;
            p_cont <= (others => '0');
        end if;
        
   -----------------------------------------------------------------------------------------------------------------------
     
    when Comprobar_Casilla_Siguiente =>
      
        
        if(dout = "001") then -- Hay pared 
            p_estado <= Reposo;
            p_enable_mem_s <= '0';
            done            <='1';
            
        elsif(dout = "100") then -- Hay fantasma
            MuerteOut <= '1';
            p_Estado <= Muerte;
            
        else                  -- No hay pared ni fantasma
            p_estado <= Actualizar_Posicion;
        end if;
        
        
    ---------------------------------------------
    
    when Actualizar_Posicion =>
    
        if(dout = "000" and cont = 0) then -- Moneda
             p_puntos <= puntos+1;
        elsif(dout = "101" and cont = 0) then
            p_puntos <= puntos+3;
        elsif(dout = "110" and cont = 0) then
            p_puntos <= puntos+6;
        else 
             p_puntos <= puntos;
        end if;
        
        p_posx <= ADDR_s(4 downto 0);
        p_posy <= ADDR_s(8 downto 5);
        p_din_s <= "011"; -- Cargo el pacman en el ciclo anterior para tenerlo listo para escribir
        
        p_cont <= cont+1;
        if(cont = 1) then
            p_estado <= Ocupar_Casilla;
            p_cont   <= (others => '0');
        end if;
        
   ----------------------------------------------

   when Ocupar_Casilla =>
   
    
        we         <= (others => '1');
    
        p_estado   <= Vaciar_Casilla;
        
   -----------------------------------------------
   
   when Vaciar_Casilla =>
     
        
        case dir_actual is -- Miro la casilla donde estaba el pacman para vaciarla
            when Arriba    => p_ADDR_s <= (posy+1) & posx;
            when Abajo     => p_ADDR_s <= (posy-1) & posx;
            when Izquierda => p_ADDR_s <= (posy)   & (posx+1);
            when Derecha   => p_ADDR_s <= (posy)   & (posx-1);
            when others    => p_ADDR_s <= ADDR_s;
        end case;
        
        p_din_s <= "010";
        
        p_cont <= cont+1;
        
        if(cont = 2) then
            we <= (others => '1');
            
        elsif(cont = 3) then
            p_cont <= (others => '0');
            done   <= '1';
            p_estado <= reposo;
            p_enable_mem_s <= '0';
        end if;
  -------------------------------------------------------------------
  
   when Muerte =>
        p_cont   <= cont+1;
        if(cont = 1) then
            p_ADDR_s <= posy & posx;
            p_posx   <= "10000"; 
            p_posy   <= "1010" ; 
            p_din_s  <= "010";
            

        elsif(cont = 4) then
            we <= (others => '1');

        elsif(cont = 5) then
            p_din_s  <= "011";
            p_ADDR_s <= posy & posx;

            
        elsif(cont = 8) then
            we <= (others => '1');

        
        elsif(cont = 9) then
            
            
            p_dir_deseada  <= Derecha;
            p_dir_actual   <= Derecha;
            
           

       elsif(cont >= "1010") then
            p_enable_mem_s <= '0';
            p_cont         <= (others => '0');
            FinVida        <= '1';
             p_vida         <= vida -1;
                if(vida=2)then --Obligamos a que la maquina no desborde
                    p_Fin    <='1';
                end if;
             
             if (vida = 1 and Fin = '1') then 
                p_estado       <= Finjuego;
                p_Fin            <='0';
             else 
                p_estado       <= Reposo;
             end if;
            
        end if;   
  ----------------------------------------------------------------------
      when FinJuego =>
            --Se han perdido todas las vidas y se acaba el juego
   ------------------------------------------------------------------
  when others =>
        p_estado <= estado;
       
    end case;
end process comb;

end Behavioral;