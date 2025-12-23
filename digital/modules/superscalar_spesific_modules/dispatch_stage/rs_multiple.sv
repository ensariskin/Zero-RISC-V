`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: rs_multiple
//
// Description:
//     Multi-entry Reservation Station (RS) for Tomasulo-based superscalar processor.
//     Buffers instructions until their source operands become available via CDB.
//     Uses Physical Register Addresses for dependency tracking (no abstract tags).
//
// Features:
//     - Parameterizable depth (default 4 entries)
//     - Physical-address-based CDB wakeup (matches cdb_dest_reg_X)
//     - Oldest-first selection policy for issue
//     - Eager misprediction flush support
//     - Combinational CDB outputs for speed, registered outputs to execute stage
//
// Behavior:
//     - Dispatch: Accepts instruction if any slot is free, even if operands not ready.
//     - Wakeup: Monitors all 6 CDB channels for matching physical register addresses.
//     - Select: Issues oldest ready instruction to functional unit.
//     - Deallocate: Frees slot after successful issue.
//////////////////////////////////////////////////////////////////////////////////

module rs_multiple #(
      parameter RS_DEPTH = 4,
      parameter DATA_WIDTH = 32,
      parameter PHYS_REG_ADDR_WIDTH = 6,
      parameter ALU_TAG = 3'b000  // This RS's ALU tag for CDB broadcast
   )(
      // Clock and Reset
      input logic clk,
      input logic reset,

      // Eager misprediction flush interface
      input logic        eager_misprediction_i,
      input logic [5:0]  mispredicted_distance_i,
      input logic [4:0]  rob_head_ptr_i,

      // Interface from Decode/Dispatch Stage
      decode_to_rs_if.reservation_station decode_if,

      // Interface to CDB (for monitoring and broadcasting results)
      cdb_if cdb_if_port,

      // Interface to Functional Unit
      rs_to_exec_if.reservation_station exec_if
   );

   localparam D = 1; // Delay for simulation
   localparam TAG_READY = 3'b111; // Tag indicating operand is ready/valid
   localparam RS_IDX_WIDTH = $clog2(RS_DEPTH);

   //==========================================================================
   // RESERVATION STATION ENTRY STRUCTURE
   //==========================================================================

   typedef struct packed {
      logic                           valid;
      logic [10:0]                    control_signals;
      logic [DATA_WIDTH-1:0]          pc;
      logic [PHYS_REG_ADDR_WIDTH-1:0] rd_phys_addr;
      logic [DATA_WIDTH-1:0]          pc_value_at_prediction;
      logic [2:0]                     branch_sel;
      logic                           branch_prediction;
      logic [DATA_WIDTH-1:0]          store_data;

      // Operand A
      logic                           operand_a_ready;
      logic [PHYS_REG_ADDR_WIDTH-1:0] operand_a_phys_addr; // Phys reg to wait for
      logic [DATA_WIDTH-1:0]          operand_a_data;

      // Operand B
      logic                           operand_b_ready;
      logic [PHYS_REG_ADDR_WIDTH-1:0] operand_b_phys_addr; // Phys reg to wait for
      logic [DATA_WIDTH-1:0]          operand_b_data;
   } rs_entry_t;

   rs_entry_t [RS_DEPTH-1:0] rs_buffer;

   //==========================================================================
   // ALLOCATION LOGIC
   //==========================================================================

   logic [RS_DEPTH-1:0] slot_valid;
   logic [RS_DEPTH-1:0] slot_free;
   logic                any_slot_free;
   logic [RS_IDX_WIDTH-1:0] alloc_idx;
   logic                alloc_enable;

   // Valid extraction
   always_comb begin
      for (int i = 0; i < RS_DEPTH; i++) begin
         slot_valid[i] = rs_buffer[i].valid;
      end
      slot_free = ~slot_valid;
      any_slot_free = |slot_free;
   end

   // Priority encoder for first free slot
   always_comb begin
      alloc_idx = '0;
      for (int i = RS_DEPTH - 1; i >= 0; i--) begin
         if (slot_free[i]) alloc_idx = i[RS_IDX_WIDTH-1:0];
      end
   end

   assign alloc_enable = decode_if.dispatch_valid && any_slot_free;
   assign decode_if.dispatch_ready = any_slot_free && exec_if.issue_ready;

   //==========================================================================
   // CDB WAKEUP LOGIC (Combinational)
   //==========================================================================

   // Wakeup signals per entry
   logic [RS_DEPTH-1:0] wakeup_a, wakeup_b;
   logic [DATA_WIDTH-1:0] wakeup_a_data [RS_DEPTH-1:0];
   logic [DATA_WIDTH-1:0] wakeup_b_data [RS_DEPTH-1:0];

   always_comb begin
      for (int i = 0; i < RS_DEPTH; i++) begin
         wakeup_a[i] = 1'b0;
         wakeup_b[i] = 1'b0;
         wakeup_a_data[i] = '0;
         wakeup_b_data[i] = '0;

         if (rs_buffer[i].valid && !rs_buffer[i].operand_a_ready) begin
            // Check ALU CDB channels (0, 1, 2)
            if (cdb_if_port.cdb_valid_0 && rs_buffer[i].operand_a_phys_addr == cdb_if_port.cdb_dest_reg_0) begin
               wakeup_a[i] = 1'b1;
               wakeup_a_data[i] = cdb_if_port.cdb_data_0;
            end else if (cdb_if_port.cdb_valid_1 && rs_buffer[i].operand_a_phys_addr == cdb_if_port.cdb_dest_reg_1) begin
               wakeup_a[i] = 1'b1;
               wakeup_a_data[i] = cdb_if_port.cdb_data_1;
            end else if (cdb_if_port.cdb_valid_2 && rs_buffer[i].operand_a_phys_addr == cdb_if_port.cdb_dest_reg_2) begin
               wakeup_a[i] = 1'b1;
               wakeup_a_data[i] = cdb_if_port.cdb_data_2;
               // Check LSQ CDB channels (3_0, 3_1, 3_2)
            end else if (cdb_if_port.cdb_valid_3_0 && rs_buffer[i].operand_a_phys_addr == cdb_if_port.cdb_dest_reg_3_0) begin
               wakeup_a[i] = 1'b1;
               wakeup_a_data[i] = cdb_if_port.cdb_data_3_0;
            end else if (cdb_if_port.cdb_valid_3_1 && rs_buffer[i].operand_a_phys_addr == cdb_if_port.cdb_dest_reg_3_1) begin
               wakeup_a[i] = 1'b1;
               wakeup_a_data[i] = cdb_if_port.cdb_data_3_1;
            end else if (cdb_if_port.cdb_valid_3_2 && rs_buffer[i].operand_a_phys_addr == cdb_if_port.cdb_dest_reg_3_2) begin
               wakeup_a[i] = 1'b1;
               wakeup_a_data[i] = cdb_if_port.cdb_data_3_2;
            end
         end

         if (rs_buffer[i].valid && !rs_buffer[i].operand_b_ready) begin
            if (cdb_if_port.cdb_valid_0 && rs_buffer[i].operand_b_phys_addr == cdb_if_port.cdb_dest_reg_0) begin
               wakeup_b[i] = 1'b1;
               wakeup_b_data[i] = cdb_if_port.cdb_data_0;
            end else if (cdb_if_port.cdb_valid_1 && rs_buffer[i].operand_b_phys_addr == cdb_if_port.cdb_dest_reg_1) begin
               wakeup_b[i] = 1'b1;
               wakeup_b_data[i] = cdb_if_port.cdb_data_1;
            end else if (cdb_if_port.cdb_valid_2 && rs_buffer[i].operand_b_phys_addr == cdb_if_port.cdb_dest_reg_2) begin
               wakeup_b[i] = 1'b1;
               wakeup_b_data[i] = cdb_if_port.cdb_data_2;
            end else if (cdb_if_port.cdb_valid_3_0 && rs_buffer[i].operand_b_phys_addr == cdb_if_port.cdb_dest_reg_3_0) begin
               wakeup_b[i] = 1'b1;
               wakeup_b_data[i] = cdb_if_port.cdb_data_3_0;
            end else if (cdb_if_port.cdb_valid_3_1 && rs_buffer[i].operand_b_phys_addr == cdb_if_port.cdb_dest_reg_3_1) begin
               wakeup_b[i] = 1'b1;
               wakeup_b_data[i] = cdb_if_port.cdb_data_3_1;
            end else if (cdb_if_port.cdb_valid_3_2 && rs_buffer[i].operand_b_phys_addr == cdb_if_port.cdb_dest_reg_3_2) begin
               wakeup_b[i] = 1'b1;
               wakeup_b_data[i] = cdb_if_port.cdb_data_3_2;
            end
         end
      end
   end

   //==========================================================================
   // SELECTION LOGIC (Oldest-First)
   //==========================================================================

   logic [RS_DEPTH-1:0] entry_ready;
   logic [RS_DEPTH-1:0] entry_rob_distance_lt [RS_DEPTH-1:0]; // For age comparison
   logic [5:0]          entry_rob_distance [RS_DEPTH-1:0];
   logic [RS_IDX_WIDTH-1:0] select_idx;
   logic                    any_ready;

   // Ready check: valid AND both operands ready (either stored or waking up this cycle)
   logic [4:0] entry_rob_idx;
   always_comb begin
      for (int i = 0; i < RS_DEPTH; i++) begin
         entry_ready[i] = rs_buffer[i].valid &&
            (rs_buffer[i].operand_a_ready || wakeup_a[i]) &&
            (rs_buffer[i].operand_b_ready || wakeup_b[i]);

         // Calculate ROB distance for each entry (for flush and age comparison)

         entry_rob_idx = rs_buffer[i].rd_phys_addr[4:0];
         if (entry_rob_idx >= rob_head_ptr_i)
            entry_rob_distance[i] = entry_rob_idx - rob_head_ptr_i;
         else
            entry_rob_distance[i] = 32 - rob_head_ptr_i + entry_rob_idx;
      end
      any_ready = |entry_ready;
   end

   // Oldest-first selection: smallest ROB distance among ready entries
   logic [5:0] min_distance;
   always_comb begin
      select_idx = '0;

      min_distance = 6'd63; // Max value
      for (int i = 0; i < RS_DEPTH; i++) begin
         if (entry_ready[i] && entry_rob_distance[i] < min_distance) begin
            min_distance = entry_rob_distance[i];
            select_idx = i[RS_IDX_WIDTH-1:0];
         end
      end
   end

   //==========================================================================
   // EAGER MISPREDICTION FLUSH LOGIC
   //==========================================================================

   logic [RS_DEPTH-1:0] should_flush;
   always_comb begin
      for (int i = 0; i < RS_DEPTH; i++) begin
         should_flush[i] = rs_buffer[i].valid && eager_misprediction_i &&
            (entry_rob_distance[i] > mispredicted_distance_i);
      end
   end

   //==========================================================================
   // REGISTERED STATE UPDATE
   //==========================================================================

   always_ff @(posedge clk or negedge reset) begin
      if (!reset) begin
         for (int i = 0; i < RS_DEPTH; i++) begin
            rs_buffer[i] <= #D '0;
         end
      end else begin
         // --- ALLOCATION ---
         if (alloc_enable) begin
            rs_buffer[alloc_idx].valid               <= #D 1'b1;
            rs_buffer[alloc_idx].control_signals     <= #D decode_if.control_signals;
            rs_buffer[alloc_idx].pc                  <= #D decode_if.pc;
            rs_buffer[alloc_idx].rd_phys_addr        <= #D decode_if.rd_phys_addr;
            rs_buffer[alloc_idx].pc_value_at_prediction <= #D decode_if.pc_value_at_prediction;
            rs_buffer[alloc_idx].branch_sel          <= #D decode_if.branch_sel;
            rs_buffer[alloc_idx].branch_prediction   <= #D decode_if.branch_prediction;
            rs_buffer[alloc_idx].store_data          <= #D decode_if.store_data;

            // Operand A: check if already ready (tag == 111)
            if (decode_if.operand_a_tag == TAG_READY) begin
               rs_buffer[alloc_idx].operand_a_ready     <= #D 1'b1;
               rs_buffer[alloc_idx].operand_a_data      <= #D decode_if.operand_a_data;
               rs_buffer[alloc_idx].operand_a_phys_addr <= #D '0;
            end else begin
               rs_buffer[alloc_idx].operand_a_ready     <= #D 1'b0;
               rs_buffer[alloc_idx].operand_a_data      <= #D '0;
               // Store the phys addr from operand_a_data (lower 6 bits as per convention)
               rs_buffer[alloc_idx].operand_a_phys_addr <= #D decode_if.operand_a_data[PHYS_REG_ADDR_WIDTH-1:0];
            end

            // Operand B: check if already ready (tag == 111)
            if (decode_if.operand_b_tag == TAG_READY) begin
               rs_buffer[alloc_idx].operand_b_ready     <= #D 1'b1;
               rs_buffer[alloc_idx].operand_b_data      <= #D decode_if.operand_b_data;
               rs_buffer[alloc_idx].operand_b_phys_addr <= #D '0;
            end else begin
               rs_buffer[alloc_idx].operand_b_ready     <= #D 1'b0;
               rs_buffer[alloc_idx].operand_b_data      <= #D '0;
               rs_buffer[alloc_idx].operand_b_phys_addr <= #D decode_if.operand_b_data[PHYS_REG_ADDR_WIDTH-1:0];
            end
         end

         // --- WAKEUP UPDATE ---
         for (int i = 0; i < RS_DEPTH; i++) begin
            if (wakeup_a[i]) begin
               rs_buffer[i].operand_a_ready <= #D 1'b1;
               rs_buffer[i].operand_a_data  <= #D wakeup_a_data[i];
            end
            if (wakeup_b[i]) begin
               rs_buffer[i].operand_b_ready <= #D 1'b1;
               rs_buffer[i].operand_b_data  <= #D wakeup_b_data[i];
            end
         end

         // --- DEALLOCATION (after successful issue) ---
         if (any_ready && exec_if.issue_ready) begin
            rs_buffer[select_idx].valid <= #D 1'b0;
         end

         // --- EAGER FLUSH ---
         for (int i = 0; i < RS_DEPTH; i++) begin
            if (should_flush[i]) begin
               rs_buffer[i].valid <= #D 1'b0;
            end
         end
      end
   end

   //==========================================================================
   // EXECUTE INTERFACE OUTPUTS (Registered for timing)
   //==========================================================================

   // Mux operand data: use wakeup data if waking up this cycle, else stored data
   logic [DATA_WIDTH-1:0] issue_operand_a, issue_operand_b;
   always_comb begin
      if (wakeup_a[select_idx])
         issue_operand_a = wakeup_a_data[select_idx];
      else
         issue_operand_a = rs_buffer[select_idx].operand_a_data;

      if (wakeup_b[select_idx])
         issue_operand_b = wakeup_b_data[select_idx];
      else
         issue_operand_b = rs_buffer[select_idx].operand_b_data;
   end

   always_ff @(posedge clk or negedge reset) begin
      if (!reset) begin
         exec_if.issue_valid            <= #D 1'b0;
         exec_if.control_signals        <= #D '0;
         exec_if.pc                     <= #D '0;
         exec_if.data_a                 <= #D '0;
         exec_if.data_b                 <= #D '0;
         exec_if.store_data             <= #D '0;
         exec_if.rd_phys_addr           <= #D '0;
         exec_if.pc_value_at_prediction <= #D '0;
         exec_if.branch_sel             <= #D '0;
         exec_if.branch_prediction      <= #D 1'b0;
      end else begin
         if (any_ready && !should_flush[select_idx]) begin
            exec_if.issue_valid            <= #D 1'b1;
            exec_if.control_signals        <= #D rs_buffer[select_idx].control_signals;
            exec_if.pc                     <= #D rs_buffer[select_idx].pc;
            exec_if.data_a                 <= #D issue_operand_a;
            exec_if.data_b                 <= #D issue_operand_b;
            exec_if.store_data             <= #D rs_buffer[select_idx].store_data;
            exec_if.rd_phys_addr           <= #D rs_buffer[select_idx].rd_phys_addr;
            exec_if.pc_value_at_prediction <= #D rs_buffer[select_idx].pc_value_at_prediction;
            exec_if.branch_sel             <= #D rs_buffer[select_idx].branch_sel;
            exec_if.branch_prediction      <= #D rs_buffer[select_idx].branch_prediction;
         end else begin
            exec_if.issue_valid <= #D 1'b0;
         end
      end
   end

   //==========================================================================
   // CDB BROADCAST OUTPUT (Combinational)
   //==========================================================================

   generate
      if (ALU_TAG == 3'b000) begin : gen_alu0_cdb
         assign cdb_if_port.cdb_valid_0             = exec_if.issue_valid && exec_if.issue_ready;
         assign cdb_if_port.cdb_tag_0               = ALU_TAG;
         assign cdb_if_port.cdb_data_0              = exec_if.data_result;
         assign cdb_if_port.cdb_dest_reg_0          = exec_if.rd_phys_addr;
         assign cdb_if_port.cdb_mem_addr_calculation_0 = exec_if.mem_addr_calculation;
         assign cdb_if_port.cdb_misprediction_0     = exec_if.misprediction;
         assign cdb_if_port.cdb_is_branch_0         = exec_if.is_branch;
         assign cdb_if_port.cdb_correct_pc_0        = exec_if.correct_pc;
      end else if (ALU_TAG == 3'b001) begin : gen_alu1_cdb
         assign cdb_if_port.cdb_valid_1             = exec_if.issue_valid && exec_if.issue_ready;
         assign cdb_if_port.cdb_tag_1               = ALU_TAG;
         assign cdb_if_port.cdb_data_1              = exec_if.data_result;
         assign cdb_if_port.cdb_dest_reg_1          = exec_if.rd_phys_addr;
         assign cdb_if_port.cdb_mem_addr_calculation_1 = exec_if.mem_addr_calculation;
         assign cdb_if_port.cdb_misprediction_1     = exec_if.misprediction;
         assign cdb_if_port.cdb_is_branch_1         = exec_if.is_branch;
         assign cdb_if_port.cdb_correct_pc_1        = exec_if.correct_pc;
      end else if (ALU_TAG == 3'b010) begin : gen_alu2_cdb
         assign cdb_if_port.cdb_valid_2             = exec_if.issue_valid && exec_if.issue_ready;
         assign cdb_if_port.cdb_tag_2               = ALU_TAG;
         assign cdb_if_port.cdb_data_2              = exec_if.data_result;
         assign cdb_if_port.cdb_dest_reg_2          = exec_if.rd_phys_addr;
         assign cdb_if_port.cdb_mem_addr_calculation_2 = exec_if.mem_addr_calculation;
         assign cdb_if_port.cdb_misprediction_2     = exec_if.misprediction;
         assign cdb_if_port.cdb_is_branch_2         = exec_if.is_branch;
         assign cdb_if_port.cdb_correct_pc_2        = exec_if.correct_pc;
      end
   endgenerate

endmodule
