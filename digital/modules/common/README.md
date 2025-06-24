# Common Components

This directory contains common hardware building blocks that are used throughout the processor design. All components have been modernized to SystemVerilog for improved typing, interfaces, and parameterization.

## Components

### parametric_mux.sv

A modernized parameterizable multiplexer that:
- Supports variable data widths with SystemVerilog typing
- Supports variable number of inputs
- Is used for data selection throughout the design
- Features improved interface clarity

### parametric_decoder.sv

A flexible decoder module that:
- Converts encoded inputs to one-hot or binary outputs
- Supports variable input and output widths
- Includes parameterized configurations

### dff_block_negedge_write.sv

Enhanced D Flip-Flop block with:
- Standardized naming and interfaces
- Optimized for negedge write operations
- Used in pipeline registers throughout the design
- Features SystemVerilog logic type for improved type safety

### dff_sync_reset_negedge_write.sv

Advanced D Flip-Flop with synchronous reset:
- Provides controlled reset functionality
- Uses negedge write timing for consistent operation
- Features improved parameter handling
- Implements modern SystemVerilog best practices

### RCA.sv (Ripple Carry Adder)

Implements multi-bit binary addition with:
- SystemVerilog logic typed inputs and outputs
- Used for address calculation and arithmetic operations
- Building block for more complex arithmetic units
- Improved parameterization

### CSA.sv (Carry Save Adder)

An optimized adder design for:
- Higher performance multi-operand addition
- Used in more complex arithmetic operations
- Reduces carry propagation delay
- Enhanced interface clarity

### FA.sv (Full Adder)

Basic building block that:
- Adds three single-bit inputs (A, B, Carry-in)
- Produces Sum and Carry-out
- Used as a component in larger adder structures
- Modernized with SystemVerilog

### HA.sv (Half Adder)

Simplest adder unit that:
- Adds two single-bit inputs (A, B)
- Produces Sum and Carry-out
- Used in the construction of Full Adders
- Updated with consistent naming conventions

## Usage

These common components are instantiated throughout the processor design:
- Multiplexers for data and control path selection
- Flip-flops for pipeline registers and state storage
- Adders for arithmetic operations and address calculations

## Design Philosophy

The common components follow these principles:
- Modern SystemVerilog architecture with improved typing
- Parameterizable designs for maximum flexibility
- Standardized naming conventions throughout all components
- Reusable modules to reduce code duplication
- Well-defined interfaces with explicit port declarations
- Optimized for specific use cases where needed
- Consistent use of SystemVerilog `logic` type for better type safety
- Thoroughly verified individual components
- Comprehensive commenting for improved maintainability
