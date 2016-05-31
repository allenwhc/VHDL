-- Non-self-checking testbench for Laboratory 3 spring 2014

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity fuel_tb is
end fuel_tb;

architecture tb_architecture of fuel_tb is

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal fuel : std_logic_vector(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal leds : std_logic_vector(3 downto 0);
	signal empty : std_logic;

	constant period : time := 20ns;

begin

	-- Unit Under Test port map
	UUT : entity fuel_encoder
		port map (
		fuel(3 downto 0) => fuel(3 downto 0),
		leds(3 downto 0) => leds(3 downto 0),
		empty => empty
		);

		
	stim: process		-- apply all binary input combinations
	begin
		for i in 0 to 15 loop
			fuel <= std_logic_vector((to_unsigned(i,4)));
			wait for period;
			if(i>=0 and i<=3) then
			    assert(leds="1110")
			    report "test failed when the tank is 1/4"&integer'image(i)&"failed"
				severity error;
				
				if(i=0 or i =1)	 then
				assert(empty='0')
			    report ""&std_logic'image(empty)&"of empty bit failed"
				severity error;
				end if;
				
			elsif(i>=4 and i<=7) then
				assert(leds="1100")
			    report "test failed when the tank is 2/4"&integer'image(i)&"failed"
				severity error;
			elsif(i>=8 and i<=11)	then
				assert(leds="1000")
			    report "test failed when the tank is 3/4"&integer'image(i)&"failed"
				severity error;
			elsif(i>=12 and i<=15)	 then
				assert(leds="0000")
			    report "test failed when the tank is 4/4"&integer'image(i)&"failed"
				severity error;
			else
				assert(leds="1111")
			    report "test failed when the tank is 4/4"&integer'image(i)&"failed"
				severity error;
				end if;
		end loop;
		wait;
	end process;
		
end tb_architecture;
