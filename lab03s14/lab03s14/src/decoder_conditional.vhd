-------------------------------------------------------------------------------
--
-- Title       : decoder_conditional
-- Design-name : lab03s14
-- Author      : 
-- Experiment  : 
-- Section     : 
-------------------------------------------------------------------------------
--
-- File        : decoder_conditional.vhd
-- Generated   : Tue Feb 25 10:52:18 2014
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
--{entity {decoder_conditional} architecture {decoder_conditional}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decoder_conditional is
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
end decoder_conditional;

--}} End of automatically maintained section

architecture decoder_conditional of decoder_conditional is
	signal tmp : std_logic_vector(3 downto 0);
	begin
	tmp <= (p,q,r,s);
	a<='0' when tmp = "0000" else
		'0' when tmp = "0010" else
		'0' when tmp = "0100" else
		'0' when tmp = "1100" else 
		'0' when tmp = "1110" else
		'1' ;
	b <= '0' when tmp = "0000" else
		'0' when tmp = "0001" else
		'0' when tmp = "0100" else
		'0' when tmp = "1011" else
		'0' when tmp = "1110" else
		'0' when tmp = "1111" else
		'1' ;
	c <= '0' when tmp = "0000" else
		'0' when tmp = "0001" else
		'0' when tmp = "0010" else
		'0' when tmp = "0011" else
		'0' when tmp = "1110" else
		'0' when tmp = "1111" else
		'1'  ;
	b <= '1' when tmp = "1110" else
		'1' when tmp = "1111" else
		'0'  ;
	
	 -- enter your statements here --

	end decoder_conditional;
