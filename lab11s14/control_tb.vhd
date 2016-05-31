-------------------------------------------------------------------------------
--
-- Title       : control_tb
-- Design      : mux_data
-- Author      : admin
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : H:\ese382\lab11s14\mux_data\src\control_tb.vhd
-- Generated   : Tue May  6 13:00:45 2014
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
--{entity {control_tb} architecture {control_tb}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity control_tb is
end control_tb;

--}} End of automatically maintained section

architecture control_tb of control_tb is
signal rst_bar,dig_0,dig_1,dig_2:std_logic;
signal clk:std_logic:='0';
signal digit_select:std_logic_vector(1 downto 0);
constant half_period:time:=10 ns;
signal end_sim:boolean:=false;
begin
	uut:entity muxed_display_control port map(
	rst_bar=>rst_bar,
	clk=>clk,
	digit_select => digit_select,
	dig_0 =>dig_0,
	dig_1 =>dig_1,
	dig_2 =>dig_2
);
rst_bar<='0','1' after 3*half_period;
clock:process
begin
	for i in 0 to 10000 loop
		clk<=not clk;
		wait for half_period;
	end loop;
	wait;
end process;

end control_tb;
