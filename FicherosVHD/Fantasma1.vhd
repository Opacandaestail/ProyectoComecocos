----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2024 11:08:15
-- Design Name: 
-- Module Name: Fantasma1 - Behavioral
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

entity Fantasma is
generic	(X_s	     : unsigned(4 downto 0) := "10000";
	 Y_s	         : unsigned(3 downto 0) :="0111";
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
end Fantasma;

architecture Behavioral of Fantasma is --Programa de la m�quina de estados del fantasma

type estados   is (Reposo,Movimiento, Leer_Casilla, Comprobamos_Casilla,  Actualiza_Posicion, 
                        Ocupa_Casilla, Restaura_Casilla, EsperaMuerte);

type direccion is (Arriba,Abajo,Izquierda,Derecha);

signal dir, p_dir	   	              : direccion;
signal p_estado, estado               : estados;

signal p_ADDR_s,ADDR_s                : unsigned(8 downto 0);

signal p_posy,posy                    : unsigned(3 downto 0);
signal p_posx,posx                    : unsigned(4 downto 0);

signal p_cont,cont                    : unsigned(3 downto 0);

signal valor_casilla_a ,p_valor_casilla_a  : std_logic_vector(2 downto 0); --Valor de casilla actual
signal valor_casilla_p ,p_valor_casilla_p  : std_logic_vector(2 downto 0); --Valor de casilla proxima

signal p_din_s,din_s                  : unsigned(2 downto 0);

signal enable_mem_s,p_enable_mem_s    : std_logic;

begin

ADDR       <= std_logic_vector(ADDR_s);
din        <= std_logic_vector(din_s);
enable_mem <= enable_mem_s;

sinc:process(clk,reset)
begin
    if(reset = '1') then
        estado        <= reposo;
        dir	          <= Arriba;
        posx          <= X_s;
        posy          <= Y_s;
        ADDR_s        <= (others => '0');
        cont          <= (others => '0');
        din_s         <= (others => '0');
        valor_casilla_a <= std_logic_vector(valor_casilla);
        valor_casilla_p <= std_logic_vector(valor_casilla);
        enable_mem_s  <= '0';
    elsif(rising_edge(clk)) then
        estado        <= p_estado;
        dir           <= p_dir;
        posx          <= p_posx;
        posy          <= p_posy;
        ADDR_s        <= p_ADDR_s;
        cont          <= p_cont;
        din_s         <= p_din_s;
        valor_casilla_a <= p_valor_casilla_a;
        valor_casilla_p <= p_valor_casilla_p;
        enable_mem_s  <= p_enable_mem_s;
    end if;
end process sinc;

comb:process(estado,mov,Move,posx,posy,ADDR_s,dir,cont,din_s,valor_casilla_a,valor_casilla_p,enable_mem_s,dout,MuerteIn,FinVida)
begin

    p_estado        <= estado;
    we              <= (others => '0');
    done            <= '0';
    MuerteOut       <= '0';
    p_din_s         <= din_s;
    p_posx          <= posx;
    p_posy          <= posy;
    p_ADDR_s        <= ADDR_s;
    p_dir  	        <= dir;
    p_cont          <= cont;
    p_enable_mem_s  <= enable_mem_s;
	p_valor_casilla_p <= valor_casilla_p;
	p_valor_casilla_a <= valor_casilla_a;
	
    if(MuerteIn = '1') then
        p_estado <= EsperaMuerte;
        p_cont <= (others => '0');
     end if;
-------------------------------------------------------------------
	case estado is
	when Reposo =>
		if (Move='1' and MuerteIn = '0') then 
			p_estado       <= Movimiento;
			p_enable_mem_s <= '1';
		end if;
		

---------------------------------------------------------------------	

    when Movimiento =>
            if (mov="00") then p_dir <=Abajo;
            elsif(mov="01") then p_dir<=Derecha;
            elsif(mov="10") then p_dir<=Izquierda;
            else p_dir<=Arriba;
            end if;

        p_estado      <=    Leer_Casilla;
        
  ---------------------------------------------------------------------	      
	when Leer_casilla => --Leer casilla deseada

	case dir is
            	when Arriba    => p_ADDR_s <= (posy-1) & posx;
            	when Abajo     => p_ADDR_s <= (posy+1) & posx;
            	when Izquierda => p_ADDR_s <= (posy)   & (posx-1);
            	when Derecha   => p_ADDR_s <= (posy)   & (posx+1);
        end case;

	
        
        if(cont = 5) then
            p_estado <= Comprobamos_Casilla;
            p_cont   <= (others => '0');
        else p_cont <= cont+1;
        end if;

---------------------------------------------------------------------------
	
	when Comprobamos_Casilla => --Comprobamos casilla
            
        if(dout = "011") then -- Hay comecocos
           MuerteOut <= '1';
           p_estado <= EsperaMuerte;
            
        elsif (dout = "000" or dout = "010" or dout = "101" or dout = "110") then --Hay bola o vacio
            p_estado          <= Actualiza_Posicion;
            p_valor_casilla_a <= valor_casilla_p;
	        p_valor_casilla_p <= dout;

	    else 
            if (mov="00") then p_dir <=Abajo;
            elsif(mov="01") then p_dir<=Derecha;
            elsif(mov="10") then p_dir<=Izquierda;
            else p_dir<=Arriba;
            end if;
            	p_estado <= Movimiento;

        end if;
	
-----------------------------------------------------------------
	when Actualiza_Posicion => --Actualizamos posicion
		p_posx <= ADDR_s(4 downto 0);
        p_posy <= ADDR_s(8 downto 5);
        p_din_s <= codigo_fantasma;
	    p_cont <= cont+1;
        if(cont = 2) then
            p_estado <= Ocupa_Casilla;
            p_cont   <= (others => '0');
        end if;
-------------------------------------------------------------
	when Ocupa_Casilla => --Ocupamos casilla
	    p_cont <= cont+1;
    	we         <= (others => '1');
	    if(cont = 2) then
            p_estado   <= Restaura_Casilla;
            p_cont     <= (others => '0');
        end if;
----------------------------------------------------------------
	when Restaura_Casilla => --Pintar la casilla anterior
        
        case dir is -- Miro la casilla donde estaba el fantasma para devolverla a como estaba
            when Arriba    => p_ADDR_s <= (posy+1) & posx;
            when Abajo     => p_ADDR_s <= (posy-1) & posx;
            when Izquierda => p_ADDR_s <= (posy)   & (posx+1);
            when Derecha   => p_ADDR_s <= (posy)   & (posx-1);
        end case;
        
        p_din_s <= unsigned(valor_casilla_a);
        
        p_cont <= cont+1;
        
        if(cont = 3) then
            we <= (others => '1');
            
        elsif(cont = 4) then
            p_cont            <= (others => '0');
            p_estado          <= Reposo;
            p_enable_mem_s    <= '0';
            done              <= '1';
            
        end if;
--------------------------------------------------------------
    when EsperaMuerte => 
        if(FinVida = '1') then
            p_estado       <= Reposo;
            p_enable_mem_s <= '0';
        end if;
--------------------------------------------------------------
	end case;
end process comb;

end Behavioral;