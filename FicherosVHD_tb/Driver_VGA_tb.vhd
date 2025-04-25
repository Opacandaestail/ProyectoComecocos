-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity Driver_VGA_tb is
end Driver_VGA_tb;

architecture test_bench of Driver_VGA_tb is

  
-- Signals for connection to the DUT
  signal clk : std_logic := '0';
  signal reset : std_logic;
  signal RGB_in : std_logic_vector(11 downto 0);
  signal ejeX : STD_LOGIC_VECTOR (9 downto 0);
  signal ejeY : STD_LOGIC_VECTOR (9 downto 0);
  signal Refresh : STD_LOGIC;
  signal HS : STD_LOGIC;
  signal VS : STD_LOGIC;
  signal RED : STD_LOGIC_VECTOR (3 downto 0);
  signal GRN : STD_LOGIC_VECTOR (3 downto 0);
  signal BLU : STD_LOGIC_VECTOR (3 downto 0);

  -- Component declaration
  component Driver_VGA
    port (
      clk : in std_logic;
      reset : in std_logic;
      RGB_in : in std_logic_vector(11 downto 0);
      ejeX : out STD_LOGIC_VECTOR (9 downto 0);
      ejeY : out STD_LOGIC_VECTOR (9 downto 0);
      Refresh : out STD_LOGIC;
      HS : out STD_LOGIC;
      VS : out STD_LOGIC;
      RED : out STD_LOGIC_VECTOR (3 downto 0);
      GRN : out STD_LOGIC_VECTOR (3 downto 0);
      BLU : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : Driver_VGA
    port map(
      clk => clk,
      reset => reset,
      RGB_in => RGB_in,
      ejeX => ejeX,
      ejeY => ejeY,
      Refresh => Refresh,
      HS => HS,
      VS => VS,
      RED => RED,
      GRN => GRN,
      BLU => BLU);

  clk <= not clk after clockPeriod/2;

  stimuli : process
  begin
    reset <= '1'; -- EDIT Initial value
    RGB_in <= (others => '0'); -- EDIT Initial value

    -- Wait one clock period
    wait for 15 * clockPeriod;
    reset <= '0';
    
    RGB_in <= "000000000000";
    
    wait for 150 * clockPeriod;
    RGB_in <= "111111111111";
    
    wait for 150* clockPeriod;
    RGB_in <= "000000001111";
    -- EDIT Genererate stimuli here

    wait;
  end process;

end test_bench;
