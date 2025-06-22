# Common Components

This directory contains common hardware building blocks that are used throughout the processor design. All components use a standardized timescale of `100 ps / 1 ps` for consistent simulation behavior.

## Components

### parametric_mux.v

A parameterizable multiplexer that:
- Supports variable data widths
- Supports variable number of inputs
- Is used for data selection throughout the design

### D_FF_block.v and D_FF_async_rst.v

Basic D Flip-Flop blocks that:
- Serve as storage elements for pipeline registers
- Provide synchronous data transfer between pipeline stages
- Include reset capability (synchronous or asynchronous variants)
- Feature parameterized data width for flexibility

### dff_block.v

Enhanced D Flip-Flop block with:
- Additional control features
- Used in newer parts of the design for improved functionality
- May include clock gating or other power-saving features

### RCA.v (Ripple Carry Adder)

Implements multi-bit binary addition with:
- Carry propagation
- Used for address calculation and arithmetic operations
- Building block for more complex arithmetic units

### CSA.v (Carry Save Adder)

An optimized adder design for:
- Higher performance multi-operand addition
- Used in more complex arithmetic operations
- Reduces carry propagation delay

### FA.v (Full Adder)

Basic building block that:
- Adds three single-bit inputs (A, B, Carry-in)
- Produces Sum and Carry-out
- Used as a component in larger adder structures

### HA.v (Half Adder)

Simplest adder unit that:
- Adds two single-bit inputs (A, B)
- Produces Sum and Carry-out
- Used in the construction of Full Adders

## Usage

These common components are instantiated throughout the processor design:
- Multiplexers for data and control path selection
- Flip-flops for pipeline registers and state storage
- Adders for arithmetic operations and address calculations

## Design Philosophy

The common components follow these principles:
- Parameterizable designs for flexibility
- Reusable modules to reduce code duplication
- Well-defined interfaces for easy integration
- Optimized for specific use cases where needed
- Consistent timescale (`100 ps / 1 ps`) for reliable simulation behavior
- Thoroughly verified individual components
