library IEEE;
use IEEE.STD_LOGIC_1164.all;		

entity converter_2421_bcd is
port(
p, q, r, s : in std_logic;
d, c, b, a : out std_logic
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
end converter_2421_bcd;		

architecture csop of converter_2421_bcd is
begin
	a <= s;
	b <= ((not p) and (not q)and r and (not s)) or ((not p) and (not q) and r and s) or (p and q and (not r) and (not s)) or (p and q and (not r) and s);
	c <= ((not p) and q and (not r) and (not s)) or (p and (not q) and r and s) or (p and q and (not r) and (not s)) or (p and q and (not r) and s);
	d <= (p and q and r and (not s)) or (p and q and r and s);		 
end csop;									