-------------------------------------------------------------------------------
--
-- Title       : timer_muxed_display
-- Design      : mux_data
-- Author      : admin
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : H:\ese382\lab11s14\mux_data\src\timer_muxed_display.vhd
-- Generated   : Tue May  6 13:18:45 2014
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
--{entity {timer_muxed_display} architecture {timer_muxed_display}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity timer_muxed_display is
	 port(
		 rst_bar : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 ai : in STD_LOGIC;
		 bi : in STD_LOGIC;
		 ao : in STD_LOGIC;
		 bo : in STD_LOGIC;
		 s : in STD_LOGIC;
		 set_arm : in STD_LOGIC;
		 seconds_clk : in STD_LOGIC;
		 alarm : out STD_LOGIC;
		 dig_0 : out STD_LOGIC;
		 dig_1 : out STD_LOGIC;
		 dig_2 : out STD_LOGIC;
		 seven_segments : out STD_LOGIC_VECTOR(6 downto 0)
	     );	   
		 attribute loc : string;
   attribute loc of clk : signal is "93";
   attribute loc of rst_bar : signal is "81";
   attribute loc of seconds_clk : signal is "45";
   attribute loc of set_arm : signal is "11";
   attribute loc of s : signal is "98";
   attribute loc of ai : signal is "97";
   attribute loc of bi : signal is "96";
   attribute loc of ao : signal is "95";
   attribute loc of bo : signal is "92";

 attribute loc of seven_segments : signal is "70,69,67,66,64,63,62";
        --     a, b, c, d, e, f, g

   attribute loc of dig_0 : signal is "89";
   attribute loc of dig_1 : signal is "88";
   attribute loc of dig_2 : signal is "87";
   attribute loc of alarm : signal is "80";
end timer_muxed_display;

--}} End of automatically maintained section

architecture timer_muxed_display of timer_muxed_display is	
signal sec:std_logic_vector(5 downto 0);
signal min:std_logic_vector(3 downto 0);
signal dig_sel:std_logic_vector(1 downto 0);
signal digit_0,digit_1,digit_2:std_logic;
begin

	 u0: entity count_down_timer port map(
		rst_bar =>rst_bar,
		clk =>clk,
		ai =>ai,
		bi =>bi,
		ao =>ao,
		bo =>bo,
		s =>s,
		set_arm =>set_arm,
		seconds_clk =>seconds_clk,
		alarm =>alarm,
		seconds =>sec,
		minutes =>min
		);
	  u1:entity muxed_display_control port map(
		rst_bar =>rst_bar,
		clk =>clk,
		digit_select=>dig_sel,
		dig_0 =>dig_0,
		dig_1 =>dig_1,
		dig_2 =>dig_2
		);
	  u2:entity muxed_display_datapath port map(
		  seconds=>sec,
		  minutes=>min, 
		
		sel=>dig_sel,
		seven_segments =>seven_segments
		);		  
end timer_muxed_display;
