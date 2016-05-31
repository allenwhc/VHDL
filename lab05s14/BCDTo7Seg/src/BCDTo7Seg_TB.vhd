library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity converter_2421_bcd_tb is
end converter_2421_bcd_tb;

architecture tb_architecture of converter_2421_bcd_tb is

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal bcd : std_logic_vector(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal seg_drive : std_logic_vector(6 downto 0);

	constant period : time := 20ns;

begin

	-- Unit Under Test port map
	UUT : entity BCDTo7Seg
		port map (
		bcd=>bcd,
		seg_drive=>seg_drive
		);

		
	stim: process		-- apply all binary input combinations
	begin
		for i in 0 to 9 loop
			bcd <= std_logic_vector(to_unsigned(i,4));
			wait for period;
		end loop;
		wait;
	end process;
		
end tb_architecture;


