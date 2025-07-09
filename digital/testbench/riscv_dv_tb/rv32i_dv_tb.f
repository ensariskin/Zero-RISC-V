# RV32I Core RISC-V DV Testbench file list
# Updated for proper module inclusion and simulation compatibility

# Testbench modules  
D:/Ensar/Tez/RV32I/digital/testbench/tb_modules/data_organizer.sv
D:/Ensar/Tez/RV32I/digital/testbench/tb_modules/memory_2rw_wb.v
D:/Ensar/Tez/RV32I/digital/testbench/tb_modules/tracer.v

# Wishbone adapters
D:/Ensar/Tez/RV32I/digital/testbench/riscv_dv_tb/rv32i_inst_wb_adapter.sv
D:/Ensar/Tez/RV32I/digital/testbench/riscv_dv_tb/rv32i_data_wb_adapter.sv
D:/Ensar/Tez/RV32I/digital/testbench/riscv_dv_tb/rv32i_tracer.sv

# Core modules (include your processor file list)
-f D:/Ensar/Tez/RV32I/digital/sim/processor.f

# Top testbench
D:/Ensar/Tez/RV32I/digital/testbench/riscv_dv_tb/dv_top.sv

# Simulation defines for compatibility
+define+SIMULATION
+define+RISCV_DV_TB

# Include directories  
+incdir+D:/Ensar/Tez/RV32I/digital/testbench/tb_modules
+incdir+D:/Ensar/Tez/RV32I/digital/testbench/riscv_dv_tb
