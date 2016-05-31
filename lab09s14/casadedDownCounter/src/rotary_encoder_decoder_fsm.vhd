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
		 cten : out STD_LOGIC;
		 up : out STD_LOGIC
	     );
end rotary_encoder_decoder_fsm;

--}} End of automatically maintained section

architecture behavioral of rotary_encoder_decoder_fsm is 
constant state0:std_logic_vector(1 downto 0):="00";
constant	state1:std_logic_vector(1 downto 0):="10";
constant	state2:std_logic_vector(1 downto 0):="11";
constant	state3:std_logic_vector(1 downto 0):="01";
signal present_state, next_state:std_logic_vector(1 downto 0);
begin							  					  
	state_reg:process(clk,rst_bar)
	begin	 
		if rising_edge(clk)then
			if rst_bar='0'then
				present_state<=state0;
			else
				present_state<=next_state;
			end if;
		end if;
	end process;
	nxt_state:process(present_state,a,b)
	begin  
		case present_state is
			when state0=>
				if rising_edge(a) and b='1'then
					next_state<=state1;
				elsif rising_edge(a) and b='0'then
					next_state<=state2;
				else
					next_state<=state0;
				end if;
			when state1=>	  
				next_state<=state0;
			when state2=>
			next_state<=state0;
			when others=>next_state<=state0;
		end case;
			
	end process; 
	(cten,up)<=present_state;
end behavioral;
