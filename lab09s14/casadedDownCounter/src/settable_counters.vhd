-------------------------------------------------------------------------------
--
-- Title       : settable_counters
-- Design      : casadedDownCounter
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab09s14\casadedDownCounter\src\settable_counters.vhd
-- Generated   : Mon Apr 14 23:55:06 2014
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
--{entity {settable_counters} architecture {settable_counters}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity settable_counters is
	 port(
		 rst_bar : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 ai : in STD_LOGIC;
		 bi : in STD_LOGIC;
		 seconds : out STD_LOGIC_VECTOR(5 downto 0);
		 minutes : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end settable_counters;

--}} End of automatically maintained section

architecture settable_counters of settable_counters is
signal up,en_cnt:std_logic;
begin
	 u0:entity rotary_encoder_decoder_fsm port map(ai,bi,clk,rst_bar,en_cnt,up);
	 u1:entity cascaded_counters port map(rst_bar,'1',clk,up,en_cnt,seconds,minutes);

end settable_counters;
