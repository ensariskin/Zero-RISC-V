# Write Back (WB) Stage

The Write Back (WB) stage is the final stage in the pipeline, responsible for writing results back to the register file. All components in this stage use a standardized timescale of `100 ps / 1 ps` for consistent simulation behavior.

## Components

### WB.v

The Write Back module that:
- Selects the appropriate data source to write back to registers
- Generates final register write signals
- Forwards write-back data to earlier pipeline stages for hazard resolution

## Operation

The WB stage selects between several possible data sources:
1. ALU result from the EX stage
2. Data loaded from memory in the MEM stage
3. PC+4 for link instructions (JAL, JALR)
4. Other calculated values based on instruction type

## Key Features

- Data source selection via multiplexers
- Register write control signal generation
- Write-back data forwarding to resolve data hazards
- Final processing of control signals
- Single-cycle write-back operation
- Uses consistent `100 ps / 1 ps` timescale for accurate simulation

## Data Selection

The WB stage uses a multiplexer to select the final result from:
- FU_i: ALU result from EX stage
- MEM_result_i: Data from memory
- PCplus_i: PC+4 value (for JAL/JALR)
- Zero (for special cases)

## Register Write Control

Control signals from previous stages determine:
- Whether a register write is performed (WE_WB)
- Which register to write to (RD_WB)
- What value is written back
