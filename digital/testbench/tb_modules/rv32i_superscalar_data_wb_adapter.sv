//////////////////////////////////////////////////////////////////////////////////
// RV32I Superscalar Data Wishbone Adapter
// 
// Converts core data interface to Wishbone B4 for memory access
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module rv32i_superscalar_data_wb_adapter (
    // Clock and reset
    input  logic        clk,
    input  logic        rst_n,
    
    // Core data interface
    input  logic [31:0] core_addr_i,
    input  logic [31:0] core_data_i,
    output logic [31:0] core_data_o,
    input  logic        core_we_i,
    input  logic [3:0]  core_be_i,
    input  logic        core_req_i,
    output logic        core_ack_o,
    output logic        core_err_o,
    
    // Wishbone B4 interface
    output logic        wb_cyc_o,
    output logic        wb_stb_o,
    output logic        wb_we_o,
    output logic [31:0] wb_adr_o,
    output logic [31:0] wb_dat_o,
    output logic [3:0]  wb_sel_o,
    input  logic        wb_stall_i,
    input  logic        wb_ack_i,
    input  logic [31:0] wb_dat_i,
    input  logic        wb_err_i
);

    localparam D = 1; // Delay for simulation purposes

    // State machine for wishbone transactions
    typedef enum logic [1:0] {
        IDLE   = 2'b00,
        ACCESS = 2'b01,
        WAIT   = 2'b10
    } state_t;
    
    state_t current_state, next_state;
    logic request_pending;
    
    // State machine - sequential logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= #D IDLE;
            request_pending <= #D 1'b0;
        end else begin
            current_state <= #D next_state;
            
            case (current_state)
                IDLE: begin
                    if (core_req_i) begin
                        request_pending <= #D 1'b1;
                    end
                end
                
                ACCESS: begin
                    if (wb_ack_i || wb_err_i) begin
                        request_pending <= #D 1'b0;
                    end
                end
                
                WAIT: begin
                    request_pending <= #D 1'b0;
                end
            endcase
        end
    end
    
    // State machine - combinational logic
    always_comb begin
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (core_req_i) begin
                    next_state = ACCESS;
                end
            end
            
            ACCESS: begin
                if (wb_ack_i || wb_err_i) begin
                    next_state = IDLE;
                end
            end
            
            WAIT: begin
                next_state = IDLE;
            end
        endcase
    end
    
    // Wishbone output assignments
    assign wb_cyc_o = (current_state == ACCESS);
    assign wb_stb_o = (current_state == ACCESS);
    assign wb_we_o  = core_we_i;
    assign wb_adr_o = core_addr_i;
    assign wb_dat_o = core_data_i;
    assign wb_sel_o = core_be_i;
    
    // Core output assignments
    assign core_data_o = wb_dat_i;
    assign core_ack_o  = wb_ack_i && (current_state == ACCESS);
    assign core_err_o  = wb_err_i && (current_state == ACCESS);

endmodule
