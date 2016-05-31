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
	signal count_int : integer range 0 to 1000;
begin
	cnt_int: process (clk, rst_bar)
	begin
		if rst_bar = '0' then
			count_int <= 0;
		elsif rising_edge(clk) then
			if	clear='1' then 
				count_int<=0;
				elsif en_count='1' then				
					if count_int = 1000 then
						count_int <= 0;
					else
						count_int <= count_int + 1; --increment count_int
					end if;
				else
					null;
			end if;
		end if;
	end process;
			q <= std_logic_vector(to_unsigned(count_int,4));
end behavior;