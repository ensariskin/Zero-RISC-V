# Instruction Fetch (IF) Stage

The Instruction Fetch (IF) stage is responsible for fetching instructions from memory and managing the program counter. All components in this stage use a standardized timescale of `100 ps / 1 ps` for consistent simulation behavior.

## Components

### IF.v

Top-level module for the Instruction Fetch stage that integrates all IF components.

### PC_new.v

Enhanced program counter with the following capabilities:
- Branch prediction handling
- Jump and link register (JALR) instruction support
- Pipeline bubble (stall) handling
- Branch misprediction recovery

### PC.v

Basic program counter implementation that:
- Increments PC by 4 in normal operation
- Can load branch/jump target addresses

### Branch_predictor.v

Branch prediction unit that:
- Analyzes instruction opcodes to detect branch/jump instructions
- Predicts whether branches will be taken
- Helps reduce branch penalties in the pipeline

### ES_IMM_Decoder.v

Extracts and sign-extends immediate values from instructions for use in address calculations.

## Operation

1. The PC provides the address to fetch the instruction from memory
2. The Branch_predictor analyzes the fetched instruction to predict branch outcomes
3. The ES_IMM_Decoder extracts immediate values for branch target calculations
4. The next PC value is calculated based on prediction (PC+4 or branch target)
5. All relevant values are passed to the IF/ID pipeline register
