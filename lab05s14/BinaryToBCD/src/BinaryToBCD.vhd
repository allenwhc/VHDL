-------------------------------------------------------------------------------
--
-- Title       : BinaryToBCD
-- Design-name : BinaryToBCD
-- Author      : Haochen Wang	
-- Experiment  : Binary to BCD
-- Section     : 
-------------------------------------------------------------------------------
--
-- File        : BinaryToBCD.vhd
-- Generated   : Tue Mar 11 08:24:45 2014
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
--{entity {BinaryToBCD} architecture {BinaryToBCD}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity BinaryToBCD is
	 port(
		 bin : in STD_LOGIC_VECTOR(5 downto 0);
		 bcd0 : out STD_LOGIC_VECTOR(3 downto 0);
		 bcd1 : out STD_LOGIC_VECTOR(2 downto 0)
	     );	
end BinaryToBCD;

architecture BinaryToBCD of BinaryToBCD is
begin  			 
	--signal bin_sig: std_logic_vector(5 downto 0);
	convert:process(bin)   
	--variable bint:=std_logic_vector(5 downto 0);
	variable bint:std_logic_vector(5 downto 0);	
	variable output:std_logic_vector(6 downto 0);
	variable temp1:unsigned(3 downto 0);
	begin
	output:="0000000"; 
	bint:=bin;
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

end process;


end BinaryToBCD;
