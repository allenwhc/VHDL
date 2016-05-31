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
constant state_p: std_logic_vector (1 downto 0) := "00";
constant state_q: std_logic_vector (1 downto 0) := "01";
constant state_r: std_logic_vector (1 downto 0) := "11";
constant state_s: std_logic_vector (1 downto 0) := "10";
signal present_state, next_state:std_logic_vector(1 downto 0);
begin	
	
	state_reg:process(clk,rst_bar)
	begin	 
		if rising_edge(clk)then
			if rst_bar='0'then
				present_state<=(b,a);
			else
				present_state<=next_state;
			end if;
		end if;
	end process; 
	
	outputs: process (a, b, present_state,clk)
		variable input : std_logic_vector(1 downto 0);
		begin
			if(rising_edge(clk)) then
			input := (b,a);
			case present_state is 
				
			when state_p =>
			if input = "01" then
			up <= '1';
			cten <= '1';
			elsif input = "10" then
			up <= '0';
			cten <= '1';
			else
			up <= '-';
			cten <= '0';
			end if;
			
			when others	 =>
			 up <= '-';
			cten <='0';
			
			end case;  
			end if;
			
	end process;
	
	nxt_state:process(present_state,a,b)
	variable input : std_logic_vector(1 downto 0);
	begin 
			input := (b,a);
		case present_state is
			when state_p =>
					if input = "01" then
						next_state <= state_q;
					elsif input = "10" then
						next_state <= state_s;
					else
						next_state <= state_p;
					end if;
					
			when state_q =>
					if input = "11" then
						next_state <= state_r;
					elsif input = "00" then
						next_state <= state_p;
					else
						next_state <= state_q;
					end if;
			when state_r=>
					if input = "01" then
						next_state <= state_q;
					elsif input = "10" then
						next_state <= state_s;
					else
						next_state <= state_r;
					end if;
			when state_s=>
					if input = "00" then
						next_state <= state_p;
					elsif input = "11" then
						next_state <= state_r;
					else
						next_state <= state_s;
					end if;
			when others	 =>
					null;
		end case;
			
	end process; 
	--(cten,up)<=present_state;
end behavioral;
