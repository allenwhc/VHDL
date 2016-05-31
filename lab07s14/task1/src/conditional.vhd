-------------------------------------------------------------------------------
--
-- Title       : conditional
-- Design      : task1
-- Author      : Haochen Wang	
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab07s14_task1\task1\src\conditional.vhd
-- Generated   : Mon Mar 31 21:40:49 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 2412 to BCD using conditional
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {conditional} architecture {conditional}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity conditional is
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
end conditional;

--}} End of automatically maintained section

architecture conditional of conditional is
signal converter_in,converter_out:std_logic_vector(3 downto 0);
begin
	converter_in<=(p,q,r,s);
	converter_out<=
		"0000"when converter_in<="0000"else
		"0001"when converter_in<="0001"else
		"0010"when converter_in<="0010"else
		"0011"when converter_in<="0011"else
		"0100"when converter_in<="0100"else
		"1011"when converter_in<="0101"else
		"1100"when converter_in<="0110"else
		"1101"when converter_in<="0111"else
		"1110"when converter_in<="1000"else
		"1111"when converter_in<="1001"else
		"----";

end conditional;
