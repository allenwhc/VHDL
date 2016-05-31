-------------------------------------------------------------------------------
--
-- Title       : ha_primitive_gates
-- Design      : hirarchical structural style half adder
-- Author      : Haochen Wang
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab06s14_task2\hirarchical structural style half adder\src\ha_primitive_gates.vhd
-- Generated   : Mon Mar 24 23:17:53 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description :  primitive gates definition
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {ha_primitive_gates} architecture {ha_primitive_gates}}
---------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity inv is
	 port(
		 i1 : in STD_LOGIC;
		 o1 : out STD_LOGIC
	     );
end inv;	  

architecture dataflow of inv is
begin 
	o1<= not i1;
end dataflow;
-----------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity and_2 is
	 port(
		 i1 : in STD_LOGIC;
		 i2 : in STD_LOGIC;
		 o1 : out STD_LOGIC
	     );
end and_2;	  

architecture dataflow of and_2 is
begin 
	o1<=i1 and i2;
end dataflow;
-------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity or_2 is
	 port(
		 i1 : in STD_LOGIC;
		 i2 : in STD_LOGIC;
		 o1 : out STD_LOGIC
	     );
end or_2;	  

architecture dataflow of or_2 is
begin 
   o1<=i1 or i2;
end dataflow;