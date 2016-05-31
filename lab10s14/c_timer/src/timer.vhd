library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity count_down_timer is
	port(
		rst_bar : in std_logic;-- asynchronous reset
		clk : in std_logic;-- system clock
		ai : in std_logic;-- channel a of inner knob
		bi : in std_logic;-- channel b of inner knob
		ao : in std_logic;-- channel a of inner knob
		bo : in std_logic;-- channel b of inner knob
		s : in std_logic;-- push button switch of inner knob
		set_arm : in std_logic;-- 1 enables setting, 0 enables runnging
		seconds_clk : in std_logic;-- 50% duty cycle one second clock
		alarm : out std_logic;-- asserted when count reaches 00.0
		seconds : out std_logic_vector(5 downto 0);-- output count
		minutes : out std_logic_vector(3 downto 0)-- output count
		); 
	
	attribute loc : string;
	attribute loc of clk : signal is "93";
	attribute loc of rst_bar : signal is "39";
	attribute loc of seconds_clk : signal is "45";
	attribute loc of set_arm : signal is "14";
	
	attribute loc of s : signal is "57";
	attribute loc of ai : signal is "56";
	attribute loc of bi : signal is "55";
	attribute loc of ao : signal is "54";
	attribute loc of bo : signal is "53";
	
	attribute loc of minutes : signal is "98,97,96,95";
	attribute loc of seconds : signal is "67,66,64,63,62,61";
	attribute loc of alarm : signal is "69";
	
	
end count_down_timer;


architecture dataflow of count_down_timer is
	type inhib_state is (run, armed, set);
	signal present_state, next_state : inhib_state;	
	signal temp_m:std_logic_vector(3 downto 0);
	signal temp_sec:std_logic_vector(5 downto 0); 
	--signal min_counts:unsigned(3 downto 0);
	--signal sec_counts:unsigned(5 downto 0);
begin  
	--alarm<='0';	
	u0: entity settable_timer port map(rst_bar,clk,ai,bi,ao,bo,temp_sec,temp_m);
	set_reg: process (clk)
	begin
		if rising_edge(clk) then
			if rst_bar = '0' then
				present_state <= set;
			else
				present_state <= next_state;
			end if;
		end if;
	end process;
	
	inhib_output: process (present_state,temp_sec,temp_m,seconds_clk)
		variable min_counts:unsigned(3 downto 0);
		variable sec_counts:unsigned(5 downto 0);
	begin 
		
		case present_state is
			when set =>
				alarm<='0';
				seconds <= temp_sec;
			minutes <= temp_m;
			when armed => 
				alarm<='0';
				sec_counts := unsigned(temp_sec);
			min_counts := unsigned(temp_m);
			
			when run =>
				if seconds_clk='1'then
					if sec_counts=0 then
						if min_counts=0 then
							alarm <= '1';
						else
							alarm<='0';
							min_counts:=min_counts-1;
							sec_counts:="111011";
						end if;
					else
						sec_counts:=sec_counts-1;
						alarm<='0';
						
					end if;
					--seconds <= temp_sec;
					--minutes <= temp_m;
					
				else
					min_counts:=min_counts;
					sec_counts:=sec_counts;
					
				end if;	
			
			when others =>
				null;
			
		end case; 
		minutes<=std_logic_vector(min_counts);
		seconds<=std_logic_vector(sec_counts);
	end process;
	
	nxt_state: process (present_state, s, set_arm)
	begin
		case present_state is
			when set =>
				if set_arm = '1' then
					next_state <= set;
				elsif set_arm= '0'then
					next_state <= armed;						
				else
					null;
			end if;
			when armed =>
				
				if rising_edge(s) and set_arm = '0'then
					next_state<=run; 
				elsif set_arm='1'then
					next_state <= set;	
				elsif set_arm = '0' and s='0'then
					next_state <= armed;
				else
					null;
			end if;
			when run =>
				if s = '0' then
					next_state <= run;
				elsif set_arm= '1' and s= '1' then
					next_state <= set;
					
				else
					null;
			end if;
		end case;
	end process;
	
end dataflow;