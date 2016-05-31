-------------------------------------------------------------------------------
--
-- Title       : seconds_counter
-- Design      : casadedDownCounter
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab09s14\casadedDownCounter\src\seconds_counter.vhd
-- Generated   : Mon Apr 14 20:33:39 2014
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
--{entity {seconds_counter} architecture {seconds_counter}}

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use ieee.numeric_std.all;

entity seconds_counter is
	 port(
		 rst_bar : in STD_LOGIC;
		 clr_bar : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 up : in STD_LOGIC;
		 en_cnt1 : in STD_LOGIC;
		 en_cnt2 : in STD_LOGIC;
		 en_out : out STD_LOGIC;
		 q : out STD_LOGIC_VECTOR(5 downto 0)
	     );
end seconds_counter;

--}} End of automatically maintained section

architecture behavioral of seconds_counter is 
begin 	
	cnt_int: process (clk, rst_bar)	
	variable sec_counts:unsigned(5 downto 0);
	begin
	if rst_bar =  '0' then
		sec_counts:="000000";
	else
		if rising_edge(clk)then
			if clr_bar='0'then
				en_out<='0';
				sec_counts:="000000";
			else
				if en_cnt1='1' and up='1'then
					if sec_counts="111011" then
						sec_counts:="000000";
						en_out<='1';
					else
						sec_counts:=sec_counts+1;
						en_out<='0';
					end if;
				elsif en_cnt1='1' and up='0'then
					if sec_counts="000000" and en_cnt2='1' then
						sec_counts:="111011";
					elsif sec_counts="000000" and en_cnt2='0'then
						sec_counts:="000000";
					else
						sec_counts:=sec_counts-1;
					end if;
				else
					null;
				end if;	
			end if;
		else
			null;
		end if;
	end if;					   				   				 
	q <= std_logic_vector(sec_counts);
	end process;
	
end behavioral;
