-------------------------------------------------------------------------------
--
-- Title       : converter_tb
-- Design      : task1
-- Author      : Haochen Wang
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab07s14_task1\task1\src\converter_tb.vhd
-- Generated   : Mon Mar 31 21:46:12 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 2421 to BCD testbench
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {converter_tb} architecture {converter_tb}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use ieee.numeric_std.all;

entity converter_tb is
end converter_tb;

--}} End of automatically maintained section

architecture behavior of converter_tb is
signal p_tb,q_tb,r_tb,s_tb,a_tb,b_tb,c_tb,d_tb:std_logic; 
begin 	
	uut0:entity csop port map(p=>p_tb,q=>q_tb,r=>r_tb,s=>s_tb,a=>a_tb,b=>b_tb,c=>c_tb,d=>d_tb);
	--uut1:entity cpos port map(p=>p_tb,q=>q_tb,r=>r_tb,s=>s_tb,a=>a_tb,b=>b_tb,c=c_tb,d=>d_tb);
	--uut2:entity selected port map(p=>p_tb,q=>q_tb,r=>r_tb,s=>s_tb,a=>a_tb,b=>b_tb,c=c_tb,d=>d_tb);
	--uut3:entity conditional port map(p=>p_tb,q=>q_tb,r=>r_tb,s=>s_tb,a=>a_tb,b=>b_tb,c=>c_tb,d=>d_tb);
	self_checking:process  
	constant period:time:=20ns;
	constant dont_care:boolean:=true;
	begin
		for i in 0 to 15 loop
			(p_tb,q_tb,r_tb,s_tb)<=(to_unsigned(i,4));
			wait for period;
			if(i<=4)then
				assert((d_tb,c_tb,b_tb,a_tb)=(p_tb,q_tb,r_tb,s_tb))
				report"test fail1"severity error;
		  	elsif((i>=11)and(i<=15))then
				assert((d_tb,c_tb,b_tb,a_tb)=(to_unsigned(i-6,4)))
				report"test faild2"severity error;
			else
				assert((d_tb='-')and(c_tb='-')and(b_tb='-')and(a_tb='-')and(dont_care=true))
				report"test failed3"severity error;
			end if;
		end loop;
		wait;	
	end process;
		
end behavior;
