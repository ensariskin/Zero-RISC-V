# Dual Data Memory Region Setup for RV32I Core

This document describes the dual data memory region setup implemented for the RV32I core testbench.

## Memory Layout

The testbench now supports two separate data memory regions as defined in the RISC-V DV configuration:

- **Region 0**: 
  - Base Address: `0x80012048`
  - Size: 4KB (4096 bytes)
  - Address Range: `0x80012048` - `0x80013047`

- **Region 1**:
  - Base Address: `0x80013048` 
  - Size: 64KB (65536 bytes)
  - Address Range: `0x80013048` - `0x80023047`

## Architecture

### Components

1. **data_memory_selector.sv**: 
   - Located in `tb_modules/`
   - Routes memory requests to appropriate region based on address
   - Converts global addresses to local memory addresses
   - Provides error responses for invalid addresses

2. **Region Memory Instances**:
   - `region0_data_memory`: 4KB memory for region 0
   - `region1_data_memory`: 64KB memory for region 1
   - Both use the existing `memory_2rw_wb` module

3. **Modified dv_top.sv**:
   - Updated to instantiate memory selector and dual memories
   - Enhanced memory initialization with region-specific loading
   - Updated display messages and parameters

## Usage

### Loading Region Data

The testbench supports loading specific data into each region:

```bash
# Load data into both regions
+load_region_data +region0_hex=region_0.hex +region1_hex=region_1.hex
```

### Generating Region Data Files

Use the provided `region_extractor.py` script to extract region data from assembly files:

```bash
# Extract regions from assembly file
python scripts/region_extractor.py path/to/assembly_file.S

# This will generate:
# - region_0.hex (for region 0 data)
# - region_1.hex (for region 1 data)
```

### Complete Test Flow

1. **Generate Assembly Test**: Use RISC-V DV to generate test
2. **Extract Region Data**: Run region extractor on assembly file
3. **Run Simulation**: Use extracted hex files for data loading

```bash
# Example simulation command
vsim +load_hex +hex_file=test.hex +load_region_data +region0_hex=region_0.hex +region1_hex=region_1.hex
```

## Address Mapping

The memory selector automatically handles address translation:

- **Global Address** → **Local Address**
- `0x80012048` → `0x00000000` (Region 0)
- `0x80012049` → `0x00000001` (Region 0)
- `0x80013048` → `0x00000000` (Region 1)
- `0x80013049` → `0x00000001` (Region 1)

## Error Handling

- **Invalid Addresses**: Addresses outside both regions return error response
- **Debug Mode**: Enable `DEBUG_MEMORY_SELECTOR` define for detailed logging
- **Error Data**: Invalid accesses return `0xDEADBEEF` data pattern

## Integration with RISC-V DV

The dual memory setup is designed to work seamlessly with RISC-V DV generated tests:

1. **Assembly Generation**: RISC-V DV generates assembly with region references
2. **Data Extraction**: Region extractor creates separate hex files
3. **Test Execution**: Testbench loads and maps data correctly
4. **Verification**: Memory accesses are properly routed and traced

## Files Modified/Added

### New Files:
- `tb_modules/data_memory_selector.sv`
- `scripts/region_extractor.py`

### Modified Files:
- `testbench/riscv_dv_tb/dv_top.sv`
- `testbench/tb_modules.f`

## Configuration

Memory region parameters are configurable in `dv_top.sv`:

```systemverilog
parameter REGION0_SIZE = 32'h1000;    // 4KB region 0
parameter REGION1_SIZE = 32'h10000;   // 64KB region 1  
parameter REGION0_BASE_ADDR = 32'h80012048;
parameter REGION1_BASE_ADDR = 32'h80013048;
```

These should match the configuration in `riscv_instr_gen_config.sv`:

```systemverilog
mem_region_t mem_region[$] = '{
  '{name:"region_0", size_in_bytes: 4096,      xwr: 3'b111},
  '{name:"region_1", size_in_bytes: 4096 * 16, xwr: 3'b111}
};
```
