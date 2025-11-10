//////////////////////////////////////////////////////////////////////////////////
// Circular Buffer with 3 Read/Write Ports
// 
// This module implements a circular buffer where:
// - Buffer values are constant and equal to their index positions
// - 3 independent read ports with individual enable signals
// - Read pointer updates based on number of enabled reads (0-3)
// - 3 write ports with write pointer management
// - Valid flags for each read port
// - Reads show current values at read pointer position before pointer update
//////////////////////////////////////////////////////////////////////////////////

module circular_buffer_3port #(
    parameter BUFFER_DEPTH = 32,  // Must be power of 2
    parameter ADDR_WIDTH = $clog2(BUFFER_DEPTH)
)(
    input  logic clk,
    input  logic rst_n,
    
    // Read port enables
    input  logic read_en_0,
    input  logic read_en_1,
    input  logic read_en_2,
    
    // Read data outputs (show current values before pointer update)
    output logic [ADDR_WIDTH:0] read_data_0,
    output logic [ADDR_WIDTH:0] read_data_1,
    output logic [ADDR_WIDTH:0] read_data_2,
    
    // Read valid outputs (indicate if read data is valid)
    output logic read_valid_0,
    output logic read_valid_1,
    output logic read_valid_2,
    
    // Write port enables
    input  logic write_en_0,
    input  logic write_en_1,
    input  logic write_en_2,
    
    // Write data inputs (optional - not used since values = index)
    //input  logic [DATA_WIDTH-1:0] write_data_0,
    //input  logic [DATA_WIDTH-1:0] write_data_1,
    //input  logic [DATA_WIDTH-1:0] write_data_2,
    
    // Status outputs
    output logic buffer_empty,
    output logic buffer_full,
    output logic [ADDR_WIDTH:0] buffer_count  // Number of valid entries
);
     
    localparam D = 1; // Delay for non-blocking assignments (for simulation purposes)
    // Internal buffer storage (initialized with index values)
    logic [ADDR_WIDTH-1:0] buffer_mem [0:BUFFER_DEPTH-1];
    
    // Read and write pointers (extra bit for full/empty detection)
    logic [ADDR_WIDTH:0] read_ptr;
    logic [ADDR_WIDTH:0] write_ptr;
    
    // Internal signals
    logic [ADDR_WIDTH:0] entries_available;
    logic [1:0] num_reads;  // 0-3 reads enabled
    logic [1:0] num_writes; // 0-3 writes enabled
    logic [ADDR_WIDTH:0] next_read_ptr;
    logic [ADDR_WIDTH:0] next_write_ptr;
    
    //==========================================================================
    // BUFFER INITIALIZATION (values equal to index)
    //==========================================================================
    
    always_comb begin
        for (int i = 0; i < BUFFER_DEPTH; i++) begin
            buffer_mem[i] = i[ADDR_WIDTH-1:0];
        end
    end
    
    //==========================================================================
    // COUNT NUMBER OF ENABLED READS/WRITES
    //==========================================================================
    
    always_comb begin
        num_reads  = read_en_0 + read_en_1 + read_en_2;
        num_writes = write_en_0 + write_en_1 + write_en_2;
    end

    
    //==========================================================================
    // BUFFER STATUS SIGNALS
    //==========================================================================
    
    // Calculate number of entries available for reading
    assign entries_available = write_ptr[ADDR_WIDTH] ? (write_ptr - read_ptr) : read_ptr[ADDR_WIDTH] ? (BUFFER_DEPTH + write_ptr[ADDR_WIDTH-1:0] - read_ptr[ADDR_WIDTH-1:0])  :  write_ptr - read_ptr;
    assign buffer_count = entries_available;
    
    // Empty when read pointer equals write pointer
    assign buffer_empty = (entries_available == 0);
    
    // Full when count equals buffer depth
    assign buffer_full = (entries_available == BUFFER_DEPTH);
    
    //==========================================================================
    // READ DATA OUTPUTS (Current values before pointer update)
    //==========================================================================
   
    logic [ADDR_WIDTH:0] data_0;
    logic [ADDR_WIDTH:0] data_1;
    logic [ADDR_WIDTH:0] data_2;
    
    logic valid_0;
    logic valid_1;
    logic valid_2;
    
    // Read port 0: Current read pointer position
    always_comb begin
        if (!buffer_empty && entries_available >= 1) begin
            data_0 = {1'b1, buffer_mem[read_ptr[ADDR_WIDTH-1:0]]};
            valid_0 = 1'b1;
        end else begin
            data_0 = '0;
            valid_0 = 1'b0;
        end
    end
    
    // Read port 1: Read pointer + 1
    always_comb begin
        if (!buffer_empty && entries_available >= 2) begin
            data_1 = {1'b1, buffer_mem[(read_ptr[ADDR_WIDTH-1:0] + 1) % BUFFER_DEPTH]};
            valid_1 = 1'b1;
        end else begin
            data_1 = '0;
            valid_1 = 1'b0;
        end
    end
    
    // Read port 2: Read pointer + 2
    always_comb begin
        if (!buffer_empty && entries_available >= 3) begin
            data_2 = {1'b1, buffer_mem[(read_ptr[ADDR_WIDTH-1:0] + 2) % BUFFER_DEPTH]};
            valid_2 = 1'b1;
        end else begin
            data_2 = '0;
            valid_2 = 1'b0;
        end
    end
    
    assign read_valid_0 = read_en_0 ? valid_0 : 1'b0;  
    assign read_data_0  = read_valid_0 ? data_0 : '0;

    assign read_valid_1 = read_en_1 ? (read_en_0 ? valid_1 : valid_0) : 1'b0;
    assign read_data_1  = read_valid_1 ? (read_valid_0 ? data_1 : data_0) : '0;

    assign read_valid_2 = read_en_2 ? (read_en_1 ? (read_en_0 ? valid_2 : valid_1) : (read_en_0 ? valid_1 : valid_0)) : 1'b0;
    assign read_data_2  = read_valid_2 ? (read_valid_1 ? (read_valid_0 ? data_2 : data_1) : (read_valid_0 ? data_1 : data_0)) : '0;
    //==========================================================================
    // POINTER UPDATE LOGIC
    //==========================================================================
    
    // Calculate next read pointer based on number of enabled reads
    always_comb begin
        next_read_ptr = read_ptr;
        
        // Only update if reads are enabled and buffer is not empty
        if (!buffer_empty) begin
            next_read_ptr = read_ptr + num_reads;
           
        end
    end
    // Calculate next write pointer based on number of enabled writes
    always_comb begin
        next_write_ptr = write_ptr;
        
        // Only update if writes are enabled and buffer is not full
        if (!buffer_full) begin
            next_write_ptr = write_ptr + num_writes;
        end
    end
    
    //==========================================================================
    // SEQUENTIAL LOGIC - POINTER UPDATES
    //==========================================================================
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            read_ptr <= #D '0;
            write_ptr <= #D {1'b1, {ADDR_WIDTH{1'b0}}}; 
        end else begin
            // Update read pointer
            read_ptr <= #D next_read_ptr;
            // Update write pointer
            write_ptr <= #D next_write_ptr;
        end
    end
    
    //==========================================================================
    // WRITE OPERATIONS (Optional - values are constant = index)
    //==========================================================================
    // Note: Since buffer values are constant and equal to index,
    // write operations don't actually modify buffer_mem.
    // However, write pointer still advances to track buffer fullness.
    
    // If you need to support actual writes (overwriting the constant values),
    // you can add write logic here. For now, this is commented out since
    // the requirement states "values will be constant and equal to index value"
    
    /*
    always_ff @(posedge clk) begin
        if (write_en_0 && !buffer_full) begin
            buffer_mem[write_ptr[ADDR_WIDTH-1:0]] <= write_data_0;
        end
        if (write_en_1 && !buffer_full && entries_available < BUFFER_DEPTH-1) begin
            buffer_mem[(write_ptr[ADDR_WIDTH-1:0] + 1) % BUFFER_DEPTH] <= write_data_1;
        end
        if (write_en_2 && !buffer_full && entries_available < BUFFER_DEPTH-2) begin
            buffer_mem[(write_ptr[ADDR_WIDTH-1:0] + 2) % BUFFER_DEPTH] <= write_data_2;
        end
    end
    */
    
    //==========================================================================
    // ASSERTIONS FOR DEBUG
    //==========================================================================
    logic [9:0] total_reads;
    logic [9:0] total_writes;
    logic [9:0] diff;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            total_reads  <= #D '0;
            total_writes <= #D '0;
            diff         <= #D '0;
        end else begin
            total_reads  <= #D total_reads  + num_reads;
            total_writes <= #D total_writes + num_writes;
            diff         <= #D total_reads - total_writes;
        end
    end
    // synthesis translate_off
    always_ff @(posedge clk) begin
        if (rst_n) begin
            // Check for underflow
            if ((num_reads > 0) && buffer_empty) begin
                $warning("[%t] Circular buffer read underflow attempt", $time);
            end
            
            // Check for overflow
            if ((num_writes > 0) && buffer_full) begin
                $warning("[%t] Circular buffer write overflow attempt", $time);
                #3ns;
                $finish;
            end
            
            // Verify pointer wraparound
            if (read_ptr[ADDR_WIDTH:0] >= 2*BUFFER_DEPTH) begin
                $error("[%t] Read pointer out of range: %d", $time, read_ptr);
            end
            if (write_ptr[ADDR_WIDTH:0] >= 2*BUFFER_DEPTH) begin
                $error("[%t] Write pointer out of range: %d", $time, write_ptr);
            end
        end
    end
    // synthesis translate_on

endmodule
