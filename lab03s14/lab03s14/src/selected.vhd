-------------------------------------------------------------------------------
--
-- Title       : selected
-- Design-name : lab03s14
-- Author      : 
-- Experiment  : 
-- Section     : 
-------------------------------------------------------------------------------
--
-- File        : selected.vhd
-- Generated   : Tue Feb 25 10:28:53 2014
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
--{entity {selected} architecture {selected}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity selected is
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
end selected;

--}} End of automatically maintained section

architecture selected of selected is
begin
	-- enter your statements here --	
	with std_logic_vector'(p,q,r,s) select
	 a	<= 	'0' when "0000"|"0010"|"0100"|"1100"|"1110",
	 '1' when "0001"|"0011"|"1011"|"1101"|"1111",
	 '-' when others;
	 with std_logic_vector'(p,q,r,s) select
	 b	<=	'0' when "0000"|"0001"|"0100"|"1011"|"1110"|"1111",
	 '1' when others;
	 with std_logic_vector'(p,q,r,s) select
	 c	<=	'0' when "0000"|"0001"|"0010"|"0011"|"1110"|"1111",
	 '1' when others;
	 with std_logic_vector'(p,q,r,s) select
	 d	<=	'1' when "1110"|"1111",
	 '0' when others;
			
end selected;
