library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity converter_2421_bcd_tb is
end converter_2421_bcd_tb;

architecture tb_architecture of converter_2421_bcd_tb is

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal bin : std_logic_vector(5 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal bcd0 : std_logic_vector(3 downto 0);
	signal bcd1 : std_logic_vector(2 downto 0);

	constant period : time := 20ns;

begin

	-- Unit Under Test port map
	UUT : entity BinaryToBCD
		port map (
		bin=>bin,
		bcd0=>bcd0,
		bcd1=>bcd1
		);

		
	stim: process		-- apply all binary input combinations
	begin
		for i in 0 to 63 loop
			bin <= std_logic_vector(to_unsigned(i,6));
			wait for period;
		end loop;
		wait;
	end process;
		
end tb_architecture;


