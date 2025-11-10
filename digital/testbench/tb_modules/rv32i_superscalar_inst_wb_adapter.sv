//////////////////////////////////////////////////////////////////////////////////
// RV32I Superscalar Instruction Wishbone Adapter
// 
// Converts core instruction interface to Wishbone B4 for 3-port parallel fetch
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module rv32i_superscalar_inst_wb_adapter (
    // Clock and reset
    input  logic        clk,
    input  logic        rst_n,
    
    // Core instruction interface
    input  logic [31:0] core_addr_i,
    output logic [31:0] core_data_o,
    
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
        IDLE  = 2'b00,
        FETCH = 2'b01,
        WAIT  = 2'b10
    } state_t;
    
    state_t current_state, next_state;
    logic [31:0] addr_reg;
    logic [31:0] data_reg;
    logic        data_valid;
    
    // State machine - sequential logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= #D IDLE;
            addr_reg <= #D core_addr_i;
            data_reg <= #D 32'h0;
            data_valid <= #D 1'b0;
        end else begin
            current_state <= #D next_state;
            
            case (current_state)
                IDLE: begin
                    addr_reg <= #D core_addr_i;
                    data_valid <= #D 1'b0;
                end
                
                FETCH: begin
                    if (wb_ack_i) begin
                        data_reg <= #D wb_dat_i;
                        data_valid <= #D 1'b1;
                    end
                end
                
                WAIT: begin
                    data_valid <= #D 1'b0;
                end
            endcase
        end
    end
    
    // State machine - combinational logic
    always_comb begin
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                next_state = FETCH;
            end
            
            FETCH: begin
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
    assign wb_cyc_o = (current_state == FETCH);
    assign wb_stb_o = (current_state == FETCH);
    assign wb_we_o  = 1'b0;  // Instructions are read-only
    assign wb_adr_o = addr_reg;
    assign wb_dat_o = 32'h0; // No data output for reads
    assign wb_sel_o = 4'b1111; // Always full word access for instructions
    
    // Core output assignment
    assign core_data_o = data_valid ? data_reg : wb_dat_i;

endmodule
