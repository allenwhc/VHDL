library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin6_bcd is
	port(
		bin : in std_logic_vector(5 downto 0); -- 6-bit binary input
		bcd0 : out std_logic_vector(3 downto 0);-- least significant BCD digit
		bcd1 : out std_logic_vector(2 downto 0) -- most significant BCD digit
		);	
end bin6_bcd; 

architecture bin2bcd of bin6_bcd is 
begin
bin_bcd:process(bin)
	variable bint: std_logic_vector(5 downto 0);
	variable bcd: std_logic_vector(6 downto 0);	
	variable temp: unsigned(3 downto 0);
begin
	temp:="0000";
	bcd(6 downto 0):= "0000000";
	bint:=bin;
	for i in 0 to 5 loop		
		--shift
		bcd(6 downto 1):=bcd(5 downto 0);
		bcd(0):=bint(5);
		bint(5 downto 1):=bint(4 downto 0);
		bint(0):='0';
		
		bcd0<=bcd(3 downto 0);
	 	bcd1<=bcd(6 downto 4);	
		 
		 if (i<7 and bcd(3 downto 0)>"0100") then
		temp:=unsigned(bcd(3 downto 0))+"0011";
		bcd(3 downto 0):=std_logic_vector(temp);
		end if;
end loop;
end process;
end	bin2bcd;