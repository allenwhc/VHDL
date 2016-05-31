MODEL
MODEL_VERSION "1.0";
DESIGN "seq";
DATE "Tue Apr 08 14:16:21 2014";
VENDOR "Lattice Semiconductor Corporation";
PROGRAM "STAMP Model Generator";

/* port name and type */
INPUT clk;
INPUT d_0;
INPUT d_1;
INPUT d_2;
INPUT d_3;
INPUT d_4;
INPUT d_5;
INPUT d_6;
INPUT d_7;
INPUT load;
INPUT rst_bar;
INPUT send;
OUTPUT sample_clk;
OUTPUT serial_out;
OUTPUT valid;

/* timing arc definitions */
clk_sample_clk_delay: DELAY clk sample_clk;
clk_sample_clk_delay: DELAY clk sample_clk;
clk_sample_clk_delay: DELAY clk sample_clk;
clk_valid_delay: DELAY clk valid;
clk_valid_delay: DELAY clk valid;
clk_serial_out_delay: DELAY clk serial_out;

/* timing check arc definitions */
load_clk_setup: SETUP(POSEDGE) load clk;
load_clk_hold: HOLD(POSEDGE) load clk;
d_0_clk_setup: SETUP(POSEDGE) d_0 clk;
d_0_clk_hold: HOLD(POSEDGE) d_0 clk;
d_1_clk_setup: SETUP(POSEDGE) d_1 clk;
d_1_clk_hold: HOLD(POSEDGE) d_1 clk;
d_2_clk_setup: SETUP(POSEDGE) d_2 clk;
d_2_clk_hold: HOLD(POSEDGE) d_2 clk;
d_3_clk_setup: SETUP(POSEDGE) d_3 clk;
d_3_clk_hold: HOLD(POSEDGE) d_3 clk;
d_4_clk_setup: SETUP(POSEDGE) d_4 clk;
d_4_clk_hold: HOLD(POSEDGE) d_4 clk;
d_5_clk_setup: SETUP(POSEDGE) d_5 clk;
d_5_clk_hold: HOLD(POSEDGE) d_5 clk;
d_6_clk_setup: SETUP(POSEDGE) d_6 clk;
d_6_clk_hold: HOLD(POSEDGE) d_6 clk;
d_7_clk_setup: SETUP(POSEDGE) d_7 clk;
d_7_clk_hold: HOLD(POSEDGE) d_7 clk;
send_clk_setup: SETUP(POSEDGE) send clk;
send_clk_hold: HOLD(POSEDGE) send clk;

ENDMODEL
