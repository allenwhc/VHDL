library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity settable_timer is
port(
	rst_bar : in std_logic;-- asynchronous reset
	clk : in std_logic;-- system clock
	ai : in std_logic;-- channel a of inner knob
	bi : in std_logic;-- channel b of inner knob
	ao : in std_logic;-- channel a of inner knob
	bo : in std_logic;-- channel b of inner knob
	seconds : out std_logic_vector(5 downto 0);-- output count
	minutes : out std_logic_vector(3 downto 0)-- output count
);
end settable_timer;	 

architecture dataflow of settable_timer is 
signal cten_sec,up_sec,cten_min,up_min,en_out,minutes_nonzero: std_logic;
begin
	u0 :entity seconds_counter port map (rst_bar,'1',clk,up_sec,cten_sec,'1',en_out,seconds);
	u1 :entity minutes_counter port map (rst_bar,'1',clk,up_min,cten_min,'1',minutes_nonzero,minutes);
	u2 : entity rotary_encoder_decoder_fsm port map( ai,bi,clk,rst_bar,cten_sec,up_sec );
	u3 : entity rotary_encoder_decoder_fsm port map( ao,bo,clk,rst_bar,cten_min,up_min );
end dataflow;