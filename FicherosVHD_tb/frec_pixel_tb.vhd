-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity frec_pixel_tb is
end frec_pixel_tb;

architecture test_bench of frec_pixel_tb is

  
-- Signals for connection to the DUT
  signal clk : STD_LOGIC := '0';
  signal reset : STD_LOGIC;
  signal clk_pixel : STD_LOGIC;

  -- Component declaration
  component frec_pixel
    port (
      clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      clk_pixel : out STD_LOGIC);
  end component;

  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : frec_pixel
    port map(
      clk => clk,
      reset => reset,
      clk_pixel => clk_pixel);

  clk <= not clk after clockPeriod/2;

  stimuli : process
  begin
    reset <= '1'; -- EDIT Initial value

    -- Wait one clock period
    wait for 5 * clockPeriod;
    reset <= '0';
    -- EDIT Genererate stimuli here

    wait;
  end process;

end test_bench;
