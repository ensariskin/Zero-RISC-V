`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2025
// Design Name: Synthesizable Instruction Buffer for Superscalar Processor
// Module Name: instruction_buffer_new
// Project Name: RV32I Superscalar
// Target Devices: 
// Tool Versions: 
// Description: Fully synthesizable instruction buffer that decouples fetch and decode
//              stages. Handles up to 3 instructions input/output per cycle.
//              Prevents deadlock with proper backpressure handling.
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created from scratch
// Additional Comments: 
// - Uses only synthesizable SystemVerilog constructs
// - Proper circular buffer with head/tail pointers
// - Conservative flow control to prevent deadlock
// - No automatic variables or non-synthesizable constructs
//////////////////////////////////////////////////////////////////////////////////

module instruction_buffer_new #(
    parameter BUFFER_DEPTH = 16,    // Number of instruction entries (must be power of 2)
    parameter DATA_WIDTH = 32
)(
    input  logic clk,
    input  logic reset,
    
    // Input from multi_fetch (up to 3 instructions per cycle)
    input  logic [4:0] fetch_valid_i,           // Which of the 3 fetch slots are valid
    input  logic [DATA_WIDTH-1:0] instruction_i_0, instruction_i_1, instruction_i_2, instruction_i_3, instruction_i_4,
    input  logic [DATA_WIDTH-1:0] pc_i_0, pc_i_1, pc_i_2, pc_i_3, pc_i_4,
    input  logic [DATA_WIDTH-1:0] imm_i_0, imm_i_1, imm_i_2, imm_i_3, imm_i_4,
    input  logic [DATA_WIDTH-1:0] pc_at_prediction_i_0, pc_at_prediction_i_1, pc_at_prediction_i_2, pc_at_prediction_i_3, pc_at_prediction_i_4,
    input  logic branch_prediction_i_0, branch_prediction_i_1, branch_prediction_i_2, branch_prediction_i_3, branch_prediction_i_4,
    
    // Output to decode stages (up to 3 instructions per cycle)
    output logic [2:0] decode_valid_o,          // How many instructions are available for decode
    output logic [DATA_WIDTH-1:0] instruction_o_0, instruction_o_1, instruction_o_2,
    output logic [DATA_WIDTH-1:0] pc_o_0, pc_o_1, pc_o_2,
    output logic [DATA_WIDTH-1:0] imm_o_0, imm_o_1, imm_o_2,
    output logic [DATA_WIDTH-1:0] pc_value_at_prediction_o_0, pc_value_at_prediction_o_1, pc_value_at_prediction_o_2,
    output logic branch_prediction_o_0, branch_prediction_o_1, branch_prediction_o_2,

    // Control signals
    input  logic [2:0] decode_ready_i,          // Which decode stages are ready to accept instructions
    output logic fetch_ready_o,                // Can accept more instructions from fetch
    input  logic flush_i,                      // Flush all buffered instructions
    
    // Status outputs
    output logic buffer_empty_o,
    output logic buffer_full_o,
    output logic [$clog2(BUFFER_DEPTH):0] occupancy_o              // Number of valid entries in buffer (up to 8)
);

    localparam D = 1; // Delay for simulation purposes
    
    // Buffer storage - separate arrays for each field (more synthesizable)
    logic [DATA_WIDTH-1:0] instruction_mem [BUFFER_DEPTH];
    logic [DATA_WIDTH-1:0] pc_mem [BUFFER_DEPTH];
    logic [DATA_WIDTH-1:0] pc_at_prediction_mem [BUFFER_DEPTH];
    logic [DATA_WIDTH-1:0] imm_mem [BUFFER_DEPTH];
    logic branch_prediction_mem [BUFFER_DEPTH];
    
    // Pointers (3-bit for 8 entries)
    logic [$clog2(BUFFER_DEPTH):0] head_ptr;    // Points to next read location
    logic [$clog2(BUFFER_DEPTH):0] tail_ptr;    // Points to next write location
    logic [$clog2(BUFFER_DEPTH):0] count;       // Number of valid entries (0-8)

    logic [$clog2(BUFFER_DEPTH):0] decode_1_read_offset;     
    logic [$clog2(BUFFER_DEPTH):0] decode_2_read_offset;   
    
    // Write enable signals for each slot
    logic write_en_0, write_en_1, write_en_2, write_en_3, write_en_4;
    logic read_en_0, read_en_1, read_en_2;
    
    // Determine how many instructions we can actually write
    logic [3:0] num_to_write;
    logic [2:0] num_to_read;
    logic [$clog2(BUFFER_DEPTH):0] space_available;
    logic [2:0] instructions_available;
    logic use_fwd_0, use_fwd_1, use_fwd_2;
    // Calculate available space (conservative)
    assign space_available = BUFFER_DEPTH - count; //(BUFFER_DEPTH > count) ? (BUFFER_DEPTH - count[2:0]) : 3'd0;
    
    // Calculate available instructions to read
    assign instructions_available = ((count+num_to_write) >= 3) ? 3'd3 : count[2:0];
    assign use_fwd_0 = (count == 0) & (num_to_write >= 1) & read_en_0;
    assign use_fwd_1 = (count <= read_en_0) & (num_to_write >= (1 + use_fwd_0)) & read_en_1;
    assign use_fwd_2 = (count <= read_en_0 + read_en_1) & (num_to_write >= (1 + use_fwd_0 + use_fwd_1)) & read_en_2;
    // Status outputs
    assign buffer_empty_o = (count == 0);
    assign buffer_full_o = (count >= (BUFFER_DEPTH - 3)); // Conservative: leave space for 3 instructions
    assign occupancy_o = count;
    
    // Backpressure logic - conservative to prevent deadlock
    assign fetch_ready_o = !flush_i && !buffer_full_o && (space_available >= 5);
    
    /* */
    // Calculate how many instructions to write this cycle
    always_comb begin
        if (flush_i || !fetch_ready_o) begin
            num_to_write = 4'd0;
        end else begin
            // Count valid input instructions
            num_to_write = fetch_valid_i[0] + fetch_valid_i[1] + fetch_valid_i[2] + fetch_valid_i[3] + fetch_valid_i[4];
            /* 
            case ({fetch_valid_i[2], fetch_valid_i[1], fetch_valid_i[0]})
                3'b001: num_to_write = (space_available >= 1) ? 3'd1 : 3'd0;
                3'b010: num_to_write = (space_available >= 1) ? 3'd0 : 3'd0;
                3'b011: num_to_write = (space_available >= 2) ? 3'd2 : 3'd0;
                3'b100: num_to_write = (space_available >= 1) ? 3'd0 : 3'd0;
                3'b101: num_to_write = (space_available >= 2) ? 3'd1 : 3'd0;
                3'b110: num_to_write = (space_available >= 2) ? 3'd0 : 3'd0;
                3'b111: num_to_write = (space_available >= 3) ? 3'd3 : 3'd0;
                default: num_to_write = 3'd0;
            endcase
            */
        end
    end
    
    // Calculate how many instructions to read this cycle
    always_comb begin
        if (flush_i) begin
            num_to_read = 3'd0;
        end else begin
            // Count ready decode stages
            case ({decode_valid_o[2], decode_valid_o[1], decode_valid_o[0]})
                3'b001: num_to_read = (instructions_available >= 1) ? 3'd1 : 3'd0;
                3'b010: num_to_read = (instructions_available >= 1) ? 3'd1 : 3'd0;
                3'b011: num_to_read = (instructions_available >= 2) ? 3'd2 : 3'd0;
                3'b100: num_to_read = (instructions_available >= 1) ? 3'd1 : 3'd0;
                3'b101: num_to_read = (instructions_available >= 2) ? 3'd2 : 3'd0;
                3'b110: num_to_read = (instructions_available >= 2) ? 3'd2 : 3'd0;
                3'b111: num_to_read = (instructions_available >= 3) ? 3'd3 : 3'd0;
                default: num_to_read = 3'd0;
            endcase
        end
    end
    
    // Generate write enables
    assign write_en_0 = fetch_valid_i[0];
    assign write_en_1 = fetch_valid_i[1];
    assign write_en_2 = fetch_valid_i[2];
    assign write_en_3 = fetch_valid_i[3];
    assign write_en_4 = fetch_valid_i[4];
    
    // Generate read enables
    assign read_en_0 = decode_ready_i[0];
    assign read_en_1 = decode_ready_i[1];
    assign read_en_2 = decode_ready_i[2];

    assign decode_valid_o[0] = read_en_0 && (instructions_available >= 1);
    assign decode_valid_o[1] = read_en_1 && (instructions_available >= (1 + decode_ready_i[0]));
    assign decode_valid_o[2] = read_en_2 && (instructions_available >= (1 + decode_ready_i[0] + decode_ready_i[1]));
    
    // Sequential logic
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            head_ptr <= #D {$clog2(BUFFER_DEPTH)+1{1'b0}};
            tail_ptr <= #D {$clog2(BUFFER_DEPTH)+1{1'b0}};
            count <= #D 5'd0;
            
            // Initialize memory arrays
            for (int i = 0; i < BUFFER_DEPTH; i++) begin
                
                instruction_mem[i] <= #D 32'h00000013; // NOP
                pc_mem[i] <= #D 32'h0;
                imm_mem[i] <= #D 32'h0;
                branch_prediction_mem[i] <= #D 1'b0;
                pc_at_prediction_mem[i] <= #D 32'h0;
            end
        end else begin
            // Handle flush
            if (flush_i) begin
                head_ptr <= #D {$clog2(BUFFER_DEPTH)+1{1'b0}};
                tail_ptr <= #D {$clog2(BUFFER_DEPTH)+1{1'b0}};
                count <= #D 5'd0;
                
            end else begin
                // Update pointers and count
                if (write_en_0 || write_en_1 || write_en_2 || write_en_3 || write_en_4) begin // we can only check write_en_0
                    tail_ptr <= #D (tail_ptr + num_to_write) % BUFFER_DEPTH;
                end
                
                if (read_en_0 || read_en_1 || read_en_2) begin
                    head_ptr <= #D (head_ptr + num_to_read) % BUFFER_DEPTH;
                end
                
                count <= #D count + num_to_write - num_to_read;
                
                // Write new instructions
                if (write_en_0) begin
                    instruction_mem[tail_ptr] <= #D instruction_i_0;
                    pc_mem[tail_ptr] <= #D pc_i_0;
                    imm_mem[tail_ptr] <= #D imm_i_0;
                    branch_prediction_mem[tail_ptr] <= #D branch_prediction_i_0;
                    pc_at_prediction_mem[tail_ptr] <= #D pc_at_prediction_i_0;
                    
                end
                
                if (write_en_1) begin
                    instruction_mem[(tail_ptr + 1) % BUFFER_DEPTH] <= #D instruction_i_1;
                    pc_mem[(tail_ptr + 1) % BUFFER_DEPTH] <= #D pc_i_1;
                    imm_mem[(tail_ptr + 1) % BUFFER_DEPTH] <= #D imm_i_1;
                    branch_prediction_mem[(tail_ptr + 1) % BUFFER_DEPTH] <= #D branch_prediction_i_1;
                    pc_at_prediction_mem[(tail_ptr + 1) % BUFFER_DEPTH] <= #D pc_at_prediction_i_1;
                   
                end
                
                if (write_en_2) begin
                    instruction_mem[(tail_ptr + 2) % BUFFER_DEPTH] <= #D instruction_i_2;
                    pc_mem[(tail_ptr + 2) % BUFFER_DEPTH] <= #D pc_i_2;
                    imm_mem[(tail_ptr + 2) % BUFFER_DEPTH] <= #D imm_i_2;
                    branch_prediction_mem[(tail_ptr + 2) % BUFFER_DEPTH] <= #D branch_prediction_i_2;
                    pc_at_prediction_mem[(tail_ptr + 2) % BUFFER_DEPTH] <= #D pc_at_prediction_i_2;
                end
                if (write_en_3) begin
                    instruction_mem[(tail_ptr + 3) % BUFFER_DEPTH] <= #D instruction_i_3;
                    pc_mem[(tail_ptr + 3) % BUFFER_DEPTH] <= #D pc_i_3;
                    imm_mem[(tail_ptr + 3) % BUFFER_DEPTH] <= #D imm_i_3;
                    branch_prediction_mem[(tail_ptr + 3) % BUFFER_DEPTH] <= #D branch_prediction_i_3;
                    pc_at_prediction_mem[(tail_ptr + 3) % BUFFER_DEPTH] <= #D pc_at_prediction_i_3;
                end
                if (write_en_4) begin
                    instruction_mem[(tail_ptr + 4) % BUFFER_DEPTH] <= #D instruction_i_4;
                    pc_mem[(tail_ptr + 4) % BUFFER_DEPTH] <= #D pc_i_4;
                    imm_mem[(tail_ptr + 4) % BUFFER_DEPTH] <= #D imm_i_4;
                    branch_prediction_mem[(tail_ptr + 4) % BUFFER_DEPTH] <= #D branch_prediction_i_4;
                    pc_at_prediction_mem[(tail_ptr + 4) % BUFFER_DEPTH] <= #D pc_at_prediction_i_4;
                end                    
            end
        end
    end
    
    // Output assignments (combinational)
    always_comb begin
        // Default outputs (NOPs)
        instruction_o_0 = 32'h00000013; // NOP
        instruction_o_1 = 32'h00000013; // NOP
        instruction_o_2 = 32'h00000013; // NOP
        pc_o_0 = 32'h0;
        pc_o_1 = 32'h0;
        pc_o_2 = 32'h0;
        imm_o_0 = 32'h0;
        imm_o_1 = 32'h0;
        imm_o_2 = 32'h0;
        branch_prediction_o_0 = 1'b0;
        branch_prediction_o_1 = 1'b0;
        branch_prediction_o_2 = 1'b0;

        decode_1_read_offset = decode_valid_o[0] ? 1 : 0 ;
        decode_2_read_offset = decode_valid_o[0] + decode_valid_o[1];
        
        // Output valid instructions
        if (decode_valid_o[0]) begin
            if(use_fwd_0) begin
                instruction_o_0 = instruction_i_0;
                pc_o_0 = pc_i_0;
                imm_o_0 = imm_i_0;
                branch_prediction_o_0 = branch_prediction_i_0;
                pc_value_at_prediction_o_0 = pc_at_prediction_i_0;
            end else begin
                instruction_o_0 = instruction_mem[head_ptr];
                pc_o_0 = pc_mem[head_ptr];
                imm_o_0 = imm_mem[head_ptr];
                branch_prediction_o_0 = branch_prediction_mem[head_ptr];
                pc_value_at_prediction_o_0 = pc_at_prediction_mem[head_ptr];
            end
        end
        
        if (decode_valid_o[1]) begin
            if(use_fwd_1) begin
                if(use_fwd_0) begin
                    instruction_o_1 = instruction_i_1;
                    pc_o_1 = pc_i_1;
                    imm_o_1 = imm_i_1;
                    branch_prediction_o_1 = branch_prediction_i_1;
                    pc_value_at_prediction_o_1 = pc_at_prediction_i_1;
                end else begin
                    instruction_o_1 = instruction_i_0;
                    pc_o_1 = pc_i_0;
                    imm_o_1 = imm_i_0;
                    branch_prediction_o_1 = branch_prediction_i_0;
                    pc_value_at_prediction_o_1 = pc_at_prediction_i_0;
                end
            end else begin
                instruction_o_1 = instruction_mem[(head_ptr + decode_1_read_offset) % BUFFER_DEPTH];
                pc_o_1 = pc_mem[(head_ptr + decode_1_read_offset) % BUFFER_DEPTH];
                imm_o_1 = imm_mem[(head_ptr + decode_1_read_offset) % BUFFER_DEPTH];
                branch_prediction_o_1 = branch_prediction_mem[(head_ptr + decode_1_read_offset) % BUFFER_DEPTH];
                pc_value_at_prediction_o_1 = pc_at_prediction_mem[(head_ptr + decode_1_read_offset) % BUFFER_DEPTH];
            end
        end
        
        if (decode_valid_o[2]) begin
            if(use_fwd_2) begin
                if(use_fwd_1) begin
                    if(use_fwd_0) begin
                        instruction_o_2 = instruction_i_2;
                        pc_o_2 = pc_i_2;
                        imm_o_2 = imm_i_2;
                        branch_prediction_o_2 = branch_prediction_i_2;
                        pc_value_at_prediction_o_2 = pc_at_prediction_i_2;
                    end else begin
                        instruction_o_2 = instruction_i_1;
                        pc_o_2 = pc_i_1;
                        imm_o_2 = imm_i_1;
                        branch_prediction_o_2 = branch_prediction_i_1;
                        pc_value_at_prediction_o_2 = pc_at_prediction_i_1;
                    end
                end else begin
                    instruction_o_2 = instruction_i_0;
                    pc_o_2 = pc_i_0;
                    imm_o_2 = imm_i_0;
                    branch_prediction_o_2 = branch_prediction_i_0;
                    pc_value_at_prediction_o_2 = pc_at_prediction_i_0;
                end
            end else begin
                instruction_o_2 = instruction_mem[(head_ptr + decode_2_read_offset) % BUFFER_DEPTH];
                pc_o_2 = pc_mem[(head_ptr + decode_2_read_offset) % BUFFER_DEPTH];
                imm_o_2 = imm_mem[(head_ptr + decode_2_read_offset) % BUFFER_DEPTH];
                branch_prediction_o_2 = branch_prediction_mem[(head_ptr + decode_2_read_offset) % BUFFER_DEPTH];
                pc_value_at_prediction_o_2 = pc_at_prediction_mem[(head_ptr + decode_2_read_offset) % BUFFER_DEPTH];
            end
        end
    end

endmodule