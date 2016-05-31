library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity counter_tb is
end counter_tb;

architecture TB_ARCHITECTURE of counter_tb is
	-- Component declaration of the tested unit
	component counter
	port(
		clear : in STD_LOGIC;
		en_count : in STD_LOGIC;
		clk : in STD_LOGIC;
		rst_bar : in STD_LOGIC;
		q : out STD_LOGIC_VECTOR(9 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clear : STD_LOGIC;
	signal en_count : STD_LOGIC;
	signal clk : STD_LOGIC;
	signal rst_bar : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal q : STD_LOGIC_VECTOR(9 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : counter
		port map (
			clear => clear,
			en_count => en_count,
			clk => clk,
			rst_bar => rst_bar,
			q => q
		);

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_counter of counter_tb is
	for TB_ARCHITECTURE
		for UUT : counter
			use entity work.counter(behavior);
		end for;
	end for;
end TESTBENCH_FOR_counter;

