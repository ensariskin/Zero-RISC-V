# Detailed Superscalar RISC-V Core Hierarchy

This document outlines the hierarchical structure of the 3-way Superscalar RISC-V processor, detailing modules, their functions, and sub-components.

## Top Level: `rv32i_superscalar_core`
The top-level core module that integrates the four main pipeline stages.

### 1. Fetch Stage: `fetch_buffer_top`
Responsible for fetching instructions, handling branch prediction, and buffering instructions for the decode stage.

*   **`multi_fetch`**: Fetches up to 5 instructions in parallel.
    *   **`early_stage_immediate_decoder`** (x5): Decodes immediates early for branch target calculation.
        *   `parametric_mux`: Utility for immediate selection.
    *   **`jump_controller_super`**: Manages branch prediction and jump logic.
        *   **`tournament_predictor`**: Complex branch predictor using local and global history.
            *   **`gshare_predictor_super`**: Global history predictor (GShare).
            *   **`branch_predictor_super`** (Bimodal): Simple saturating counter predictor.
            *   *Top-level logic for Chooser (Tournament) selection.*
        *   **`jalr_predictor`**: Predictor for JALR instructions (indirect jumps).
    *   **`pc_ctrl_super`**: Computes the next PC based on predictions and corrections.
        *   `parametric_mux`: Utility for PC selection.

*   **`instruction_buffer_new`**: A circular buffer (FIFO) decoupling Fetch and Decode.
    *   *Leaf module detailing buffer logic and pointers.*

### 2. Issue Stage: `issue_stage`
Decodes instructions and renames registers to eliminate false dependencies (WAW, WAR).

*   **`rv32i_decoder`** (x3): Decodes 3 instructions in parallel.
    *   *Leaf module for instruction decoding.*
*   **`register_alias_table` (RAT)**: Maps architectural registers to physical registers.
    *   **`circular_buffer_3port`** (`free_address_buffer`): Manages the free list of physical registers.
    *   **`brat_circular_buffer`**: Branch Resolution Alias Table. Handles snapshots of RAT for branch misprediction recovery.
    *   **`circular_buffer_3port`** (`lsq_address_buffer`): *Likely used for LSQ allocation tracking (implied context).*

### 3. Dispatch Stage: `dispatch_stage`
Manages out-of-order execution, instruction ordering, and data dependencies.

*   **`reorder_buffer` (ROB)**: Ensures in-order commit of instructions.
    *   *Leaf module managing ROB entries, commit logic, and misprediction flushes.*
*   **`reservation_station`** (x3): Holds instructions waiting for operands.
    *   *Leaf module managing operand readiness and issue to execution.*
*   **`multi_port_register_file`**: Physical Register File (PRF).
    *   *Leaf module providing 6 read ports and 3 write ports.*
*   **`lsq_simple_top`**: Load/Store Queue.
    *   **`priority_encoder`**: Used for eager misprediction flushing to find the first invalid entry.
    *   *Contains internal circular buffer logic for Load/Store ordering and forwarding.*

### 4. Execute Stage: `superscalar_execute_stage`
Contains functional units for instruction execution.

*   **`function_unit_alu_shifter`** (x3): General purpose execution unit.
    *   **`alu`**: Arithmetic Logic Unit.
        *   `arithmetic_unit`
        *   `logical_unit`
        *   `parametric_mux`
    *   **`shifter`**: Barrel shifter.
        *   `parametric_mux`
    *   `parametric_mux`: Output selection.
*   **`Branch_Controller`** (x3): Handling branch outcome resolution in Execute stage.
    *   `parametric_mux`

## Common/Utility Modules
*   **`parametric_mux`**: generic multiplexer used extensively.
*   **`circular_buffer_3port`**: generic circular buffer used in RAT.
