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

      input  logic store_can_issue_0, // signal from ROB that store at head can be issued
      input  logic [PHYS_REG_WIDTH-1:0] allowed_store_address_0, // allowed store address from ROB

      input  logic store_can_issue_1, // signal from ROB that store at head can be issued
      input  logic [PHYS_REG_WIDTH-1:0] allowed_store_address_1, // allowed store address from ROB

      input  logic store_can_issue_2, // signal from ROB that store at head can be issued
      input  logic [PHYS_REG_WIDTH-1:0] allowed_store_address_2, // allowed store address from ROB
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
      output logic                            mem_0_req_valid_o,
      output logic                            mem_0_req_is_store_o,
      output logic [DATA_WIDTH-1:0]           mem_0_req_addr_o,
      output logic [DATA_WIDTH-1:0]           mem_0_req_data_o,
      output logic [3:0]                      mem_0_req_be_o,
      input  logic                            mem_0_req_ready_i,

      input  logic                            mem_0_resp_valid_i,
      input  logic [DATA_WIDTH-1:0]           mem_0_resp_data_i,


      // Memory interface (simple - one operation at a time)
      output logic                            mem_1_req_valid_o,
      output logic                            mem_1_req_is_store_o,
      output logic [DATA_WIDTH-1:0]           mem_1_req_addr_o,
      output logic [DATA_WIDTH-1:0]           mem_1_req_data_o,
      output logic [3:0]                      mem_1_req_be_o,
      input  logic                            mem_1_req_ready_i,

      input  logic                            mem_1_resp_valid_i,
      input  logic [DATA_WIDTH-1:0]           mem_1_resp_data_i,


       // Memory interface (simple - one operation at a time)
      output logic                            mem_2_req_valid_o,
      output logic                            mem_2_req_is_store_o,
      output logic [DATA_WIDTH-1:0]           mem_2_req_addr_o,
      output logic [DATA_WIDTH-1:0]           mem_2_req_data_o,
      output logic [3:0]                      mem_2_req_be_o,
      input  logic                            mem_2_req_ready_i,

      input  logic                            mem_2_resp_valid_i,
      input  logic [DATA_WIDTH-1:0]           mem_2_resp_data_i,

      `ifndef SYNTHESIS
      // Debug interface
      output logic [DATA_WIDTH-1:0]           tracer_0_store_data,
      output logic [DATA_WIDTH-1:0]           tracer_1_store_data,
      output logic [DATA_WIDTH-1:0]           tracer_2_store_data,
      `endif
      // Status outputs
      output logic [LSQ_ADDR_WIDTH:0]         lsq_count_o,
      output logic                            lsq_full_o,
      output logic                            lsq_empty_o
   );

   localparam D = 1;  // Delay for simulation

   logic [2:0] mem_0_type_sel;
   logic [2:0] mem_1_type_sel;
   logic [2:0] mem_2_type_sel;

   logic [DATA_WIDTH-1:0] load_0_data;
   logic [DATA_WIDTH-1:0] load_1_data;
   logic [DATA_WIDTH-1:0] load_2_data;

   logic [DATA_WIDTH-1:0] store_0_data;
   logic [DATA_WIDTH-1:0] store_1_data;
   logic [DATA_WIDTH-1:0] store_2_data;

   `ifndef SYNTHESIS
   assign tracer_0_store_data = store_0_data;
   assign tracer_1_store_data = store_1_data;
   assign tracer_2_store_data = store_2_data;
   `endif
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
   logic [LSQ_ADDR_WIDTH:0] head_ptr_1;
   logic [LSQ_ADDR_WIDTH:0] head_ptr_2;

   logic [LSQ_ADDR_WIDTH+1:0] distance_0;  // Points to oldest entry
   logic [LSQ_ADDR_WIDTH+1:0] distance_1;
   logic [LSQ_ADDR_WIDTH+1:0] distance_2;

   logic [LSQ_ADDR_WIDTH:0] tail_ptr, tail_plus_3;  // Points to next free entry
   logic [LSQ_ADDR_WIDTH-1:0] alloc_0_ptr;  // Points to next free entry
   logic [LSQ_ADDR_WIDTH-1:0] alloc_1_ptr;  // Points to next free entry
   logic [LSQ_ADDR_WIDTH-1:0] alloc_2_ptr;  // Points to next free entry
   logic [LSQ_ADDR_WIDTH:0] count;
   logic [LSQ_ADDR_WIDTH-1:0] head_idx;
   logic [LSQ_ADDR_WIDTH-1:0] head_idx_1;
   logic [LSQ_ADDR_WIDTH-1:0] head_idx_2;
   assign head_idx   = head_ptr[LSQ_ADDR_WIDTH-1:0];
   assign head_idx_1 = head_ptr_1[LSQ_ADDR_WIDTH-1:0];
   assign head_idx_2 = head_ptr_2[LSQ_ADDR_WIDTH-1:0];

   assign lsq_count_o = count;
   assign lsq_full_o  = (count == LSQ_DEPTH);
   assign lsq_empty_o = (count == 0);
   assign alloc_ready_o = (count <= (LSQ_DEPTH - 3));  // Need space for 3

   // Calculate count
   always_comb begin
      count = 6;//tail_ptr - head_ptr;  // todo check maybe use valid
   end
   assign tail_plus_3 = tail_ptr + 3;
   assign distance_0 = (tail_plus_3 - head_ptr) <  (tail_ptr +3 - head_ptr) ?  (tail_plus_3 - head_ptr) : (tail_ptr +3 - head_ptr); 
   assign distance_1 = (tail_plus_3 - head_ptr_1) <  (tail_ptr +3 - head_ptr_1) ?  (tail_plus_3 - head_ptr_1) : (tail_ptr +3 - head_ptr_1);
   assign distance_2 = (tail_plus_3 - head_ptr_2) < (tail_ptr +3 - head_ptr_2) ? (tail_plus_3 - head_ptr_2) : (tail_ptr +3 - head_ptr_2);


   //==========================================================================
   // Forwarding Logic
   //==========================================================================
   logic fwd_head_0;
   logic fwd_head_1; 
   logic fwd_head_2;

   logic head_0_should_wait;
   logic head_1_should_wait;
   logic head_2_should_wait;

   logic [1:0] head_0_fwd_source;
   logic [1:0] head_1_fwd_source;
   logic [1:0] head_2_fwd_source;

   logic head_0_head_1_addr_match;
   logic head_0_head_2_addr_match;
   logic head_1_head_2_addr_match;

   logic head_0_newer_than_head_1;
   logic head_0_newer_than_head_2;
   logic head_1_newer_than_head_2;
   logic head_1_newer_than_head_0;
   logic head_2_newer_than_head_0;
   logic head_2_newer_than_head_1;

   logic head_0_valids;
   logic head_1_valids;
   logic head_2_valids;

   logic head_0_size_ge_head_1; // head 0 size is greater or equal to head 1
   logic head_0_size_ge_head_2;
   logic head_1_size_ge_head_0;
   logic head_1_size_ge_head_2;
   logic head_2_size_ge_head_0;
   logic head_2_size_ge_head_1;


   `ifdef SECURE_UNALIGN_LSQ
      logic head_0_should_wait_unaligned_store;
      logic head_1_should_wait_unaligned_store;
      logic head_2_should_wait_unaligned_store;
   `endif

   always_comb begin

      head_0_head_1_addr_match = lsq_buffer[head_idx].addr_valid && lsq_buffer[head_idx_1].addr_valid && (lsq_buffer[head_idx].address == lsq_buffer[head_idx_1].address);
      head_0_head_2_addr_match = lsq_buffer[head_idx].addr_valid && lsq_buffer[head_idx_2].addr_valid && (lsq_buffer[head_idx].address == lsq_buffer[head_idx_2].address);
      head_1_head_2_addr_match = lsq_buffer[head_idx_1].addr_valid && lsq_buffer[head_idx_2].addr_valid && (lsq_buffer[head_idx_1].address == lsq_buffer[head_idx_2].address);
      
      head_0_newer_than_head_1 = (distance_0 < distance_1) ? 1'b1 : 1'b0;
      head_0_newer_than_head_2 = (distance_0 < distance_2) ? 1'b1 : 1'b0;
      head_1_newer_than_head_2 = (distance_1 < distance_2) ? 1'b1 : 1'b0;
      head_1_newer_than_head_0 = (distance_1 < distance_0) ? 1'b1 : 1'b0;
      head_2_newer_than_head_0 = (distance_2 < distance_0) ? 1'b1 : 1'b0;
      head_2_newer_than_head_1 = (distance_2 < distance_1) ? 1'b1 : 1'b0;

      head_0_valids = lsq_buffer[head_idx].addr_valid & lsq_buffer[head_idx].data_valid;
      head_1_valids = lsq_buffer[head_idx_1].addr_valid & lsq_buffer[head_idx_1].data_valid;
      head_2_valids = lsq_buffer[head_idx_2].addr_valid & lsq_buffer[head_idx_2].data_valid;

      head_0_size_ge_head_1 = (lsq_buffer[head_idx].size >= lsq_buffer[head_idx_1].size) ? 1'b1 : 1'b0;
      head_0_size_ge_head_2 = (lsq_buffer[head_idx].size >= lsq_buffer[head_idx_2].size) ? 1'b1 : 1'b0;
      head_1_size_ge_head_0 = (lsq_buffer[head_idx_1].size >= lsq_buffer[head_idx].size) ? 1'b1 : 1'b0;
      head_1_size_ge_head_2 = (lsq_buffer[head_idx_1].size >= lsq_buffer[head_idx_2].size) ? 1'b1 : 1'b0;
      head_2_size_ge_head_0 = (lsq_buffer[head_idx_2].size >= lsq_buffer[head_idx].size) ? 1'b1 : 1'b0;
      head_2_size_ge_head_1 = (lsq_buffer[head_idx_2].size >= lsq_buffer[head_idx_1].size) ? 1'b1 : 1'b0;

      // Head 0 forwarding
      head_0_should_wait = 1'b0;
      fwd_head_0         = 1'b0;
      head_0_fwd_source  = 2'b00;
      `ifdef SECURE_UNALIGN_LSQ
         head_0_should_wait_unaligned_store = 0;
      `endif

      if(lsq_buffer[head_idx].valid && !lsq_buffer[head_idx].is_store && lsq_buffer[head_idx].addr_valid) begin // If it is load
         if(head_0_newer_than_head_1 && lsq_buffer[head_idx_1].is_store && 
            head_0_newer_than_head_2 && lsq_buffer[head_idx_2].is_store ) begin // If head is the newest
            if(head_1_newer_than_head_2) begin // give priority to head 1
               head_0_should_wait = !head_1_valids | 
                                    (head_1_valids & head_0_head_1_addr_match & !head_1_size_ge_head_0 & !lsq_buffer[head_idx_1].mem_issued) | 
                                    (head_1_valids & !head_0_head_1_addr_match & !head_2_valids) | 
                                    (head_1_valids & !head_0_head_1_addr_match & head_2_valids & head_0_head_2_addr_match & !head_2_size_ge_head_0 & !lsq_buffer[head_idx_2].mem_issued);

               if(!head_0_should_wait) begin
                  if(head_0_head_1_addr_match && head_1_size_ge_head_0) begin
                     fwd_head_0        = 1'b1;
                     head_0_fwd_source = 2'b01;
                  end else if(head_0_head_2_addr_match && head_2_size_ge_head_0) begin
                     fwd_head_0        = 1'b1;
                     head_0_fwd_source = 2'b10;
                  end
               end
            end else begin // give priority to head 2
               head_0_should_wait = !head_2_valids | 
                                    (head_2_valids & head_0_head_2_addr_match & !head_2_size_ge_head_0 & !lsq_buffer[head_idx_2].mem_issued) | 
                                    (head_2_valids & !head_0_head_2_addr_match & !head_1_valids) | 
                                    (head_2_valids & !head_0_head_2_addr_match & head_1_valids & head_0_head_1_addr_match & !head_1_size_ge_head_0 & !lsq_buffer[head_idx_1].mem_issued);
               if(!head_0_should_wait) begin
                  if(head_0_head_2_addr_match && head_2_size_ge_head_0) begin
                     fwd_head_0        = 1'b1;
                     head_0_fwd_source = 2'b10;
                  end else if(head_0_head_1_addr_match && head_1_size_ge_head_0) begin
                     fwd_head_0        = 1'b1;
                     head_0_fwd_source = 2'b01;
                  end
               end
            end
            `ifdef SECURE_UNALIGN_LSQ
               head_0_should_wait_unaligned_store = (head_1_valids & (lsq_buffer[head_idx_1].address[1:0] != 2'b00 | lsq_buffer[head_idx].address[1:0] != 2'b00)) | (head_2_valids & (lsq_buffer[head_idx_2].address[1:0] != 2'b00 ));
            `endif
         end else if(head_0_newer_than_head_1 && lsq_buffer[head_idx_1].is_store) begin // If head is newer than head 1

            head_0_should_wait = !head_1_valids | 
                                 (head_1_valids & head_0_head_1_addr_match & !head_1_size_ge_head_0 & !lsq_buffer[head_idx_1].mem_issued);

            if(!head_0_should_wait && head_0_head_1_addr_match && head_1_size_ge_head_0) begin
               fwd_head_0        = 1'b1;
               head_0_fwd_source = 2'b01;
            end
            `ifdef SECURE_UNALIGN_LSQ
               head_0_should_wait_unaligned_store = (head_1_valids & (lsq_buffer[head_idx_1].address[1:0] != 2'b00 | lsq_buffer[head_idx].address[1:0] != 2'b00));
            `endif
         end else if(head_0_newer_than_head_2 && lsq_buffer[head_idx_2].is_store) begin // If head is newer than head 2
            head_0_should_wait = !head_2_valids | 
                                 (head_2_valids & head_0_head_2_addr_match & !head_2_size_ge_head_0 & !lsq_buffer[head_idx_2].mem_issued);
            if(!head_0_should_wait && head_0_head_2_addr_match && head_2_size_ge_head_0) begin
               fwd_head_0        = 1'b1;
               head_0_fwd_source = 2'b10;
            end
            `ifdef SECURE_UNALIGN_LSQ
               head_0_should_wait_unaligned_store = (head_2_valids & (lsq_buffer[head_idx_2].address[1:0] != 2'b00 | lsq_buffer[head_idx].address[1:0] != 2'b00));
            `endif
         end
      end 

      // Head 1 forwarding
      head_1_should_wait = 1'b0;
      fwd_head_1         = 1'b0;
      head_1_fwd_source  = 2'b00;
      `ifdef SECURE_UNALIGN_LSQ
         head_1_should_wait_unaligned_store = 0;
      `endif

      if(lsq_buffer[head_idx_1].valid && !lsq_buffer[head_idx_1].is_store && lsq_buffer[head_idx_1].addr_valid) begin // If it is load
         if(head_1_newer_than_head_0 && lsq_buffer[head_idx].is_store &&
            head_1_newer_than_head_2 && lsq_buffer[head_idx_2].is_store ) begin // If head_1 is the newest
            if(head_0_newer_than_head_2) begin // give priority to head 0
               head_1_should_wait = !head_0_valids | 
                                    (head_0_valids & head_0_head_1_addr_match & !head_0_size_ge_head_1 & !lsq_buffer[head_idx].mem_issued) | 
                                    (head_0_valids & !head_0_head_1_addr_match & !head_2_valids) | 
                                    (head_0_valids & !head_0_head_1_addr_match & head_2_valids & head_1_head_2_addr_match & !head_2_size_ge_head_1 & !lsq_buffer[head_idx_2].mem_issued);
               if(!head_1_should_wait) begin
                  if(head_0_head_1_addr_match && head_0_size_ge_head_1) begin
                     fwd_head_1        = 1'b1;
                     head_1_fwd_source = 2'b00;
                  end else if(head_1_head_2_addr_match && head_2_size_ge_head_1) begin
                     fwd_head_1        = 1'b1;
                     head_1_fwd_source = 2'b10;
                  end
               end
            end else begin // give priority to head 2
               head_1_should_wait = !head_2_valids | 
                                    (head_2_valids & head_1_head_2_addr_match & !head_2_size_ge_head_1 & !lsq_buffer[head_idx_2].mem_issued) | 
                                    (head_2_valids & !head_1_head_2_addr_match & !head_0_valids) | 
                                    (head_2_valids & !head_1_head_2_addr_match & head_0_valids & head_0_head_1_addr_match & !head_0_size_ge_head_1 & !lsq_buffer[head_idx].mem_issued);

               if(!head_1_should_wait) begin
                  if(head_1_head_2_addr_match && head_2_size_ge_head_1) begin
                     fwd_head_1        = 1'b1;
                     head_1_fwd_source = 2'b10;
                  end else if(head_0_head_1_addr_match && head_0_size_ge_head_1) begin
                     fwd_head_1        = 1'b1;
                     head_1_fwd_source = 2'b00;
                  end
               end
            end
            `ifdef SECURE_UNALIGN_LSQ
               head_1_should_wait_unaligned_store = (head_0_valids & (lsq_buffer[head_idx].address[1:0] != 2'b00 | lsq_buffer[head_idx_1].address[1:0] != 2'b00)) | (head_2_valids & (lsq_buffer[head_idx_2].address[1:0] != 2'b00 | lsq_buffer[head_idx_1].address[1:0] != 2'b00));
            `endif
         end else if(head_1_newer_than_head_0 && lsq_buffer[head_idx].is_store) begin // If head_1 is newer than head 0
            head_1_should_wait = !head_0_valids | 
                                 (head_0_valids & head_0_head_1_addr_match & !head_0_size_ge_head_1 & !lsq_buffer[head_idx].mem_issued);
            if(!head_1_should_wait && head_0_head_1_addr_match && head_0_size_ge_head_1) begin
               fwd_head_1        = 1'b1;
               head_1_fwd_source = 2'b00;
            end
            `ifdef SECURE_UNALIGN_LSQ
               head_1_should_wait_unaligned_store = (head_0_valids & (lsq_buffer[head_idx].address[1:0] != 2'b00 | lsq_buffer[head_idx_1].address[1:0] != 2'b00 ));
            `endif
         end else if(head_1_newer_than_head_2 && lsq_buffer[head_idx_2].is_store) begin // If head_1 is newer than head 2
            head_1_should_wait = !head_2_valids | 
                                 (head_2_valids & head_1_head_2_addr_match & !head_2_size_ge_head_1 & !lsq_buffer[head_idx_2].mem_issued);
                                    
            if(!head_1_should_wait && head_1_head_2_addr_match && head_2_size_ge_head_1) begin
               fwd_head_1        = 1'b1;
               head_1_fwd_source = 2'b10;
            end
            `ifdef SECURE_UNALIGN_LSQ
               head_1_should_wait_unaligned_store = (head_2_valids & (lsq_buffer[head_idx_2].address[1:0] != 2'b00 | lsq_buffer[head_idx_1].address[1:0] != 2'b00));
            `endif
         end
      end

      // Head 2 forwarding
      head_2_should_wait = 1'b0;
      fwd_head_2         = 1'b0;
      head_2_fwd_source  = 2'b00;
      `ifdef SECURE_UNALIGN_LSQ
         head_2_should_wait_unaligned_store = 0;
      `endif

      if(lsq_buffer[head_idx_2].valid && !lsq_buffer[head_idx_2].is_store && lsq_buffer[head_idx_2].addr_valid) begin // If it is load
         if(head_2_newer_than_head_0 && lsq_buffer[head_idx].is_store &&
            head_2_newer_than_head_1 && lsq_buffer[head_idx_1].is_store) begin // If head_2 is the newest
            if(head_0_newer_than_head_1) begin // give priority to head 0
               head_2_should_wait = !head_0_valids | 
                                    (head_0_valids & head_0_head_2_addr_match & !head_0_size_ge_head_2 & !lsq_buffer[head_idx].mem_issued) | 
                                    (head_0_valids & !head_0_head_2_addr_match & !head_1_valids) | 
                                    (head_0_valids & !head_0_head_2_addr_match & head_1_valids & head_1_head_2_addr_match & !head_1_size_ge_head_2 & !lsq_buffer[head_idx_1].mem_issued);
               if(!head_2_should_wait) begin
                  if(head_0_head_2_addr_match && head_0_size_ge_head_2) begin
                     fwd_head_2        = 1'b1;
                     head_2_fwd_source = 2'b00;
                  end else if(head_1_head_2_addr_match && head_1_size_ge_head_2) begin
                     fwd_head_2        = 1'b1;
                     head_2_fwd_source = 2'b01;
                  end
               end
            end else begin // give priority to head 1
               head_2_should_wait = !head_1_valids | 
                                    (head_1_valids & head_1_head_2_addr_match & !head_1_size_ge_head_2 & !lsq_buffer[head_idx_1].mem_issued) | 
                                    (head_1_valids & !head_1_head_2_addr_match & !head_0_valids) | 
                                    (head_1_valids & !head_1_head_2_addr_match & head_0_valids & head_0_head_2_addr_match & !head_0_size_ge_head_2 & !lsq_buffer[head_idx].mem_issued);
               if(!head_2_should_wait) begin
                  if(head_1_head_2_addr_match && head_1_size_ge_head_2) begin
                     fwd_head_2        = 1'b1;
                     head_2_fwd_source = 2'b01;
                  end else if(head_0_head_2_addr_match && head_0_size_ge_head_2) begin
                     fwd_head_2        = 1'b1;
                     head_2_fwd_source = 2'b00;
                  end
               end
            end
            `ifdef SECURE_UNALIGN_LSQ
               head_2_should_wait_unaligned_store = (head_0_valids & (lsq_buffer[head_idx].address[1:0] != 2'b00 | lsq_buffer[head_idx_2].address[1:0] != 2'b00)) | (head_1_valids & (lsq_buffer[head_idx_1].address[1:0] != 2'b00 | lsq_buffer[head_idx_2].address[1:0] != 2'b00));
            `endif
         end else if(head_2_newer_than_head_0 && lsq_buffer[head_idx].is_store) begin // If head_2 is newer than head 0
            head_2_should_wait = !head_0_valids | 
                                 (head_0_valids & head_0_head_2_addr_match & !head_0_size_ge_head_2 & !lsq_buffer[head_idx].mem_issued);

            if(!head_2_should_wait && head_0_head_2_addr_match && head_0_size_ge_head_2) begin
               fwd_head_2        = 1'b1;
               head_2_fwd_source = 2'b00;
            end
            `ifdef SECURE_UNALIGN_LSQ
               head_2_should_wait_unaligned_store = (head_0_valids & (lsq_buffer[head_idx].address[1:0] != 2'b00 | lsq_buffer[head_idx_2].address[1:0] != 2'b00));
            `endif
         end else if(head_2_newer_than_head_1 && lsq_buffer[head_idx_1].is_store) begin // If head_2 is newer than head 1
            head_2_should_wait = !head_1_valids | 
                                 (head_1_valids & head_1_head_2_addr_match & !head_1_size_ge_head_2 & !lsq_buffer[head_idx_1].mem_issued);
            if(!head_2_should_wait && head_1_head_2_addr_match && head_1_size_ge_head_2) begin
               fwd_head_2        = 1'b1;
               head_2_fwd_source = 2'b01;
            end
            `ifdef SECURE_UNALIGN_LSQ
               head_2_should_wait_unaligned_store = (head_1_valids & (lsq_buffer[head_idx_1].address[1:0] != 2'b00 | lsq_buffer[head_idx_2].address[1:0] != 2'b00));
            `endif
         end
      end

    
   end

   
   
   //==========================================================================
   // ALLOCATION LOGIC (Tail Side)
   //==========================================================================

   logic actual_alloc_0, actual_alloc_1, actual_alloc_2;
   logic [LSQ_ADDR_WIDTH:0] new_tail;
   logic [1:0] num_allocs;

   logic deallocate_head;
   logic deallocate_head_1;
   logic deallocate_head_2;

   
   assign deallocate_head = !lsq_empty_o & lsq_buffer[head_idx].valid && lsq_buffer[head_idx].mem_issued && 
                            (mem_0_resp_valid_i | lsq_buffer[head_idx].mem_complete);
      
   assign deallocate_head_1 = !lsq_empty_o && lsq_buffer[head_idx_1].valid && lsq_buffer[head_idx_1].mem_issued && 
                              (mem_1_resp_valid_i | lsq_buffer[head_idx_1].mem_complete); //todo add check store to load forwarding
   
   assign deallocate_head_2 = !lsq_empty_o && lsq_buffer[head_idx_2].valid && lsq_buffer[head_idx_2].mem_issued && 
                              (mem_2_resp_valid_i | lsq_buffer[head_idx_2].mem_complete);

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
      alloc_0_ptr = tail_ptr[LSQ_ADDR_WIDTH-1:0];
      alloc_1_ptr = tail_ptr + actual_alloc_0;
      alloc_2_ptr = tail_ptr + actual_alloc_0 + actual_alloc_1;
   end

   // Allocate entries
   always_ff @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         tail_ptr <= #D 6'd0;
         head_ptr <= #D 6'd0;
         head_ptr_1 <= #D 6'd1;
         head_ptr_2 <= #D 6'd2;
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
                  lsq_buffer[alloc_0_ptr].data       <= #D alloc_data_operand_0_i;
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
                  lsq_buffer[alloc_1_ptr].data       <= #D alloc_data_operand_1_i;
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
                  lsq_buffer[alloc_2_ptr].data       <= #D alloc_data_operand_2_i;
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

         if (mem_0_req_valid_o && mem_0_req_ready_i) begin
            lsq_buffer[head_idx].mem_issued <= #D 1'b1;
         end

         if (mem_1_req_valid_o && mem_1_req_ready_i) begin
            lsq_buffer[head_idx_1].mem_issued <= #D 1'b1;
         end

         if (mem_2_req_valid_o && mem_2_req_ready_i) begin
            lsq_buffer[head_idx_2].mem_issued <= #D 1'b1;
         end
         /* 
         if (mem_resp_valid_i & lsq_buffer[head_idx].mem_issued) begin
            lsq_buffer[head_idx].mem_complete <= #D 1'b1;
            if(!lsq_buffer[head_idx].is_store) begin
               lsq_buffer[head_idx].data <= #D mem_resp_data_i; // For loads, store response data
               lsq_buffer[head_idx].data_valid <= #D 1'b1;
            end
         end
         */

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
               // data can coming from memory so we need to check cdb 3 also 
               // but to get correct data we need to check phys reg, for the store operations we can store
               // phy reg of source load operation to data field, if tag is 3 --- fixed
               if (lsq_buffer[i].is_store && !lsq_buffer[i].data_valid) begin
                  if ((cdb_interface.cdb_valid_0 && lsq_buffer[i].data_tag == cdb_interface.cdb_tag_0) ||
                      (cdb_interface.cdb_valid_1 && lsq_buffer[i].data_tag == cdb_interface.cdb_tag_1) ||
                      (cdb_interface.cdb_valid_2 && lsq_buffer[i].data_tag == cdb_interface.cdb_tag_2) ||
                      (cdb_interface.cdb_valid_3_2 && lsq_buffer[i].data_tag == 3'b011 &&                    
                       lsq_buffer[i].data == cdb_interface.cdb_dest_reg_3_2) ||
                      (cdb_interface.cdb_valid_3_1 && lsq_buffer[i].data_tag == 3'b011 && 
                        lsq_buffer[i].data == cdb_interface.cdb_dest_reg_3_1) ||
                      (cdb_interface.cdb_valid_3_0 && lsq_buffer[i].data_tag == 3'b011 && 
                        lsq_buffer[i].data == cdb_interface.cdb_dest_reg_3_0) ) begin 

                     lsq_buffer[i].data_valid <= #D 1'b1;
                     lsq_buffer[i].data_tag   <= #D TAG_READY;

                     if (cdb_interface.cdb_valid_0 && lsq_buffer[i].data_tag == cdb_interface.cdb_tag_0)
                        lsq_buffer[i].data <= #D cdb_interface.cdb_data_0;
                     else if (cdb_interface.cdb_valid_1 && lsq_buffer[i].data_tag == cdb_interface.cdb_tag_1)
                        lsq_buffer[i].data <= #D cdb_interface.cdb_data_1;
                     else if (cdb_interface.cdb_valid_2 && lsq_buffer[i].data_tag == cdb_interface.cdb_tag_2)
                        lsq_buffer[i].data <= #D cdb_interface.cdb_data_2;
                     else if (cdb_interface.cdb_valid_3_2 && lsq_buffer[i].data_tag == 3'b011 && 
                              lsq_buffer[i].data == cdb_interface.cdb_dest_reg_3_2)
                        lsq_buffer[i].data <= #D cdb_interface.cdb_data_3_2;
                     else if (cdb_interface.cdb_valid_3_1 && lsq_buffer[i].data_tag == 3'b011 && 
                              lsq_buffer[i].data == cdb_interface.cdb_dest_reg_3_1)
                        lsq_buffer[i].data <= #D cdb_interface.cdb_data_3_1;
                     else 
                        lsq_buffer[i].data <= #D cdb_interface.cdb_data_3_0;
                  end
               end
            end
         end

         if (deallocate_head  | fwd_head_0) begin
            if(distance_0 < distance_1) begin
               if(distance_0 < distance_2) begin
                  head_ptr <= #D head_ptr + 1;
               end
               else begin
                  head_ptr <= #D head_ptr_2 + 1;
               end
            end
            else begin
               if(distance_1 < distance_2) begin
                  head_ptr <= #D head_ptr_1 + 1;
               end
               else begin
                  head_ptr <= #D head_ptr_2 + 1;
               end
            end
            lsq_buffer[head_idx].valid <= #D 1'b0;
            lsq_buffer[head_idx].addr_tag <= #D 3'd0;
            lsq_buffer[head_idx].addr_valid <= #D 1'b0;
            lsq_buffer[head_idx].address <= #D 32'd0;
            lsq_buffer[head_idx].data <= #D 32'd0;
            lsq_buffer[head_idx].data_tag <= #D 3'd0;
            lsq_buffer[head_idx].data_valid <= #D 1'b0;
            lsq_buffer[head_idx].is_store <= #D 1'b0;
            lsq_buffer[head_idx].mem_complete <= #D 1'b0;
            lsq_buffer[head_idx].mem_issued <= #D 1'b0;
            lsq_buffer[head_idx].phys_reg <= #D '0;
            lsq_buffer[head_idx].sign_extend <= #D 1'b0;
            lsq_buffer[head_idx].size <= #D mem_size_t'(0);
           
         end

         if(deallocate_head_1 | fwd_head_1) begin
             if(distance_0 < distance_1) begin
               if(distance_0 < distance_2) begin
                  head_ptr_1 <= #D head_ptr + 1 + (deallocate_head | fwd_head_0);
               end
               else begin
                  head_ptr_1 <= #D head_ptr_2 + 1 + (deallocate_head | fwd_head_0);
               end
            end
            else begin
               if(distance_1 < distance_2) begin
                  head_ptr_1 <= #D head_ptr_1 + 1 + (deallocate_head | fwd_head_0);
               end
               else begin
                  head_ptr_1 <= #D head_ptr_2 + 1 + (deallocate_head | fwd_head_0);
               end
            end
            lsq_buffer[head_idx_1].valid <= #D 1'b0;
            lsq_buffer[head_idx_1].addr_tag <= #D 3'd0;
            lsq_buffer[head_idx_1].addr_valid <= #D 1'b0;
            lsq_buffer[head_idx_1].address <= #D 32'd0;
            lsq_buffer[head_idx_1].data <= #D 32'd0;
            lsq_buffer[head_idx_1].data_tag <= #D 3'd0;
            lsq_buffer[head_idx_1].data_valid <= #D 1'b0;
            lsq_buffer[head_idx_1].is_store <= #D 1'b0;
            lsq_buffer[head_idx_1].mem_complete <= #D 1'b0;
            lsq_buffer[head_idx_1].mem_issued <= #D 1'b0;
            lsq_buffer[head_idx_1].phys_reg <= #D '0;
            lsq_buffer[head_idx_1].sign_extend <= #D 1'b0;
            lsq_buffer[head_idx_1].size <= #D mem_size_t'(0);
         end

         if(deallocate_head_2 | fwd_head_2) begin
            if(distance_0 < distance_1) begin
               if(distance_0 < distance_2) begin
                  head_ptr_2 <= #D head_ptr + 1 + (deallocate_head | fwd_head_0) + (deallocate_head_1 | fwd_head_1);
               end
               else begin
                  head_ptr_2 <= #D head_ptr_2 + 1 + (deallocate_head | fwd_head_0) + (deallocate_head_1 | fwd_head_1);
               end
            end
            else begin
               if(distance_1 < distance_2) begin
                  head_ptr_2 <= #D head_ptr_1 + 1 + (deallocate_head | fwd_head_0) + (deallocate_head_1 | fwd_head_1);
               end
               else begin
                  head_ptr_2 <= #D head_ptr_2 + 1 + (deallocate_head | fwd_head_0) + (deallocate_head_1 | fwd_head_1);
               end
            end
            lsq_buffer[head_idx_2].valid <= #D 1'b0;
            lsq_buffer[head_idx_2].addr_tag <= #D 3'd0;
            lsq_buffer[head_idx_2].addr_valid <= #D 1'b0;
            lsq_buffer[head_idx_2].address <= #D 32'd0;
            lsq_buffer[head_idx_2].data <= #D 32'd0;
            lsq_buffer[head_idx_2].data_tag <= #D 3'd0;
            lsq_buffer[head_idx_2].data_valid <= #D 1'b0;
            lsq_buffer[head_idx_2].is_store <= #D 1'b0;
            lsq_buffer[head_idx_2].mem_complete <= #D 1'b0;
            lsq_buffer[head_idx_2].mem_issued <= #D 1'b0;
            lsq_buffer[head_idx_2].phys_reg <= #D '0;
            lsq_buffer[head_idx_2].sign_extend <= #D 1'b0;
            lsq_buffer[head_idx_2].size <= #D mem_size_t'(0);
         end

            
      end
   end


   //==========================================================================
   // MEMORY REQUEST LOGIC (Head Side - FIFO)
   //==========================================================================

   

   logic head_ready;
   always_comb begin
      head_ready = 1'b0;
      `ifdef SECURE_UNALIGN_LSQ
      if (!lsq_empty_o && lsq_buffer[head_idx].valid && !lsq_buffer[head_idx].mem_issued && !(fwd_head_0 | head_0_should_wait | head_0_should_wait_unaligned_store)) begin 
      `else
      if (!lsq_empty_o && lsq_buffer[head_idx].valid && !lsq_buffer[head_idx].mem_issued && !(fwd_head_0 | head_0_should_wait)) begin 
      `endif
         // Head entry is ready if address is valid
         // For stores, also need data to be valid
         if (lsq_buffer[head_idx].addr_valid) begin
            if (lsq_buffer[head_idx].is_store) begin 
               //we need a permission for store from ROB because store operation at LSQ should not be issued before branch prediction is resolved // todo check them with rd, it is more reliable
               if((store_can_issue_0 && (lsq_buffer[head_idx].phys_reg == allowed_store_address_0)) ||
                  (store_can_issue_1 && (lsq_buffer[head_idx].phys_reg == allowed_store_address_1)) ||
                  (store_can_issue_2 && (lsq_buffer[head_idx].phys_reg == allowed_store_address_2))
               ) begin 
                  head_ready = lsq_buffer[head_idx].data_valid;
               end else begin
                  head_ready = 1'b0;
               end
            end else begin
               head_ready = 1'b1;  // Load only needs address
            end
         end
      end
   end

   logic head_ready_1;
   always_comb begin
      head_ready_1 = 1'b0;
      `ifdef SECURE_UNALIGN_LSQ
      if (!lsq_empty_o && lsq_buffer[head_idx_1].valid && !lsq_buffer[head_idx_1].mem_issued && !(fwd_head_1 | head_1_should_wait | head_1_should_wait_unaligned_store)) begin 
      `else
      if (!lsq_empty_o && lsq_buffer[head_idx_1].valid && !lsq_buffer[head_idx_1].mem_issued && !(fwd_head_1 | head_1_should_wait)) begin 
      `endif
         // Head entry is ready if address is valid
         // For stores, also need data to be valid
         if (lsq_buffer[head_idx_1].addr_valid) begin
            if (lsq_buffer[head_idx_1].is_store) begin   
               //we need a permission for store from ROB because store operation at LSQ should not be issued before branch prediction is resolved
               if((store_can_issue_0 && (lsq_buffer[head_idx_1].phys_reg == allowed_store_address_0)) ||
                  (store_can_issue_1 && (lsq_buffer[head_idx_1].phys_reg == allowed_store_address_1)) ||
                  (store_can_issue_2 && (lsq_buffer[head_idx_1].phys_reg == allowed_store_address_2))
               ) begin //todo add 2 more store enable signals
                  head_ready_1 = lsq_buffer[head_idx_1].data_valid;
               end else begin
                  head_ready_1 = 1'b0;
               end
            end else begin
               head_ready_1 = 1'b1;  // Load only needs address
            end
         end
      end
   end


   logic head_ready_2;
   always_comb begin
      head_ready_2 = 1'b0;
      `ifdef SECURE_UNALIGN_LSQ
      if (!lsq_empty_o && lsq_buffer[head_idx_2].valid && !lsq_buffer[head_idx_2].mem_issued && !(fwd_head_2 | head_2_should_wait | head_2_should_wait_unaligned_store)) begin 
      `else
      if (!lsq_empty_o && lsq_buffer[head_idx_2].valid && !lsq_buffer[head_idx_2].mem_issued && !(fwd_head_2 | head_2_should_wait)) begin 
      `endif 
         // Head entry is ready if address is valid
         // For stores, also need data to be valid
         if (lsq_buffer[head_idx_2].addr_valid) begin
            if (lsq_buffer[head_idx_2].is_store) begin 
               //we need a permission for store from ROB because store operation at LSQ should not be issued before branch prediction is resolved
               if((store_can_issue_0 && (lsq_buffer[head_idx_2].phys_reg == allowed_store_address_0)) ||
                  (store_can_issue_1 && (lsq_buffer[head_idx_2].phys_reg == allowed_store_address_1)) ||
                  (store_can_issue_2 && (lsq_buffer[head_idx_2].phys_reg == allowed_store_address_2))
               ) begin
                  head_ready_2 = lsq_buffer[head_idx_2].data_valid;
               end else begin
                  head_ready_2 = 1'b0;
               end
            end else begin
               head_ready_2 = 1'b1;  // Load only needs address
            end
         end
      end
   end


   // Issue memory request
   assign mem_0_req_valid_o    = head_ready;
   assign mem_0_req_is_store_o = mem_0_resp_valid_i ? 1'b0  : lsq_buffer[head_idx].is_store;
   assign mem_0_req_addr_o     = lsq_buffer[head_idx].address;
   assign mem_0_req_data_o     = store_0_data;
   assign mem_0_req_be_o =  generate_byte_enable( 
         0, //lsq_buffer[head_idx].address[1:0],
         lsq_buffer[head_idx].size
      );

   assign mem_1_req_valid_o    = head_ready_1;
   assign mem_1_req_is_store_o = mem_1_resp_valid_i ? 1'b0  : lsq_buffer[head_idx_1].is_store;
   assign mem_1_req_addr_o     = lsq_buffer[head_idx_1].address;
   assign mem_1_req_data_o     = store_1_data;
   assign mem_1_req_be_o =  generate_byte_enable(
         0, //lsq_buffer[head_idx_1].address[1:0],
         lsq_buffer[head_idx_1].size
      );

   assign mem_2_req_valid_o    = head_ready_2;
   assign mem_2_req_is_store_o = mem_2_resp_valid_i ? 1'b0  : lsq_buffer[head_idx_2].is_store;
   assign mem_2_req_addr_o     = lsq_buffer[head_idx_2].address;
   assign mem_2_req_data_o     = store_2_data;
   assign mem_2_req_be_o =  generate_byte_enable(
         0, //lsq_buffer[head_idx_2].address[1:0],
         lsq_buffer[head_idx_2].size
      );

   assign mem_0_type_sel = {lsq_buffer[head_idx].sign_extend, lsq_buffer[head_idx].size};
   assign mem_1_type_sel = {lsq_buffer[head_idx_1].sign_extend, lsq_buffer[head_idx_1].size};
   assign mem_2_type_sel = {lsq_buffer[head_idx_2].sign_extend, lsq_buffer[head_idx_2].size};

   logic [31:0] load_0_src_data;
   logic [31:0] load_1_src_data;
   logic [31:0] load_2_src_data;

   assign load_0_src_data = fwd_head_0 ? (head_0_fwd_source == 2) ? lsq_buffer[head_idx_2].data : lsq_buffer[head_idx_1].data : mem_0_resp_data_i;
   assign load_1_src_data = fwd_head_1 ? (head_1_fwd_source == 2) ? lsq_buffer[head_idx_2].data : lsq_buffer[head_idx].data : mem_1_resp_data_i;
   assign load_2_src_data = fwd_head_2 ? (head_2_fwd_source == 1) ? lsq_buffer[head_idx_1].data : lsq_buffer[head_idx].data : mem_2_resp_data_i;

   data_organizer #(.size(32)) load_0_data_organizer (
      .data_in(load_0_src_data), 
      .Type_sel(mem_0_type_sel),
      .data_out(load_0_data)
   );

   data_organizer #(.size(32)) store_0_data_organizer (
      .data_in(lsq_buffer[head_idx].data),
      .Type_sel(mem_0_type_sel),
      .data_out(store_0_data)
   );

   data_organizer #(.size(32)) load_1_data_organizer (
      .data_in(load_1_src_data), 
      .Type_sel(mem_1_type_sel),
      .data_out(load_1_data)
   );

   data_organizer #(.size(32)) store_1_data_organizer (
      .data_in(lsq_buffer[head_idx_1].data),
      .Type_sel(mem_1_type_sel),
      .data_out(store_1_data)
   );

   data_organizer #(.size(32)) load_2_data_organizer (
      .data_in(load_2_src_data), 
      .Type_sel(mem_2_type_sel),
      .data_out(load_2_data)
   );

   data_organizer #(.size(32)) store_2_data_organizer (
      .data_in(lsq_buffer[head_idx_2].data),
      .Type_sel(mem_2_type_sel),
      .data_out(store_2_data)
   );


   //==========================================================================
   // MEMORY RESPONSE AND CDB BROADCAST (for loads)
   //==========================================================================

   assign cdb_interface.cdb_valid_3_0 = mem_0_resp_valid_i | fwd_head_0; //lsq_buffer[head_idx].mem_complete;
   assign cdb_interface.cdb_tag_3_0 = 3'b011;
   assign cdb_interface.cdb_data_3_0 =  load_0_data; //lsq_buffer[head_idx].data;
   assign cdb_interface.cdb_dest_reg_3_0 = lsq_buffer[head_idx].phys_reg;

   assign cdb_interface.cdb_valid_3_1 = mem_1_resp_valid_i | fwd_head_1; //lsq_buffer[head_idx_1].mem_complete;
   assign cdb_interface.cdb_tag_3_1 = 3'b011;
   assign cdb_interface.cdb_data_3_1 =  load_1_data; //lsq_buffer[head_idx_1].data;
   assign cdb_interface.cdb_dest_reg_3_1 = lsq_buffer[head_idx_1].phys_reg;

   assign cdb_interface.cdb_valid_3_2 = mem_2_resp_valid_i | fwd_head_2; //lsq_buffer[head_idx_2].mem_complete;
   assign cdb_interface.cdb_tag_3_2 = 3'b011;
   assign cdb_interface.cdb_data_3_2 =  load_2_data; //we nedd mask here
   assign cdb_interface.cdb_dest_reg_3_2 = lsq_buffer[head_idx_2].phys_reg;



endmodule

