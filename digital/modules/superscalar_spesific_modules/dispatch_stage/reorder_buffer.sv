`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: rob_circular_buffer
//
// Description:
//     Circular buffer for Reorder Buffer (ROB) implementation
//     Manages out-of-order execution with in-order commit
//
// Features:
//     - Allocation interface: Up to 3 simultaneous allocations
//     - CDB interface: Update data, tag, executed, and exception flags
//     - Read interface: 6 read ports for reservation stations (3 insts × 2 operands)
//     - Commit interface: Up to 3 in-order commits per cycle
//     - Head/Tail pointers for circular buffer management
//
// Buffer Entry Structure:
//     - data[31:0]: Result data
//     - tag[2:0]: Producer tag (3'b111 = valid/ready)
//     - executed: Indicates instruction has completed
//     - exception: Indicates exception/misprediction occurred
//////////////////////////////////////////////////////////////////////////////////

module reorder_buffer #(
        parameter DATA_WIDTH = 32,
        parameter TAG_WIDTH = 3,
        parameter BUFFER_DEPTH = 32, // Must be power of 2
        parameter ADDR_WIDTH = $clog2(BUFFER_DEPTH)
    )(
        input  logic clk,
        input  logic reset,
        input  logic secure_mode,

        //==========================================================================
        // ALLOCATION INTERFACE (from Register Alias Table)
        //==========================================================================
        input  logic alloc_enable_0,
        input  logic alloc_enable_1,
        input  logic alloc_enable_2,
        input  logic [TAG_WIDTH-1:0] alloc_tag_0,  // Producer tag for allocation
        input  logic [TAG_WIDTH-1:0] alloc_tag_1,
        input  logic [TAG_WIDTH-1:0] alloc_tag_2,
        input logic [ADDR_WIDTH-1:0] alloc_addr_0,  // Allocated ROB index
        input logic [ADDR_WIDTH-1:0] alloc_addr_1,
        input logic [ADDR_WIDTH-1:0] alloc_addr_2,
        input logic alloc_is_store_0,
        input logic alloc_is_store_1,
        input logic alloc_is_store_2,
        output logic alloc_success,  // All requested allocations succeeded

        //==========================================================================
        // CDB INTERFACE (from execution units)
        //==========================================================================
        input  logic cdb_valid_0,
        input  logic cdb_valid_1,
        input  logic cdb_valid_2,
        input  logic cdb_valid_3_0,
        input  logic cdb_valid_3_1,
        input  logic cdb_valid_3_2,

        input  logic [ADDR_WIDTH-1:0] cdb_addr_0,
        input  logic [ADDR_WIDTH-1:0] cdb_addr_1,
        input  logic [ADDR_WIDTH-1:0] cdb_addr_2,
        input  logic [ADDR_WIDTH-1:0] cdb_addr_3_0,
        input  logic [ADDR_WIDTH-1:0] cdb_addr_3_1,
        input  logic [ADDR_WIDTH-1:0] cdb_addr_3_2,

        input  logic [DATA_WIDTH-1:0] cdb_data_0,
        input  logic [DATA_WIDTH-1:0] cdb_data_1,
        input  logic [DATA_WIDTH-1:0] cdb_data_2,
        input  logic [DATA_WIDTH-1:0] cdb_data_3_0,
        input  logic [DATA_WIDTH-1:0] cdb_data_3_1,
        input  logic [DATA_WIDTH-1:0] cdb_data_3_2,

        input  logic cdb_exception_0,  // Misprediction/exception flag
        input  logic cdb_exception_1,
        input  logic cdb_exception_2,
        input  logic cdb_exception_3_0,
        input  logic cdb_exception_3_1,
        input  logic cdb_exception_3_2,

        input  logic cdb_is_branch_0, // Is the instruction a branch
        input  logic cdb_is_branch_1,
        input  logic cdb_is_branch_2,

        input  logic cdb_mem_addr_calculation_0,
        input  logic cdb_mem_addr_calculation_1,
        input  logic cdb_mem_addr_calculation_2,

    //==========================================================================
    // Tracer Interface (for debugging, non-synthesis)
    //==========================================================================
    `ifndef SYNTHESIS
        tracer_interface.sink i_tracer_0,
        tracer_interface.sink i_tracer_1,
        tracer_interface.sink i_tracer_2,

        tracer_interface.source o_tracer_0,
        tracer_interface.source o_tracer_1,
        tracer_interface.source o_tracer_2,

        input logic [DATA_WIDTH-1:0] tracer_store_data_0,
        input logic [DATA_WIDTH-1:0] tracer_store_data_1,
        input logic [DATA_WIDTH-1:0] tracer_store_data_2,
    `endif
        //==========================================================================
        // READ INTERFACE (for reservation stations)
        //==========================================================================
        input  logic [ADDR_WIDTH-1:0] read_addr_0,
        input  logic [ADDR_WIDTH-1:0] read_addr_1,
        input  logic [ADDR_WIDTH-1:0] read_addr_2,
        input  logic [ADDR_WIDTH-1:0] read_addr_3,
        input  logic [ADDR_WIDTH-1:0] read_addr_4,
        input  logic [ADDR_WIDTH-1:0] read_addr_5,
        output logic [DATA_WIDTH-1:0] read_data_0,
        output logic [DATA_WIDTH-1:0] read_data_1,
        output logic [DATA_WIDTH-1:0] read_data_2,
        output logic [DATA_WIDTH-1:0] read_data_3,
        output logic [DATA_WIDTH-1:0] read_data_4,
        output logic [DATA_WIDTH-1:0] read_data_5,
        output logic [TAG_WIDTH-1:0] read_tag_0,
        output logic [TAG_WIDTH-1:0] read_tag_1,
        output logic [TAG_WIDTH-1:0] read_tag_2,
        output logic [TAG_WIDTH-1:0] read_tag_3,
        output logic [TAG_WIDTH-1:0] read_tag_4,
        output logic [TAG_WIDTH-1:0] read_tag_5,

        //==========================================================================
        // COMMIT INTERFACE (in-order commits)
        //==========================================================================
        output logic commit_valid_0,  // Head is ready to commit
        output logic commit_valid_1,  // Head+1 is ready to commit
        output logic commit_valid_2,  // Head+2 is ready to commit
        output logic [DATA_WIDTH-1:0] commit_data_0,
        output logic [DATA_WIDTH-1:0] commit_data_1,
        output logic [DATA_WIDTH-1:0] commit_data_2,
        output logic [ADDR_WIDTH-1:0] commit_addr_0,
        output logic [ADDR_WIDTH-1:0] commit_addr_1,
        output logic [ADDR_WIDTH-1:0] commit_addr_2,

        // TODO remove these, not needed anymore
        output logic commit_exception_0,
        output logic commit_exception_1,
        output logic commit_exception_2,

        output logic commit_is_branch_0,
        output logic commit_is_branch_1,
        output logic commit_is_branch_2,

        //==========================================================================
        // STORE PERMISSION OUTPUTS
        //==========================================================================
        output logic store_can_issue_0,
        output logic [ADDR_WIDTH:0] allowed_store_address_0,

        output logic store_can_issue_1,
        output logic [ADDR_WIDTH:0] allowed_store_address_1,

        output logic store_can_issue_2,
        output logic [ADDR_WIDTH:0] allowed_store_address_2,
        //==========================================================================
        // LSQ RAT COMMITS
        //==========================================================================
        output logic lsq_commit_valid_0,  // Head is ready to commit
        output logic lsq_commit_valid_1,  // Head+1 is ready to commit
        output logic lsq_commit_valid_2,  // Head+2 is ready to commit
        //==========================================================================
        // STATUS OUTPUTS
        //==========================================================================
        output logic buffer_empty,
        output logic buffer_full,
        output logic [ADDR_WIDTH:0] buffer_count,  // Number of valid entries
        output logic [ADDR_WIDTH-1:0] head_ptr,
        output logic [ADDR_WIDTH-1:0] tail_ptr,

        //==========================================================================
        // EAGER MISPREDICTION
        //==========================================================================
        input  logic branch_misprediction_i,
        input  logic [ADDR_WIDTH-1:0] branch_mispredicted_rob_idx_i,
        output logic [ADDR_WIDTH-1:0] rob_head_ptr_o,

        //==========================================================================
        // TMR ERROR OUTPUTS
        //==========================================================================
        output logic head_ptr_fatal_o,
        output logic tail_ptr_fatal_o
    );

    localparam D = 1;  // Delay for simulation
    localparam TAG_VALID = 3'b111;  // Tag indicating data is valid and ready

    //==========================================================================
    // BUFFER STORAGE
    //==========================================================================

    // ROB entry structure - packed for better waveform visibility
    typedef struct packed {
        logic [DATA_WIDTH-1:0] data;
        logic [TAG_WIDTH-1:0] tag; // todo remove - design path without tag
        logic [ADDR_WIDTH-1:0] addr;
        logic executed;
        logic exception;
        logic is_branch;
        logic is_store;
    } rob_entry_t;

    // Reorder buffer storage - single array of structs
    rob_entry_t [BUFFER_DEPTH-1:0] buffer;

    `ifndef SYNTHESIS
    // Tracer instances for debugging (non-synthesis)
    typedef struct packed {
        logic valid;
        logic [31:0] pc;
        logic [31:0] instr;
        logic [4:0] reg_addr;
        logic [31:0] reg_data;
        logic is_load;
        logic is_store;
        logic is_float;
        logic [1:0] mem_size;
        logic [31:0] mem_addr;
        logic [31:0] mem_data;
        logic [31:0] fpu_flags;
    } tracer_entry_t;
    tracer_entry_t [BUFFER_DEPTH-1:0] tracer_buffer;
    `endif

    //==========================================================================
    // TMR: Triplicated Head/Tail Pointer Registers
    //==========================================================================
    logic [ADDR_WIDTH:0] head_ptr_reg_0, head_ptr_reg_1, head_ptr_reg_2;
    logic [ADDR_WIDTH:0] tail_ptr_reg_0, tail_ptr_reg_1, tail_ptr_reg_2;

    // TMR: Voted outputs (used in logic)
    logic [ADDR_WIDTH:0] head_ptr_reg;
    logic [ADDR_WIDTH:0] tail_ptr_reg;

    // TMR: Error signals from voters
    logic head_ptr_mismatch;
    logic head_ptr_err_0, head_ptr_err_1, head_ptr_err_2;
    logic tail_ptr_mismatch;
    logic tail_ptr_err_0, tail_ptr_err_1, tail_ptr_err_2;

    // TMR: Voter instances
    tmr_voter #(.DATA_WIDTH(ADDR_WIDTH+1)) head_ptr_voter (
        .secure_mode_i      (secure_mode),
        .data_0_i           (head_ptr_reg_0),
        .data_1_i           (head_ptr_reg_1),
        .data_2_i           (head_ptr_reg_2),
        .data_o             (head_ptr_reg),
        .mismatch_detected_o(head_ptr_mismatch),
        .error_0_o          (head_ptr_err_0),
        .error_1_o          (head_ptr_err_1),
        .error_2_o          (head_ptr_err_2),
        .fatal_error_o      (head_ptr_fatal_o)
    );

    tmr_voter #(.DATA_WIDTH(ADDR_WIDTH+1)) tail_ptr_voter (
        .secure_mode_i      (secure_mode),
        .data_0_i           (tail_ptr_reg_0),
        .data_1_i           (tail_ptr_reg_1),
        .data_2_i           (tail_ptr_reg_2),
        .data_o             (tail_ptr_reg),
        .mismatch_detected_o(tail_ptr_mismatch),
        .error_0_o          (tail_ptr_err_0),
        .error_1_o          (tail_ptr_err_1),
        .error_2_o          (tail_ptr_err_2),
        .fatal_error_o      (tail_ptr_fatal_o)
    );

    // Assign outputs
    assign head_ptr = head_ptr_reg[ADDR_WIDTH-1:0];
    assign tail_ptr = tail_ptr_reg[ADDR_WIDTH-1:0];

    // Eager misprediction outputs for LSQ flush
    assign rob_head_ptr_o = head_ptr_reg[ADDR_WIDTH-1:0];

    // Calculate mispredicted distance - select based on which FU mispredicted
    //==========================================================================
    // BUFFER STATUS
    //==========================================================================

    logic [ADDR_WIDTH:0] entries_used;
    logic [ADDR_WIDTH:0] entries_free;

    assign entries_used = tail_ptr_reg - head_ptr_reg; // TODO: can be wrong we need to check MSB
    assign entries_free = BUFFER_DEPTH - entries_used;
    assign buffer_count = entries_used;
    assign buffer_empty = (entries_used == 0);
    assign buffer_full = (entries_used == BUFFER_DEPTH);

    //==========================================================================
    // ALLOCATION LOGIC
    //==========================================================================
    logic [ADDR_WIDTH-1:0] alloc_idx_0;
    logic [ADDR_WIDTH-1:0] alloc_idx_1;
    logic [ADDR_WIDTH-1:0] alloc_idx_2;

    logic [1:0] num_alloc_requests;
    logic [ADDR_WIDTH:0] next_tail_ptr;


    logic [ADDR_WIDTH-1:0] head_idx, head_plus_1_idx, head_plus_2_idx;

    //==========================================================================
    // TMR: Triplicated Delayed Head Index Registers
    //==========================================================================
    logic [ADDR_WIDTH-1:0] head_idx_d1_0, head_idx_d1_1, head_idx_d1_2;
    logic [ADDR_WIDTH-1:0] head_plus_1_idx_d1_0, head_plus_1_idx_d1_1, head_plus_1_idx_d1_2;
    logic [ADDR_WIDTH-1:0] head_plus_2_idx_d1_0, head_plus_2_idx_d1_1, head_plus_2_idx_d1_2;

    // TMR: Voted outputs (used in logic)
    logic [ADDR_WIDTH-1:0] head_idx_d1, head_plus_1_idx_d1, head_plus_2_idx_d1;

    // TMR: Error signals from voters
    logic head_idx_d1_mismatch, head_plus_1_idx_d1_mismatch, head_plus_2_idx_d1_mismatch;
    logic head_idx_d1_err_0, head_idx_d1_err_1, head_idx_d1_err_2, head_idx_d1_fatal;
    logic head_plus_1_idx_d1_err_0, head_plus_1_idx_d1_err_1, head_plus_1_idx_d1_err_2, head_plus_1_idx_d1_fatal;
    logic head_plus_2_idx_d1_err_0, head_plus_2_idx_d1_err_1, head_plus_2_idx_d1_err_2, head_plus_2_idx_d1_fatal;

    // TMR: Voter instances for delayed head indices
    tmr_voter #(.DATA_WIDTH(ADDR_WIDTH)) head_idx_d1_voter (
        .secure_mode_i      (secure_mode),
        .data_0_i           (head_idx_d1_0),
        .data_1_i           (head_idx_d1_1),
        .data_2_i           (head_idx_d1_2),
        .data_o             (head_idx_d1),
        .mismatch_detected_o(head_idx_d1_mismatch),
        .error_0_o          (head_idx_d1_err_0),
        .error_1_o          (head_idx_d1_err_1),
        .error_2_o          (head_idx_d1_err_2),
        .fatal_error_o      (head_idx_d1_fatal)
    );

    tmr_voter #(.DATA_WIDTH(ADDR_WIDTH)) head_plus_1_idx_d1_voter (
        .secure_mode_i      (secure_mode),
        .data_0_i           (head_plus_1_idx_d1_0),
        .data_1_i           (head_plus_1_idx_d1_1),
        .data_2_i           (head_plus_1_idx_d1_2),
        .data_o             (head_plus_1_idx_d1),
        .mismatch_detected_o(head_plus_1_idx_d1_mismatch),
        .error_0_o          (head_plus_1_idx_d1_err_0),
        .error_1_o          (head_plus_1_idx_d1_err_1),
        .error_2_o          (head_plus_1_idx_d1_err_2),
        .fatal_error_o      (head_plus_1_idx_d1_fatal)
    );

    tmr_voter #(.DATA_WIDTH(ADDR_WIDTH)) head_plus_2_idx_d1_voter (
        .secure_mode_i      (secure_mode),
        .data_0_i           (head_plus_2_idx_d1_0),
        .data_1_i           (head_plus_2_idx_d1_1),
        .data_2_i           (head_plus_2_idx_d1_2),
        .data_o             (head_plus_2_idx_d1),
        .mismatch_detected_o(head_plus_2_idx_d1_mismatch),
        .error_0_o          (head_plus_2_idx_d1_err_0),
        .error_1_o          (head_plus_2_idx_d1_err_1),
        .error_2_o          (head_plus_2_idx_d1_err_2),
        .fatal_error_o      (head_plus_2_idx_d1_fatal)
    );

    logic [1:0] num_commits;
    logic [ADDR_WIDTH:0] next_head_ptr;

    // Count number of allocation requests
    always_comb begin
        num_alloc_requests = alloc_enable_0 + alloc_enable_1 + alloc_enable_2;
    end

    // Check if allocation can succeed (block during eager misprediction)
    assign alloc_success = (entries_free >= num_alloc_requests) && !branch_misprediction_i;

    // Assign allocation addresses (current tail position)
    assign alloc_idx_0 = tail_ptr_reg[ADDR_WIDTH-1:0];
    assign alloc_idx_1 = (tail_ptr_reg[ADDR_WIDTH-1:0] + alloc_enable_0) % BUFFER_DEPTH;
    assign alloc_idx_2 = (tail_ptr_reg[ADDR_WIDTH-1:0] + alloc_enable_0 + alloc_enable_1) % BUFFER_DEPTH;

    // Calculate next tail pointer with eager misprediction handling
    always_comb begin
        next_tail_ptr = tail_ptr_reg;

        if (branch_misprediction_i) begin
            if(branch_mispredicted_rob_idx_i < tail_ptr_reg[ADDR_WIDTH-1:0])
                next_tail_ptr = {tail_ptr_reg[ADDR_WIDTH], branch_mispredicted_rob_idx_i} + 1'b1;
            else
                next_tail_ptr = {~tail_ptr_reg[ADDR_WIDTH], branch_mispredicted_rob_idx_i} + 1'b1;
        end else if (alloc_success && !buffer_full) begin
            next_tail_ptr = tail_ptr_reg + num_alloc_requests;
        end
    end

    assign head_idx = head_ptr_reg[ADDR_WIDTH-1:0];
    assign head_plus_1_idx = (head_ptr_reg[ADDR_WIDTH-1:0] + 1'b1) % BUFFER_DEPTH;
    assign head_plus_2_idx = (head_ptr_reg[ADDR_WIDTH-1:0] + 2'b10) % BUFFER_DEPTH;

    // Commit ready signals - in-order commit requirement
    // Added tail boundary checks to prevent committing orphan entries after tail truncation
    // entries_used >= N ensures head+N-1 is within valid range
    assign commit_valid_0 = buffer[head_idx].executed && (entries_used >= 1);

    assign commit_valid_1 = secure_mode? 1'b0 : commit_valid_0 & buffer[head_plus_1_idx].executed & (entries_used >= 2);

    assign commit_valid_2 = secure_mode? 1'b0 : commit_valid_0 & commit_valid_1 & buffer[head_plus_2_idx].executed & (entries_used >= 3);


    assign lsq_commit_valid_0 = commit_valid_0 & buffer[head_idx].is_store;
    assign lsq_commit_valid_1 = commit_valid_1 & buffer[head_plus_1_idx].is_store;
    assign lsq_commit_valid_2 = commit_valid_2 & buffer[head_plus_2_idx].is_store;

    // Commit data outputs
    assign commit_data_0 = buffer[head_idx].data;
    assign commit_data_1 = buffer[head_plus_1_idx].data;
    assign commit_data_2 = buffer[head_plus_2_idx].data;
    assign commit_addr_0 = buffer[head_idx].addr;
    assign commit_addr_1 = buffer[head_plus_1_idx].addr;
    assign commit_addr_2 = buffer[head_plus_2_idx].addr;

    assign commit_exception_0 = buffer[head_idx].exception & commit_valid_0;
    assign commit_exception_1 = buffer[head_plus_1_idx].exception & commit_valid_1;
    assign commit_exception_2 = buffer[head_plus_2_idx].exception & commit_valid_2;

    assign commit_is_branch_0 = buffer[head_idx].is_branch & commit_valid_0;
    assign commit_is_branch_1 = buffer[head_plus_1_idx].is_branch & commit_valid_1;
    assign commit_is_branch_2 = buffer[head_plus_2_idx].is_branch & commit_valid_2;

    // Store permission outputs
    assign store_can_issue_0 =  buffer[head_idx].is_store && buffer[head_idx].tag==TAG_VALID; //TODO add 2 more store can issue signals for head+1 and head+2 and check brnach status
    assign allowed_store_address_0 = {1'b1, head_idx};

    // todo check prev instruction is also store and both trying to write to same address
    assign store_can_issue_1 =  buffer[head_plus_1_idx].is_store && buffer[head_plus_1_idx].tag==TAG_VALID && (buffer[head_idx].is_branch ? buffer[head_idx].executed & !buffer[head_idx].exception : 1'b1);
    assign allowed_store_address_1 = {1'b1, head_plus_1_idx};

    assign store_can_issue_2 =  buffer[head_plus_2_idx].is_store && buffer[head_plus_2_idx].tag==TAG_VALID && (buffer[head_plus_1_idx].is_branch ? buffer[head_plus_1_idx].executed & !buffer[head_plus_1_idx].exception : 1'b1) && (buffer[head_idx].is_branch ? buffer[head_idx].executed & !buffer[head_idx].exception : 1'b1);
    assign allowed_store_address_2 = {1'b1, head_plus_2_idx};

    // Count number of commits
    always_comb begin
        num_commits = commit_valid_0 + commit_valid_1 + commit_valid_2;
    end

    // Calculate next head pointer (commits advance head)
    always_comb begin
        next_head_ptr = head_ptr_reg + num_commits;
    end

    //==========================================================================
    // CDB UPDATE LOGIC (with forwarding to read ports)
    //==========================================================================

    // Address matching signals for CDB forwarding
    logic read_0_match_cdb_0, read_0_match_cdb_1, read_0_match_cdb_2, read_0_match_cdb_3_0, read_0_match_cdb_3_1, read_0_match_cdb_3_2;
    logic read_1_match_cdb_0, read_1_match_cdb_1, read_1_match_cdb_2, read_1_match_cdb_3_0, read_1_match_cdb_3_1, read_1_match_cdb_3_2;
    logic read_2_match_cdb_0, read_2_match_cdb_1, read_2_match_cdb_2, read_2_match_cdb_3_0, read_2_match_cdb_3_1, read_2_match_cdb_3_2;
    logic read_3_match_cdb_0, read_3_match_cdb_1, read_3_match_cdb_2, read_3_match_cdb_3_0, read_3_match_cdb_3_1, read_3_match_cdb_3_2;
    logic read_4_match_cdb_0, read_4_match_cdb_1, read_4_match_cdb_2, read_4_match_cdb_3_0, read_4_match_cdb_3_1, read_4_match_cdb_3_2;
    logic read_5_match_cdb_0, read_5_match_cdb_1, read_5_match_cdb_2, read_5_match_cdb_3_0, read_5_match_cdb_3_1, read_5_match_cdb_3_2;

    assign read_0_match_cdb_0   = cdb_valid_0 && (cdb_addr_0 == read_addr_0) && !cdb_mem_addr_calculation_0;
    assign read_0_match_cdb_1   = cdb_valid_1 && (cdb_addr_1 == read_addr_0) && !cdb_mem_addr_calculation_1;
    assign read_0_match_cdb_2   = cdb_valid_2 && (cdb_addr_2 == read_addr_0) && !cdb_mem_addr_calculation_2;
    assign read_0_match_cdb_3_0 = cdb_valid_3_0 && (cdb_addr_3_0 == read_addr_0);
    assign read_0_match_cdb_3_1 = cdb_valid_3_1 && (cdb_addr_3_1 == read_addr_0);
    assign read_0_match_cdb_3_2 = cdb_valid_3_2 && (cdb_addr_3_2 == read_addr_0);

    assign read_1_match_cdb_0   = cdb_valid_0 && (cdb_addr_0 == read_addr_1) && !cdb_mem_addr_calculation_0;
    assign read_1_match_cdb_1   = cdb_valid_1 && (cdb_addr_1 == read_addr_1) && !cdb_mem_addr_calculation_1;
    assign read_1_match_cdb_2   = cdb_valid_2 && (cdb_addr_2 == read_addr_1) && !cdb_mem_addr_calculation_2;
    assign read_1_match_cdb_3_0 = cdb_valid_3_0 && (cdb_addr_3_0 == read_addr_1);
    assign read_1_match_cdb_3_1 = cdb_valid_3_1 && (cdb_addr_3_1 == read_addr_1);
    assign read_1_match_cdb_3_2 = cdb_valid_3_2 && (cdb_addr_3_2 == read_addr_1);

    assign read_2_match_cdb_0   = cdb_valid_0 && (cdb_addr_0 == read_addr_2) && !cdb_mem_addr_calculation_0;
    assign read_2_match_cdb_1   = cdb_valid_1 && (cdb_addr_1 == read_addr_2) && !cdb_mem_addr_calculation_1;
    assign read_2_match_cdb_2   = cdb_valid_2 && (cdb_addr_2 == read_addr_2) && !cdb_mem_addr_calculation_2;
    assign read_2_match_cdb_3_0 = cdb_valid_3_0 && (cdb_addr_3_0 == read_addr_2);
    assign read_2_match_cdb_3_1 = cdb_valid_3_1 && (cdb_addr_3_1 == read_addr_2);
    assign read_2_match_cdb_3_2 = cdb_valid_3_2 && (cdb_addr_3_2 == read_addr_2);

    assign read_3_match_cdb_0   = cdb_valid_0 && (cdb_addr_0 == read_addr_3) && !cdb_mem_addr_calculation_0;
    assign read_3_match_cdb_1   = cdb_valid_1 && (cdb_addr_1 == read_addr_3) && !cdb_mem_addr_calculation_1;
    assign read_3_match_cdb_2   = cdb_valid_2 && (cdb_addr_2 == read_addr_3) && !cdb_mem_addr_calculation_2;
    assign read_3_match_cdb_3_0 = cdb_valid_3_0 && (cdb_addr_3_0 == read_addr_3);
    assign read_3_match_cdb_3_1 = cdb_valid_3_1 && (cdb_addr_3_1 == read_addr_3);
    assign read_3_match_cdb_3_2 = cdb_valid_3_2 && (cdb_addr_3_2 == read_addr_3);

    assign read_4_match_cdb_0   = cdb_valid_0 && (cdb_addr_0 == read_addr_4) && !cdb_mem_addr_calculation_0;
    assign read_4_match_cdb_1   = cdb_valid_1 && (cdb_addr_1 == read_addr_4) && !cdb_mem_addr_calculation_1;
    assign read_4_match_cdb_2   = cdb_valid_2 && (cdb_addr_2 == read_addr_4) && !cdb_mem_addr_calculation_2;
    assign read_4_match_cdb_3_0 = cdb_valid_3_0 && (cdb_addr_3_0 == read_addr_4);
    assign read_4_match_cdb_3_1 = cdb_valid_3_1 && (cdb_addr_3_1 == read_addr_4);
    assign read_4_match_cdb_3_2 = cdb_valid_3_2 && (cdb_addr_3_2 == read_addr_4);

    assign read_5_match_cdb_0 = cdb_valid_0 && (cdb_addr_0 == read_addr_5) && !cdb_mem_addr_calculation_0;
    assign read_5_match_cdb_1 = cdb_valid_1 && (cdb_addr_1 == read_addr_5) && !cdb_mem_addr_calculation_1;
    assign read_5_match_cdb_2 = cdb_valid_2 && (cdb_addr_2 == read_addr_5) && !cdb_mem_addr_calculation_2;
    assign read_5_match_cdb_3_0 = cdb_valid_3_0 && (cdb_addr_3_0 == read_addr_5);
    assign read_5_match_cdb_3_1 = cdb_valid_3_1 && (cdb_addr_3_1 == read_addr_5);
    assign read_5_match_cdb_3_2 = cdb_valid_3_2 && (cdb_addr_3_2 == read_addr_5);

    //==========================================================================
    // Forwarding from allocation to read ports
    //==========================================================================
    logic read_0_match_alloc_0, read_0_match_alloc_1, read_0_match_alloc_2;
    logic read_1_match_alloc_0, read_1_match_alloc_1, read_1_match_alloc_2;
    logic read_2_match_alloc_0, read_2_match_alloc_1, read_2_match_alloc_2;
    logic read_3_match_alloc_0, read_3_match_alloc_1, read_3_match_alloc_2;
    logic read_4_match_alloc_0, read_4_match_alloc_1, read_4_match_alloc_2;
    logic read_5_match_alloc_0, read_5_match_alloc_1, read_5_match_alloc_2;

    assign read_0_match_alloc_0 = alloc_enable_0 && (alloc_idx_0 == read_addr_0);
    assign read_0_match_alloc_1 = alloc_enable_1 && (alloc_idx_1 == read_addr_0);
    assign read_0_match_alloc_2 = alloc_enable_2 && (alloc_idx_2 == read_addr_0);

    assign read_1_match_alloc_0 = alloc_enable_0 && (alloc_idx_0 == read_addr_1);
    assign read_1_match_alloc_1 = alloc_enable_1 && (alloc_idx_1 == read_addr_1);
    assign read_1_match_alloc_2 = alloc_enable_2 && (alloc_idx_2 == read_addr_1);

    assign read_2_match_alloc_0 = alloc_enable_0 && (alloc_idx_0 == read_addr_2);
    assign read_2_match_alloc_1 = alloc_enable_1 && (alloc_idx_1 == read_addr_2);
    assign read_2_match_alloc_2 = alloc_enable_2 && (alloc_idx_2 == read_addr_2);

    assign read_3_match_alloc_0 = alloc_enable_0 && (alloc_idx_0 == read_addr_3);
    assign read_3_match_alloc_1 = alloc_enable_1 && (alloc_idx_1 == read_addr_3);
    assign read_3_match_alloc_2 = alloc_enable_2 && (alloc_idx_2 == read_addr_3);

    assign read_4_match_alloc_0 = alloc_enable_0 && (alloc_idx_0 == read_addr_4);
    assign read_4_match_alloc_1 = alloc_enable_1 && (alloc_idx_1 == read_addr_4);
    assign read_4_match_alloc_2 = alloc_enable_2 && (alloc_idx_2 == read_addr_4);

    assign read_5_match_alloc_0 = alloc_enable_0 && (alloc_idx_0 == read_addr_5);
    assign read_5_match_alloc_1 = alloc_enable_1 && (alloc_idx_1 == read_addr_5);
    assign read_5_match_alloc_2 = alloc_enable_2 && (alloc_idx_2 == read_addr_5);

    //==========================================================================
    // READ PORT IMPLEMENTATION (with CDB forwarding)
    //==========================================================================

    // Read port 0: Forward from CDB if available, otherwise read from buffer
    always_comb begin
        if (read_0_match_cdb_3_2) begin
            read_data_0 = cdb_data_3_2;
            read_tag_0 = TAG_VALID;
        end else if (read_0_match_cdb_3_1) begin
            read_data_0 = cdb_data_3_1;
            read_tag_0 = TAG_VALID;
        end else if (read_0_match_cdb_3_0) begin
            read_data_0 = cdb_data_3_0;
            read_tag_0 = TAG_VALID;
        end else if (read_0_match_cdb_2) begin
            read_data_0 = cdb_data_2;
            read_tag_0 = TAG_VALID;
        end else if (read_0_match_cdb_1) begin
            read_data_0 = cdb_data_1;
            read_tag_0 = TAG_VALID;
        end else if (read_0_match_cdb_0) begin
            read_data_0 = cdb_data_0;
            read_tag_0 = TAG_VALID;
        end else if (read_0_match_alloc_2) begin
            read_data_0 = {26'd0, 1'b1, alloc_idx_2}; // New allocation, data not ready
            read_tag_0 = alloc_tag_2;
        end else if (read_0_match_alloc_1) begin
            read_data_0 = {26'd0, 1'b1, alloc_idx_1}; // New allocation, data not ready
            read_tag_0 = alloc_tag_1;
        end else if (read_0_match_alloc_0) begin
            read_data_0 = {26'd0, 1'b1, alloc_idx_0}; // New allocation, data not ready
            read_tag_0 = alloc_tag_0;
        end else begin
            //read_data_0 = buffer[read_addr_0].data; send lsq destination address if value expected from LSQ
            read_tag_0 = buffer[read_addr_0].tag;
            if(read_tag_0 == 3'b011) begin
                read_data_0 = {26'd0, 1'b1, read_addr_0}; // LSQ destination address
            end else begin
                read_data_0 = buffer[read_addr_0].data;
            end
        end
    end

    // Read port 1
    always_comb begin
        if (read_1_match_cdb_3_2) begin
            read_data_1 = cdb_data_3_2;
            read_tag_1 = TAG_VALID;
        end else if (read_1_match_cdb_3_1) begin
            read_data_1 = cdb_data_3_1;
            read_tag_1 = TAG_VALID;
        end else if (read_1_match_cdb_3_0) begin
            read_data_1 = cdb_data_3_0;
            read_tag_1 = TAG_VALID;
        end else if (read_1_match_cdb_2) begin
            read_data_1 = cdb_data_2;
            read_tag_1 = TAG_VALID;
        end else if (read_1_match_cdb_1) begin
            read_data_1 = cdb_data_1;
            read_tag_1 = TAG_VALID;
        end else if (read_1_match_cdb_0) begin
            read_data_1 = cdb_data_0;
            read_tag_1 = TAG_VALID;
        end else if (read_1_match_alloc_2) begin
            read_data_1 = {26'd0, 1'b1, alloc_idx_2}; // New allocation, data not ready
            read_tag_1 = alloc_tag_2;
        end else if (read_1_match_alloc_1) begin
            read_data_1 = {26'd0, 1'b1, alloc_idx_1}; // New allocation, data not ready
            read_tag_1 = alloc_tag_1;
        end else if (read_1_match_alloc_0) begin
            read_data_1 = {26'd0, 1'b1, alloc_idx_0}; // New allocation, data not ready
            read_tag_1 = alloc_tag_0;
        end else begin
            read_tag_1 = buffer[read_addr_1].tag;
            if(read_tag_1 == 3'b011) begin
                read_data_1 = {26'd0, 1'b1, read_addr_1}; // LSQ destination address
            end else begin
                read_data_1 = buffer[read_addr_1].data;
            end
        end
    end

    // Read port 2
    always_comb begin
        if (read_2_match_cdb_3_2) begin
            read_data_2 = cdb_data_3_2;
            read_tag_2 = TAG_VALID;
        end else  if (read_2_match_cdb_3_1) begin
            read_data_2 = cdb_data_3_1;
            read_tag_2 = TAG_VALID;
        end else  if (read_2_match_cdb_3_0) begin
            read_data_2 = cdb_data_3_0;
            read_tag_2 = TAG_VALID;
        end else if (read_2_match_cdb_2) begin
            read_data_2 = cdb_data_2;
            read_tag_2 = TAG_VALID;
        end else if (read_2_match_cdb_1) begin
            read_data_2 = cdb_data_1;
            read_tag_2 = TAG_VALID;
        end else if (read_2_match_cdb_0) begin
            read_data_2 = cdb_data_0;
            read_tag_2 = TAG_VALID;
        end else if (read_2_match_alloc_2) begin
            read_data_2 = {26'd0, 1'b1, alloc_idx_2}; // New allocation, data not ready
            read_tag_2 = alloc_tag_2;
        end else if (read_2_match_alloc_1) begin
            read_data_2 = {26'd0, 1'b1, alloc_idx_1}; // New allocation, data not ready
            read_tag_2 = alloc_tag_1;
        end else if (read_2_match_alloc_0) begin
            read_data_2 = {26'd0, 1'b1, alloc_idx_0}; // New allocation, data not ready
            read_tag_2 = alloc_tag_0;
        end else begin
            read_tag_2 = buffer[read_addr_2].tag;
            if(read_tag_2 == 3'b011) begin
                read_data_2 = {26'd0, 1'b1, read_addr_2}; // LSQ destination address
            end else begin
                read_data_2 = buffer[read_addr_2].data;
            end
        end
    end

    // Read port 3
    always_comb begin
        if (read_3_match_cdb_3_2) begin
            read_data_3 = cdb_data_3_2;
            read_tag_3 = TAG_VALID;
        end else if (read_3_match_cdb_3_1) begin
            read_data_3 = cdb_data_3_1;
            read_tag_3 = TAG_VALID;
        end else if (read_3_match_cdb_3_0) begin
            read_data_3 = cdb_data_3_0;
            read_tag_3 = TAG_VALID;
        end else if (read_3_match_cdb_2) begin
            read_data_3 = cdb_data_2;
            read_tag_3 = TAG_VALID;
        end else if (read_3_match_cdb_1) begin
            read_data_3 = cdb_data_1;
            read_tag_3 = TAG_VALID;
        end else if (read_3_match_cdb_0) begin
            read_data_3 = cdb_data_0;
            read_tag_3 = TAG_VALID;
        end else if (read_3_match_alloc_2) begin
            read_data_3 = {26'd0, 1'b1, alloc_idx_2}; // New allocation, data not ready
            read_tag_3 = alloc_tag_2;
        end else if (read_3_match_alloc_1) begin
            read_data_3 = {26'd0, 1'b1, alloc_idx_1}; // New allocation, data not ready
            read_tag_3 = alloc_tag_1;
        end else if (read_3_match_alloc_0) begin
            read_data_3 = {26'd0, 1'b1, alloc_idx_0}; // New allocation, data not ready
            read_tag_3 = alloc_tag_0;
        end else begin
            read_tag_3 = buffer[read_addr_3].tag;
            if(read_tag_3 == 3'b011) begin
                read_data_3 = {26'd0, 1'b1, read_addr_3}; // LSQ destination address
            end else begin
                read_data_3 = buffer[read_addr_3].data;
            end
        end
    end

    // Read port 4
    always_comb begin
        if (read_4_match_cdb_3_2) begin
            read_data_4 = cdb_data_3_2;
            read_tag_4 = TAG_VALID;
        end else if (read_4_match_cdb_3_1) begin
            read_data_4 = cdb_data_3_1;
            read_tag_4 = TAG_VALID;
        end else if (read_4_match_cdb_3_0) begin
            read_data_4 = cdb_data_3_0;
            read_tag_4 = TAG_VALID;
        end else if (read_4_match_cdb_2) begin
            read_data_4 = cdb_data_2;
            read_tag_4 = TAG_VALID;
        end else if (read_4_match_cdb_1) begin
            read_data_4 = cdb_data_1;
            read_tag_4 = TAG_VALID;
        end else if (read_4_match_cdb_0) begin
            read_data_4 = cdb_data_0;
            read_tag_4 = TAG_VALID;
        end else if (read_4_match_alloc_2) begin
            read_data_4 = {26'd0, 1'b1, alloc_idx_2}; // New allocation, data not ready
            read_tag_4 = alloc_tag_2;
        end else if (read_4_match_alloc_1) begin
            read_data_4 = {26'd0, 1'b1, alloc_idx_1}; // New allocation, data not ready
            read_tag_4 = alloc_tag_1;
        end else if (read_4_match_alloc_0) begin
            read_data_4 = {26'd0, 1'b1, alloc_idx_0}; // New allocation, data not ready
            read_tag_4 = alloc_tag_0;
        end else begin
            read_tag_4 = buffer[read_addr_4].tag;
            if(read_tag_4 == 3'b011) begin
                read_data_4 = {26'd0, 1'b1, read_addr_4}; // LSQ destination address
            end else begin
                read_data_4 = buffer[read_addr_4].data;
            end
        end
    end

    // Read port 5
    always_comb begin
        if (read_5_match_cdb_3_2) begin
            read_data_5 = cdb_data_3_2;
            read_tag_5 = TAG_VALID;
        end else if (read_5_match_cdb_3_1) begin
            read_data_5 = cdb_data_3_1;
            read_tag_5 = TAG_VALID;
        end else if (read_5_match_cdb_3_0) begin
            read_data_5 = cdb_data_3_0;
            read_tag_5 = TAG_VALID;
        end else if (read_5_match_cdb_2) begin
            read_data_5 = cdb_data_2;
            read_tag_5 = TAG_VALID;
        end else if (read_5_match_cdb_1) begin
            read_data_5 = cdb_data_1;
            read_tag_5 = TAG_VALID;
        end else if (read_5_match_cdb_0) begin
            read_data_5 = cdb_data_0;
            read_tag_5 = TAG_VALID;
        end else if (read_5_match_alloc_2) begin
            read_data_5 = {26'd0, 1'b1, alloc_idx_2}; // New allocation, data not ready
            read_tag_5 = alloc_tag_2;
        end else if (read_5_match_alloc_1) begin
            read_data_5 = {26'd0, 1'b1, alloc_idx_1}; // New allocation, data not ready
            read_tag_5 = alloc_tag_1;
        end else if (read_5_match_alloc_0) begin
            read_data_5 = {26'd0, 1'b1, alloc_idx_0}; // New allocation, data not ready
            read_tag_5 = alloc_tag_0;
        end else begin
            read_tag_5 = buffer[read_addr_5].tag;
            if(read_tag_5 == 3'b011) begin
                read_data_5 = {26'd0, 1'b1, read_addr_5}; // LSQ destination address
            end else begin
                read_data_5 = buffer[read_addr_5].data;
            end
        end
    end

    //==========================================================================
    // SEQUENTIAL LOGIC - BUFFER UPDATES
    //==========================================================================

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Reset all buffer entries
            for (int i = 0; i < BUFFER_DEPTH; i++) begin
                buffer[i] <= #D '0;
                tracer_buffer <= #D '0;
            end

            // Reset all three TMR copies of pointers
            head_ptr_reg_0 <= #D '0;
            head_ptr_reg_1 <= #D '0;
            head_ptr_reg_2 <= #D '0;
            tail_ptr_reg_0 <= #D '0;
            tail_ptr_reg_1 <= #D '0;
            tail_ptr_reg_2 <= #D '0;

            // Reset all three TMR copies of delayed head indices
            head_idx_d1_0 <= #D 5'd0;
            head_idx_d1_1 <= #D 5'd0;
            head_idx_d1_2 <= #D 5'd0;
            head_plus_1_idx_d1_0 <= #D 5'd1;
            head_plus_1_idx_d1_1 <= #D 5'd1;
            head_plus_1_idx_d1_2 <= #D 5'd1;
            head_plus_2_idx_d1_0 <= #D 5'd2;
            head_plus_2_idx_d1_1 <= #D 5'd2;
            head_plus_2_idx_d1_2 <= #D 5'd2;

        end else begin
            // Normal operation - eager misprediction handled via tail truncation in next_tail_ptr
            // Update all three TMR copies of head pointer (commits) - self-healing writes voted value to all
            head_ptr_reg_0 <= #D next_head_ptr;
            head_ptr_reg_1 <= #D next_head_ptr;
            head_ptr_reg_2 <= #D next_head_ptr;
            // Update all three TMR copies of tail pointer (allocations)
            tail_ptr_reg_0 <= #D next_tail_ptr;
            tail_ptr_reg_1 <= #D next_tail_ptr;
            tail_ptr_reg_2 <= #D next_tail_ptr;

            // Update all three TMR copies of delayed head indices - self-healing
            head_idx_d1_0 <= #D head_idx;
            head_idx_d1_1 <= #D head_idx;
            head_idx_d1_2 <= #D head_idx;
            head_plus_1_idx_d1_0 <= #D head_plus_1_idx;
            head_plus_1_idx_d1_1 <= #D head_plus_1_idx;
            head_plus_1_idx_d1_2 <= #D head_plus_1_idx;
            head_plus_2_idx_d1_0 <= #D head_plus_2_idx;
            head_plus_2_idx_d1_1 <= #D head_plus_2_idx;
            head_plus_2_idx_d1_2 <= #D head_plus_2_idx;

            //==================================================================
            // ALLOCATION - Initialize new entries
            //==================================================================
            if (alloc_success) begin
                if (alloc_enable_0) begin
                    buffer[alloc_idx_0].data <= #D '0;
                    buffer[alloc_idx_0].tag <= #D alloc_tag_0;
                    buffer[alloc_idx_0].addr <= #D alloc_addr_0;
                    buffer[alloc_idx_0].executed <= #D 1'b0;
                    buffer[alloc_idx_0].exception <= #D 1'b0;
                    buffer[alloc_idx_0].is_branch <= #D 1'b0; // todo set is_branch at allocation
                    buffer[alloc_idx_0].is_store <= #D alloc_is_store_0;

                        `ifndef SYNTHESIS
                    tracer_buffer[alloc_idx_0].valid     <= #D i_tracer_0.valid;
                    tracer_buffer[alloc_idx_0].pc        <= #D i_tracer_0.pc;
                    tracer_buffer[alloc_idx_0].instr     <= #D i_tracer_0.instr;
                    tracer_buffer[alloc_idx_0].reg_addr  <= #D i_tracer_0.reg_addr;
                    tracer_buffer[alloc_idx_0].reg_data  <= #D i_tracer_0.reg_data;
                    tracer_buffer[alloc_idx_0].is_load   <= #D i_tracer_0.is_load;
                    tracer_buffer[alloc_idx_0].is_store  <= #D i_tracer_0.is_store;
                    tracer_buffer[alloc_idx_0].is_float  <= #D i_tracer_0.is_float;
                    tracer_buffer[alloc_idx_0].mem_size  <= #D i_tracer_0.mem_size;
                    tracer_buffer[alloc_idx_0].mem_addr  <= #D i_tracer_0.mem_addr;
                    tracer_buffer[alloc_idx_0].mem_data  <= #D i_tracer_0.mem_data;
                    tracer_buffer[alloc_idx_0].fpu_flags <= #D i_tracer_0.fpu_flags;
                        `endif


                end
                if (alloc_enable_1) begin
                    buffer[alloc_idx_1].data <= #D '0;
                    buffer[alloc_idx_1].tag <= #D alloc_tag_1;
                    buffer[alloc_idx_1].addr <= #D alloc_addr_1;
                    buffer[alloc_idx_1].executed <= #D 1'b0;
                    buffer[alloc_idx_1].exception <= #D 1'b0;
                    buffer[alloc_idx_1].is_branch <= #D 1'b0;
                    buffer[alloc_idx_1].is_store <= #D alloc_is_store_1;

                        `ifndef SYNTHESIS
                    tracer_buffer[alloc_idx_1].valid     <= #D i_tracer_1.valid;
                    tracer_buffer[alloc_idx_1].pc        <= #D i_tracer_1.pc;
                    tracer_buffer[alloc_idx_1].instr     <= #D i_tracer_1.instr;
                    tracer_buffer[alloc_idx_1].reg_addr  <= #D i_tracer_1.reg_addr;
                    tracer_buffer[alloc_idx_1].reg_data  <= #D i_tracer_1.reg_data;
                    tracer_buffer[alloc_idx_1].is_load   <= #D i_tracer_1.is_load;
                    tracer_buffer[alloc_idx_1].is_store  <= #D i_tracer_1.is_store;
                    tracer_buffer[alloc_idx_1].is_float  <= #D i_tracer_1.is_float;
                    tracer_buffer[alloc_idx_1].mem_size  <= #D i_tracer_1.mem_size;
                    tracer_buffer[alloc_idx_1].mem_addr  <= #D i_tracer_1.mem_addr;
                    tracer_buffer[alloc_idx_1].mem_data  <= #D i_tracer_1.mem_data;
                    tracer_buffer[alloc_idx_1].fpu_flags <= #D i_tracer_1.fpu_flags;
                        `endif
                end
                if (alloc_enable_2) begin
                    buffer[alloc_idx_2].data <= #D '0;
                    buffer[alloc_idx_2].tag <= #D alloc_tag_2;
                    buffer[alloc_idx_2].addr <= #D alloc_addr_2;
                    buffer[alloc_idx_2].executed <= #D 1'b0;
                    buffer[alloc_idx_2].exception <= #D 1'b0;
                    buffer[alloc_idx_2].is_branch <= #D 1'b0;
                    buffer[alloc_idx_2].is_store <= #D alloc_is_store_2;

                        `ifndef SYNTHESIS
                    tracer_buffer[alloc_idx_2].valid     <= #D i_tracer_2.valid;
                    tracer_buffer[alloc_idx_2].pc        <= #D i_tracer_2.pc;
                    tracer_buffer[alloc_idx_2].instr     <= #D i_tracer_2.instr;
                    tracer_buffer[alloc_idx_2].reg_addr  <= #D i_tracer_2.reg_addr;
                    tracer_buffer[alloc_idx_2].reg_data  <= #D i_tracer_2.reg_data;
                    tracer_buffer[alloc_idx_2].is_load   <= #D i_tracer_2.is_load;
                    tracer_buffer[alloc_idx_2].is_store  <= #D i_tracer_2.is_store;
                    tracer_buffer[alloc_idx_2].is_float  <= #D i_tracer_2.is_float;
                    tracer_buffer[alloc_idx_2].mem_size  <= #D i_tracer_2.mem_size;
                    tracer_buffer[alloc_idx_2].mem_addr  <= #D i_tracer_2.mem_addr;
                    tracer_buffer[alloc_idx_2].mem_data  <= #D i_tracer_2.mem_data;
                    tracer_buffer[alloc_idx_2].fpu_flags <= #D i_tracer_2.fpu_flags;
                        `endif
                end
            end

            //==================================================================
            // CDB UPDATES - Write results from execution units
            //==================================================================
            if (cdb_valid_0 && (buffer[cdb_addr_0].tag == 3'b000 | (buffer[cdb_addr_0].tag == 3'b011 & buffer[cdb_addr_0].is_store & cdb_mem_addr_calculation_0))) begin
                buffer[cdb_addr_0].data <= #D cdb_data_0;
                buffer[cdb_addr_0].tag <= #D TAG_VALID;
                buffer[cdb_addr_0].executed <= #D !cdb_mem_addr_calculation_0;
                buffer[cdb_addr_0].exception <= #D cdb_exception_0;
                buffer[cdb_addr_0].is_branch <= #D cdb_is_branch_0;
            end
                `ifndef SYNTHESIS
            if (cdb_valid_0 && (buffer[cdb_addr_0].tag == 3'b000 | (buffer[cdb_addr_0].tag == 3'b011 & cdb_mem_addr_calculation_0))) begin
                // Update tracer info on execution completion
                if(cdb_mem_addr_calculation_0) begin
                    tracer_buffer[cdb_addr_0].mem_addr <= #D cdb_data_0;
                end
                else begin
                    tracer_buffer[cdb_addr_0].reg_data <= #D cdb_data_0;
                end
                    `endif
            end
            if (cdb_valid_1 && (buffer[cdb_addr_1].tag == 3'b001 | (buffer[cdb_addr_1].tag == 3'b011 & buffer[cdb_addr_1].is_store & cdb_mem_addr_calculation_1))) begin //todo do we need store address anymore?
                buffer[cdb_addr_1].data <= #D cdb_data_1;
                buffer[cdb_addr_1].tag <= #D TAG_VALID;
                buffer[cdb_addr_1].executed <= #D !cdb_mem_addr_calculation_1;
                buffer[cdb_addr_1].exception <= #D cdb_exception_1;
                buffer[cdb_addr_1].is_branch <= #D cdb_is_branch_1;

            end
                `ifndef SYNTHESIS
            if (cdb_valid_1 && (buffer[cdb_addr_1].tag == 3'b001 | (buffer[cdb_addr_1].tag == 3'b011 & cdb_mem_addr_calculation_1))) begin //todo do we need store address anymore?
                // Update tracer info on execution completion
                if(cdb_mem_addr_calculation_1) begin
                    tracer_buffer[cdb_addr_1].mem_addr <= #D cdb_data_1;
                end
                else begin
                    tracer_buffer[cdb_addr_1].reg_data <= #D cdb_data_1;
                end
                    `endif
            end
            if (cdb_valid_2 && (buffer[cdb_addr_2].tag == 3'b010 | (buffer[cdb_addr_2].tag == 3'b011 & buffer[cdb_addr_2].is_store & cdb_mem_addr_calculation_2))) begin
                buffer[cdb_addr_2].data <= #D cdb_data_2;
                buffer[cdb_addr_2].tag <= #D TAG_VALID;
                buffer[cdb_addr_2].executed <= #D !cdb_mem_addr_calculation_2;
                buffer[cdb_addr_2].exception <= #D cdb_exception_2;
                buffer[cdb_addr_2].is_branch <= #D cdb_is_branch_2;


            end
                `ifndef SYNTHESIS
            if (cdb_valid_2 && (buffer[cdb_addr_2].tag == 3'b010 | (buffer[cdb_addr_2].tag == 3'b011 & cdb_mem_addr_calculation_2))) begin

                if(cdb_mem_addr_calculation_2) begin
                    tracer_buffer[cdb_addr_2].mem_addr <= #D cdb_data_2;
                end
                else begin
                    tracer_buffer[cdb_addr_2].reg_data <= #D cdb_data_2;
                end
                    `endif
            end
            if (cdb_valid_3_2 && (buffer[cdb_addr_3_2].tag == 3'b011 | buffer[cdb_addr_3_2].tag == TAG_VALID) ) begin
                buffer[cdb_addr_3_2].data <= #D cdb_data_3_2;
                buffer[cdb_addr_3_2].tag <= #D TAG_VALID;
                buffer[cdb_addr_3_2].executed <= #D 1'b1;
                buffer[cdb_addr_3_2].exception <= #D cdb_exception_3_2;
                buffer[cdb_addr_3_2].is_store <= #D 1'b1;
                buffer[cdb_addr_3_2].is_branch <= #D 1'b0;

                    `ifndef SYNTHESIS
                tracer_buffer[cdb_addr_3_2].reg_data <= #D cdb_data_3_2;
                tracer_buffer[cdb_addr_3_2].mem_data <= #D tracer_store_data_2;
                    `endif
            end
            if (cdb_valid_3_1 && (buffer[cdb_addr_3_1].tag == 3'b011 | buffer[cdb_addr_3_1].tag == TAG_VALID) ) begin
                buffer[cdb_addr_3_1].data <= #D cdb_data_3_1;
                buffer[cdb_addr_3_1].tag <= #D TAG_VALID;
                buffer[cdb_addr_3_1].executed <= #D 1'b1;
                buffer[cdb_addr_3_1].exception <= #D cdb_exception_3_1;
                buffer[cdb_addr_3_1].is_store <= #D 1'b1;
                buffer[cdb_addr_3_1].is_branch <= #D 1'b0;

                    `ifndef SYNTHESIS
                tracer_buffer[cdb_addr_3_1].reg_data <= #D cdb_data_3_1;
                tracer_buffer[cdb_addr_3_1].mem_data <= #D tracer_store_data_1;
                    `endif
            end
            if (cdb_valid_3_0 && (buffer[cdb_addr_3_0].tag == 3'b011 | buffer[cdb_addr_3_0].tag == TAG_VALID) ) begin
                buffer[cdb_addr_3_0].data <= #D cdb_data_3_0;
                buffer[cdb_addr_3_0].tag <= #D TAG_VALID;
                buffer[cdb_addr_3_0].executed <= #D 1'b1;
                buffer[cdb_addr_3_0].exception <= #D cdb_exception_3_0;
                buffer[cdb_addr_3_0].is_store <= #D 1'b1;
                buffer[cdb_addr_3_0].is_branch <= #D 1'b0;

                    `ifndef SYNTHESIS
                tracer_buffer[cdb_addr_3_0].reg_data <= #D cdb_data_3_0;
                tracer_buffer[cdb_addr_3_0].mem_data <= #D tracer_store_data_0;
                    `endif
            end

            if(head_idx_d1 != head_idx) begin // detected commit
                // Clear committed entries (head, head+1, head+2)
                buffer[head_idx_d1] <= #D '0;
                if(head_plus_1_idx_d1 != head_idx) begin // if only one commit happened, head idx will be same as head+1 idx, so don't clear if they are same
                    buffer[head_plus_1_idx_d1] <= #D '0;
                    if(head_plus_2_idx_d1 != head_idx) begin
                        buffer[head_plus_2_idx_d1] <= #D '0;
                    end
                end
            end

        end
    end


    //==========================================================================
    // Tracer Output
    //==========================================================================
    `ifndef SYNTHESIS
    always_comb begin
        o_tracer_0.valid     = commit_valid_0 ? tracer_buffer[head_idx].valid : 1'b0; // todo we don't need tracer buffer valid, we can simply use commit valid
        o_tracer_0.pc        = commit_valid_0 ? tracer_buffer[head_idx].pc : 32'd0;
        o_tracer_0.instr     = commit_valid_0 ? tracer_buffer[head_idx].instr : 32'd0;
        o_tracer_0.reg_addr  = commit_valid_0 ? tracer_buffer[head_idx].reg_addr : 5'd0;
        o_tracer_0.reg_data  = commit_valid_0 ? tracer_buffer[head_idx].reg_data : 32'd0;
        o_tracer_0.is_load   = commit_valid_0 ? tracer_buffer[head_idx].is_load : 1'b0;
        o_tracer_0.is_store  = commit_valid_0 ? tracer_buffer[head_idx].is_store : 1'b0;
        o_tracer_0.is_float  = commit_valid_0 ? tracer_buffer[head_idx].is_float : 1'b0;
        o_tracer_0.mem_size  = commit_valid_0 ? tracer_buffer[head_idx].mem_size : 2'd0;
        o_tracer_0.mem_addr  = commit_valid_0 ? tracer_buffer[head_idx].mem_addr : 32'd0;
        o_tracer_0.mem_data  = commit_valid_0 ? tracer_buffer[head_idx].mem_data : 32'd0;
        o_tracer_0.fpu_flags = commit_valid_0 ? tracer_buffer[head_idx].fpu_flags : 32'd0;

        o_tracer_1.valid     = commit_valid_1 ? tracer_buffer[head_plus_1_idx].valid : 1'b0;
        o_tracer_1.pc        = commit_valid_1 ? tracer_buffer[head_plus_1_idx].pc : 32'd0;
        o_tracer_1.instr     = commit_valid_1 ? tracer_buffer[head_plus_1_idx].instr : 32'd0;
        o_tracer_1.reg_addr  = commit_valid_1 ? tracer_buffer[head_plus_1_idx].reg_addr : 5'd0;
        o_tracer_1.reg_data  = commit_valid_1 ? tracer_buffer[head_plus_1_idx].reg_data : 32'd0;
        o_tracer_1.is_load   = commit_valid_1 ? tracer_buffer[head_plus_1_idx].is_load : 1'b0;
        o_tracer_1.is_store  = commit_valid_1 ? tracer_buffer[head_plus_1_idx].is_store : 1'b0;
        o_tracer_1.is_float  = commit_valid_1 ? tracer_buffer[head_plus_1_idx].is_float : 1'b0;
        o_tracer_1.mem_size  = commit_valid_1 ? tracer_buffer[head_plus_1_idx].mem_size : 2'd0;
        o_tracer_1.mem_addr  = commit_valid_1 ? tracer_buffer[head_plus_1_idx].mem_addr : 32'd0;
        o_tracer_1.mem_data  = commit_valid_1 ? tracer_buffer[head_plus_1_idx].mem_data : 32'd0;
        o_tracer_1.fpu_flags = commit_valid_1 ? tracer_buffer[head_plus_1_idx].fpu_flags : 32'd0;

        o_tracer_2.valid     = commit_valid_2 ? tracer_buffer[head_plus_2_idx].valid : 1'b0;
        o_tracer_2.pc        = commit_valid_2 ? tracer_buffer[head_plus_2_idx].pc : 32'd0;
        o_tracer_2.instr     = commit_valid_2 ? tracer_buffer[head_plus_2_idx].instr : 32'd0;
        o_tracer_2.reg_addr  = commit_valid_2 ? tracer_buffer[head_plus_2_idx].reg_addr : 5'd0;
        o_tracer_2.reg_data  = commit_valid_2 ? tracer_buffer[head_plus_2_idx].reg_data : 32'd0;
        o_tracer_2.is_load   = commit_valid_2 ? tracer_buffer[head_plus_2_idx].is_load : 1'b0;
        o_tracer_2.is_store  = commit_valid_2 ? tracer_buffer[head_plus_2_idx].is_store : 1'b0;
        o_tracer_2.is_float  = commit_valid_2 ? tracer_buffer[head_plus_2_idx].is_float : 1'b0;
        o_tracer_2.mem_size  = commit_valid_2 ? tracer_buffer[head_plus_2_idx].mem_size : 2'd0;
        o_tracer_2.mem_addr  = commit_valid_2 ? tracer_buffer[head_plus_2_idx].mem_addr : 32'd0;
        o_tracer_2.mem_data  = commit_valid_2 ? tracer_buffer[head_plus_2_idx].mem_data : 32'd0;
        o_tracer_2.fpu_flags = commit_valid_2 ? tracer_buffer[head_plus_2_idx].fpu_flags : 32'd0;
    end
    `endif
    //==========================================================================
    // ASSERTIONS FOR DEBUG
    //==========================================================================

    // synthesis translate_off
    always_ff @(posedge clk) begin
        if (reset) begin
            // Check for allocation overflow
            if (num_alloc_requests > 0 && !alloc_success) begin
                $warning("[%t] ROB allocation failed - buffer full or insufficient space - or flush happened", $time);
            end

            // Check pointer wraparound
            if (head_ptr_reg > 2*BUFFER_DEPTH) begin
                $error("[%t] ROB head pointer out of range: %d", $time, head_ptr_reg);
            end
            if (tail_ptr_reg > 2*BUFFER_DEPTH) begin
                $error("[%t] ROB tail pointer out of range: %d", $time, tail_ptr_reg);
            end
        end
    end
    // synthesis translate_on

endmodule
