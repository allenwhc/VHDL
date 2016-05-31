-- Testbench A for lab 10 Task 1, Spring 2014 

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity set_initial_value_tb is
end set_initial_value_tb;

architecture tb_architecture of set_initial_value_tb is
	
	-- Stimulus signals
	signal rst_bar : std_logic;
	signal clk : std_logic := '0';
	signal ai : std_logic;
	signal bi : std_logic;
	signal ao : std_logic;
	signal bo : std_logic;
	-- observed signals - signals mapped to the output ports of tested entity
	signal seconds : std_logic_vector(5 downto 0);
	signal minutes : std_logic_vector(3 downto 0);
	
	constant half_period : time := 10 ns;
	constant rotary_quarter_period : time := 20 * half_period;	
	
	signal end_sim : boolean := false;
	
begin
	
	-- Unit Under Test port map
	UUT : entity settable_timer
	port map (
		rst_bar => rst_bar,
		clk => clk,
		ai => ai,
		bi => bi,
		ao => ao,
		bo => bo,
		seconds => seconds,
		minutes => minutes
		);
		
	-- reset the system
	rst_bar <= '0', '1' after 3 * half_period;
	
	-- system clock runs until end_sim = true
	clock: process
	begin
		while end_sim = false loop
			clk <= not clk;
			wait for half_period;
		end loop;
		wait;
	end process;
	
	-- stimulus process
	stim: process
	begin
		
		ai <= '0';			-- initial position of inner and outter
		bi <= '0';			-- knobs of rotary encoder
		ao <= '0';
		bo <= '0';
		
		wait for 11 * half_period;	-- brief idle time
		
		-- Counters are initially 0:00
		
		-- Increment minutes setting to 15 minutes
		-- rolls over to 5:00 minutes, -> 5:00
		for i in 0 to 14 loop	-- clockwise rotation increase to 15 min
			ao <= '1';
			wait for rotary_quarter_period;
			bo <= '1';
			wait for rotary_quarter_period;
			ao <= '0';
			wait for rotary_quarter_period;
			bo <= '0';
			wait for rotary_quarter_period;			
		end loop;
		
		-- change setting to 1 minute by turning ccw, -> 1:00		
		for i in 0 to 3 loop	-- counter clockwise decrease of 4 min 
			bo <= '1';
			wait for rotary_quarter_period;
			ao <= '1';
			wait for rotary_quarter_period;
			bo <= '0';
			wait for rotary_quarter_period;
			ao <= '0';
			wait for rotary_quarter_period;			
		end loop;
		
		-- Now increase the seconds setting	to 30 seconds, -> 1:30			
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
				
		-- reduce setting by 15 seconds, -> 1:15		
		for i in 0 to 14 loop	-- counter clockwise decrease of 1 min 
			bi <= '1';
			wait for rotary_quarter_period;
			ai <= '1';
			wait for rotary_quarter_period;
			bi <= '0';
			wait for rotary_quarter_period;
			ai <= '0';
			wait for rotary_quarter_period;			
		end loop;
		
		wait for 10 * half_period;		-- brief delay
		
		end_sim <= true;		-- stop system clock		-- stop clocks		
		
		wait;
		
	end process;
	
end tb_architecture;



