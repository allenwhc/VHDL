-------------------------------------------------------------------------------
--
-- Title       : BinaryToSeg
-- Design-name : BinaryToSeg
-- Author      : Haochen Wang
-- Experiment  : 
-- Section     : 
-------------------------------------------------------------------------------
--
-- File        : BinaryToSeg.vhd
-- Generated   : Tue Mar 11 12:36:20 2014
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
--{entity {BinaryToSeg} architecture {BinaryToSeg}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity BinaryToSeg is
	 port(
		 binary : in STD_LOGIC_VECTOR(5 downto 0);
		 seven_seg0 : out STD_LOGIC_VECTOR(6 downto 0);
		 seven_seg1 : out STD_LOGIC_VECTOR(6 downto 0)
	     );
	attribute loc : string;
   attribute loc of binary : signal is "P2,P3,P4,P5,P6,P7";
   attribute loc of seven_seg1 : signal is
                 "P30,P17,P26,P21,P15,P19,P42";
   attribute loc of seven_seg0 : signal is
                 "P8,P37,P39,P43,P24,P9,P41";
end BinaryToSeg;

--}} End of automatically maintained section

architecture BinaryToSeg of BinaryToSeg is
signal bcd0:std_logic_vector(3 downto 0);
	signal bcd1:std_logic_vector(2 downto 0);
begin
	convert:process(binary)   
	--variable bint:=std_logic_vector(5 downto 0);
	variable bint:std_logic_vector(5 downto 0);	
	variable temp1 : unsigned(3 downto 0);
	variable output:std_logic_vector(6 downto 0);	
	
	begin
	output:="0000000"; 
	bint:=binary;
	temp1:="0000";
	for i in 0 to 5 loop 
		output(6 downto 1):=output(5 downto 0);
		output(0):=bint(5);
		bint(5 downto 1):=bint(4 downto 0);
		bint(0):='0';  
		
		bcd0<=output(3 downto 0);
		bcd1<=output(6 downto 4);
		if(i<5 and output(3 downto 0)>"0100")then		
			temp1:=unsigned(output( 3 downto 0))+"0011";
			output(3 downto 0):=std_logic_vector(temp1);
		end if;
	end loop; 
	if (bcd0<="0000") then
			seven_seg0<="0000001";
		elsif (bcd0<="0001")then
			seven_seg0<="1001111";
		elsif (bcd0<="0010")then
			seven_seg0<="0010010";
		elsif (bcd0<="0011")then
			seven_seg0<="0000110";
	 	elsif (bcd0<="0100")then
			seven_seg0<="1001100";
		elsif (bcd0<="0101")then
			seven_seg0<="0100100";
		elsif(bcd0<="0110")then
			seven_seg0<="0100000";
		elsif (bcd0<="0111")then
			seven_seg0<="0001111";	
		elsif (bcd0<="1000")then
			seven_seg0<="0000000";
		elsif (bcd0<="1001")then
			seven_seg0<="0000100";
		end if;
		
	if (bcd1<="000") then
			seven_seg1<="0000001";
		elsif (bcd1<="001")then
			seven_seg1<="1001111";
		elsif (bcd1<="010")then
			seven_seg1<="0010010";
		elsif (bcd1<="011")then
			seven_seg1<="0000110";
	 	elsif (bcd1<="100")then
			seven_seg1<="0111001";
		elsif (bcd1<="101")then
			seven_seg1<="1001100";
		elsif(bcd1<="110")then
			seven_seg1<="1001100";
		elsif (bcd1<="111")then
			seven_seg1<="0001111";	
		end if;

end process;
	

end BinaryToSeg;
