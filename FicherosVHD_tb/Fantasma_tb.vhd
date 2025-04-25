-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.NUMERIC_STD.ALL;

entity Fantasma_tb is
end Fantasma_tb;

architecture test_bench of Fantasma_tb is

  -- Constants for generic values
  constant X_s : unsigned := "10000"; -- ADD value for the generic
  constant Y_s : unsigned := "0111"; -- ADD value for the generic
  constant nasa : unsigned := "100"; -- ADD value for the generic
  
-- Signals for connection to the DUT
  signal Move : STD_LOGIC;
  signal reset : STD_LOGIC;
  signal clk : STD_LOGIC := '0';
  signal dout : STD_LOGIC_VECTOR (2 downto 0);
  signal din : STD_LOGIC_VECTOR (2 downto 0);
  signal we : STD_LOGIC_VECTOR(0 downto 0);
  signal enable_mem : STD_LOGIC;
  signal ADDR : STD_LOGIC_VECTOR (8 downto 0);
  signal done : STD_LOGIC;

  -- Component declaration
  component Fantasma
    generic (
      X_s : unsigned;
      Y_s : unsigned;
      nasa : unsigned);
    port (
      Move : in STD_LOGIC;
      reset : in STD_LOGIC;
      clk : in STD_LOGIC;
      dout : in STD_LOGIC_VECTOR (2 downto 0);
      din : out STD_LOGIC_VECTOR (2 downto 0);
      we : out STD_LOGIC_VECTOR(0 downto 0);
      enable_mem : out STD_LOGIC;
      ADDR : out STD_LOGIC_VECTOR (8 downto 0);
      done : out STD_LOGIC);
  end component;

  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : Fantasma
    generic map(
      X_s => X_s,
      Y_s => Y_s,
      nasa => nasa)
    port map(
      Move => Move,
      reset => reset,
      clk => clk,
      dout => dout,
      din => din,
      we => we,
      enable_mem => enable_mem,
      ADDR => ADDR,
      done => done);

  clk <= not clk after clockPeriod/2;

  stimuli : process
  begin
    Move <= '1'; -- EDIT Initial value
    reset <= '1'; -- EDIT Initial value
    dout <= (others => '0'); -- EDIT Initial value

    -- Wait one clock period
    wait for 1 * clockPeriod;
    reset <= '0';
    -- EDIT Genererate stimuli here

    wait;
  end process;

end test_bench;
