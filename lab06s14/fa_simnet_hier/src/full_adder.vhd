-------------------------------------------------------------------------------
--
-- Title       : full_adder
-- Design      : fa_simnet_hier
-- Author      : Haochen Wang
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab06s14_task3\fa_simnet_hier\src\full_adder.vhd
-- Generated   : Tue Mar 25 00:15:16 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : full adder
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {full_adder} architecture {full_adder}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity full_adder is
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 carry_in : in STD_LOGIC;
		 sum : out STD_LOGIC;
		 carry_out : out STD_LOGIC
	     );
end full_adder;

----------------------------------------

architecture full_adder of full_adder is 
component half_adder is
	port(a,b:in std_logic;
		sum,carry_out:out std_logic);	 
end component;
signal s_s,c1,c2:std_logic;
begin
	 u1:entity half_adder port map(a,carry_in,s_s,c1);
	 u2:entity half_adder port map(s_s,b,sum,c2);
	 carry_out<=c1 or c2;

end full_adder;
