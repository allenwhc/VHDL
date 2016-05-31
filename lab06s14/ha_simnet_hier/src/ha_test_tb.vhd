-------------------------------------------------------------------------------
--
-- Title       : ha_mixed_tb
-- Design      : ha_mixed_simnet
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\Lab06s14\ha_mixed_simnet\src\ha_mixed_tb.vhd
-- Generated   : Mon Mar 24 22:45:01 2014
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
--{entity {ha_mixed_tb} architecture {ha_mixed_tb}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity ha_mixed_tb is
end ha_mixed_tb;

--}} End of automatically maintained section

architecture behavior of ha_mixed_tb is	  
--declare signals to assign values and to observe
	signal a_tb,b_tb,sum_tb,carry_out_tb:std_logic;
begin

	uut: entity half_adder port map(a=>a_tb,b=>b_tb,sum=>sum_tb,carry_out=>carry_out_tb);
	--define a process to apply input stimulus and test outputs
	tb:process
	constant period:time:=100ns;
	constant n:integer:=2;
	begin--apply every possible input combination
		for i in 0 to 2**n-1 loop
			(a_tb,b_tb)<=to_unsigned(i,n);
			wait for period;
			assert((sum_tb=(a_tb xor b_tb))and (carry_out_tb=(a_tb and b_tb)))
			report"test failed"severity error;
		end loop;	
		wait;	  --indefinitely suspend process
	end process;
end;
