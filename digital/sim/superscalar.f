//////////////////////////////////////////////////////////////////////////////////
// RV32I Superscalar Core Simulation Script
// 
// This script provides simulation commands for the superscalar testbench
//////////////////////////////////////////////////////////////////////////////////

# Superscalar testbench filelist
+incdir+../testbench/include
-F ../modules/digital_top/digital_top.f
-F ../modules/superscalar_spesific_modules/top.f
-F ../testbench/tb_modules_superscalar.f


# Define macros for simulation
+define+SIM_MODE
+define+SUPERSCALAR_MODE

# Set simulation parameters  
+hex_file=../hex/init.hex
+region0_base=80000000
+region1_base=80001000
