# DSIM simulation script for pc_ctrl_super testbench
# This will help identify logic errors in the PC control module

# File list for PC control testbench
+incdir+../modules/common/src
../modules/common/src/parametric_mux.sv
../modules/superscalar_spesific_modules/fetch_stage/pc_ctrl_super.sv
../modules/superscalar_spesific_modules/fetch_stage/tb_pc_ctrl_super_simple.sv

# Simulation options
+define+SIM_MODE
+timescale=1ns/1ns