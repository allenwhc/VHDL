-------------------------------------------------------------------------------
--
-- Title       : cpos
-- Design      : task1
-- Author      : Haochen Wang
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab07s14_task1\task1\src\cpos.vhd
-- Generated   : Mon Mar 31 21:04:08 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description :  2421 to BCD using CPOS
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {cpos} architecture {cpos}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity cpos is
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
end cpos;

--}} End of automatically maintained section

architecture dataflow of cpos is
begin
	a<=s;
	b<=(p or q or r or s)
	and(p or q or r or not s)
	and(p or not q or r or s)
	and(not p or q or not r or not s)
	and(not p or not q or not r or s)
	and(not p or not q or not r or not s);
	c<=(p or q or r or s)
	and(p or q or r or not s)
	and(p or q or not r or s)
	and(p or q or not r or not s)
	and(not p or not q or not r or s)
	and(not p or not q or not r or not s);
	d<=(p or q or r or s)
	and(p or q or r or not s)
	and(p or q or not r or s)
	and(p or q or not r or not s)
	and(p or not q or r or s)
	and(not p or q or not r or not s) 
	and(not p or not q or r or s)
	and(not p or not q or r or not s);

end dataflow;
