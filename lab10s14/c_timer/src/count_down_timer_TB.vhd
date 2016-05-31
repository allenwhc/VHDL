-- Testbench for lab 10 Task 2 

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity count_down_timer_tb is
end count_down_timer_tb;

architecture tb_architecture of count_down_timer_tb is
	
	-- Stimulus signals
	signal rst_bar : std_logic;
	signal clk : std_logic := '0';
	signal ai : std_logic;
	signal bi : std_logic;
	signal ao : std_logic;
	signal bo : std_logic;
	signal s : std_logic;
	signal set_arm : std_logic;
	signal seconds_clk : std_logic := '0';
	
	-- Observed signals
	signal alarm : std_logic;
	signal seconds : std_logic_vector(5 downto 0);
	signal minutes : std_logic_vector(3 downto 0);
	
	constant half_period : time := 10 ns;
	constant rotary_quarter_period : time := 20 * half_period;
	constant half_period_second : time := 100 * half_period;
	
	signal end_sim : boolean := false;
	
begin
	
	-- Unit Under Test port map
	UUT : entity count_down_timer
	port map (
		rst_bar => rst_bar,
		clk => clk,
		ai => ai,
		bi => bi,
		ao => ao,
		bo => bo,
		s => s,
		set_arm => set_arm,
		seconds_clk => seconds_clk,
		alarm => alarm,
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
	
	-- seconds clock runs unti end_sim = true
	-- period for seconds clock is not 1 second, instead it is
	-- much faster for simulation purposes. However, it is 100
	-- times slower than the system clock
	
	seconds_clock: process
	begin
		while end_sim = false loop
			seconds_clk <= not seconds_clk;
			wait for half_period_second;
		end loop;
		wait;
	end process;
	
	-- stimulus process
	stim: process
	begin
		
		set_arm <= '0';	-- switch in arm positin
		s <= '0';			-- pushbutton not pressed
		
		ai <= '0';			-- initial position of inner and outter
		bi <= '0';			-- knobs of rotary encoder
		ao <= '0';
		bo <= '0';
		
		wait for 11 * half_period;	-- brief idle time
		
		set_arm <= '1';	-- switch to set position
		
		wait for 10 * half_period;
		
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
		
		set_arm <= '0';		-- switch to arm
		
		wait for 10 * half_period;		-- brief delay
		
		s <= '1';				-- press and release pushbutton to start down count		
		wait for 10 * half_period;		
		s <= '0';		
		
		wait until alarm = '1';			-- countinue counting until count reaches
												-- zero and alarm is asserted		
		wait for 10 * half_period;
		
		s <= '1';				-- press and release pushbutton to silence alarm						
		wait for 10 * half_period;		
		s <= '0';				
		
		wait for 10 * half_period;		-- brief delay
		
		end_sim <= true;		-- stop system clock		-- stop clocks		
		
		wait;
		
	end process;
	
end tb_architecture;


