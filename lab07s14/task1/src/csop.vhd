-------------------------------------------------------------------------------
--
-- Title       : csop
-- Design      : task1
-- Author      : Haochen Wang
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab07s14_task1\task1\src\csop.vhd
-- Generated   : Mon Mar 31 20:57:25 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 2421 to BCD using CSOP
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {csop} architecture {csop}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity csop is
	 port(
		 p : in STD_LOGIC;
		 q : in STD_LOGIC;
		 r : in STD_LOGIC;
		 s : in STD_LOGIC;
		 a : out STD_LOGIC;
		 b : out STD_LOGIC;
		 c : out STD_LOGIC;
		 d : out STD_LOGIC
	     );
end csop;

--}} End of automatically maintained section

architecture dataflow of csop is
begin

	
	a<=s;
	b<=(not p and not q and r and not s)
	or(not p and not q and r and s)
	or(p and q and not r and not s)
	or(p and q and not r and s);
	c<=(not p and q and not r and not s)
	or(p and not q and r and s)
	or(p and q and not r and not s)
	or(p and q and not r and s);
	d<=(p and q and r and not s)
	or(p and q and r and s);

end dataflow;
