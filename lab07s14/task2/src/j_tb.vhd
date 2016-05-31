-- Non-self-checking testbench for Laboratory 3 spring 2014

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity j_tb is
end j_tb;

architecture tb_architecture of j_tb is

	signal a,b,c,p,q,r : std_logic;
	constant period : time := 20ns;
	constant dont_care: boolean :=false;	
	
		type t_vector is record
			a, b, c :  std_logic;
  			p, q, r :  std_logic;
		end record;	  
		
		type t_array is array (natural range <>)
		of t_vector;			
		
			constant t_vectors : t_array := (
			--a,b,c,p,q,r
			('0', '0', '0', '0','0','0'),
			('0', '0', '1', '0','0','1'),
			('0', '1', '1', '0','1','0'),
			('1', '1', '1', '0','1','1'),
			('1', '1', '0', '1','0','0'),
			('1', '0', '0', '1','0','1'));
			
			begin

	-- Unit Under Test port map
	UUT : entity john2bin
		port map (
		a=>a,
		b=>b,
		c=>c,
		p=>p,
		q=>q,
		r=>r
		);

		
	stim: process		-- apply all binary input combinations
	begin
		for i in t_vectors'range loop
			a <= t_vectors(i).a;
			b <= t_vectors(i).b; 
			c <= t_vectors(i).c;
			wait for period; 	
			   if(dont_care= false)	then
				assert (( p = t_vectors(i).p ) and (q = t_vectors(i).q)and(r = t_vectors(i).r))
				report "test vector " & integer'image(i)& " failed" &" for input a="& std_logic'image(a) & " and b = " & std_logic'image(b)&"and c="& std_logic'image(c) 
				severity error;	
				else
					assert (( p = '-' ) and (q = '-')and(r = '-'))
					report "test vector " & integer'image(i)& " failed" &" for input a="& std_logic'image(a) & " and b = "& std_logic'image(b)&"and c="& std_logic'image(c)
					severity error;	
			   end if;
		end loop;
		wait;
	end process;
		
end tb_architecture;
