-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity comparador_tb is
end comparador_tb;

architecture test_bench of comparador_tb is

  -- Constants for generic values
  constant NBit : integer := 8; -- EDIT Value for the generic
  constant End_Of_Screen : integer := 10; -- EDIT Value for the generic
  constant Start_Of_Pulse : integer := 20; -- EDIT Value for the generic
  constant End_Of_Pulse : integer := 30; -- EDIT Value for the generic
  constant End_Of_Line : integer := 40; -- EDIT Value for the generic
  
-- Signals for connection to the DUT
  signal clk : STD_LOGIC := '0';
  signal reset : STD_LOGIC;
  signal data : STD_LOGIC_VECTOR (Nbit-1 downto 0);
  signal O1 : STD_LOGIC;
  signal O2 : STD_LOGIC;
  signal O3 : STD_LOGIC;

  -- Component declaration
  component comparador
    generic (
      NBit : integer := 8;
      End_Of_Screen : integer := 10;
      Start_Of_Pulse : integer := 20;
      End_Of_Pulse : integer := 30;
      End_Of_Line : integer := 40);
    port (
      clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      data : in STD_LOGIC_VECTOR (Nbit-1 downto 0);
      O1 : out STD_LOGIC;
      O2 : out STD_LOGIC;
      O3 : out STD_LOGIC);
  end component;

  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : comparador
    generic map(
      NBit => NBit,
      End_Of_Screen => End_Of_Screen,
      Start_Of_Pulse => Start_Of_Pulse,
      End_Of_Pulse => End_Of_Pulse,
      End_Of_Line => End_Of_Line)
    port map(
      clk => clk,
      reset => reset,
      data => data,
      O1 => O1,
      O2 => O2,
      O3 => O3);

  clk <= not clk after clockPeriod/2;

  stimuli : process
  begin
    reset <= '1'; -- EDIT Initial value
    data <= (others => '0'); -- EDIT Initial value

    -- Wait one clock period
    wait for 5 * clockPeriod;
    reset <= '0';
    
    wait for 2 * clockPeriod;
    data <= "11111111";
    
    wait for 15 * clockPeriod;
    data <= "00101000";
    
    wait for 15 * clockPeriod;
    data <= "00011001";
    
    wait for 15 * clockPeriod;
    data <= "00000001";
    -- EDIT Genererate stimuli here

    wait;
  end process;

end test_bench;
