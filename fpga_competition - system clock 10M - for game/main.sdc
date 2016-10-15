#************************************************************
# THIS IS A WIZARD-GENERATED FILE.                           
#
# Version 10.0 Build 218 06/27/2010 SJ Web Edition
#
#************************************************************

# Copyright (C) 1991-2010 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.



# Clock constraints

create_clock -name "clock" -period 20ns [get_ports {clock}]
#derive_clock_uncertainty  -name "clock"

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

set_input_delay -clock clock -max 2 [all_inputs]

set_input_delay -clock clock -min 0 [all_inputs]
set_output_delay -clock clock 2 [all_outputs]
# tsu/th constraints

# tco constraints

# tpd constraints

#set_fix_hold "clock"
#compile -only_design_rule -incremental_mapping
# report_ucp -summary
#set_clock_uncertainty
#derive_pll_clocks