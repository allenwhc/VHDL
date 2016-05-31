SetActiveLib -work
comp -include "$dsn\src\right_shift_reg.vhd" 
comp -include "$dsn\src\TestBench\right_shift_reg_TB.vhd" 
asim +access +r TESTBENCH_FOR_right_shift_reg 
wave 
wave -noreg d
wave -noreg load
wave -noreg en_shift
wave -noreg clk
wave -noreg rst_bar
wave -noreg serial_out
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\right_shift_reg_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_right_shift_reg 
