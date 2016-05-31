SetActiveLib -work
comp -include "$dsn\src\counter.vhd" 
comp -include "$dsn\src\TestBench\counter_TB.vhd" 
asim +access +r TESTBENCH_FOR_counter 
wave 
wave -noreg clear
wave -noreg en_count
wave -noreg clk
wave -noreg rst_bar
wave -noreg q
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\counter_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_counter 
