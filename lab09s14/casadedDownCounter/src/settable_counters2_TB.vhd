-- Lab 9 Task 5 Testbench Version 2 04/13/14
-- Settable Cascade Counters

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity settable_counters_tb is
end settable_counters_tb;

architecture tb_architecture of settable_counters_tb is
	
	
	-- Stimulus signals
	signal rst_bar : std_logic;
	signal clk : std_logic := '0';
	signal ai : std_logic;
	signal bi : std_logic;
	-- Observed signals
	signal seconds : std_logic_vector(5 downto 0);
	signal minutes : std_logic_vector(3 downto 0);
	
	constant half_period : time := 10 ns;
	constant rotary_quarter_period : time := 20 * half_period;
	
	signal end_sim : boolean := false;
	
begin
	
	-- Unit Under Test port map
	UUT : entity settable_counters
	port map (
		rst_bar => rst_bar,
		clk => clk,
		ai => ai,
		bi => bi,
		seconds => seconds,
		minutes => minutes
		);
	
	rst_bar <= '0', '1' after 4 * half_period;
	
	clock: process
	begin
		while end_sim = false loop
			clk <= not clk;
			wait for half_period;
		end loop;
		wait;
	end process;
	
	stim: process
	begin
		ai <= '0';
		bi <= '0';
		wait for 11 * half_period;
		
		-- counters are initially 0:00
		
		-- increment setting to 9:59 and then
		-- roll over to 0:00
		
		for j in 0 to 9 loop	-- set for 10 minutes
			for i in 0 to 59 loop	-- clockwise rotation increase of 1 min
				ai <= '1';
				wait for rotary_quarter_period;
				bi <= '1';
				wait for rotary_quarter_period;
				ai <= '0';
				wait for rotary_quarter_period;
				bi <= '0';
				wait for rotary_quarter_period;			
			end loop;
		end loop;
		
		-- After roll over continue increasing setting to 9:00
		for j in 0 to 8 loop	-- set for 9 minutes
			for i in 0 to 59 loop	-- clockwise rotation increase of 1 min
				ai <= '1';
				wait for rotary_quarter_period;
				bi <= '1';
				wait for rotary_quarter_period;
				ai <= '0';
				wait for rotary_quarter_period;
				bi <= '0';
				wait for rotary_quarter_period;			
			end loop;
		end loop;		
		
		-- increase setting further to 9:30
		for i in 0 to 29 loop	-- clockwise rotation increase 30 seconds
			ai <= '1';
			wait for rotary_quarter_period;
			bi <= '1';
			wait for rotary_quarter_period;
			ai <= '0';
			wait for rotary_quarter_period;
			bi <= '0';
			wait for rotary_quarter_period;			
		end loop;	
		
		wait for 12 * half_period;		-- pause rotation briefly		
		
		-- reduce setting by 9 minutes to 0:30
		for j in 0 to 8 loop
			for i in 0 to 59 loop	-- counter clockwise decrease of 1 min 
				bi <= '1';
				wait for rotary_quarter_period;
				ai <= '1';
				wait for rotary_quarter_period;
				bi <= '0';
				wait for rotary_quarter_period;
				ai <= '0';
				wait for rotary_quarter_period;			
			end loop;
		end loop;
		
		-- reduce to 0:00 and then an additional 10 seconds
		for i in 0 to 39 loop	-- counter clockwise decrease of 1 min 
			bi <= '1';
			wait for rotary_quarter_period;
			ai <= '1';
			wait for rotary_quarter_period;
			bi <= '0';
			wait for rotary_quarter_period;
			ai <= '0';
			wait for rotary_quarter_period;			
		end loop;
		
		end_sim <= true;		-- stop system clock		
		
		wait;
		
	end process;
	
end tb_architecture;



