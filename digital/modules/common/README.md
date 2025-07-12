# Common Hardware Components

This directory contains fundamental hardware building blocks utilized throughout the RISC-V processor implementation. All components are implemented in SystemVerilog with modern design practices including parameterization, strong typing, and standardized interfaces.

## Component Library

### parametric_mux.sv

Parameterizable multiplexer implementation featuring:
- Configurable data width and input count parameters
- SystemVerilog logic type for improved type safety
- Utilized for data path selection and control signal routing
- Optimized for synthesis and timing closure

### parametric_decoder.sv

Flexible decoder component providing:
- Binary to one-hot output conversion
- Configurable input and output width parameters
- Support for enable/disable control signals
- Used in control logic and address decoding

### dff_block_negedge_write.sv

D Flip-Flop register block implementation:
- Negative edge triggered write operation
- Standardized interface definition
- Employed in pipeline register stages
- SystemVerilog enhanced for clarity and reliability

### dff_sync_reset_negedge_write.sv

Synchronous reset D Flip-Flop implementation:
- Controlled synchronous reset functionality
- Negative edge write timing for pipeline consistency
- Modern SystemVerilog parameter handling
- Used in state machines and control registers

### RCA.sv (Ripple Carry Adder)

Multi-bit ripple carry adder providing:
- Parameterizable bit width configuration
- Full carry chain implementation
- Utilized for address calculation and basic arithmetic
- SystemVerilog logic type for all signal interfaces

### CSA.sv (Carry Save Adder)

Optimized carry save adder design featuring:
- Reduced carry propagation delay characteristics
- Multi-operand addition capability
- Enhanced arithmetic performance
- Used in complex computational units

### FA.sv (Full Adder)

Single-bit full adder implementation:
- Three-input addition (A, B, Carry-in)
- Sum and carry-out generation
- Building block for larger arithmetic structures
- Optimized gate-level implementation

### HA.sv (Half Adder)

Basic two-input adder component:
- Two single-bit input addition
- Sum and carry output generation
- Fundamental component for adder construction
- Minimal gate delay implementation

## Design Application

These components are integrated throughout the processor architecture:

- **Data Path Selection**: Multiplexers route operands and results between pipeline stages
- **Control Logic**: Decoders generate control signals from instruction encoding
- **Pipeline Registers**: Flip-flops maintain state and data between pipeline stages
- **Arithmetic Operations**: Adder components perform address calculation and arithmetic functions
- **State Management**: Register components maintain processor state and control information

## Design Principles

The component library adheres to established design standards:

- **SystemVerilog Implementation**: Modern HDL features for improved design clarity
- **Parameterizable Architecture**: Configurable components for design flexibility
- **Standardized Interfaces**: Consistent port naming and signal conventions
- **Reusable Design Blocks**: Minimized code duplication through component reuse
- **Type Safety**: Explicit SystemVerilog logic types for signal integrity
- **Synthesis Optimization**: Components optimized for FPGA and ASIC implementation
- **Verification Readiness**: Well-defined interfaces for comprehensive testing
- **Documentation Standards**: Complete component documentation for maintainability
