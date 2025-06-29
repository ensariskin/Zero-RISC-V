# Fetch Stage

The Fetch Stage is responsible for retrieving instructions from memory and managing the program counter. This stage forms the first part of the 5-stage RISC-V pipeline.

## Components

### fetch_stage.sv

Top-level module for the Fetch Stage that integrates all fetch components and interfaces with the instruction memory.

### program_counter_ctrl.sv

Enhanced program counter control with the following capabilities:
- Improved branch prediction handling
- Enhanced Jump and Link Register (JALR) instruction support with additional prediction path
- AUIPC instruction support for PC-relative addressing
- Pipeline bubble (stall) handling with minimal performance impact
- Branch misprediction recovery with optimized logic
- PC+immediate calculation enhancement for improved accuracy
- Framework for potential PC value caching in jump operations

### branch_predictor.sv

Branch prediction unit that:
- Analyzes instruction opcodes to detect branch/jump instructions
- Predicts whether branches will be taken
- Identifies JALR instructions for special handling
- Helps reduce branch penalties in the pipeline

### early_stage_immediate_decoder.sv

Extracts and sign-extends immediate values from instructions for:
- Branch/jump target address calculation
- Early handling of immediate values in the pipeline

## Operation

1. The program counter provides the address to fetch the instruction from memory
2. The branch predictor analyzes the fetched instruction to predict branch/jump outcomes
3. The immediate decoder extracts immediate values for target address calculations
4. The next PC value is calculated based on prediction (sequential or branch target)
5. All relevant values are passed to the IF/ID pipeline register

## Signals

- **Predicted_MPC**: Indicates when a branch or jump is predicted taken
- **JALR**: Special signal for handling Jump And Link Register instructions
- **IMM**: Extended immediate value for address calculations
- **PCplus**: PC+4 value for sequential execution and link register storage

## Control Flow

The fetch stage implements enhanced branch prediction to minimize branch penalties. It features:
- Unconditional jumps (JAL): Always predicted taken with optimized PC calculation
- Conditional branches: Predicted using static prediction with improved target calculation
- Register-based jumps (JALR): Enhanced handling with additional prediction path
- AUIPC support: Proper handling of PC-relative addressing
- PC value preservation: Improved mechanics for storing and retrieving PC+4
- Potential performance optimizations: Framework for future PC value caching
- Comprehensive error detection and recovery mechanisms
