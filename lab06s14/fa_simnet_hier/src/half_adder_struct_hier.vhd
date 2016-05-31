-------------------------------------------------------------------------------
--
-- Title       : half_adder_struct_hier
-- Design      : hirarchical structural style half adder
-- Author      : Haochen Wang
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab06s14_task2\hirarchical structural style half adder\src\half_adder_struct_hier.vhd
-- Generated   : Mon Mar 24 23:28:47 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : half_adder struct
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {half_adder_struct_hier} architecture {half_adder_struct_hier}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity half_adder is
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 sum : out STD_LOGIC;
		 carry_out : out STD_LOGIC
	     );
end half_adder;

-------------------------------------

architecture dataflow of half_adder is
begin
	uut:entity xor_2 port map(i1=>a,i2=>b,o1=>sum);
	carry_out<=a and b;
end dataflow;
