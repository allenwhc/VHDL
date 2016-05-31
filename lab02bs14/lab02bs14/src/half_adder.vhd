-------------------------------------------------------------------------------
--
-- Title       : half_adder
-- Design-name : lab02s14
-- Author      : 
-- Experiment  : 
-- Section     : 
-------------------------------------------------------------------------------
--
-- File        : half_adder.vhd
-- Generated   : Tue Feb 18 08:15:42 2014
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
--{entity {half_adder} architecture {half_adder}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity half_adder is
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 sum : out STD_LOGIC;
		 carry_out : out STD_LOGIC
	     );		 
		 	
	attribute loc : string;
	attribute loc of a : signal is "P3";
	attribute loc of b : signal is "P4";
	attribute loc of sum : signal is "P27";
	attribute loc of carry_out : signal is "P26";
end half_adder;

--}} End of automatically maintained section

architecture half_adder of half_adder is
begin
	
	sum <= (not a and b) or (a and not b);
	carry_out <= a and b;	   

	 -- enter your statements here --

end half_adder;
