----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2024 04:33:46 PM
-- Design Name: 
-- Module Name: Acceso_Memoria - Behavioral
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

entity Acceso_Memoria is
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
end Acceso_Memoria;

architecture Behavioral of Acceso_Memoria is --Multiplexor que da preferencia de acceso a la memoria
begin


dout_c   <= dout_mem when enable_mem_c = '1'  else
            (others => '0');
          
          
dout_f1  <= dout_mem when enable_mem_f1 = '1' else
            (others => '0');
            
dout_f2  <= dout_mem when enable_mem_f2 = '1' else
            (others => '0');            
 
ADDR_mem <= ADDR_c  when enable_mem_c = '1'   else
            ADDR_f1 when enable_mem_f1 = '1'  else
            ADDR_f2 when enable_mem_f2 = '1'  else
            (others => '0');

Din_mem  <= Din_c  when enable_mem_c  = '1'   else
            Din_f1 when enable_mem_f1 = '1'   else
            Din_f2 when enable_mem_f2 = '1'   else
            (others => '0');
           
we_mem   <= we_c  when enable_mem_c  = '1'    else
            we_f1 when enable_mem_f1 = '1'    else
            we_f2 when enable_mem_f2 = '1'    else
            (others => '0');

end Behavioral;
