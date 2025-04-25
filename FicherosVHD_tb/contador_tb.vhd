-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity contador_tb is
end contador_tb;

architecture test_bench of contador_tb is

  -- Constants for generic values
  constant Nbit : INTEGER := 8; -- EDIT Value for the generic
  
-- Signals for connection to the DUT
  signal clk : STD_LOGIC := '0';
  signal reset : STD_LOGIC;
  signal enable : STD_LOGIC;
  signal resets : STD_LOGIC;
  signal Q : STD_LOGIC_VECTOR (Nbit-1 downto 0);

  -- Component declaration
  component contador
    generic (
      Nbit : INTEGER := 8);
    port (
      clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      enable : in STD_LOGIC;
      resets : in STD_LOGIC;
      Q : out STD_LOGIC_VECTOR (Nbit-1 downto 0));
  end component;

  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : contador
    generic map(
      Nbit => Nbit)
    port map(
      clk => clk,
      reset => reset,
      enable => enable,
      resets => resets,
      Q => Q);

  clk <= not clk after clockPeriod/2;

  stimuli : process
  begin
    reset <= '1'; -- EDIT Initial value
    enable <= '0'; -- EDIT Initial value
    resets <= '0'; -- EDIT Initial value

    -- Wait one clock period
    wait for 4 * clockPeriod;
    enable <= '1';
    reset <= '0';
    
    wait for 20 * clockPeriod;
    resets <= '1';
    
    wait for 5 * clockPeriod;
    resets <= '0';
    -- EDIT Genererate stimuli here

    wait;
  end process;

end test_bench;
