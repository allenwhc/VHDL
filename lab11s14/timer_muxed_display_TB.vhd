library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity timer_muxed_display_tb is
end timer_muxed_display_tb;

architecture TB_ARCHITECTURE of timer_muxed_display_tb is

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal rst_bar : STD_LOGIC;
	signal clk : STD_LOGIC := '0';
	signal ai : STD_LOGIC;
	signal bi : STD_LOGIC;
	signal ao : STD_LOGIC;
	signal bo : STD_LOGIC;
	signal s : STD_LOGIC;
	signal set_arm : STD_LOGIC;
	signal seconds_clk : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal alarm : STD_LOGIC;
	signal seven_segments : STD_LOGIC_VECTOR(6 downto 0);
	signal dig_0 : STD_LOGIC;
	signal dig_1 : STD_LOGIC;
	signal dig_2 : STD_LOGIC;

	constant half_period : time := 500 ns;
	constant rotary_quarter_period : time := 100 * half_period;
	constant half_period_second : time := 200 * half_period;
	
	signal end_sim : boolean := false;

begin

	-- Unit Under Test port map
	UUT : entity timer_muxed_display
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
			seven_segments => seven_segments,
			dig_0 => dig_0,
			dig_1 => dig_1,
			dig_2 => dig_2
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

end TB_ARCHITECTURE;


