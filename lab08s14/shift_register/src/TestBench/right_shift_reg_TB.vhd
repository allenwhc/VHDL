library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity right_shift_reg_tb is
end right_shift_reg_tb;

architecture TB_ARCHITECTURE of right_shift_reg_tb is
	-- Component declaration of the tested unit
	component right_shift_reg
	port(
		d : in STD_LOGIC_VECTOR(7 downto 0);
		load : in STD_LOGIC;
		en_shift : in STD_LOGIC;
		clk : in STD_LOGIC;
		rst_bar : in STD_LOGIC;
		serial_out : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal d : STD_LOGIC_VECTOR(7 downto 0);
	signal load : STD_LOGIC;
	signal en_shift : STD_LOGIC;
	signal clk : STD_LOGIC;
	signal rst_bar : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal serial_out : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : right_shift_reg
		port map (
			d => d,
			load => load,
			en_shift => en_shift,
			clk => clk,
			rst_bar => rst_bar,
			serial_out => serial_out
		);

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_right_shift_reg of right_shift_reg_tb is
	for TB_ARCHITECTURE
		for UUT : right_shift_reg
			use entity work.right_shift_reg(behavior);
		end for;
	end for;
end TESTBENCH_FOR_right_shift_reg;

