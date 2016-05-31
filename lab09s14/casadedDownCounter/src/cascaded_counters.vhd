-------------------------------------------------------------------------------
--
-- Title       : cascaded_counters
-- Design      : casadedDownCounter
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab09s14\casadedDownCounter\src\cascaded_counters.vhd
-- Generated   : Mon Apr 14 21:58:30 2014
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
--{entity {cascaded_counters} architecture {cascaded_counters}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity cascaded_counters is
	 port(
		 rst_bar : in STD_LOGIC;
		 clr_bar : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 up : in STD_LOGIC;
		 en_cnt : in STD_LOGIC;
		 seconds : out STD_LOGIC_VECTOR(5 downto 0);
		 minutes : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end cascaded_counters;

--}} End of automatically maintained section

architecture cascaded_counters of cascaded_counters is
signal en_carry,non_z:std_logic;
begin
	u0:entity seconds_counter port map(rst_bar,clr_bar,clk,up,en_cnt,non_z,en_carry,seconds);
	u1:entity minutes_counter port map(rst_bar,clr_bar,clk,up,en_cnt,en_carry,non_z,minutes);
	 -- enter your statements here --

end cascaded_counters;
