-------------------------------------------------------------------------------
--
-- Title       : xor_2_struct
-- Design      : hirarchical structural style half adder
-- Author      : Haochen Wang
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab06s14_task2\hirarchical structural style half adder\src\xor_2_struct.vhd
-- Generated   : Mon Mar 24 23:22:18 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description :  xor computation consturction
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {xor_2_struct} architecture {xor_2_struct}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity xor_2 is
	 port(
		 i1 : in STD_LOGIC;
		 i2 : in STD_LOGIC;
		 o1 : out STD_LOGIC
	     );
end xor_2;

--------------------------------

architecture dataflow of xor_2 is  
signal i_inv,o1_inv,o2_inv,o1_and,o2_and:std_logic;
begin
	u00:entity inv port map(i1,o1_inv);
	u01:entity inv port map(i2,o2_inv);
	u11:entity and_2 port map(i1,o2_inv,o1_and);
	u12:entity and_2 port map(o1_inv,i2,o2_and);
	u2:entity or_2 port map(o1_and,o2_and,o1);
end dataflow;
