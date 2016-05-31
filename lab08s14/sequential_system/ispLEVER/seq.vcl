[DEVICE]

Family = M4A5;
PartType = M4A5-64/32;
Package = 44PLCC;
PartNumber = M4A5-64/32-10JC;
Speed = -10;
Operating_condition = COM;
EN_Segment = NO;
Pin_MC_1to1 = NO;
Voltage = 5.0;

[REVISION]

RCS = "$Revision: 1.2 $";
Parent = m4a5.lci;
SDS_file = m4a5.sds;
Design = seq.tt4;
Rev = 0.01;
DATE = 4/8/14;
TIME = 14:11:10;
Type = TT2;
Pre_Fit_Time = 1;
Source_Format = EDIF;

[IGNORE ASSIGNMENTS]

Pin_Assignments = NO;
Pin_Keep_Block = NO;
Pin_Keep_Segment = NO;
Group_Assignments = NO;
Macrocell_Assignments = NO;
Macrocell_Keep_Block = NO;
Macrocell_Keep_Segment = NO;
Pin_Reservation = NO;
Timing_Constraints = NO;
Block_Reservation = NO;
Segment_Reservation = NO;
Ignore_Source_Location = NO;
Ignore_Source_Optimization = NO;
Ignore_Source_Timing = NO;

[CLEAR ASSIGNMENTS]

Pin_Assignments = NO;
Pin_Keep_Block = NO;
Pin_Keep_Segment = NO;
Group_Assignments = NO;
Macrocell_Assignments = NO;
Macrocell_Keep_Block = NO;
Macrocell_Keep_Segment = NO;
Pin_Reservation = NO;
Timing_Constraints = NO;
Block_Reservation = NO;
Segment_Reservation = NO;
Ignore_Source_Location = NO;
Ignore_Source_Optimization = NO;
Ignore_Source_Timing = NO;

[BACKANNOTATE NETLIST]

Netlist = VERILOG;
Delay_File = SDF;
Generic_VCC = ;
Generic_GND = ;

[BACKANNOTATE ASSIGNMENTS]

Pin_Assignment = NO;
Pin_Block = NO;
Pin_Macrocell_Block = NO;
Routing = NO;

[GLOBAL PROJECT OPTIMIZATION]

Balanced_Partitioning = YES;
Spread_Placement = YES;
Max_Pin_Percent = 100;
Max_Macrocell_Percent = 100;
Max_Inter_Seg_Percent = 100;
Max_Seg_In_Percent = 100;
Max_Blk_In_Percent = 100;

[FITTER REPORT FORMAT]

Fitter_Options = YES;
Pinout_Diagram = NO;
Pinout_Listing = YES;
Detailed_Block_Segment_Summary = YES;
Input_Signal_List = YES;
Output_Signal_List = YES;
Bidir_Signal_List = YES;
Node_Signal_List = YES;
Signal_Fanout_List = YES;
Block_Segment_Fanin_List = YES;
Prefit_Eqn = YES;
Postfit_Eqn = YES;
Page_Break = YES;

[OPTIMIZATION OPTIONS]

Logic_Reduction = YES;
Max_PTerm_Split = 16;
Max_PTerm_Collapse = 16;
XOR_Synthesis = YES;
Node_Collapse = Yes;
DT_Synthesis = Yes;

[FITTER GLOBAL OPTIONS]

Run_Time = 0;
Set_Reset_Dont_Care = NO;
In_Reg_Optimize = YES;
Clock_Optimize = NO;
Conf_Unused_IOs = OUT_LOW;

[POWER]
Powerlevel = Low, High;
Default = High;
Type = GLB;

[HARDWARE DEVICE OPTIONS]
Zero_Hold_Time = No;
Signature_Word = 0;
Pull_up = No;
Out_Slew_Rate = FAST, SLOW, 0;
Device_max_fanin = 33;
Device_max_pterms = 20;
Usercode_Format = Hex;

[PIN RESERVATIONS]
layer = OFF;

[LOCATION ASSIGNMENT]

Layer = OFF
serial_out = OUTPUT,19,1,-;
sample_clk = OUTPUT,26,2,-;
valid = OUTPUT,24,2,-;
u1_cnt_int_count_0_ = NODE,*,0,-;
u1_cnt_int_count_1_ = NODE,*,2,-;
u1_cnt_int_count_3_ = NODE,*,2,-;
u1_cnt_int_count_5_ = NODE,*,0,-;
u1_cnt_int_count_4_ = NODE,*,0,-;
u1_cnt_int_count_2_ = NODE,*,0,-;
u2_q = NODE,*,1,-;
u1_cnt_int_count_7_ = NODE,*,2,-;
u1_cnt_int_count_6_ = NODE,*,0,-;
u1_q_3_ = NODE,*,0,-;
u1_cnt_int_un5_count_27_n = NODE,*,3,-;
u1_cnt_int_count_17_ = NODE,*,0,-;
u1_n_109_n = NODE,*,3,-;
u1_n_85_n = NODE,*,3,-;
u1_n_58_n = NODE,*,1,-;
u1_cnt_int_count_31_ = NODE,*,2,-;
u1_cnt_int_count_30_ = NODE,*,2,-;
u1_cnt_int_count_29_ = NODE,*,0,-;
u1_cnt_int_count_28_ = NODE,*,0,-;
u1_cnt_int_count_27_ = NODE,*,0,-;
u1_cnt_int_count_26_ = NODE,*,0,-;
u1_cnt_int_count_25_ = NODE,*,3,-;
u1_cnt_int_count_24_ = NODE,*,0,-;
u1_cnt_int_count_23_ = NODE,*,3,-;
u1_cnt_int_count_22_ = NODE,*,3,-;
u1_cnt_int_count_21_ = NODE,*,0,-;
u1_cnt_int_count_20_ = NODE,*,3,-;
u1_cnt_int_count_19_ = NODE,*,0,-;
u1_cnt_int_count_18_ = NODE,*,0,-;
u1_cnt_int_count_13_ = NODE,*,2,-;
u1_cnt_int_count_12_ = NODE,*,3,-;
u1_cnt_int_count_11_ = NODE,*,2,-;
u1_cnt_int_count_10_ = NODE,*,2,-;
u1_cnt_int_count_9_ = NODE,*,2,-;
u1_cnt_int_count_8_ = NODE,*,2,-;
RN_serial_out = NODE,-1,1,-;
u0_q1_6_ = NODE,*,1,-;
u0_q1_5_ = NODE,*,1,-;
u0_q1_4_ = NODE,*,1,-;
u0_q1_3_ = NODE,*,1,-;
u0_q1_2_ = NODE,*,1,-;
u0_q1_1_ = NODE,*,1,-;
u0_q1_7_ = NODE,*,1,-;
u1_cnt_int_un5_count_28_n = NODE,*,2,-;
u1_cnt_int_un5_count_26_n = NODE,*,0,-;
u1_cnt_int_count_16_ = NODE,*,3,-;
u1_cnt_int_count_15_ = NODE,*,3,-;
u1_cnt_int_count_14_ = NODE,*,2,-;
clk = INPUT,11,-,-;
