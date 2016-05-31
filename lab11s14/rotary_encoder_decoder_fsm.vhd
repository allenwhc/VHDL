-------------------------------------------------------------------------------
--
-- Title       : rotary_encoder_decoder_fsm
-- Design      : casadedDownCounter
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Documents\Active HDL\lab09s14\casadedDownCounter\src\rotary_encoder_decoder_fsm.vhd
-- Generated   : Mon Apr 14 22:23:08 2014
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
--{entity {rotary_encoder_decoder_fsm} architecture {rotary_encoder_decoder_fsm}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity rotary_encoder_decoder_fsm is
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 rst_bar : in STD_LOGIC;
		 direction_changed:out std_logic;
		 cten : out STD_LOGIC;
		 up : out STD_LOGIC
	     );
end rotary_encoder_decoder_fsm;

--}} End of automatically maintained section

architecture behavioral of rotary_encoder_decoder_fsm is 
type state is (state_a,state_b,state_c,state_d);
signal present_state, next_state:state;
begin	
	
	state_reg:process(clk)
	begin	 
		if rising_edge(clk)then
			if rst_bar='0'then
				present_state<=state_a;
			else
				present_state<=next_state;
			end if;
		end if;
	end process; 
	
	outputs: process (present_state)		   
	variable output: std_logic_vector(2 downto 0);
		begin
			case present_state is
				when state_a=>output:="0-0";
				when state_b=>output:="011";
				when state_c=>output:="101";
				when state_d=>output:="0-0";
				when others=>output:="000";
			end case;
			up<=output(1);
			cten<=output(0);
			direction_changed<=output(2);	
	end process;
	
	nxt_state:process(present_state,a,b)
	variable input : std_logic_vector(1 downto 0);
	begin 
			input := (b,a);
			if a='0'then 
				case present_state is
					when state_d =>	  
						next_state <= state_a;
					when others=>
					next_state <=state_a;
				end case;
			elsif a='1' and b='1'then
				case present_state is
					when state_a=>next_state<=state_c;
					when state_b=>next_state<=state_d;
					when state_c=>next_state<=state_d;
					when others=>next_state<=state_d;
				end case;
			elsif a='1' and b='0'then
				  case present_state is
					when state_a=>next_state<=state_b;
					when state_b=>next_state<=state_d;
					when state_c=>next_state<=state_d;
					when others=>next_state<=state_d;
				end case;
			else
				next_state<=state_a;
			end if;
	end process; 
	--(cten,up)<=present_state;
end behavioral;
