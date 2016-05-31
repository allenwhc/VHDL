-------------------------------------------------------------------------------
--
-- Title       : C2421BCD_CPOS
-- Design-name : lab03s14
-- Author      : 
-- Experiment  : 
-- Section     : 
-------------------------------------------------------------------------------
--
-- File        : C2421BCD_CPOS.vhd
-- Generated   : Tue Feb 25 09:57:15 2014
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
--{entity {C2421BCD_CPOS} architecture {C2421BCD_CPOS}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity C2421BCD_CPOS is
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
	attribute loc : string;
   attribute loc of p : signal is "P3";
   attribute loc of q : signal is "P4";
   attribute loc of r : signal is "P5";		
   attribute loc of s : signal is "P6";
   attribute loc of d : signal is "P27";		
   attribute loc of c : signal is "P26";		
   attribute loc of b : signal is "P25";		
   attribute loc of a : signal is "P24";
end C2421BCD_CPOS;

--}} End of automatically maintained section

architecture cpos of C2421BCD_CPOS is
begin
	a <= s;
	
	b <= (p or q or (not r) or s) and (p or q or (not r) or(not s)) and ((not p) or (not q) or r or s) and (p or r or (not r) or s);
	
	c <= (p or (not q) or r or s) and 
		((not p) or q or (not r) or (not s)) and 
		((not p) or (not q) or r or s) and 
		((not p) or (not q) or r or (not s));
	
	d <= ((not p) or (not q) or (not r) or s) and 
		((not p) or (not q) or (not r) or (not s));
	 -- enter your statements here --

end cpos;
