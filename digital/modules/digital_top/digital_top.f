# RISC-V RV32I Processor Compilation Design File List
# Using absolute paths - no environment variables required

# Define the compilation order to respect dependencies

# 1. Common/shared modules
-f D:/Ensar/Tez/RV32I/digital/modules/common/common.f

# 2. Pipeline stages in execution order
-f D:/Ensar/Tez/RV32I/digital/modules/fetch_stage/fetch_stage.f
-f D:/Ensar/Tez/RV32I/digital/modules/decode_stage/decode_stage.f
-f D:/Ensar/Tez/RV32I/digital/modules/execute/execute.f
-f D:/Ensar/Tez/RV32I/digital/modules/mem/mem.f
-f D:/Ensar/Tez/RV32I/digital/modules/write_back/write_back.f

# 3. Pipeline registers
-f D:/Ensar/Tez/RV32I/digital/modules/pipeline_register/pipeline_register.f

# 4. Pipeline hazard control
-f D:/Ensar/Tez/RV32I/digital/modules/hazard/hazard.f

# Top-level module files
D:/Ensar/Tez/RV32I/digital/modules/digital_top/src/rv32i_core.sv
D:/Ensar/Tez/RV32I/digital/modules/digital_top/src/rv32i_core_wb.sv