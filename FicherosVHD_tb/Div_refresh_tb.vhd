-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity Div_Refresh_tb is
end Div_Refresh_tb;

architecture test_bench of Div_Refresh_tb is

  
-- Signals for connection to the DUT
  signal clk : STD_LOGIC := '0';
  signal reset : STD_LOGIC;
  signal refresh : STD_LOGIC := '0'; 
  signal refresh_div : STD_LOGIC;

  -- Component declaration
  component Div_Refresh
    port (
      clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      refresh : in STD_LOGIC;
      refresh_div : out STD_LOGIC);
  end component;

  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : Div_Refresh
    port map(
      clk => clk,
      reset => reset,
      refresh => refresh,
      refresh_div => refresh_div);

  clk <= not clk after clockPeriod/2;
  refresh <= not refresh after 3*clockPeriod;
  stimuli : process
  begin
    reset <= '1'; -- EDIT Initial value


    -- Wait one clock period
    wait for 1 * clockPeriod;
    reset <= '0';
    -- EDIT Genererate stimuli here

    wait;
  end process;

end test_bench;
