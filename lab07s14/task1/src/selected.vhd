-------------------------------------------------------------------------------
--
-- Title       : selected
-- Design      : task1
-- Author      : Haochen Wang	
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab07s14_task1\task1\src\selected.vhd
-- Generated   : Mon Mar 31 21:13:23 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 2421 to BCD using Selected Form
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
end selected;

--}} End of automatically maintained section

architecture dataflow of selected is	
signal converter_in,converter_out:std_logic_vector(3 downto 0);
begin
	--converter:process(p,q,r,s)
	--begin  	  
		converter_in<=(p,q,r,s);
		with converter_in select 
		converter_out<=
		"0000"when"0000",
		"0001"when"0001",
		"0010"when"0010",
		"0011"when"0011",
		"0100"when"0100",
		"1011"when"0101",
		"1100"when"0110",
		"1101"when"0111",
		"1110"when"1000",
		"1111"when"1001",
		"----"when others;	
	--	end;
	--end process;
	(d,c,b,a)<=converter_out;
end dataflow;
