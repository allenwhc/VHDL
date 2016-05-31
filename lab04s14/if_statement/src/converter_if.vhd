-------------------------------------------------------------------------------
--
-- Title       : converter_if
-- Design-name : if_statement
-- Author      : Haochen Wang
-- Experiment  : if statement for 2421 converter
-- Section     : TA
-------------------------------------------------------------------------------
--
-- File        : converter_if.vhd
-- Generated   : Tue Mar  4 08:34:26 2014
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
--{entity {converter_if} architecture {converter_if}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity converter_if is
	 port(
		 p : in STD_LOGIC;
		 q : in STD_LOGIC;
		 r : in STD_LOGIC;
		 s : in STD_LOGIC;
		 a : out STD_LOGIC;
		 b : out STD_LOGIC;
		 c : out STD_LOGIC;
		 d : out STD_LOGIC
	     );	 
	attribute loc : string;
   attribute loc of p : signal is "P3";
   attribute loc of q : signal is "P4";
   attribute loc of r : signal is "P5";		
   attribute loc of s : signal is "P6";
   attribute loc of d : signal is "P27";		
   attribute loc of c : signal is "P26";		
   attribute loc of b : signal is "P25";		
   attribute loc of a : signal is "P24";
end converter_if;

--}} End of automatically maintained section

architecture converter_if of converter_if is
signal condition:std_logic_vector(3 downto 0);
signal input:std_logic_vector(3 downto 0);
begin
	-- enter your statements here -- 
	input<=(p,q,r,s);
	 casey:process(input)
	 begin
		if(input<="0000")	then
			 condition<="0000";
		elsif(input<="0001") then
			condition<="0001";
		elsif(input<="0010") then
			condition<="0010";
		elsif(input<="0011") then
			condition<="0011";
		elsif(input<="0100") then
			condition<="0100";
		elsif(input<="1011") then
			condition<="0101";
		elsif(input<="1100") then
			condition<="0110";
		elsif(input<="1101") then
			condition<="0111";
		elsif(input<="1110") then
			condition<="1000";
		elsif(input<="1111") then
			condition<="1001";
		else
			condition<="----"; 
	end if;
	end process;
	(d,c,b,a)<=condition;		
end converter_if;
