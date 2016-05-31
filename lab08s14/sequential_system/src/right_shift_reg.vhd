library ieee;
use ieee.std_logic_1164.all;


entity right_shift_reg is
    port(
        d : in std_logic_vector(7 downto 0);   -- parallel input data
        load : in std_logic;        -- synchronous load parallel input  
        en_shift : in std_logic;    -- enable shift if load is unasserted
        clk : in std_logic;         -- clk
        rst_bar : in std_logic;     -- asynchronous reset
        serial_out : out std_logic  -- serial output
        );
end right_shift_reg; 

architecture behavior of right_shift_reg is
	begin
	process (clk)
		variable q1 : std_logic_vector(7 downto 0);
		begin
		if rst_bar = '0' then
			q1(7 downto 0):="00000000";
		elsif rising_edge(clk) then
			if(load='1')  then
				q1:=d;
			elsif(en_shift='1')	 then
				q1:='0'&q1(7 downto 1);
			else
				null;
			end if;
		end if;
		serial_out<=q1(0);
		end process;
end behavior;