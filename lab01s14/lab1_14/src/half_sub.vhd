-------------------------------------------------------------------------------
--
-- Title       : half_sub
-- Design-name : lab1_14
-- Author      : 
-- Experiment  : 
-- Section     : 
-------------------------------------------------------------------------------
--
-- File        : half_sub.vhd
-- Generated   : Tue Feb  4 09:23:54 2014
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
--{entity {half_sub} architecture {dataflow}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity half_sub is
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 borrow : out STD_LOGIC;
		 diff : out STD_LOGIC
	     );
end half_sub;

--}} End of automatically maintained section

architecture dataflow of half_sub is
begin

	-- enter your statements here -- 
	diff <= a xor b;
	borrow <= not a and b;

end dataflow;
