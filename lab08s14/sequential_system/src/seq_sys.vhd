library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seq_sys is
    port(
        load : in std_logic;        -- command pulse to load parallel input data
        send : in std_logic;        -- command pulse to transmit serial data
        clk : in std_logic;         -- system clock4
        rst_bar : in std_logic;     -- asynchronous reset
        d : in std_logic_vector(7 downto 0);    -- parallel input data
        serial_out : out std_logic; -- serial output
        valid : out std_logic;      -- indicates serial output data is valid
        sample_clk : out std_logic  -- sample serial output on rising edge
        ); 
	attribute loc : string;
	attribute loc of d : signal is "P3,P4,P5,P6,P7,P8,P9,P15";
	attribute loc of send : signal is "P14";
	attribute loc of load : signal is "P2";
	attribute loc of clk : signal is "P11";
	attribute loc of rst_bar : signal is "P33";

	attribute loc of sample_clk : signal is "P26";
	attribute loc of valid : signal is "P24";
	attribute loc of serial_out : signal is "P19";	
end seq_sys;

architecture behavior of seq_sys is
signal q,a,dx,vx,qbar:std_logic;	
signal temp:std_logic_vector(3 downto 0);
begin 
		u0: entity right_shift_reg port map (d,load,a,clk,rst_bar,serial_out);
		u1: entity counter port map (load,q,clk,'1',temp);
		u2: entity dff_en port map ('1',clk,send,rst_bar,q);
		a<=send or q;
		dx<=not temp(3);
		vx<=dx and q;
		valid<=vx;
		sample_clk<= not clk and vx;
end behavior;