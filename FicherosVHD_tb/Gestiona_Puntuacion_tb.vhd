-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity Gestiona_Puntuacion_tb is
end Gestiona_Puntuacion_tb;

architecture test_bench of Gestiona_Puntuacion_tb is

  
-- Signals for connection to the DUT
  signal clk : STD_LOGIC := '0';
  signal reset : STD_LOGIC;
  signal puntos : STD_LOGIC_vector(7 downto 0);
  signal ADDR : STD_LOGIC_VECTOR (8 downto 0);
  signal Din : STD_LOGIC_VECTOR (4 downto 0);
  signal we : STD_LOGIC_VECTOR (0 downto 0);

  -- Component declaration
  component Gestiona_Puntuacion
    port (
      clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      puntos : in STD_LOGIC_vector(7 downto 0);
      ADDR : out STD_LOGIC_VECTOR (8 downto 0);
      Din : out STD_LOGIC_VECTOR (4 downto 0);
      we : out STD_LOGIC_VECTOR (0 downto 0));
  end component;

  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : Gestiona_Puntuacion
    port map(
      clk => clk,
      reset => reset,
      puntos => puntos,
      ADDR => ADDR,
      Din => Din,
      we => we);

  clk <= not clk after clockPeriod/2;

  stimuli : process
  begin
    reset <= '1'; -- EDIT Initial value
    puntos <= "10011100"; -- EDIT Initial value

    -- Wait one clock period
    wait for 1 * clockPeriod;
    reset <= '0';
    
    wait for 3*clockPeriod;
    puntos <= "10011111";
    -- EDIT Genererate stimuli here

    wait;
  end process;

end test_bench;
