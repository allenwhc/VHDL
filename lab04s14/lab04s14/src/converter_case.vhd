-------------------------------------------------------------------------------
--
-- Title       : converter_case
-- Design-name : lab04s14
-- Author      : Haochen Wang	
-- Experiment  : case statement for 2421 converter
-- Section     : TA
-------------------------------------------------------------------------------
--
-- File        : converter_case.vhd
-- Generated   : Tue Mar  4 08:05:49 2014
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
--{entity {converter_case} architecture {converter_case}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity converter_case is
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
end converter_case;

--}} End of automatically maintained section

architecture behavior of converter_case is
	signal condition:std_logic_vector(3 downto 0);
begin		   
	casey:process(p,q,r,s)
	begin
		case std_logic_vector'(p,q,r,s)is
			when "0000"=>condition<="0000";
			when "0001"=>condition<="0001";
			when "0010"=>condition<="0010";
			when "0011"=>condition<="0011";
			when "0100"=>condition<="0100";
			when "1011"=>condition<="0101";
			when "1100"=>condition<="0110";
			when "1101"=>condition<="0111";
			when "1110"=>condition<="1000";
			when "1111"=>condition<="1001";
			when others =>condition<="----";  			
		end case;		
	end process;
	(d,c,b,a)<=condition;
end behavior;
