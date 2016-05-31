-------------------------------------------------------------------------------
--
-- Title       : pdegefsm
-- Design      : setable_timer
-- Author      : admin
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : H:\ese382\lab10s14\setable_timer\src\pdegefsm.vhd
-- Generated   : Tue Apr 29 11:51:15 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : positive edge detector
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {pdegefsm} architecture {pdegefsm}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity pedgefsm is
	port(
		a : in STD_LOGIC;
		rst_bar : in STD_LOGIC;
		clk : in STD_LOGIC;
		a_pe : out STD_LOGIC
		);
end pedgefsm;						

architecture pedgefsm of pedgefsm is 
	type state is (state_a,state_b,state_c);
	signal present_state, next_state:state;
begin
	state_reg:process(clk,rst_bar)
	begin
		if rst_bar='0'then
			present_state<=state_a;
		elsif rising_edge(clk) then 
			present_state<=next_state;
		end if;
	end process;
	outputs:process(present_state)
	begin
		case present_state is
			when state_c=>a_pe<='1';
			when state_a|state_b=>a_pe<='0';
		end case;
	end process;
	nxt_state:process(present_state,a)
	begin
		case present_state is
			when state_a=>
				if a='0'then
					next_state<=state_b;
				else
					next_state<=state_a;
			end if;
			when state_b=>
				if a='1'then
					next_state<=state_c;
				else
					next_state<=state_b;
			end if;
			when state_c=>
				if a='0'then
					next_state<=state_b;
				else
					next_state<=state_a;
			end if;
		end case;
	end process;
end pedgefsm;
