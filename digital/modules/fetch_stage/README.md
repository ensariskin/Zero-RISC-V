# Instruction Fetch Stage

The Instruction Fetch stage implements the first pipeline stage of the RISC-V processor, responsible for instruction retrieval from memory and program counter management. This stage provides the foundation for the 5-stage pipeline architecture.

## Module Components

### fetch_stage.sv

Top-level fetch stage integration module providing:
- Instruction memory interface management
- Component instantiation and interconnection
- Signal routing between fetch stage components
- Pipeline stage output generation

### program_counter_ctrl.sv

Program counter control unit implementing:
- Sequential program counter increment logic
- Branch target address calculation
- Jump instruction target address handling
- JALR (Jump and Link Register) instruction support
- AUIPC (Add Upper Immediate to PC) instruction handling
- Pipeline stall and bubble management
- Branch misprediction recovery mechanisms
- PC+4 calculation for link register operations

### branch_predictor.sv

Branch prediction unit featuring:
- Instruction opcode analysis for branch/jump detection
- Static branch prediction algorithm implementation
- JALR instruction identification and special handling
- Branch penalty reduction optimization
- Prediction accuracy monitoring capabilities

### early_stage_immediate_decoder.sv

Immediate value extraction and processing unit:
- Instruction immediate field decoding
- Sign extension for various immediate formats
- Early immediate value availability for address calculation
- Support for all RISC-V immediate encoding formats

## Stage Operation

The fetch stage executes the following sequence each clock cycle:

1. **Instruction Address Generation**: Program counter provides memory address for instruction fetch
2. **Instruction Retrieval**: Interface with instruction memory to obtain instruction word
3. **Branch Prediction**: Analysis of instruction to predict control flow changes
4. **Immediate Decoding**: Extraction and processing of immediate values for address calculation
5. **Next PC Calculation**: Determination of subsequent program counter value based on prediction
6. **Pipeline Handoff**: Transfer of instruction and control information to IF/ID pipeline register

## Control Signals

### Output Signals
- **Predicted_MPC**: Branch or jump prediction indication signal
- **JALR**: Jump and Link Register instruction identification
- **IMM**: Sign-extended immediate value for address calculations
- **PCplus**: PC+4 value for sequential execution and return address storage

### Internal Control
- **Branch Target**: Calculated branch destination address
- **Jump Target**: Calculated jump destination address
- **Stall Control**: Pipeline stall management for hazard handling
- **Prediction Valid**: Branch prediction validity indication

## Performance Optimization

The fetch stage incorporates several performance enhancement mechanisms:

- **Static Branch Prediction**: Reduces average branch penalty through prediction
- **Early Address Calculation**: Minimizes critical path delay for target address generation
- **JALR Optimization**: Specialized handling for register-based jump instructions
- **Pipeline Efficiency**: Maintains single-cycle instruction fetch under normal conditions
- **Stall Minimization**: Efficient bubble handling to reduce performance impact
- **Prediction Recovery**: Fast recovery mechanisms for branch mispredictions

## Memory Interface

The instruction fetch stage interfaces with instruction memory through:
- **Address Bus**: 32-bit instruction address output
- **Data Bus**: 32-bit instruction word input
- **Control Signals**: Memory enable and timing control
- **Ready Signal**: Memory response indication for multi-cycle operations
