-------------------------------------------------------------------------------
--
-- Title       : count_down_timer
-- Design      : setable_timer
-- Author      : admin
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : H:\ese382\lab10s14\setable_timer\src\count_down_timer.vhd
-- Generated   : Tue Apr 29 12:06:55 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description :  countdown timer
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {count_down_timer} architecture {count_down_timer}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity count_down_timer is
	port(
		rst_bar : in STD_LOGIC;
		clk : in STD_LOGIC;
		ai : in STD_LOGIC;
		bi : in STD_LOGIC;
		ao : in STD_LOGIC;
		bo : in STD_LOGIC;
		s : in STD_LOGIC;
		set_arm : in STD_LOGIC;
		seconds_clk : in STD_LOGIC;
		alarm : out STD_LOGIC;
		seconds : out STD_LOGIC_VECTOR(5 downto 0);
		minutes : out STD_LOGIC_VECTOR(3 downto 0)
		);	 
	attribute loc : string;
   attribute loc of clk : signal is "93";
   attribute loc of rst_bar : signal is "39";
   attribute loc of seconds_clk : signal is "45";
   attribute loc of set_arm : signal is "14";

   attribute loc of s : signal is "57";
   attribute loc of ai : signal is "56";
   attribute loc of bi : signal is "55";
   attribute loc of ao : signal is "54";
   attribute loc of bo : signal is "53";

   attribute loc of minutes : signal is "98,97,96,95";
   attribute loc of seconds : signal is "67,66,64,63,62,61";
   attribute loc of alarm : signal is "69";

end count_down_timer;


architecture count_down_timer of count_down_timer is
	signal up_sec,en_cnt1_sec,en_cnt2_sec,en_out_sec:std_logic;
	signal sec:std_logic_vector(5 downto 0);
	signal up_min, en_cnt1_min, en_cnt2_min, min_non_zero:std_logic;
	signal min:std_logic_vector(3 downto 0);
	signal cten_rot_sec, up_rot_sec:std_logic;
	signal cten_rot_min, up_rot_min:std_logic;
	signal fsm_out:std_logic_vector(1 downto 0);
	signal sec_clk_edge:std_logic;
	signal flag:std_logic;
begin									  
	u0: entity rotary_encoder_decoder_fsm port map(ai,bi,clk,rst_bar,open,cten_rot_sec,up_rot_sec);
	u1: entity seconds_counter port map(rst_bar,'1',clk,up_sec,'0',en_cnt1_sec,en_cnt2_sec,en_out_sec,sec);
	u2: entity rotary_encoder_decoder_fsm port map(ao,bo,clk,rst_bar,open,cten_rot_min,up_rot_min);
	u3: entity minutes_counter port map(rst_bar,'1',clk,up_min,en_cnt1_min,en_cnt2_min,min_non_zero,min);
	minutes<=min;
	seconds<=sec;
	u4: entity pedgefsm port map(seconds_clk,rst_bar,clk,sec_clk_edge);
	u5: entity control_unit port map(rst_bar,clk,s,set_arm,fsm_out);   
	--u6: entity settable_timer port map(rst_bar,clk,ai,bi,ao,bo,sec,min);
	en_cnt1_sec<=
	cten_rot_sec when fsm_out="01" else
	sec_clk_edge when fsm_out="11"else 
	'0';
	
	en_cnt2_sec<=
	'1' when fsm_out="01" else
	min_non_zero when fsm_out="11"else
	'0';
	
	up_sec<=
	up_rot_sec when fsm_out="01"else
	'0' when fsm_out="11"else
	'0';
	
	en_cnt1_min<=
	cten_rot_min when fsm_out="01"else
	sec_clk_edge when fsm_out="11"else
	'0';
	
	en_cnt2_min<=
	'1' when fsm_out="01"else
	en_out_sec when fsm_out="11"else 
	'0';
	
	up_min<=
	up_rot_min when fsm_out="01"else
	'0'when fsm_out="11"else 
	'0';	
	
	flag<=
	'1' when  fsm_out="11" and min/="0000" and sec="000000"	else
	'1' when  fsm_out="11" and sec="111011"
	else '0';
	
	alarm<=
	'1'when fsm_out="11" and min="0000" and sec="000000" and flag='0'
	else '0';
  
	
	
end count_down_timer;
