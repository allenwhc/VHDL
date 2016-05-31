
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all; 

entity muxed_display_datapath is
	port(
		minutes : in std_logic_vector(3 downto 0);-- minutes value from timer
		seconds : in std_logic_vector(5 downto 0);-- seconds value from timer
		sel : in std_logic_vector(1 downto 0);-- digit select from control
		seven_segments : out std_logic_vector(6 downto 0) -- to all segment drivers
		);
end muxed_display_datapath;	 

architecture behavioral of muxed_display_datapath is
signal sec1,sec2,temp: std_logic_vector(3 downto 0);
begin
	
u0: entity bin6_bcd	port map(bin=> seconds,
	bcd0=> sec1,
	bcd1 => sec2(2 downto 0));
	sec2(3)<='0';
	
temp<=sec1 when sel="00" else
	  sec2 when sel="01" else
	  minutes  when sel="10" else
		 "0000";
	  
u1: entity bcd_seven port map(
	bcd => temp,
	seg_drive => seven_segments
);



end	behavioral;
