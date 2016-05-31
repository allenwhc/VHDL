library ieee;
use ieee.std_logic_1164.all;

entity dff_en is
    port(
        d : in std_logic;       -- data input
        clk : in std_logic;     -- clock input 
        en : in std_logic;      -- enable input
        rst_bar : in std_logic; -- asynchronous reset
        q : out std_logic       -- output
        );
end dff_en;

architecture behavioral of dff_en is
begin
	process (d, clk, en, rst_bar)
	begin
		if rst_bar = '0' then -- asynchronous set
				q<='0';
		elsif clk'event and clk='1' then
			if en='1' then	   --en gate
				q<=d;
			else
				null;
			end if;
		end if;
end process;
end behavioral;

