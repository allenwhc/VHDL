library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port(
        clear : in std_logic;       -- synchronous clear counter
        en_count : in std_logic;    -- enable count
        clk : in std_logic;         -- clock
        rst_bar : in std_logic;     -- asynchronous reset bar
        q : out std_logic_vector(3 downto 0)    -- outputs
        );
end counter;

architecture behavior of counter is
begin
	cnt_int: process (clk, rst_bar)	
	variable count:integer:=0;
	begin
		if rst_bar = '0' then
			q<="0000";
		elsif rising_edge(clk) and clear='1'then
			q<="0000";
		elsif rising_edge(clk) and en_count='1' then				
			count:=count+1;
			q<=std_logic_vector(to_unsigned(count,4));
			if count=9 then
				q<="0000";
				count:=0;
			end if;
		end if;
	end process;
end behavior;