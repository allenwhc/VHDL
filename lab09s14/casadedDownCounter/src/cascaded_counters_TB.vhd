-- Lab 9 Task 3 Testbench Version 1 04/11/14
-- Note that the cascaded counter as defined rolls over when counting
-- up, but not when counting down

-- Stimulus counts up from 00:0 to 9:59. Counter rolls over to 00:0 and
-- continues to count up to 9:58. Pauses for four clocks with counter
-- disabled, then counts down to 0:00. Next counts up to 0:08
-- and then is cleared to 0:00 by clr_bar

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity cascaded_counters_tb is
end cascaded_counters_tb;

architecture tb_architecture of cascaded_counters_tb is
	
	-- Stimulus signals
	signal rst_bar : std_logic;
	signal clr_bar : std_logic;
	signal clk : std_logic := '0';
	signal up : std_logic;
	signal en_cnt : std_logic;
	-- observed signals
	signal seconds : std_logic_vector(5 downto 0);
	signal minutes : std_logic_vector(3 downto 0);
	
	constant half_period : time := 10 ns;
	
begin
	
	-- Unit Under Test port map
	UUT : entity cascaded_counters
	port map (
		rst_bar => rst_bar,
		clr_bar => clr_bar,
		clk => clk,
		up => up,
		en_cnt => en_cnt,
		seconds => seconds,
		minutes => minutes
		);
	
	rst_bar <= '0', '1' after 4 * half_period;
	
	sys_clk: process
	begin
		clr_bar <= '1';	-- unassert clear
		
		up <= '1';			-- count direction is up
		en_cnt <= '1';		-- and counter is enabled		
		for i in 0 to 1203 loop	-- count from 0:00 till
			clk <= not clk;		-- past 9:59, counter will
			wait for half_period;	-- roll over
		end loop;
		
		up <= '1';			-- continue counting to 9:58
		en_cnt <= '1';		
		for i in 0 to 1195 loop
			clk <= not clk;
			wait for half_period;
		end loop;	
		
		
		up <= '0';			-- change count direction
		en_cnt <= '0';		-- next disable count and verify that
		for i in 0 to 7 loop		-- counter does not count
			clk <= not clk;
			wait for half_period;
		end loop;
		
		up <= '0';			-- count down past reaching 0:00
		en_cnt <= '1';		-- verify that counter does not roll
		for i in 0 to 1214 loop	-- under
			clk <= not clk;
			wait for half_period;
		end loop;
		
		up <= '1';			-- count up from 0:00 to 0:08
		en_cnt <= '1';
		for i in 0 to 15 loop
			clk <= not clk;
			wait for half_period;
		end loop;
		
		clr_bar <= '0';	-- assert and hold clear
		for i in 0 to 7 loop	-- counter remains 00:0
			clk <= not clk;
			wait for half_period;
		end loop;
		
		wait;		-- done
		
	end process;		
	
end tb_architecture;



