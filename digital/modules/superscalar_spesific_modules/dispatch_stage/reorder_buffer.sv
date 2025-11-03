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

    input  logic [DATA_WIDTH-1:0] cdb_correct_pc_0, // Correct PC for branch/jalr
    input  logic [DATA_WIDTH-1:0] cdb_correct_pc_1,
    input  logic [DATA_WIDTH-1:0] cdb_correct_pc_2,

    input  logic cdb_is_branch_0, // Is the instruction a branch
    input  logic cdb_is_branch_1,
    input  logic cdb_is_branch_2,

    input  logic cdb_mem_addr_calculation_0,
    input  logic cdb_mem_addr_calculation_1,
    input  logic cdb_mem_addr_calculation_2,

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
    
    output logic commit_exception_0,
    output logic commit_exception_1,
    output logic commit_exception_2,

    output logic [DATA_WIDTH-1:0] commit_correct_pc_0,
    output logic [DATA_WIDTH-1:0] commit_correct_pc_1,
    output logic [DATA_WIDTH-1:0] commit_correct_pc_2,

    output logic commit_is_branch_0,
    output logic commit_is_branch_1,
    output logic commit_is_branch_2,

    output logic [DATA_WIDTH-1:0] upadate_predictor_pc_0, // For branch predictor update
    output logic [DATA_WIDTH-1:0] upadate_predictor_pc_1,
    output logic [DATA_WIDTH-1:0] upadate_predictor_pc_2,

    
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
    output logic [ADDR_WIDTH-1:0] tail_ptr
);

    localparam D = 1;  // Delay for simulation
    localparam TAG_VALID = 3'b111;  // Tag indicating data is valid and ready

    //==========================================================================
    // BUFFER STORAGE
    //==========================================================================

    // Buffer entry structure
    logic [BUFFER_DEPTH-1:0][DATA_WIDTH-1:0] buffer_data;
    logic [BUFFER_DEPTH-1:0][TAG_WIDTH-1:0] buffer_tag;
    logic [BUFFER_DEPTH-1:0][ADDR_WIDTH-1:0] buffer_addr;
    logic [BUFFER_DEPTH-1:0] buffer_executed;
    logic [BUFFER_DEPTH-1:0] buffer_exception;

    /// branch and jalr related buffers (not efficient but easy to implement)
    logic [BUFFER_DEPTH-1:0] [DATA_WIDTH-1:0] buffer_correct_pc;
    logic [BUFFER_DEPTH-1:0] buffer_is_branch;
    logic [BUFFER_DEPTH-1:0] buffer_is_store;

    // Head and tail pointers (extra bit for full/empty detection)
    logic [ADDR_WIDTH:0] head_ptr_reg;
    logic [ADDR_WIDTH:0] tail_ptr_reg;

    logic exception_detected;

    // Assign outputs
    assign head_ptr = head_ptr_reg[ADDR_WIDTH-1:0];
    assign tail_ptr = tail_ptr_reg[ADDR_WIDTH-1:0];

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
    logic [ADDR_WIDTH-1:0] head_idx_d1, head_plus_1_idx_d1, head_plus_2_idx_d1;
    logic [1:0] num_commits;
    logic [ADDR_WIDTH:0] next_head_ptr;

    assign exception_detected = buffer_exception[head_idx];

    // Count number of allocation requests
    always_comb begin
        num_alloc_requests = alloc_enable_0 + alloc_enable_1 + alloc_enable_2;
    end

    // Check if allocation can succeed
    assign alloc_success = (entries_free >= num_alloc_requests); //todo unnecessary?

    // Assign allocation addresses (current tail position)
    assign alloc_idx_0 = tail_ptr_reg[ADDR_WIDTH-1:0];
    assign alloc_idx_1 = (tail_ptr_reg[ADDR_WIDTH-1:0] + alloc_enable_0) % BUFFER_DEPTH;
    assign alloc_idx_2 = (tail_ptr_reg[ADDR_WIDTH-1:0] + alloc_enable_0 + alloc_enable_1) % BUFFER_DEPTH;

    // Calculate next tail pointer
    always_comb begin
        next_tail_ptr = tail_ptr_reg;
        if (alloc_success && !buffer_full) begin
            next_tail_ptr = tail_ptr_reg + num_alloc_requests;
        end
        if(exception_detected) begin
            next_tail_ptr = 0; // Flush on exception
        end
    end

    assign head_idx = head_ptr_reg[ADDR_WIDTH-1:0];
    assign head_plus_1_idx = (head_ptr_reg[ADDR_WIDTH-1:0] + 1'b1) % BUFFER_DEPTH;
    assign head_plus_2_idx = (head_ptr_reg[ADDR_WIDTH-1:0] + 2'b10) % BUFFER_DEPTH;

    // Commit ready signals - in-order commit requirement
    // TODO STORES CAN COUSE BOTTLECK HERE - OPTIMEZE LATER
    assign commit_valid_0 = buffer_executed[head_idx]; //& !buffer_is_branch[head_idx];

    assign commit_valid_1 = commit_valid_0 & !buffer_exception[head_idx] & 
                            buffer_executed[head_plus_1_idx] & !buffer_exception[head_plus_1_idx] ;

    assign commit_valid_2 = commit_valid_0 & commit_valid_1  & !buffer_exception[head_plus_1_idx] &
                            buffer_executed[head_plus_2_idx] & !buffer_exception[head_plus_2_idx] ;
    

    assign lsq_commit_valid_0 = commit_valid_0 & buffer_is_store[head_idx];
    assign lsq_commit_valid_1 = commit_valid_1 & buffer_is_store[head_plus_1_idx];
    assign lsq_commit_valid_2 = commit_valid_2 & buffer_is_store[head_plus_2_idx];

    // Commit data outputs
    assign commit_data_0 = buffer_data[head_idx];
    assign commit_data_1 = buffer_data[head_plus_1_idx];
    assign commit_data_2 = buffer_data[head_plus_2_idx];
    assign commit_addr_0 = buffer_addr[head_idx];
    assign commit_addr_1 = buffer_addr[head_plus_1_idx];
    assign commit_addr_2 = buffer_addr[head_plus_2_idx];

    assign commit_exception_0 = buffer_exception[head_idx];
    assign commit_exception_1 = 1'b0; //buffer_exception[head_plus_1_idx];
    assign commit_exception_2 = 1'b0; //buffer_exception[head_plus_2_idx];

    assign commit_correct_pc_0 = buffer_correct_pc[head_idx];
    assign commit_correct_pc_1 = '0; //buffer_correct_pc[head_plus_1_idx];
    assign commit_correct_pc_2 = '0; //buffer_correct_pc[head_plus_2_idx];

    assign commit_is_branch_0 = buffer_is_branch[head_idx] & commit_valid_0;
    assign commit_is_branch_1 = buffer_is_branch[head_plus_1_idx] & commit_valid_1;
    assign commit_is_branch_2 = buffer_is_branch[head_plus_2_idx] & commit_valid_2;

    assign upadate_predictor_pc_0 = buffer_data[head_idx];
    assign upadate_predictor_pc_1 = buffer_data[head_plus_1_idx];
    assign upadate_predictor_pc_2 = buffer_data[head_plus_2_idx];


    // Store permission outputs
    assign store_can_issue_0 =  buffer_is_store[head_idx] && buffer_tag[head_idx]==TAG_VALID; //TODO add 2 more store can issue signals for head+1 and head+2 and check brnach status
    assign allowed_store_address_0 = {1'b1, head_idx};

    // todo check prev instruction is also store and both trying to write to same address
    assign store_can_issue_1 =  buffer_is_store[head_plus_1_idx] && buffer_tag[head_plus_1_idx]==TAG_VALID && (buffer_is_branch[head_idx] ? buffer_executed[head_idx] & !buffer_exception[head_idx] : 1'b1);
    assign allowed_store_address_1 = {1'b1, head_plus_1_idx};

    assign store_can_issue_2 =  buffer_is_store[head_plus_2_idx] && buffer_tag[head_plus_2_idx]==TAG_VALID && (buffer_is_branch[head_plus_1_idx] ? buffer_executed[head_plus_1_idx] & !buffer_exception[head_plus_1_idx] : 1'b1) && (buffer_is_branch[head_idx] ? buffer_executed[head_idx] & !buffer_exception[head_idx] : 1'b1);
    assign allowed_store_address_2 = {1'b1, head_plus_2_idx}; 

    // Count number of commits
    always_comb begin
        num_commits = commit_valid_0 + commit_valid_1 + commit_valid_2;
    end

    // Calculate next head pointer
    always_comb begin
        next_head_ptr = head_ptr_reg + num_commits; // default

        if(exception_detected) begin
            next_head_ptr = 0; // Flush on exception
        end
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
            //read_data_0 = buffer_data[read_addr_0]; send lsq destination address if value expected from LSQ
            read_tag_0 = buffer_tag[read_addr_0];
            if(read_tag_0 == 3'b011) begin
                read_data_0 = {26'd0, 1'b1, read_addr_0}; // LSQ destination address
            end else begin
                read_data_0 = buffer_data[read_addr_0];
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
            read_tag_1 = buffer_tag[read_addr_1];
            if(read_tag_1 == 3'b011) begin
                read_data_1 = {26'd0, 1'b1, read_addr_1}; // LSQ destination address
            end else begin
                read_data_1 = buffer_data[read_addr_1];
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
            read_tag_2 = buffer_tag[read_addr_2];
            if(read_tag_2 == 3'b011) begin
                read_data_2 = {26'd0, 1'b1, read_addr_2}; // LSQ destination address
            end else begin
                read_data_2 = buffer_data[read_addr_2];
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
            read_tag_3 = buffer_tag[read_addr_3];
            if(read_tag_3 == 3'b011) begin
                read_data_3 = {26'd0, 1'b1, read_addr_3}; // LSQ destination address
            end else begin
                read_data_3 = buffer_data[read_addr_3];
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
            read_tag_4 = buffer_tag[read_addr_4];
            if(read_tag_4 == 3'b011) begin
                read_data_4 = {26'd0, 1'b1, read_addr_4}; // LSQ destination address
            end else begin
                read_data_4 = buffer_data[read_addr_4];
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
            read_tag_5 = buffer_tag[read_addr_5];
            if(read_tag_5 == 3'b011) begin
                read_data_5 = {26'd0, 1'b1, read_addr_5}; // LSQ destination address
            end else begin
                read_data_5 = buffer_data[read_addr_5];
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
                buffer_data[i] <= #D '0;
                buffer_tag[i] <= #D '0;
                buffer_addr[i] <= #D '0;
                buffer_executed[i] <= #D 1'b0;
                buffer_exception[i] <= #D 1'b0;

                buffer_correct_pc[i] <= #D '0;
                buffer_is_branch[i] <= #D 1'b0;
                buffer_is_store[i] <= #D 1'b0;
            end

            // Reset pointers
            head_ptr_reg <= #D '0;
            tail_ptr_reg <= #D '0;

            head_idx_d1 <= #D 5'd0;
            head_plus_1_idx_d1 <= #D 5'd1;
            head_plus_2_idx_d1 <= #D 5'd2;

        end else begin
            if(exception_detected) begin
                // On exception, flush the buffer
                for (int i = 0; i < BUFFER_DEPTH; i++) begin
                    buffer_data[i] <= #D '0;
                    buffer_tag[i] <= #D '0;
                    buffer_addr[i] <= #D '0;
                    buffer_executed[i] <= #D 1'b0;
                    buffer_exception[i] <= #D 1'b0;

                    buffer_correct_pc[i] <= #D '0;
                    buffer_is_branch[i] <= #D 1'b0;
                    buffer_is_store[i] <= #D 1'b0;
                end

                // Reset pointers
                head_ptr_reg <= #D '0;
                tail_ptr_reg <= #D '0;

                head_idx_d1 <= #D 5'd0;
                head_plus_1_idx_d1 <= #D 5'd1;
                head_plus_2_idx_d1 <= #D 5'd2;
            end else begin
                // Update head pointer (commits)
                head_ptr_reg <= #D next_head_ptr;
                // Update tail pointer (allocations)
                tail_ptr_reg <= #D next_tail_ptr;

                // Update delayed head indices
                head_idx_d1 <= #D head_idx;
                head_plus_1_idx_d1 <= #D head_plus_1_idx;
                head_plus_2_idx_d1 <= #D head_plus_2_idx;

                //==================================================================
                // ALLOCATION - Initialize new entries
                //==================================================================
                if (alloc_success) begin
                    if (alloc_enable_0) begin
                        buffer_data[alloc_idx_0] <= #D '0;
                        buffer_tag[alloc_idx_0] <= #D alloc_tag_0;
                        buffer_addr[alloc_idx_0] <= #D alloc_addr_0;
                        buffer_executed[alloc_idx_0] <= #D 1'b0;
                        buffer_exception[alloc_idx_0] <= #D 1'b0;

                        buffer_correct_pc[alloc_idx_0] <= #D '0;
                        buffer_is_branch[alloc_idx_0] <= #D 1'b0; // todo set is_branch at allocation
                        buffer_is_store[alloc_idx_0] <= #D alloc_is_store_0;

                    end
                    if (alloc_enable_1) begin
                        buffer_data[alloc_idx_1] <= #D '0;
                        buffer_tag[alloc_idx_1] <= #D alloc_tag_1;
                        buffer_addr[alloc_idx_1] <= #D alloc_addr_1;
                        buffer_executed[alloc_idx_1] <= #D 1'b0;
                        buffer_exception[alloc_idx_1] <= #D 1'b0;

                        buffer_correct_pc[alloc_idx_1] <= #D '0;
                        buffer_is_branch[alloc_idx_1] <= #D 1'b0;
                        buffer_is_store[alloc_idx_1] <= #D alloc_is_store_1;
                    end
                    if (alloc_enable_2) begin
                        buffer_data[alloc_idx_2] <= #D '0;
                        buffer_tag[alloc_idx_2] <= #D alloc_tag_2;
                        buffer_addr[alloc_idx_2] <= #D alloc_addr_2;
                        buffer_executed[alloc_idx_2] <= #D 1'b0;
                        buffer_exception[alloc_idx_2] <= #D 1'b0;

                        buffer_correct_pc[alloc_idx_2] <= #D '0;
                        buffer_is_branch[alloc_idx_2] <= #D 1'b0;
                        buffer_is_store[alloc_idx_2] <= #D alloc_is_store_2;
                    end
                end

                //==================================================================
                // CDB UPDATES - Write results from execution units
                //==================================================================
                if (cdb_valid_0 && (buffer_tag[cdb_addr_0] == 3'b000 | (buffer_tag[cdb_addr_0] == 3'b011 & buffer_is_store[cdb_addr_0] & cdb_mem_addr_calculation_0))) begin
                    buffer_data[cdb_addr_0] <= #D cdb_data_0;
                    buffer_tag[cdb_addr_0] <= #D TAG_VALID;
                    buffer_executed[cdb_addr_0] <= #D !cdb_mem_addr_calculation_0;
                    buffer_exception[cdb_addr_0] <= #D cdb_exception_0;

                    buffer_correct_pc[cdb_addr_0] <= #D cdb_correct_pc_0;
                    buffer_is_branch[cdb_addr_0] <= #D cdb_is_branch_0;
                end
                if (cdb_valid_1 && (buffer_tag[cdb_addr_1] == 3'b001 | (buffer_tag[cdb_addr_1] == 3'b011 & buffer_is_store[cdb_addr_1] & cdb_mem_addr_calculation_1))) begin
                    buffer_data[cdb_addr_1] <= #D cdb_data_1;
                    buffer_tag[cdb_addr_1] <= #D TAG_VALID;
                    buffer_executed[cdb_addr_1] <= #D !cdb_mem_addr_calculation_1;
                    buffer_exception[cdb_addr_1] <= #D cdb_exception_1;

                    buffer_correct_pc[cdb_addr_1] <= #D cdb_correct_pc_1;
                    buffer_is_branch[cdb_addr_1] <= #D cdb_is_branch_1;
                end
                if (cdb_valid_2 && (buffer_tag[cdb_addr_2] == 3'b010 | (buffer_tag[cdb_addr_2] == 3'b011 & buffer_is_store[cdb_addr_2] & cdb_mem_addr_calculation_2))) begin
                    buffer_data[cdb_addr_2] <= #D cdb_data_2;
                    buffer_tag[cdb_addr_2] <= #D TAG_VALID;
                    buffer_executed[cdb_addr_2] <= #D !cdb_mem_addr_calculation_2;
                    buffer_exception[cdb_addr_2] <= #D cdb_exception_2;

                    buffer_correct_pc[cdb_addr_2] <= #D cdb_correct_pc_2;
                    buffer_is_branch[cdb_addr_2] <= #D cdb_is_branch_2;
                end
                if (cdb_valid_3_2 && (buffer_tag[cdb_addr_3_2] == 3'b011 | buffer_tag[cdb_addr_3_2] == TAG_VALID) ) begin 
                    buffer_data[cdb_addr_3_2] <= #D cdb_data_3_2;
                    buffer_tag[cdb_addr_3_2] <= #D TAG_VALID;
                    buffer_executed[cdb_addr_3_2] <= #D 1'b1;
                    buffer_exception[cdb_addr_3_2] <= #D cdb_exception_3_2;
                    buffer_is_store[cdb_addr_3_2] <= #D 1'b1;

                    buffer_correct_pc[cdb_addr_3_2] <= #D '0;
                    buffer_is_branch[cdb_addr_3_2] <= #D 1'b0;
                end
                if (cdb_valid_3_1 && (buffer_tag[cdb_addr_3_1] == 3'b011 | buffer_tag[cdb_addr_3_1] == TAG_VALID) ) begin 
                    buffer_data[cdb_addr_3_1] <= #D cdb_data_3_1;
                    buffer_tag[cdb_addr_3_1] <= #D TAG_VALID;
                    buffer_executed[cdb_addr_3_1] <= #D 1'b1;
                    buffer_exception[cdb_addr_3_1] <= #D cdb_exception_3_1;
                    buffer_is_store[cdb_addr_3_1] <= #D 1'b1;

                    buffer_correct_pc[cdb_addr_3_1] <= #D '0;
                    buffer_is_branch[cdb_addr_3_1] <= #D 1'b0;
                end
                if (cdb_valid_3_0 && (buffer_tag[cdb_addr_3_0] == 3'b011 | buffer_tag[cdb_addr_3_0] == TAG_VALID) ) begin 
                    buffer_data[cdb_addr_3_0] <= #D cdb_data_3_0;
                    buffer_tag[cdb_addr_3_0] <= #D TAG_VALID;
                    buffer_executed[cdb_addr_3_0] <= #D 1'b1;
                    buffer_exception[cdb_addr_3_0] <= #D cdb_exception_3_0;
                    buffer_is_store[cdb_addr_3_0] <= #D 1'b1;
                    

                    buffer_correct_pc[cdb_addr_3_0] <= #D '0;
                    buffer_is_branch[cdb_addr_3_0] <= #D 1'b0;
                end

                if(head_idx_d1 != head_idx) begin // detected commit
                    // Clear committed entries (head, head+1, head+2)
                    buffer_data[head_idx_d1] <= #D '0;
                    buffer_tag[head_idx_d1] <= #D '0;
                    buffer_addr[head_idx_d1] <= #D '0;
                    buffer_executed[head_idx_d1] <= #D 1'b0;
                    buffer_exception[head_idx_d1] <= #D 1'b0;

                    buffer_correct_pc[head_idx_d1] <= #D '0;
                    buffer_is_branch[head_idx_d1] <= #D 1'b0;
                    buffer_is_store[head_idx_d1] <= #D 1'b0;
                    if(head_plus_1_idx_d1 != head_idx) begin // if only one commit happened, head idx will be same as head+1 idx, so don't clear if they are same
                        buffer_data[head_plus_1_idx_d1] <= #D '0;
                        buffer_tag[head_plus_1_idx_d1] <= #D '0;
                        buffer_addr[head_plus_1_idx_d1] <= #D '0;
                        buffer_executed[head_plus_1_idx_d1] <= #D 1'b0;
                        buffer_exception[head_plus_1_idx_d1] <= #D 1'b0;

                        buffer_correct_pc[head_plus_1_idx_d1] <= #D '0;
                        buffer_is_branch[head_plus_1_idx_d1] <= #D 1'b0;
                        buffer_is_store[head_plus_1_idx_d1] <= #D 1'b0;
                        if(head_plus_2_idx_d1 != head_idx) begin
                            buffer_data[head_plus_2_idx_d1] <= #D '0;
                            buffer_tag[head_plus_2_idx_d1] <= #D '0;
                            buffer_addr[head_plus_2_idx_d1] <= #D '0;
                            buffer_executed[head_plus_2_idx_d1] <= #D 1'b0;
                            buffer_exception[head_plus_2_idx_d1] <= #D 1'b0;

                            buffer_correct_pc[head_plus_2_idx_d1] <= #D '0;
                            buffer_is_branch[head_plus_2_idx_d1] <= #D 1'b0;
                            buffer_is_store[head_plus_2_idx_d1] <= #D 1'b0;
                        end
                    end
                end

            end
        end
    end

    //==========================================================================
    // ASSERTIONS FOR DEBUG
    //==========================================================================

    // synthesis translate_off
    always_ff @(posedge clk) begin
        if (reset) begin
            // Check for allocation overflow
            if (num_alloc_requests > 0 && !alloc_success) begin
                $warning("[%t] ROB allocation failed - buffer full or insufficient space", $time);
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
