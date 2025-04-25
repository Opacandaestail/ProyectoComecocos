-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity comecocos_tb is
end comecocos_tb;

architecture test_bench of comecocos_tb is

  
-- Signals for connection to the DUT
  signal Move : STD_LOGIC;
  signal reset : STD_LOGIC;
  signal clk : STD_LOGIC := '0';
  signal udlr : STD_LOGIC_VECTOR (3 downto 0);
  signal dout : STD_LOGIC_VECTOR (2 downto 0);
  signal din : STD_LOGIC_VECTOR (2 downto 0);
  signal we : STD_LOGIC_VECTOR(0 downto 0);
  signal enable_mem : STD_LOGIC;
  signal come_bola : STD_LOGIC;
  signal ADDR : STD_LOGIC_VECTOR (8 downto 0);
  signal done : STD_LOGIC;

  -- Component declaration
  component comecocos
    port (
      Move : in STD_LOGIC;
      reset : in STD_LOGIC;
      clk : in STD_LOGIC;
      udlr : in STD_LOGIC_VECTOR (3 downto 0);
      dout : in STD_LOGIC_VECTOR (2 downto 0);
      din : out STD_LOGIC_VECTOR (2 downto 0);
      we : out STD_LOGIC_VECTOR(0 downto 0);
      enable_mem : out STD_LOGIC;
      come_bola : out STD_LOGIC;
      ADDR : out STD_LOGIC_VECTOR (8 downto 0);
      done : out STD_LOGIC);
  end component;

  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : comecocos
    port map(
      Move => Move,
      reset => reset,
      clk => clk,
      udlr => udlr,
      dout => dout,
      din => din,
      we => we,
      enable_mem => enable_mem,
      come_bola => come_bola,
      ADDR => ADDR,
      done => done);

  clk <= not clk after clockPeriod/2;

  stimuli : process
  begin
    Move <= '1'; -- EDIT Initial value
    reset <= '1'; -- EDIT Initial value
    udlr <= (others => '0'); -- EDIT Initial value
    dout <= (others => '0'); -- EDIT Initial value

    -- Wait one clock period
    wait for 10 * clockPeriod;
reset <= '0'; 
    udlr <= ("0001"); -- EDIT Initial value
    dout <= ("000");
    
    wait for 200 * clockPeriod;
reset <= '0'; 
    dout <= ("001");
    
    -- EDIT Genererate stimuli here

    wait;
  end process;

end test_bench;
