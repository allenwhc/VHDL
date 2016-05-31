library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity count_down_timer is
	port(
		rst_bar : in std_logic;-- asynchronous reset
		clk : in std_logic;-- system clock
		ai : in std_logic;-- channel a of inner knob
		bi : in std_logic;-- channel b of inner knob
		ao : in std_logic;-- channel a of inner knob
		bo : in std_logic;-- channel b of inner knob
		s : in std_logic;-- push button switch of inner knob
		set_arm : in std_logic;-- 1 enables setting, 0 enables runnging
		seconds_clk : in std_logic;-- 50% duty cycle one second clock
		alarm : out std_logic;-- asserted when count reaches 00.0
		seconds : out std_logic_vector(5 downto 0);-- output count
		minutes : out std_logic_vector(3 downto 0)-- output count
		); 
	
	attribute loc : string;
	attribute loc of clk : signal is "93";
	attribute loc of rst_bar : signal is "39";
	attribute loc of seconds_clk : signal is "45";
	attribute loc of set_arm : signal is "14";
	
	attribute loc of s : signal is "57";
	attribute loc of ai : signal is "56";
	attribute loc of bi : signal is "55";
	attribute loc of ao : signal is "54";
	attribute loc of bo : signal is "53";
	
	attribute loc of minutes : signal is "98,97,96,95";
	attribute loc of seconds : signal is "67,66,64,63,62,61";
	attribute loc of alarm : signal is "69";
	
	
end count_down_timer;


architecture dataflow of count_down_timer is
	type inhib_state is (run, armed, set,idle);
	signal present_state, next_state : inhib_state;	
	signal temp_m:std_logic_vector(3 downto 0);
	signal temp_sec:std_logic_vector(5 downto 0); 
	signal flag:std_logic;
	--signal min_counts:unsigned(3 downto 0);
	--signal sec_counts:unsigned(5 downto 0);
begin  

	
end dataflow;