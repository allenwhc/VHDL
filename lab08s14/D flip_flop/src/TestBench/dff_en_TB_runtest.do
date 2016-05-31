SetActiveLib -work
comp -include "$dsn\src\flipflop.vhd" 
comp -include "$dsn\src\TestBench\dff_en_TB.vhd" 
asim +access +r TESTBENCH_FOR_dff_en 
wave 
wave -noreg d
wave -noreg clk
wave -noreg en
wave -noreg rst_bar
wave -noreg q
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\dff_en_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_dff_en 
