-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity Gestion_Botones_tb is
end Gestion_Botones_tb;

architecture test_bench of Gestion_Botones_tb is

  
-- Signals for connection to the DUT
  signal udlr_in : std_logic_vector(3 downto 0);
  signal clk : std_logic := '0';
  signal reset : std_logic;
  signal udlr_out : std_logic_vector(3 downto 0);

  -- Component declaration
  component Gestion_Botones
    port (
      udlr_in : in std_logic_vector(3 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      udlr_out : out std_logic_vector(3 downto 0));
  end component;

  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : Gestion_Botones
    port map(
      udlr_in => udlr_in,
      clk => clk,
      reset => reset,
      udlr_out => udlr_out);

  clk <= not clk after clockPeriod/2;

  stimuli : process
  begin
    udlr_in <= (others => '0'); -- EDIT Initial value
    reset <= '1'; -- EDIT Initial value

    -- Wait one clock period
    wait for 1 * clockPeriod;
    reset <= '0';
    udlr_in <= "1000";
    
    wait for 15*clockPeriod;
    udlr_in <= "0000";
    
    wait for 15*clockPeriod;
    udlr_in <= "1100";
    -- EDIT Genererate stimuli here
    wait for 15*clockPeriod;
    udlr_in <= "0001";
    wait;
  end process;

end test_bench;
