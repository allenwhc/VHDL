library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity control_unit is 
	port(
		rst_bar:in std_logic;
		clk: in std_logic;
		s: in std_logic;
		set_arm: in std_logic;
		mode: out std_logic_vector(1 downto 0)
		);
end control_unit;

architecture fsm of control_unit is
	type state is (idle, set, arm, run, run2);
	signal present_state, next_state:state;
begin
	state_reg:process(clk)
	begin
		if rising_edge(clk) then
			if rst_bar = '0' then
				present_state <= idle;
			else
				present_state <= next_state;
			end if;
		end if;
	end process;
	
	inhib_output: process (present_state)
	begin 
		case present_state is
			when idle=>mode<="00";
			when set=>mode<="01";
			when arm=>mode<="10";
			when run=>mode<="11";
			when run2=>mode<="11";
			when others=>mode<="00";	
		end case; 
	end process;
	
	nxt_state: process (present_state, s, set_arm)
	begin
		case present_state is
			when idle=>
				if set_arm = '1' then
					next_state <= set;
				else
					next_state<=idle;
			end if;
			when set =>
				if set_arm='0'then
					next_state<=arm;
				else
					next_state<=set;
			end if;
			when arm =>	
				if set_arm='1'then
					next_state <= set;	
				elsif s='1' and set_arm = '0'then
					next_state<=run;  
				else
					next_state <= arm;
			end if;
			when run =>
				if set_arm='1' then
					next_state <= set;
				elsif s = '0'and set_arm='0' then
					next_state <= run2;			
				else
					next_state <= run;
			end if;
			when run2 => 
				if set_arm= '1' then
					next_state <= set;
				elsif set_arm='0'and s='1'then
					next_state<=idle;
				else
					next_state <= run2;
			end if;
		end case;
	end process;
end fsm;