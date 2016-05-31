-- Lab 9 Task 4 Testbench Version 1 04/12/14
-- Rotary encoder decoder

library ieee;
use ieee.std_logic_1164.all;

entity rotary_encoder_decoder_fsm_tb is
end rotary_encoder_decoder_fsm_tb;

architecture tb_architecture of rotary_encoder_decoder_fsm_tb is

	-- Stimulus signals
	signal a : std_logic;
	signal b : std_logic;
	signal clk : std_logic := '0';
	signal rst_bar : std_logic;
	-- observed signals
	signal cten : std_logic;
	signal up : std_logic;

	signal end_sim : boolean := false;
	constant half_period : time := 10 ns;	-- system clock half period
	constant rotary_quarter_period : time := 20 * half_period; -- rotary

begin

	-- Unit Under Test port map
	UUT : entity rotary_encoder_decoder_fsm
		port map (
			a => a,
			b => b,
			clk => clk,
			rst_bar => rst_bar,
			cten => cten,
			up => up
		);

	rst_bar <= '0', '1' after 3 * half_period;	-- system reset
	
	clock: process
	begin
		while end_sim = false loop	-- clock controlled by end_sim
		clk <= not clk;
		wait for half_period;
	end loop;
	wait;
	end process;
	
	stim: process
	begin
		a <= '0';		-- initial rotary encoder position
		b <= '0';

		wait for 11 * half_period;	-- encoder not yet turned
		
		for i in 0 to 63 loop	-- clockwise rotation 64 pulses
			a <= '1';
			wait for rotary_quarter_period;
			b <= '1';
			wait for rotary_quarter_period;
			a <= '0';
			wait for rotary_quarter_period;
			b <= '0';
			wait for rotary_quarter_period;			
		end loop;
		
		wait for 12 * half_period;		
		
		for i in 0 to 67 loop	-- counter clockwise rotation 
			b <= '1';				-- 68 pulses
			wait for rotary_quarter_period;
			a <= '1';
			wait for rotary_quarter_period;
			b <= '0';
			wait for rotary_quarter_period;
			a <= '0';
			wait for rotary_quarter_period;			
		end loop;

		end_sim <= true;		-- stop clock		
		
		wait;		-- done
		
	end process;

end tb_architecture;



