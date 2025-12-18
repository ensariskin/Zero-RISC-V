//////////////////////////////////////////////////////////////////////////////////
// RV32I Superscalar Core Testbench Module Filelist
// 
// This file contains all the modules required for the superscalar testbench
//////////////////////////////////////////////////////////////////////////////////

// Common modules
tb_modules/data_memory_selector.sv
tb_modules/memory_2rw_old.sv
tb_modules/memory_2rw_wb.v
tb_modules/memory_3rw.sv
tb_modules/memory_5rw.sv

tb_modules/memory_3rw_unaligned.sv

// Superscalar-specific testbench modules
tb_modules/rv32i_inst_wb_adapter.sv
tb_modules/rv32i_superscalar_data_wb_adapter.sv
tb_modules/tb_multi_port_register_file.sv
tb_modules/tb_register_alias_table.sv
tb_modules/tb_fetch_buffer_top.sv

tb_modules/tracer_3port.sv
tb_modules/pipeline_performance_analyzer.sv

tb_modules/ras_monitor.sv
#tb_modules/bp_logger_multi.sv

// Superscalar testbench top
riscv_dv_tb/dv_top_superscalar.sv


