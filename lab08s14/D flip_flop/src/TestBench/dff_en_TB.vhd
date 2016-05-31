library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity dff_en_tb is
end dff_en_tb;

architecture TB_ARCHITECTURE of dff_en_tb is
	-- Component declaration of the tested unit
	component dff_en
	port(
		d : in STD_LOGIC;
		clk : in STD_LOGIC;
		en : in STD_LOGIC;
		rst_bar : in STD_LOGIC;
		q : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal d : STD_LOGIC;
	signal clk : STD_LOGIC;
	signal en : STD_LOGIC;
	signal rst_bar : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal q : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : dff_en
		port map (
			d => d,
			clk => clk,
			en => en,
			rst_bar => rst_bar,
			q => q
		);

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_dff_en of dff_en_tb is
	for TB_ARCHITECTURE
		for UUT : dff_en
			use entity work.dff_en(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_dff_en;

