-------------------------------------------------------------------------------
--
-- Title       : minutes_counter
-- Design      : casadedDownCounter
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab09s14\casadedDownCounter\src\minutes_counter.vhd
-- Generated   : Mon Apr 14 21:36:52 2014
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
--{entity {minutes_counter} architecture {minutes_counter}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity minutes_counter is
	 port(
		 rst_bar : in STD_LOGIC;
		 clr_bar : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 up : in STD_LOGIC;
		 en_cnt1 : in STD_LOGIC;
		 en_cnt2 : in STD_LOGIC;
		 minutes_nonzero : out STD_LOGIC;
		 q : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end minutes_counter;

--}} End of automatically maintained section

architecture behavioral of minutes_counter is 
begin 	
	cnt_int: process (clk, rst_bar)	
	variable min_counts:unsigned(3 downto 0);
	begin
	if rst_bar =  '0' then
		min_counts:="0000";
		minutes_nonzero<='0';
	else
		if rising_edge(clk)then
			if min_counts="0000"then
				minutes_nonzero<='0';
			else
				minutes_nonzero<='1';
			end if;
			if clr_bar='0'then	  
				minutes_nonzero<='0';
				min_counts:="0000";
			else
				if en_cnt1='1' and up='1'and en_cnt2='1'then
					if min_counts="1001" then
						min_counts:="0000";	
						minutes_nonzero<='0';
					else
						min_counts:=min_counts+1;
					end if;
				elsif en_cnt1='1' and up='0'and en_cnt2='1'then
					if min_counts="0000" then
						min_counts:="0000";
					elsif min_counts="0001" then
						min_counts:=min_counts-1;	
						minutes_nonzero<='0';
					else
						min_counts:=min_counts-1;
					end if;
				else
					null;
				end if;	
			end if;
		else
			null;
		end if;
		
	end if;		
	if min_counts /=0 then
		minutes_nonzero<='1';
		else
		minutes_nonzero<='0';
	end if;
	
	
	q <= std_logic_vector(min_counts);
	end process;
	
end behavioral;