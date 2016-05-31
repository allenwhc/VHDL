-------------------------------------------------------------------------------
--
-- Title       : john2bin
-- Design-name : task2
-- Author      : Haochen Wang
-- Experiment  : Lab 7
-- Section     : 
-------------------------------------------------------------------------------
--
-- File        : john2bin.vhd
-- Generated   : Tue Apr  1 09:01:27 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Johnson to Binary
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {john2bin} architecture {john2bin}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity john2bin is
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 c : in STD_LOGIC;
		 p : out STD_LOGIC;
		 q : out STD_LOGIC;
		 r : out STD_LOGIC
	     );
end john2bin;

--}} End of automatically maintained section

architecture dataflow of john2bin is
begin
	p <= (a and b and not c) or (a and not b and not c);
	q <= (not a and b and c) or (a and b and c);
	r <= (not a and not b and c) or (a and b and c) or (a and not b and not c);
end dataflow;
