library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_seven is
port(
bcd : in std_logic_vector(3 downto 0); -- 4 bit BCD input
seg_drive : out std_logic_vector(6 downto 0) -- segments a ...g
);
end bcd_seven;

architecture seven of bcd_seven is
	type truth_table is array (0 to 9) of std_logic_vector(6 downto 0);
	constant seven_out : truth_table :=
	("0000001", "1001111", "0010010", "0000110", "1001100", "0100100", "0100000", "0001111","0000000","0000100");
	
begin
	seg_drive<=seven_out(to_integer(unsigned(bcd(3 downto 0))));
end	seven;