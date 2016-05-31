-------------------------------------------------------------------------------
--
-- Title       : converter_loop
-- Design-name : converter_loop
-- Author      : Haochen Wang	
-- Experiment  : loop for 2421 converter
-- Section     : TA
-------------------------------------------------------------------------------
--
-- File        : converter_loop.vhd
-- Generated   : Tue Mar  4 08:52:38 2014
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
--{entity {converter_loop} architecture {converter_loop}}

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.numeric_std.all;


entity converter_loop is
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
end converter_loop;

--}} End of automatically maintained section

architecture converter_loop of converter_loop is
 	   signal output:std_logic_vector(3 downto 0);
begin 					  
	
	loopy:process(p,q,r,s)
	variable value:unsigned(3 downto 0);   
	variable temp:std_logic_vector(3 downto 0);	
	variable input:std_logic_vector(3 downto 0);

begin 	 	 
	input:=(p,q,r,s);
		temp:="0000";
		value:=(p,q,r,s);
		for i in 0 to 3 loop 
			if(value<5)then
				output(i)<=input(i);
				next;
			elsif(value>=5 and value<=10)then
				output(i)<='-';
				next;
					
			elsif(value>10)then	
				input:=std_logic_vector(value-6); 
				output(i)<=input(i);
				next;
			 
			end if ; 
			
		end loop;
		
	end process;
	(d,c,b,a)<=output;
end converter_loop;
