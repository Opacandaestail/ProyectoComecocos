-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity Dibuja_tb is
end Dibuja_tb;

architecture test_bench of Dibuja_tb is

  
-- Signals for connection to the DUT
  signal clk : std_logic := '0';
  signal reset : std_logic;
  signal EjeX : STD_LOGIC_VECTOR (9 downto 0);
  signal EjeY : STD_LOGIC_VECTOR (9 downto 0);
  signal RGB : STD_LOGIC_VECTOR (11 downto 0);

  -- Component declaration
  component Dibuja
    port (
      clk : in std_logic;
      reset : in std_logic;
      EjeX : in STD_LOGIC_VECTOR (9 downto 0);
      EjeY : in STD_LOGIC_VECTOR (9 downto 0);
      RGB : out STD_LOGIC_VECTOR (11 downto 0));
  end component;

  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : Dibuja
    port map(
      clk => clk,
      reset => reset,
      EjeX => EjeX,
      EjeY => EjeY,
      RGB => RGB);

  clk <= not clk after clockPeriod/2;

  stimuli : process
  begin
    reset <= '1'; -- EDIT Initial value
    EjeX <= (others => '0'); -- EDIT Initial value
    EjeY <= (others => '0'); -- EDIT Initial value

    -- Wait one clock period
    wait for 15 * clockPeriod;
    reset <= '0';
    wait for 15 * clockPeriod;
    EjeX <= "0111101010";
    -- EDIT Genererate stimuli here

    wait;
  end process;

end test_bench;
