-------------------------------------------------------------------------------
--
-- Title       : BCDTo7Seg
-- Design-name : BCDTo7Seg
-- Author      : Haochen Wang
-- Experiment  : 
-- Section     : 
-------------------------------------------------------------------------------
--
-- File        : BCDTo7Seg.vhd
-- Generated   : Tue Mar 11 11:54:43 2014
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
--{entity {BCDTo7Seg} architecture {BCDTo7Seg}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity BCDTo7Seg is
	 port(
		 bcd : in STD_LOGIC_VECTOR(3 downto 0);
		 seg_drive : out STD_LOGIC_VECTOR(6 downto 0)
	     );
end BCDTo7Seg;

--}} End of automatically maintained section

architecture BCDTo7Seg of BCDTo7Seg is
begin
	seg:process(bcd)
	--variable bcdi:std_logic_vector(3 downto 0);
	--variable seg: std_logic_vector(6 downto 0);
	--variable temp:unsigned(3 downto 0);
	begin
		--bcdi:=bcd;
		--seg:="0000000";
		if (bcd<="0000") then
			seg_drive<="0111111";
		elsif (bcd<="0001")then
			seg_drive<="0000110";
		elsif (bcd<="0010")then
			seg_drive<="1011011";
		elsif (bcd<="0011")then
			seg_drive<="1001111";
	 	elsif (bcd<="0100")then
			seg_drive<="1000110";
		elsif (bcd<="0101")then
			seg_drive<="1101101";
		elsif(bcd<="0110")then
			seg_drive<="1111101";
		elsif (bcd<="0111")then
			seg_drive<="0000111";	
		elsif (bcd<="1000")then
			seg_drive<="1111111";
		elsif (bcd<="1001")then
			seg_drive<="1101111";
		end if;
	end process;
end BCDTo7Seg;
