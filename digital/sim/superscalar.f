//////////////////////////////////////////////////////////////////////////////////
// RV32I Superscalar Core Simulation Script
// 
// This script provides simulation commands for the superscalar testbench
//////////////////////////////////////////////////////////////////////////////////

# Superscalar testbench filelist
+incdir+../testbench/include
-F ../modules/common/common.f
-F ../modules/fetch_stage/fetch_stage.f
-F ../modules/decode_stage/decode_stage.f
-F ../modules/execute/execute.f
-F ../modules/mem/mem.f
-F ../modules/write_back/write_back.f
-F ../modules/hazard/hazard.f
-F ../modules/digital_top/digital_top.f
-F ../modules/superscalar_spesific_modules/superscalar_core.f
-F ../testbench/tb_modules_superscalar.f

# Define macros for simulation
+define+SIM_MODE
+define+SUPERSCALAR_MODE

# Set simulation parameters  
+hex_file=../hex/init.hex
+region0_base=80000000
+region1_base=80001000
