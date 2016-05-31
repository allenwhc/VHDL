-------------------------------------------------------------------------------
--
-- Title       : mux_data_datapath_tb
-- Design      : mux_data
-- Author      : admin
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : H:\ese382\lab11s14\mux_data\src\mux_data_datapath_tb.vhd
-- Generated   : Tue May  6 11:29:42 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {mux_data_datapath_tb} architecture {mux_data_datapath_tb}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity mux_data_datapath_tb is
end mux_data_datapath_tb;

--}} End of automatically maintained section

architecture mux_data_datapath_tb of mux_data_datapath_tb is
		 signal minutes :  STD_LOGIC_VECTOR(3 downto 0);
		 signal seconds :  STD_LOGIC_VECTOR(5 downto 0);
		 signal sel :  STD_LOGIC_VECTOR(1 downto 0);
		 signal seven_segments :  STD_LOGIC_VECTOR(6 downto 0);
begin
	 -- Unit Under Test port map
	UUT : entity muxed_display_datapath
		port map (
		minutes=>minutes,
		seconds=>seconds,
		sel=>sel,
		seven_segments=>seven_segments
		);
	 -- enter your statements here --
	sec: process 
	begin
	for i in 0 to 59 loop
		seconds<=std_logic_vector(to_unsigned(i,6));
		wait for 30 ns;
		end loop;
	end process;   
	
	min: process 
	begin
	for i in 0 to 9 loop
		minutes<=std_logic_vector(to_unsigned(i,4));
		wait for 1800 ns;
		end loop;
	end process;
	
	s: process 
	begin
	for i in 0 to 2 loop
		sel<=std_logic_vector(to_unsigned(i,2));
		wait for 5 ns;
		end loop;
	end process;
end mux_data_datapath_tb;
