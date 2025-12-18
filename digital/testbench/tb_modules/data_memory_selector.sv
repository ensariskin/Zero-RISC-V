//////////////////////////////////////////////////////////////////////////////////
// Data Memory Selector for RV32I Core
// 
// This module selects between two data memory regions based on address:
// - Region 0: 0x80000000 - 0x80013047 (4KB)
// - Region 1: 0x80001000 - 0x80023047 (64KB)
//
// The module implements address decoding and routes requests to the appropriate
// memory instance while maintaining Wishbone protocol compliance.
//////////////////////////////////////////////////////////////////////////////////

module data_memory_selector (
    input logic clk,
    input logic rst_n,
    
    // Core interface (from data wb adapter)
    input logic         core_wb_cyc_i,
    input logic         core_wb_stb_i,
    input logic         core_wb_we_i,
    input logic [31:0]  core_wb_adr_i,
    input logic [31:0]  core_wb_dat_i,
    input logic [3:0]   core_wb_sel_i,
    output logic        core_wb_stall_o,
    output logic        core_wb_ack_o,
    output logic [31:0] core_wb_dat_o,
    output logic        core_wb_err_o,
    
    // Region 0 memory interface
    output logic        region0_wb_cyc_o,
    output logic        region0_wb_stb_o,
    output logic        region0_wb_we_o,
    output logic [31:0] region0_wb_adr_o,
    output logic [31:0] region0_wb_dat_o,
    output logic [3:0]  region0_wb_sel_o,
    input logic         region0_wb_stall_i,
    input logic         region0_wb_ack_i,
    input logic [31:0]  region0_wb_dat_i,
    input logic         region0_wb_err_i,
    
    // Region 1 memory interface
    output logic        region1_wb_cyc_o,
    output logic        region1_wb_stb_o,
    output logic        region1_wb_we_o,
    output logic [31:0] region1_wb_adr_o,
    output logic [31:0] region1_wb_dat_o,
    output logic [3:0]  region1_wb_sel_o,
    input logic         region1_wb_stall_i,
    input logic         region1_wb_ack_i,
    input logic [31:0]  region1_wb_dat_i,
    input logic         region1_wb_err_i,


   input logic [31:0]  REGION0_BASE,
   input logic [31:0]  REGION1_BASE
);

    // Address mapping parameters

    parameter logic [31:0] REGION0_SIZE = 32'h00001000;  // 4KB (4096 bytes)
    parameter logic [31:0] REGION1_SIZE = 32'h00010000;  // 64KB (65536 bytes)
    
    // Calculate end addresses
    logic [31:0] REGION0_END; 
    logic [31:0] REGION1_END;
    assign REGION0_END = REGION0_BASE + REGION0_SIZE - 1;
    assign REGION1_END = REGION1_BASE + REGION1_SIZE - 1;
    
    // Address decoding signals
    logic addr_in_region0;
    logic addr_in_region1;
    logic addr_valid;
    logic addr_in_region0_d1;
    logic addr_in_region1_d1;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            addr_in_region0_d1 <= 1'b0;
            addr_in_region1_d1 <= 1'b0;
  
        end else begin
            addr_in_region0_d1 <= addr_in_region0;
            addr_in_region1_d1 <= addr_in_region1;
            
        end
    end
    // Address decoding logic
    always_comb begin
        addr_in_region0 = (core_wb_adr_i >= REGION0_BASE) && (core_wb_adr_i <= REGION0_END);
        addr_in_region1 = (core_wb_adr_i >= REGION1_BASE) && (core_wb_adr_i <= REGION1_END);
        addr_valid = addr_in_region0 || addr_in_region1;
    end
    
    // Region 0 memory control
    always_comb begin
        if (addr_in_region0) begin
            region0_wb_cyc_o = core_wb_cyc_i;
            region0_wb_stb_o = core_wb_stb_i;
            region0_wb_we_o  = core_wb_we_i;
            region0_wb_adr_o = core_wb_adr_i - REGION0_BASE; // Convert to local address
            region0_wb_dat_o = core_wb_dat_i;
            region0_wb_sel_o = core_wb_sel_i;
        end else begin
            region0_wb_cyc_o = 1'b0;
            region0_wb_stb_o = 1'b0;
            region0_wb_we_o  = 1'b0;
            region0_wb_adr_o = 32'h0;
            region0_wb_dat_o = 32'h0;
            region0_wb_sel_o = 4'h0;
        end
    end
    
    // Region 1 memory control
    always_comb begin
        if (addr_in_region1) begin
            region1_wb_cyc_o = core_wb_cyc_i;
            region1_wb_stb_o = core_wb_stb_i;
            region1_wb_we_o  = core_wb_we_i;
            region1_wb_adr_o = core_wb_adr_i - REGION1_BASE; // Convert to local address
            region1_wb_dat_o = core_wb_dat_i;
            region1_wb_sel_o = core_wb_sel_i;
        end else begin
            region1_wb_cyc_o = 1'b0;
            region1_wb_stb_o = 1'b0;
            region1_wb_we_o  = 1'b0;
            region1_wb_adr_o = 32'h0;
            region1_wb_dat_o = 32'h0;
            region1_wb_sel_o = 4'h0;
        end
    end
    
    // Core response multiplexing
    always_comb begin
        if (addr_in_region0_d1 | addr_in_region0) begin
            core_wb_stall_o = region0_wb_stall_i;
            core_wb_ack_o   = region0_wb_ack_i;
            core_wb_dat_o   = region0_wb_dat_i;
            core_wb_err_o   = region0_wb_err_i;
        end else if (addr_in_region1_d1 | addr_in_region1) begin
            core_wb_stall_o = region1_wb_stall_i;
            core_wb_ack_o   = region1_wb_ack_i;
            core_wb_dat_o   = region1_wb_dat_i;
            core_wb_err_o   = region1_wb_err_i;
        end else begin
            // Invalid address - generate error response
            core_wb_stall_o = 1'b0;
            core_wb_ack_o   = 0; // Acknowledge immediately for error
            core_wb_dat_o   = 32'hDEADBEEF; // Error data pattern
            core_wb_err_o   = core_wb_cyc_i && core_wb_stb_i; // Signal error for invalid address
        end
    end

    initial begin
        // Display region base addresses and sizes
        #1;
        $display("Region 0 base address: 0x%08x (Size: %0d bytes) , Region 0 end_address = 0x%08x", REGION0_BASE, REGION0_SIZE, REGION0_END);
        $display("Region 1 base address: 0x%08x (Size: %0d bytes) , Region 1 end_address = 0x%08x", REGION1_BASE, REGION1_SIZE, REGION1_END);
    end
    
    always @(posedge clk) begin
        if (rst_n && core_wb_cyc_i && core_wb_stb_i && !addr_valid) begin
            $display("[%t] ERROR: Memory Selector - Invalid address access 0x%08x", $time, core_wb_adr_i);
            #100ns;
            $finish;
        end
    end
    
    // Debug information
    `ifdef DEBUG_MEMORY_SELECTOR
    always @(posedge clk) begin
        if (rst_n && core_wb_cyc_i && core_wb_stb_i) begin
            if (addr_in_region0) begin
                $display("[%t] Memory Selector: Access to Region 0, Addr=0x%08x, Local=0x%08x, WE=%b", 
                         $time, core_wb_adr_i, region0_wb_adr_o, core_wb_we_i);
            end else if (addr_in_region1) begin
                $display("[%t] Memory Selector: Access to Region 1, Addr=0x%08x, Local=0x%08x, WE=%b", 
                         $time, core_wb_adr_i, region1_wb_adr_o, core_wb_we_i);
            end else begin
                $display("[%t] Memory Selector: Invalid address access 0x%08x", $time, core_wb_adr_i);
            end
        end
    end
    `endif

endmodule
