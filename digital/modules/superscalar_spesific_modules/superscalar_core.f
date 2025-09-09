# Superscalar specific modules file list
# Top level superscalar core
../superscalar_spesific_modules/src/rv32i_superscalar_core.sv

# Multi-decode stage and register file
../superscalar_spesific_modules/src/multi_decode_stage.sv
../superscalar_spesific_modules/src/multi_port_register_file.sv
../superscalar_spesific_modules/src/register_alias_table.sv
../superscalar_spesific_modules/src/triple_priority_encoder.sv
../superscalar_spesific_modules/src/triple_priority_encoder_ver2.sv
../superscalar_spesific_modules/src/triple_priority_encoder_ver3.sv
../superscalar_spesific_modules/src/tb_register_alias_table.sv

# Include fetch and buffer modules
../superscalar_spesific_modules/src/multi_fetch.sv
../superscalar_spesific_modules/src/instruction_buffer.sv  
../superscalar_spesific_modules/src/fetch_buffer_top.sv


# Include supporting modules
../superscalar_spesific_modules/src/pc_ctrl_super.sv
../superscalar_spesific_modules/src/jump_controller_super.sv
../superscalar_spesific_modules/src/branch_predictor_super.sv
