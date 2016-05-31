-- Lab 9 Task 1 Testbench Version 1 04/11/14

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity seconds_counter_tb is
end seconds_counter_tb;

architecture tb_architecture of seconds_counter_tb is

	-- Stimulus signals
	signal rst_bar : std_logic;
	signal clr_bar : std_logic;
	signal clk : std_logic := '0';	-- clock initially 0
	signal up : std_logic;
	signal en_cnt1 : std_logic;
	signal en_cnt2 : std_logic;
	-- observed signals
	signal en_out : std_logic;
	signal q : std_logic_vector(5 downto 0);

	constant half_period : time := 10 ns;	-- half sys clock period

begin

	-- Unit Under Test port map
	UUT : entity seconds_counter
		port map (
			rst_bar => rst_bar,
			clr_bar => clr_bar,
			clk => clk,
			up => up,
			en_cnt1 => en_cnt1,
			en_cnt2 => en_cnt2,
			en_out => en_out,
			q => q
		);
	
	rst_bar <= '0', '1' after 3 * half_period;	-- 1 1/2 clock reset
	
	stim: process
	begin
		clr_bar <= '1';		-- unassert clear
		up <= '0';				-- count direction is up
		en_cnt1 <= '0';		-- counter is not enabled
		en_cnt2 <= '1';	-- this enable should not affect counting up
		
		for i in 0 to 3 loop		-- check that counter does not count
			clk <= not clk;		-- generate 2 clocks
			wait for half_period;
		end loop;
		
		en_cnt2 <= '0';	-- this enable should not affect counting up		
		for i in 0 to 3 loop		-- check that counter does not count
			clk <= not clk;		-- generate 4 clocks
			wait for half_period;
		end loop;		
		
		
		en_cnt1 <= '1';			-- counter enabled for counting up		
		for i in 0 to 125 loop	-- count up 63 times, check rollover
			clk <= not clk;
			wait for half_period;
		end loop;
		
		up <= '0';		-- change direction to count down
		en_cnt2 <= '1';			-- count down with roll under
		for i in 0 to 11 loop	-- count down 6 times
			clk <= not clk;
			wait for half_period;
		end loop;
		
		en_cnt2 <= '0';	-- count down with no roll under
		for i in 0 to 125 loop	-- count down 63 times
			clk <= not clk;
			wait for half_period;
		end loop;
		
		up <= '1';		-- change direction to count up
		for i in 0 to 15 loop	-- count up 8 times
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



