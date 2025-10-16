`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: lsq_simple_top
//
// Description:
//     Simplified Load-Store Queue (LSQ) with circular buffer
//     No dependency checking - strictly in-order execution
//     Optimized for area and power, not performance
//
// Design Philosophy:
//     - SIMPLICITY over performance
//     - In-order load/store execution
//     - Circular buffer like ROB (head/tail pointers)
//     - No CAM, no forwarding, no complex dependency tracking
//     - Area and power optimized
//
// Operation:
//     - Allocate entries in program order (from Issue Stage)
//     - Execute loads/stores from head in FIFO order
//     - Deallocate after memory operation completes
//     - Uses ROB ordering - no separate age tracking needed
//
// Performance Trade-off:
//     - Loads/stores execute sequentially (no out-of-order)
//     - Simpler = smaller area, lower power, easier verification
//     - Good enough for embedded applications
//////////////////////////////////////////////////////////////////////////////////

module lsq_simple_top
   import lsq_package::*;
   (
      input  logic clk,
      input  logic rst_n,

      // Allocation interface (from Issue Stage)
      // Allocation 0
      input  logic                            alloc_valid_0_i,
      input  logic                            alloc_is_store_0_i,
      input  logic [PHYS_REG_WIDTH-1:0]       alloc_phys_reg_0_i,
      input  logic [TAG_WIDTH-1:0]            alloc_addr_tag_0_i,
      input  logic [DATA_WIDTH-1:0]           alloc_data_operand_0_i,
      input  logic [TAG_WIDTH-1:0]            alloc_data_tag_0_i,
      input  logic [1:0]                      alloc_size_0_i,
      input  logic                            alloc_sign_extend_0_i,

      // Allocation 1
      input  logic                            alloc_valid_1_i,
      input  logic                            alloc_is_store_1_i,
      input  logic [PHYS_REG_WIDTH-1:0]       alloc_phys_reg_1_i,
      input  logic [TAG_WIDTH-1:0]            alloc_addr_tag_1_i,
      input  logic [DATA_WIDTH-1:0]           alloc_data_operand_1_i,
      input  logic [TAG_WIDTH-1:0]            alloc_data_tag_1_i,
      input  logic [1:0]                      alloc_size_1_i,
      input  logic                            alloc_sign_extend_1_i,

      // Allocation 2
      input  logic                            alloc_valid_2_i,
      input  logic                            alloc_is_store_2_i,
      input  logic [PHYS_REG_WIDTH-1:0]       alloc_phys_reg_2_i,
      input  logic [TAG_WIDTH-1:0]            alloc_addr_tag_2_i,
      input  logic [DATA_WIDTH-1:0]           alloc_data_operand_2_i,
      input  logic [TAG_WIDTH-1:0]            alloc_data_tag_2_i,
      input  logic [1:0]                      alloc_size_2_i,
      input  logic                            alloc_sign_extend_2_i,

      output logic                            alloc_ready_o,

      cdb_if cdb_interface,
      // Memory interface (simple - one operation at a time)
      output logic                            mem_req_valid_o,
      output logic                            mem_req_is_store_o,
      output logic [DATA_WIDTH-1:0]           mem_req_addr_o,
      output logic [DATA_WIDTH-1:0]           mem_req_data_o,
      output logic [3:0]                      mem_req_be_o,
      output logic [1:0]                      mem_req_size_o,
      output logic                            mem_req_sign_extend_o,
      input  logic                            mem_req_ready_i,

      input  logic                            mem_resp_valid_i,
      input  logic [DATA_WIDTH-1:0]           mem_resp_data_i,

      // Status outputs
      output logic [LSQ_ADDR_WIDTH:0]         lsq_count_o,
      output logic                            lsq_full_o,
      output logic                            lsq_empty_o
   );

   localparam D = 1;  // Delay for simulation

   //==========================================================================
   // CIRCULAR BUFFER STRUCTURE (like ROB)
   //==========================================================================

   typedef struct packed {
      logic                       valid;
      logic                       is_store;
      logic [PHYS_REG_WIDTH-1:0]  phys_reg;       // For loads only

      // Address
      logic                       addr_valid;
      logic [DATA_WIDTH-1:0]      address;
      logic [TAG_WIDTH-1:0]       addr_tag;

      // Data (for stores)
      logic                       data_valid;
      logic [DATA_WIDTH-1:0]      data;
      logic [TAG_WIDTH-1:0]       data_tag;

      // Operation attributes
      mem_size_t                  size;
      logic                       sign_extend;

      // Execution state
      logic                       mem_issued;     // Sent to memory
      logic                       mem_complete;   // Memory responded
   } lsq_simple_entry_t;

   lsq_simple_entry_t [LSQ_DEPTH-1:0] lsq_buffer;

   //==========================================================================
   // HEAD AND TAIL POINTERS (Circular Buffer)
   //==========================================================================

   logic [LSQ_ADDR_WIDTH:0] head_ptr;  // Points to oldest entry
   logic [LSQ_ADDR_WIDTH:0] tail_ptr;  // Points to next free entry
   logic [LSQ_ADDR_WIDTH-1:0] alloc_0_ptr;  // Points to next free entry
   logic [LSQ_ADDR_WIDTH-1:0] alloc_1_ptr;  // Points to next free entry
   logic [LSQ_ADDR_WIDTH-1:0] alloc_2_ptr;  // Points to next free entry
   logic [LSQ_ADDR_WIDTH:0] count;
   logic [LSQ_ADDR_WIDTH-1:0] head_idx;
   assign head_idx = head_ptr[LSQ_ADDR_WIDTH-1:0];

   assign lsq_count_o = count;
   assign lsq_full_o  = (count == LSQ_DEPTH);
   assign lsq_empty_o = (count == 0);
   assign alloc_ready_o = (count <= (LSQ_DEPTH - 3));  // Need space for 3

   // Calculate count
   always_comb begin
      count = tail_ptr - head_ptr;
   end

   //==========================================================================
   // ALLOCATION LOGIC (Tail Side)
   //==========================================================================

   logic actual_alloc_0, actual_alloc_1, actual_alloc_2;
   logic [LSQ_ADDR_WIDTH:0] new_tail;
   logic [1:0] num_allocs;

   logic deallocate_head;
   assign deallocate_head = !lsq_empty_o &&
      lsq_buffer[head_idx].valid &&
      lsq_buffer[head_idx].mem_complete;

   always_comb begin
      actual_alloc_0 = 1'b0;
      actual_alloc_1 = 1'b0;
      actual_alloc_2 = 1'b0;

      // Determine how many allocations we can actually do
      if (alloc_ready_o) begin
         actual_alloc_0 = alloc_valid_0_i;
         actual_alloc_1 = alloc_valid_1_i;
         actual_alloc_2 = alloc_valid_2_i;
      end

      num_allocs = {1'b0, actual_alloc_0} + {1'b0, actual_alloc_1} + {1'b0, actual_alloc_2};
      new_tail = tail_ptr + num_allocs;
      alloc_0_ptr = tail_ptr;
      alloc_1_ptr = tail_ptr + actual_alloc_0;
      alloc_2_ptr = tail_ptr + actual_alloc_0 + actual_alloc_1;
   end

   // Allocate entries
   always_ff @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         tail_ptr <= #D '0;
         head_ptr <= #D '0;
         for (int i = 0; i < LSQ_DEPTH; i++) begin
            lsq_buffer[i] <= #D '0;
         end
      end else begin
         // Allocation 0
         if (actual_alloc_0) begin
           
            lsq_buffer[alloc_0_ptr].valid       <= #D 1'b1;
            lsq_buffer[alloc_0_ptr].is_store    <= #D alloc_is_store_0_i;
            lsq_buffer[alloc_0_ptr].phys_reg    <= #D alloc_phys_reg_0_i;
            lsq_buffer[alloc_0_ptr].size        <= #D mem_size_t'(alloc_size_0_i);
            lsq_buffer[alloc_0_ptr].sign_extend <= #D alloc_sign_extend_0_i;
            lsq_buffer[alloc_0_ptr].mem_issued  <= #D 1'b0;
            lsq_buffer[alloc_0_ptr].mem_complete <= #D 1'b0;

            // Address
            lsq_buffer[alloc_0_ptr].addr_valid <= #D 1'b0;
            lsq_buffer[alloc_0_ptr].address    <= #D '0;
            lsq_buffer[alloc_0_ptr].addr_tag   <= #D alloc_addr_tag_0_i;
          

            // Data (stores only)
            if (alloc_is_store_0_i) begin
               if (alloc_data_tag_0_i == TAG_READY) begin // todo delete
                  lsq_buffer[alloc_0_ptr].data_valid <= #D 1'b1;
                  lsq_buffer[alloc_0_ptr].data       <= #D alloc_data_operand_0_i;
                  lsq_buffer[alloc_0_ptr].data_tag   <= #D TAG_READY;
               end else begin
                  lsq_buffer[alloc_0_ptr].data_valid <= #D 1'b0;
                  lsq_buffer[alloc_0_ptr].data       <= #D '0;
                  lsq_buffer[alloc_0_ptr].data_tag   <= #D alloc_data_tag_0_i;
               end
            end else begin
               lsq_buffer[alloc_0_ptr].data_valid <= #D 1'b0;
               lsq_buffer[alloc_0_ptr].data       <= #D '0;
               lsq_buffer[alloc_0_ptr].data_tag   <= #D TAG_READY;
            end
         end

         // Allocation 1
         if (actual_alloc_1) begin

            lsq_buffer[alloc_1_ptr].valid       <= #D 1'b1;
            lsq_buffer[alloc_1_ptr].is_store    <= #D alloc_is_store_1_i;
            lsq_buffer[alloc_1_ptr].phys_reg    <= #D alloc_phys_reg_1_i;
            lsq_buffer[alloc_1_ptr].size        <= #D mem_size_t'(alloc_size_1_i);
            lsq_buffer[alloc_1_ptr].sign_extend <= #D alloc_sign_extend_1_i;
            lsq_buffer[alloc_1_ptr].mem_issued  <= #D 1'b0;
            lsq_buffer[alloc_1_ptr].mem_complete <= #D 1'b0;

            lsq_buffer[alloc_1_ptr].addr_valid <= #D 1'b0;
            lsq_buffer[alloc_1_ptr].address    <= #D '0;
            lsq_buffer[alloc_1_ptr].addr_tag   <= #D alloc_addr_tag_1_i;


            if (alloc_is_store_1_i) begin
               if (alloc_data_tag_1_i == TAG_READY) begin
                  lsq_buffer[alloc_1_ptr].data_valid <= #D 1'b1;
                  lsq_buffer[alloc_1_ptr].data       <= #D alloc_data_operand_1_i;
                  lsq_buffer[alloc_1_ptr].data_tag   <= #D TAG_READY;
               end else begin
                  lsq_buffer[alloc_1_ptr].data_valid <= #D 1'b0;
                  lsq_buffer[alloc_1_ptr].data       <= #D '0;
                  lsq_buffer[alloc_1_ptr].data_tag   <= #D alloc_data_tag_1_i;
               end
            end else begin
               lsq_buffer[alloc_1_ptr].data_valid <= #D 1'b0;
               lsq_buffer[alloc_1_ptr].data       <= #D '0;
               lsq_buffer[alloc_1_ptr].data_tag   <= #D TAG_READY;
            end
         end

         // Allocation 2
         if (actual_alloc_2) begin
            lsq_buffer[alloc_2_ptr].valid       <= #D 1'b1;
            lsq_buffer[alloc_2_ptr].is_store    <= #D alloc_is_store_2_i;
            lsq_buffer[alloc_2_ptr].phys_reg    <= #D alloc_phys_reg_2_i;
            lsq_buffer[alloc_2_ptr].size        <= #D mem_size_t'(alloc_size_2_i);
            lsq_buffer[alloc_2_ptr].sign_extend <= #D alloc_sign_extend_2_i;
            lsq_buffer[alloc_2_ptr].mem_issued  <= #D 1'b0;
            lsq_buffer[alloc_2_ptr].mem_complete <= #D 1'b0;
            lsq_buffer[alloc_2_ptr].addr_valid <= #D 1'b0;
            lsq_buffer[alloc_2_ptr].address    <= #D '0;
            lsq_buffer[alloc_2_ptr].addr_tag   <= #D alloc_addr_tag_2_i;

            if (alloc_is_store_2_i) begin
               if (alloc_data_tag_2_i == TAG_READY) begin
                  lsq_buffer[alloc_2_ptr].data_valid <= #D 1'b1;
                  lsq_buffer[alloc_2_ptr].data       <= #D alloc_data_operand_2_i;
                  lsq_buffer[alloc_2_ptr].data_tag   <= #D TAG_READY;
               end else begin
                  lsq_buffer[alloc_2_ptr].data_valid <= #D 1'b0;
                  lsq_buffer[alloc_2_ptr].data       <= #D '0;
                  lsq_buffer[alloc_2_ptr].data_tag   <= #D alloc_data_tag_2_i;
               end
            end else begin
               lsq_buffer[alloc_2_ptr].data_valid <= #D 1'b0;
               lsq_buffer[alloc_2_ptr].data       <= #D '0;
               lsq_buffer[alloc_2_ptr].data_tag   <= #D TAG_READY;
            end
         end
         // Update tail pointer
         tail_ptr <= #D new_tail;

         if (mem_req_valid_o && mem_req_ready_i) begin
            lsq_buffer[head_idx].mem_issued <= #D 1'b1;
         end

         if (mem_resp_valid_i & lsq_buffer[head_idx].mem_issued) begin
            lsq_buffer[head_idx].mem_complete <= #D 1'b1;
            if(!lsq_buffer[head_idx].is_store) begin
               lsq_buffer[head_idx].data <= #D mem_resp_data_i; // For loads, store response data
               lsq_buffer[head_idx].data_valid <= #D 1'b1;
            end
         end

         for (int i = 0; i < LSQ_DEPTH; i++) begin
            if (lsq_buffer[i].valid) begin
               // Address resolution
               if (!lsq_buffer[i].addr_valid) begin
                  if ((cdb_interface.cdb_valid_0 && lsq_buffer[i].addr_tag == cdb_interface.cdb_tag_0) ||
                        (cdb_interface.cdb_valid_1 && lsq_buffer[i].addr_tag == cdb_interface.cdb_tag_1) ||
                        (cdb_interface.cdb_valid_2 && lsq_buffer[i].addr_tag == cdb_interface.cdb_tag_2)) begin

                     lsq_buffer[i].addr_valid <= #D 1'b1;
                     lsq_buffer[i].addr_tag   <= #D TAG_READY;

                     if (cdb_interface.cdb_valid_0 && lsq_buffer[i].addr_tag == cdb_interface.cdb_tag_0)
                        lsq_buffer[i].address <= #D cdb_interface.cdb_data_0;
                     else if (cdb_interface.cdb_valid_1 && lsq_buffer[i].addr_tag == cdb_interface.cdb_tag_1)
                        lsq_buffer[i].address <= #D cdb_interface.cdb_data_1;
                     else
                        lsq_buffer[i].address <= #D cdb_interface.cdb_data_2;
                  end
               end

               // Data resolution (stores only)
               if (lsq_buffer[i].is_store && !lsq_buffer[i].data_valid) begin
                  if ((cdb_interface.cdb_valid_0 && lsq_buffer[i].data_tag == cdb_interface.cdb_tag_0) ||
                        (cdb_interface.cdb_valid_1 && lsq_buffer[i].data_tag == cdb_interface.cdb_tag_1) ||
                        (cdb_interface.cdb_valid_2 && lsq_buffer[i].data_tag == cdb_interface.cdb_tag_2)) begin

                     lsq_buffer[i].data_valid <= #D 1'b1;
                     lsq_buffer[i].data_tag   <= #D TAG_READY;

                     if (cdb_interface.cdb_valid_0 && lsq_buffer[i].data_tag == cdb_interface.cdb_tag_0)
                        lsq_buffer[i].data <= #D cdb_interface.cdb_data_0;
                     else if (cdb_interface.cdb_valid_1 && lsq_buffer[i].data_tag == cdb_interface.cdb_tag_1)
                        lsq_buffer[i].data <= #D cdb_interface.cdb_data_1;
                     else
                        lsq_buffer[i].data <= #D cdb_interface.cdb_data_2;
                  end
               end
            end
         end

         if (deallocate_head) begin
            lsq_buffer[head_idx].valid <= #D 1'b0;
            head_ptr <= #D head_ptr + 1'b1;
         end
      end
   end


   //==========================================================================
   // MEMORY REQUEST LOGIC (Head Side - FIFO)
   //==========================================================================

   

   logic head_ready;
   always_comb begin
      head_ready = 1'b0;

      if (!lsq_empty_o && lsq_buffer[head_idx].valid && !lsq_buffer[head_idx].mem_issued) begin // TODO LATCH???
         // Head entry is ready if address is valid
         // For stores, also need data to be valid
         if (lsq_buffer[head_idx].addr_valid) begin
            if (lsq_buffer[head_idx].is_store) begin
               head_ready = lsq_buffer[head_idx].data_valid;
            end else begin
               head_ready = 1'b1;  // Load only needs address
            end
         end
      end
   end

   // Issue memory request
   assign mem_req_valid_o = head_ready;
   assign mem_req_is_store_o = lsq_buffer[head_idx].mem_complete ? 1'b0  : lsq_buffer[head_idx].is_store;
   assign mem_req_addr_o     = lsq_buffer[head_idx].mem_complete ? 32'd0 : lsq_buffer[head_idx].address;
   assign mem_req_data_o     = lsq_buffer[head_idx].mem_complete ? 32'd0 : lsq_buffer[head_idx].data;
   assign mem_req_size_o     = lsq_buffer[head_idx].mem_complete ? 2'd0  : lsq_buffer[head_idx].size;
   assign mem_req_sign_extend_o = lsq_buffer[head_idx].mem_complete ? 1'b0  : lsq_buffer[head_idx].sign_extend;
   assign mem_req_be_o = lsq_buffer[head_idx].mem_complete ? 4'd0  : 
      generate_byte_enable( // todo check
         lsq_buffer[head_idx].address[1:0],
         lsq_buffer[head_idx].size
      );


   //==========================================================================
   // MEMORY RESPONSE AND CDB BROADCAST (for loads)
   //==========================================================================

   assign cdb_interface.cdb_valid_3 = lsq_buffer[head_idx].mem_complete;
   assign cdb_interface.cdb_tag_3 = 3'b011;
   assign cdb_interface.cdb_data_3 = lsq_buffer[head_idx].data;
   assign cdb_interface.cdb_dest_reg_3 = lsq_buffer[head_idx].phys_reg;



endmodule

