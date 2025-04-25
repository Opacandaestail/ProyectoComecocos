-- Testbench automatically generated

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity Memoria_Tablero_tb is
end Memoria_Tablero_tb;

architecture test_bench of Memoria_Tablero_tb is

  
-- Signals for connection to the DUT
  signal clka : STD_LOGIC := '0';
  signal ena : STD_LOGIC;
  signal wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
  signal addra : STD_LOGIC_VECTOR(8 DOWNTO 0);
  signal dina : STD_LOGIC_VECTOR(2 DOWNTO 0);
  signal douta : STD_LOGIC_VECTOR(2 DOWNTO 0);
  signal clkb : STD_LOGIC := '0';
  signal web : STD_LOGIC_VECTOR(0 DOWNTO 0);
  signal addrb : STD_LOGIC_VECTOR(8 DOWNTO 0);
  signal dinb : STD_LOGIC_VECTOR(2 DOWNTO 0);
  signal doutb : STD_LOGIC_VECTOR(2 DOWNTO 0);
  signal aux : std_logic_vector(2 downto 0);

  -- Component declaration
  component Memoria_Tablero
    port (
      clka : IN STD_LOGIC;
      ena : IN STD_LOGIC;
      wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      dina : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      clkb : IN STD_LOGIC;
      web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addrb : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      dinb : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      doutb : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
  end component;

  constant clockPeriod : time := 10 ns; -- EDIT Clock period

begin
  DUT : Memoria_Tablero
    port map(
      clka => clka,
      ena => ena,
      wea => wea,
      addra => addra,
      dina => dina,
      douta => douta,
      clkb => clkb,
      web => web,
      addrb => addrb,
      dinb => dinb,
      doutb => doutb);

  clka <= not clka after clockPeriod/2;
  clkb <= not clkb after clockPeriod/2;
  stimuli : process
  begin
    ena <= '1'; -- EDIT Initial value
    wea <= (others => '0'); -- EDIT Initial value
    addra <= (others => '0'); -- EDIT Initial value
    dina <= (others => '0'); -- EDIT Initial value
    web <= (others => '0'); -- EDIT Initial value
    addrb <= (others => '0'); -- EDIT Initial value
    dinb <= (others => '0'); -- EDIT Initial value

    -- Wait one clock period
    wait for 46ns;
    wea <= (others => '1');
    dina <= "111";
    
    wait for 2*clockPeriod;
    wea <= (others => '0');
    
    -- EDIT Genererate stimuli here

    wait;
  end process;

aux <= douta;
end test_bench;
