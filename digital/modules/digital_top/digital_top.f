# RISC-V RV32I Processor Compilation Design File List
# Using absolute paths - no environment variables required

# Define the compilation order to respect dependencies

# 1. Common/shared modules
-F ../common/common.f

# 2. Pipeline stages in execution order
-F ../fetch_stage/fetch_stage.f
-F ../decode_stage/decode_stage.f
-F ../execute/execute.f
-F ../mem/mem.f
-F ../write_back/write_back.f

# 3. Pipeline hazard control
-F ../hazard/hazard.f

# Top-level module files
/src/rv32i_core.sv
/src/rv32i_core_wb.sv
