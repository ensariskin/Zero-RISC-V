`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Package: lsq_package
//
// Description:
//     Common definitions and types for Load-Store Queue (LSQ) implementation
//     Used across all LSQ submodules for consistent data structures
//
// Contents:
//     - LSQ entry structure definition
//     - Memory operation types
//     - Size encoding constants
//     - LSQ parameters
//////////////////////////////////////////////////////////////////////////////////

package lsq_package;

    // LSQ Parameters
    parameter int LSQ_DEPTH = 12;           // Total queue entries
    parameter int LSQ_ADDR_WIDTH = $clog2(LSQ_DEPTH);  // 4 bits for 12 entries
    parameter int DATA_WIDTH = 32;          // Data width
    parameter int TAG_WIDTH = 2;            // CDB tag width
    parameter int ROB_ADDR_WIDTH = 5;       // ROB index width (32 entries)
    parameter int PHYS_REG_WIDTH = 6;       // Physical register address width
    parameter int FORWARD_WINDOW = 4;       // Store forwarding window size
    
    // Memory operation size encoding
    typedef enum logic [1:0] {
        SIZE_BYTE = 2'b00,      // LB/LBU/SB
        SIZE_HALF = 2'b01,      // LH/LHU/SH
        SIZE_WORD = 2'b10,      // LW/SW
        SIZE_RSVD = 2'b11       // Reserved
    } mem_size_t;
    
    // LSQ entry structure
    typedef struct packed {
        // Entry validity and type
        logic                       valid;          // Entry is occupied
        logic                       is_store;       // 1=store, 0=load
        
        // Address computation
        logic                       addr_valid;     // Address has been computed
        logic [DATA_WIDTH-1:0]      address;        // Computed memory address
        logic [TAG_WIDTH-1:0]       addr_tag;       // Address dependency tag
        
        // Store data
        logic                       data_valid;     // Data available (for stores)
        logic [DATA_WIDTH-1:0]      data;           // Store data
        logic [TAG_WIDTH-1:0]       data_tag;       // Store data dependency tag
        
        // Ordering and destination
        logic [ROB_ADDR_WIDTH-1:0]  rob_idx;        // ROB index for ordering
        logic [PHYS_REG_WIDTH-1:0]  phys_reg;       // Destination physical register (loads)
        
        // Memory operation attributes
        mem_size_t                  size;           // Byte/Half/Word
        logic                       sign_extend;    // Sign extend for loads
        
        // Execution status
        logic                       executed;       // Load has been executed
        logic                       committed;      // Store has been committed
    } lsq_entry_t;
    
    // Tag constants
    localparam logic [TAG_WIDTH-1:0] TAG_ALU0  = 2'b00;
    localparam logic [TAG_WIDTH-1:0] TAG_ALU1  = 2'b01;
    localparam logic [TAG_WIDTH-1:0] TAG_ALU2  = 2'b10;
    localparam logic [TAG_WIDTH-1:0] TAG_READY = 2'b11;
    
    // Helper function: Extract bytes from word based on address and size
    function automatic logic [DATA_WIDTH-1:0] extract_bytes(
        input logic [DATA_WIDTH-1:0] word_data,
        input logic [1:0]            byte_offset,
        input mem_size_t             size,
        input logic                  sign_ext
    );
        logic [DATA_WIDTH-1:0] result;
        logic sign_bit;
        
        case (size)
            SIZE_BYTE: begin
                // Extract byte based on offset
                case (byte_offset)
                    2'b00: result[7:0] = word_data[7:0];
                    2'b01: result[7:0] = word_data[15:8];
                    2'b10: result[7:0] = word_data[23:16];
                    2'b11: result[7:0] = word_data[31:24];
                endcase
                sign_bit = sign_ext ? result[7] : 1'b0;
                result[31:8] = {24{sign_bit}};
            end
            
            SIZE_HALF: begin
                // Extract halfword based on offset (aligned to 2 bytes)
                if (byte_offset[1]) begin
                    result[15:0] = word_data[31:16];
                end else begin
                    result[15:0] = word_data[15:0];
                end
                sign_bit = sign_ext ? result[15] : 1'b0;
                result[31:16] = {16{sign_bit}};
            end
            
            SIZE_WORD: begin
                // Full word
                result = word_data;
            end
            
            default: result = '0;
        endcase
        
        return result;
    endfunction
    
    // Helper function: Insert bytes into word for stores
    function automatic logic [DATA_WIDTH-1:0] insert_bytes(
        input logic [DATA_WIDTH-1:0] store_data,
        input logic [1:0]            byte_offset,
        input mem_size_t             size
    );
        logic [DATA_WIDTH-1:0] result;
        
        case (size)
            SIZE_BYTE: begin
                case (byte_offset)
                    2'b00: result = {24'b0, store_data[7:0]};
                    2'b01: result = {16'b0, store_data[7:0], 8'b0};
                    2'b10: result = {8'b0, store_data[7:0], 16'b0};
                    2'b11: result = {store_data[7:0], 24'b0};
                endcase
            end
            
            SIZE_HALF: begin
                if (byte_offset[1]) begin
                    result = {store_data[15:0], 16'b0};
                end else begin
                    result = {16'b0, store_data[15:0]};
                end
            end
            
            SIZE_WORD: begin
                result = store_data;
            end
            
            default: result = '0;
        endcase
        
        return result;
    endfunction
    
    // Helper function: Generate byte enable for stores
    function automatic logic [3:0] generate_byte_enable(
        input logic [1:0] byte_offset,
        input mem_size_t  size
    );
        logic [3:0] be;
        
        case (size)
            SIZE_BYTE: begin
                case (byte_offset)
                    2'b00: be = 4'b0001;
                    2'b01: be = 4'b0010;
                    2'b10: be = 4'b0100;
                    2'b11: be = 4'b1000;
                endcase
            end
            
            SIZE_HALF: begin
                if (byte_offset[1]) begin
                    be = 4'b1100;
                end else begin
                    be = 4'b0011;
                end
            end
            
            SIZE_WORD: begin
                be = 4'b1111;
            end
            
            default: be = 4'b0000;
        endcase
        
        return be;
    endfunction

endpackage

