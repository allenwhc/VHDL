-------------------------------------------------------------------------------
--
-- Title       : ha_mixed
-- Design      : ha_mixed_simnet
-- Author      : Haochen Wang
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\Lab06s14\ha_mixed_simnet\src\ha_mixed.vhd
-- Generated   : Mon Mar 24 22:36:04 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : mixed style of half adder
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {ha_mixed} architecture {ha_mixed}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ha_mixed is
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 sum : out STD_LOGIC;
		 carry_out : out STD_LOGIC
	     );
end ha_mixed;

--}} End of automatically maintained section

architecture ha_mixed of ha_mixed is
begin
	sum<=a xor b;		--dataflow concurrent statement
	co:process(a,b)	 --start of process concurrent statement
	begin
		if a='1'then
			carry_out<=b;
		else
			carry_out<='0';
		end if;
		end process co;
end ha_mixed;
