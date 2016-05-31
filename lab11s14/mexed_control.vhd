-------------------------------------------------------------------------------
--
-- Title       : muxed_display_control
-- Design      : mux_data
-- Author      : admin
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : H:\ese382\lab11s14\mux_data\src\mexed_control.vhd
-- Generated   : Tue May  6 12:04:02 2014
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
--{entity {muxed_display_control} architecture {dataflow_mc}}

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use ieee.numeric_std.all;

entity muxed_display_control is
port(

	rst_bar : in std_logic;-- reset input
	clk : in std_logic;-- system clock
	digit_select : out std_logic_vector(1 downto 0); -- select digit
	dig_0 : out std_logic;-- active low signal, turns on digit driver
	dig_1 : out std_logic;-- active low signal, turns on digit driver
	dig_2 : out std_logic-- active low signal, turns on digit driver
);
end muxed_display_control;

--}} End of automatically maintained section

architecture dataflow_mc of muxed_display_control is  
type state is (state0,state1,state2,state3,state4,state5,state6,state7,state8);	   
signal present_state,next_state:state;
signal count:unsigned(3 downto 0);

begin
	counter_p:process(clk,rst_bar) 
	begin
		if rst_bar='0'then
			count<="0000";
		elsif rising_edge(clk)then
			if count= 15 then
				
				count<="0000";	
			else
				count<=count+1;
			end if;
		end if;	
	end process;
	
	state_reg:process(clk) 
	begin
	if rising_edge(clk)then
		if rst_bar='0'then
			present_state<=state0;
		else
			present_state<=next_state;
		end if;
		end if;
	end process;
	
	output:process(present_state)
	begin
		case present_state is
			when state0=>
			digit_select<="00";
			dig_0<='1';
			dig_1<='1';
			dig_2<='1';	
			
			when state1=>
			digit_select<="00";
			dig_0<='0';
			dig_1<='1';
			dig_2<='1';	
			
			when state2=>
			digit_select<="00";
			dig_0<='1';
			dig_1<='1';
			dig_2<='1';
			
			when state3=>
			digit_select<="01";
			dig_0<='1';
			dig_1<='1';
			dig_2<='1';	
			
			when state4=>
			digit_select<="01";
			dig_0<='1';
			dig_1<='0';
			dig_2<='1';	
			
			when state5=>
			digit_select<="01";
			dig_0<='1';
			dig_1<='1';
			dig_2<='1';
			
			when state6=>
			digit_select<="10";
			dig_0<='1';
			dig_1<='1';
			dig_2<='1';
			
			when state7=>
			digit_select<="10";
			dig_0<='1';
			dig_1<='1';
			dig_2<='0';	
			
			when state8=>
			digit_select<="10";
			dig_0<='1';
			dig_1<='1';
			dig_2<='1';	
		end case;
	end process;
	
	nxt_state:process(present_state,count)
	begin  
		case present_state is
			when state0=>next_state<=state1;
			when state1=>
			if (count=15) then
				next_state<=state2;
			else
				next_state<=state1;
			end if;
			when state2=>next_state<=state3;
			when state3=>next_state<=state4;
			when state4=>
			if (count=15) then
				next_state<=state5;
			else
				next_state<=state4;
			end if;
			when state5=>next_state<=state6;
			when state6=>next_state<=state7;
			when state7=>
			if (count=15) then
				next_state<=state8;
			else
				next_state<=state7;
			end if;
			when state8=>next_state<=state0;
			end case;
	end process;
	
end dataflow_mc;
