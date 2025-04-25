-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity Arquitectura_Superior_tb is
end Arquitectura_Superior_tb;

architecture test_bench of Arquitectura_Superior_tb is

  
-- Signals for connection to the DUT
  signal clk : std_logic := '0';
  signal reset : std_logic;
  signal udlr_in : std_logic_vector(3 downto 0);
  signal LED : std_logic_vector(3 downto 0);
  signal RED : std_logic_vector(3 downto 0);
  signal GRN : std_logic_vector(3 downto 0);
  signal BLU : std_logic_vector(3 downto 0);
  signal HS : std_logic;
  signal VS : std_logic;

  -- Component declaration
  component Arquitectura_Superior
    port (
      clk : in std_logic;
      reset : in std_logic;
      udlr_in : in std_logic_vector(3 downto 0);
      LED : out std_logic_vector(3 downto 0);
      RED : out std_logic_vector(3 downto 0);
      GRN : out std_logic_vector(3 downto 0);
      BLU : out std_logic_vector(3 downto 0);
      HS : out std_logic;
      VS : out std_logic);
  end component;


  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : Arquitectura_Superior
    port map(
      clk => clk,
      reset => reset,
      udlr_in => udlr_in,
      LED => LED,
      RED => RED,
      GRN => GRN,
      BLU => BLU,
      HS => HS,
      VS => VS);

  clk <= not clk after clockPeriod/2;


  stimuli : process
  begin
    reset <= '1'; -- EDIT Initial value
    udlr_in <= (others => '0'); -- EDIT Initial value

    -- Wait one clock period
    wait for 1 * clockPeriod;
    reset <= '0';
    -- EDIT Genererate stimuli here

    wait;
  end process;

end test_bench;
