-- Lab 9 Task 1 Testbench Version 1 04/11/14
-- 04/12/2014
-- Zhe Yan  && Haochen Wang
-- second counter for Task 1

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity seconds_counter is
port(
	rst_bar : in std_logic;-- asynchronous reset
	clr_bar : in std_logic;-- synchronous clear
	clk : in std_logic;-- system clock
	up : in std_logic;-- count direction, 1 => up, 0 => down
	en_cnt1 : in std_logic;-- enable required to count up or down
	en_cnt2 : in std_logic;-- enable required to count down past 0
	en_out : out std_logic;-- enable next counting stage (carry out)
	q : out std_logic_vector(5 downto 0)-- output count
);
end seconds_counter; 

architecture dataflow of seconds_counter is	
	signal count_sec : unsigned(5 downto 0);
begin
	scount:process(clk,rst_bar) 
	begin
		if(rst_bar='0')	then
			   en_out<='0';
			   count_sec<="000000";
		elsif(rising_edge(clk))then
			if	clr_bar='0' then
				en_out<='0';
			   	count_sec<="000000";
			elsif en_cnt1='1'and up='1' then
				if count_sec="111010"then
					en_out<='1';  
					count_sec<=count_sec+1;
				elsif count_sec="111011"then
					
					count_sec<="000000";	
					en_out<='0'; 
				else
					count_sec<=count_sec+1;
					en_out<='0';
				end if;
				
			elsif en_cnt1='1' and up='0' then 
				if count_sec="000001"and en_cnt2='1'then
					en_out<='1';  
					count_sec<=count_sec-1;
				elsif count_sec="000000"and en_cnt2='1'then
					count_sec<="111011"; 
					en_out<='0';
				elsif count_sec="000001"and en_cnt2='0'then
					en_out<='1';  
					count_sec<=count_sec-1;
				elsif count_sec="000000"and en_cnt2='0' then
					count_sec<="000000";
					en_out<='0';
				else
					count_sec<=count_sec-1;
					en_out<='0';
				end if;
				
				end if;
		end if;

	end process;
	q <= std_logic_vector(count_sec);
end dataflow;