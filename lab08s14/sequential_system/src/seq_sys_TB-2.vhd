-- Testbench for Laboratory 8 spring 14

-- NOTE! System clock period changed to 20 ns

library ieee;
use ieee.std_logic_1164.all;

entity seq_sys_tb is
end seq_sys_tb;

architecture tb_architecture of seq_sys_tb is
    
    -- Stimulus signals
    signal load : std_logic;
    signal send : std_logic;
    signal clk : std_logic := '0';
    signal rst_bar : std_logic;
    signal d : std_logic_vector(7 downto 0);
    -- Observed signals
    signal serial_out : std_logic;
    signal valid : std_logic;
    signal sample_clk : std_logic;
    
begin
    
    -- Unit Under Test port map
    UUT : entity seq_sys
    port map (
        load => load,
        send => send,
        clk => clk,
        rst_bar => rst_bar,
        d => d,
        serial_out => serial_out,
        valid => valid,
        sample_clk => sample_clk
        );
    
    clk <= not clk after 10 ns;         -- free running clock, 20 ns period
    
    rst_bar <= '0', '1' after 40 ns;    -- power on reset
    
    load <= '0', '1' after 80 ns, '0' after 110 ns; -- 30 ns load pulse
    
    send <= '0', '1' after 120 ns, '0' after 150 ns; -- 30 ns send pulse
    
    d <= "01010101";                    -- parallel data to be loaded
    
end tb_architecture;


