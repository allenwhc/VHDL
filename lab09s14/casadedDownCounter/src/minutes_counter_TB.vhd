-- Lab 9 Task 2 Testbench Version 1 04/11/14

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity minutes_counter_tb is
end minutes_counter_tb;

architecture tb_architecture of minutes_counter_tb is

	-- Stimulus signals
	signal rst_bar : std_logic;
	signal clr_bar : std_logic;
	signal clk : std_logic := '0';
	signal up : std_logic;
	signal en_cnt1 : std_logic;
	signal en_cnt2 : std_logic;
	-- observed signals
--	signal en_out : std_logic;
	signal minutes_nonzero : std_logic;
	signal q : std_logic_vector(3 downto 0);

	constant half_period : time := 10 ns;	-- half sys clock period

begin

	-- Unit Under Test port map
	UUT : entity minutes_counter
		port map (
			rst_bar => rst_bar,
			clr_bar => clr_bar,
			clk => clk,
			up => up,
			en_cnt1 => en_cnt1,
			en_cnt2 => en_cnt2,
--			en_out => en_out,
			minutes_nonzero => minutes_nonzero,
			q => q
		);
	
	rst_bar <= '0', '1' after 3 * half_period;	-- 1 1/2 clock reset
	
	stim: process
	begin
		clr_bar <= '1';		-- unassert clear
		up <= '1';				-- count direction is up
		en_cnt1 <= '0';		-- counter is not enabled
		en_cnt2 <= '1';		-- counter is not enabled
		
		for i in 0 to 3 loop		-- check that counter does not count
			clk <= not clk;		-- generate 2 clocks
			wait for half_period;
		end loop;

		en_cnt1 <= '1';		-- counter is not enabled
		en_cnt2 <= '0';		-- counter is not enabled
		
		for i in 0 to 3 loop		-- check that counter does not count
			clk <= not clk;		-- generate 4 clocks
			wait for half_period;
		end loop;				
		
		en_cnt1 <= '1';			-- counter is enabled for counting
		en_cnt2 <= '1';			-- counter is enabled for counting			
		for i in 0 to 29 loop	-- count up 15 times, check rollover
			clk <= not clk;
			wait for half_period;
		end loop;
		
		up <= '0';		-- change direction to count down
		for i in 0 to 35 loop	-- count down 18 times
			clk <= not clk;
			wait for half_period;
		end loop;
		
		up <= '1';		-- change direction to count up
		for i in 0 to 13 loop	-- count up 7 times
			clk <= not clk;
			wait for half_period;
		end loop;
		
		clr_bar <= '0';			-- clear count
		for i in 0 to 3 loop
			clk <= not clk;
			wait for half_period;
		end loop;
		
		wait;		-- done
		
	end process;		

end tb_architecture;



