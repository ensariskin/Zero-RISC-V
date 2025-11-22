// Pipeline Performance Analyzer
// Analyzes bottlenecks in 3-way superscalar processor
// Tracks:
//   1. RS blocking reasons (which CDB channel we're waiting for)
//   2. Dispatch valid analysis (why instructions aren't dispatching)

module pipeline_performance_analyzer(
      input logic clk,
      input logic reset,

      // Pipeline 0 signals
      input logic dispatch_valid_0,
      input logic dispatch_ready_0,
      input logic issue_valid_0,
      input logic [2:0] operand_a_tag_0,
      input logic [2:0] operand_b_tag_0,

      // Pipeline 1 signals
      input logic dispatch_valid_1,
      input logic dispatch_ready_1,
      input logic issue_valid_1,
      input logic [2:0] operand_a_tag_1,
      input logic [2:0] operand_b_tag_1,

      // Pipeline 2 signals
      input logic dispatch_valid_2,
      input logic dispatch_ready_2,
      input logic issue_valid_2,
      input logic [2:0] operand_a_tag_2,
      input logic [2:0] operand_b_tag_2,

      // ROB and instruction availability
      input logic rob_full,
      input logic instruction_available_0,
      input logic instruction_available_1,
      input logic instruction_available_2,

      input logic misprediction_detected
   );

   // Clock counter
   integer cycle_count = 0;

   // File pointer
   integer file_pointer;

   // RS state tracking (per pipeline)
   logic rs_active_0, rs_active_1, rs_active_2;
   logic prev_dispatch_valid_0, prev_dispatch_valid_1, prev_dispatch_valid_2;
   logic prev_dispatch_ready_0, prev_dispatch_ready_1, prev_dispatch_ready_2;

   logic rs0_occupied, rs1_occupied, rs2_occupied;

   // ========== Pipeline 0 Counters ==========
   // RS Blocker counters - Operand A
   integer p0_rs_a_waiting_cdb0 = 0;
   integer p0_rs_a_waiting_cdb1 = 0;
   integer p0_rs_a_waiting_cdb2 = 0;
   integer p0_rs_a_waiting_cdb3 = 0;
   // RS Blocker counters - Operand B
   integer p0_rs_b_waiting_cdb0 = 0;
   integer p0_rs_b_waiting_cdb1 = 0;
   integer p0_rs_b_waiting_cdb2 = 0;
   integer p0_rs_b_waiting_cdb3 = 0;

   // Dispatch blocker counters
   integer p0_blocked_by_dependency = 0;
   integer p0_blocked_by_rob_full = 0;
   integer p0_blocked_by_no_instruction = 0;
   integer p0_blocked_by_misprediction = 0;
   integer p0_blocked_by_unknown = 0;
   integer p0_total_dispatch_stalls = 0;

   // ========== Pipeline 1 Counters ==========
   // RS Blocker counters - Operand A
   integer p1_rs_a_waiting_cdb0 = 0;
   integer p1_rs_a_waiting_cdb1 = 0;
   integer p1_rs_a_waiting_cdb2 = 0;
   integer p1_rs_a_waiting_cdb3 = 0;
   // RS Blocker counters - Operand B
   integer p1_rs_b_waiting_cdb0 = 0;
   integer p1_rs_b_waiting_cdb1 = 0;
   integer p1_rs_b_waiting_cdb2 = 0;
   integer p1_rs_b_waiting_cdb3 = 0;

   integer p1_blocked_by_dependency = 0;
   integer p1_blocked_by_rob_full = 0;
   integer p1_blocked_by_no_instruction = 0;
   integer p1_blocked_by_misprediction = 0;
   integer p1_blocked_by_unknown = 0;
   integer p1_total_dispatch_stalls = 0;

   // ========== Pipeline 2 Counters ==========
   // RS Blocker counters - Operand A
   integer p2_rs_a_waiting_cdb0 = 0;
   integer p2_rs_a_waiting_cdb1 = 0;
   integer p2_rs_a_waiting_cdb2 = 0;
   integer p2_rs_a_waiting_cdb3 = 0;
   // RS Blocker counters - Operand B
   integer p2_rs_b_waiting_cdb0 = 0;
   integer p2_rs_b_waiting_cdb1 = 0;
   integer p2_rs_b_waiting_cdb2 = 0;
   integer p2_rs_b_waiting_cdb3 = 0;

   integer p2_blocked_by_dependency = 0;
   integer p2_blocked_by_rob_full = 0;
   integer p2_blocked_by_no_instruction = 0;
   integer p2_blocked_by_misprediction = 0;
   integer p2_blocked_by_unknown = 0;
   integer p2_total_dispatch_stalls = 0;

   integer total_rs_blocking = 0;
   integer total_dispatch_stalls = 0;
   integer total_dependency_blocks = 0;
   integer total_rob_blocks = 0;
   integer total_no_instr_blocks = 0;
   integer total_misprediction_blocks = 0;
   integer total_unknown_blocks = 0;


   // Open file
   initial begin
      file_pointer = $fopen("pipeline_performance_analysis.log", "w");
      $fwrite(file_pointer, "Pipeline Performance Analysis Report\n");
      $fwrite(file_pointer, "====================================\n\n");
      $fwrite(file_pointer, "Report Interval: Every 1000 cycles\n");
      $fwrite(file_pointer, "====================================\n\n");
   end

   always @(posedge clk) begin
      if (reset) begin
         cycle_count <= 0;
         rs_active_0 <= 0;
         rs_active_1 <= 0;
         rs_active_2 <= 0;
         prev_dispatch_valid_0 <= 0;
         prev_dispatch_valid_1 <= 0;
         prev_dispatch_valid_2 <= 0;
         prev_dispatch_ready_0 <= 0;
         prev_dispatch_ready_1 <= 0;
         prev_dispatch_ready_2 <= 0;

         rs0_occupied <= 0;
         rs1_occupied <= 0;
         rs2_occupied <= 0;
      end else begin
         cycle_count <= cycle_count + 1;

         // ==================== PIPELINE 0 ANALYSIS ====================

         // Track RS active state
         if (misprediction_detected) begin
            rs_active_0 <= 0;
            rs0_occupied <= 0;
         end else if (dispatch_valid_0) begin
            rs_active_0 <= 1;
            rs0_occupied <= 1;
         end else if (issue_valid_0) begin
            rs0_occupied <= 0;
         end

         // RS Blocker Analysis: dispatch happened but issue didn't
         if (rs0_occupied  & !issue_valid_0 & !misprediction_detected) begin
            // todo add total counter here

            // Check which CDB operand A is waiting for
            if (operand_a_tag_0 == 3'd0) begin
               p0_rs_a_waiting_cdb0 <= p0_rs_a_waiting_cdb0 + 1;
            end
            if (operand_a_tag_0 == 3'd1) begin
               p0_rs_a_waiting_cdb1 <= p0_rs_a_waiting_cdb1 + 1;
            end
            if (operand_a_tag_0 == 3'd2) begin
               p0_rs_a_waiting_cdb2 <= p0_rs_a_waiting_cdb2 + 1;
            end
            if (operand_a_tag_0 == 3'd3) begin
               p0_rs_a_waiting_cdb3 <= p0_rs_a_waiting_cdb3 + 1;
            end

            // Check which CDB operand B is waiting for
            if (operand_b_tag_0 == 3'd0) begin
               p0_rs_b_waiting_cdb0 <= p0_rs_b_waiting_cdb0 + 1;
            end
            if (operand_b_tag_0 == 3'd1) begin
               p0_rs_b_waiting_cdb1 <= p0_rs_b_waiting_cdb1 + 1;
            end
            if (operand_b_tag_0 == 3'd2) begin
               p0_rs_b_waiting_cdb2 <= p0_rs_b_waiting_cdb2 + 1;
            end
            if (operand_b_tag_0 == 3'd3) begin
               p0_rs_b_waiting_cdb3 <= p0_rs_b_waiting_cdb3 + 1;
            end
         end

         // Dispatch Valid Analysis
         if (!dispatch_valid_0) begin
            p0_total_dispatch_stalls <= p0_total_dispatch_stalls + 1;
            if(rs_active_0 & !misprediction_detected) begin
               // Check if blocked by dependency (dispatch_ready = 0)
               if (!prev_dispatch_ready_0) begin
                  p0_blocked_by_dependency <= p0_blocked_by_dependency + 1;
               end else if (prev_dispatch_ready_0) begin
                  if (rob_full) begin // maybe we should use previous value here?
                     p0_blocked_by_rob_full <= p0_blocked_by_rob_full + 1;
                  end else if (!instruction_available_0) begin
                     p0_blocked_by_no_instruction <= p0_blocked_by_no_instruction + 1;
                  end
               end
               else begin
                  p0_blocked_by_unknown <= p0_blocked_by_unknown + 1;
               end
            end else begin
               p0_blocked_by_misprediction <= p0_blocked_by_misprediction + 1;
            end
         end

         // ==================== PIPELINE 1 ANALYSIS ====================
         if (misprediction_detected) begin
            rs_active_1 <= 0;
         end
         else if (dispatch_valid_1) begin
            rs_active_1 <= 1;
         end

         if (rs_active_1 & !issue_valid_1 & !misprediction_detected & prev_dispatch_valid_1) begin
            // Check which CDB operand A is waiting for
            if (operand_a_tag_1 == 3'd0) begin
               p1_rs_a_waiting_cdb0 <= p1_rs_a_waiting_cdb0 + 1;
            end
            if (operand_a_tag_1 == 3'd1) begin
               p1_rs_a_waiting_cdb1 <= p1_rs_a_waiting_cdb1 + 1;
            end
            if (operand_a_tag_1 == 3'd2) begin
               p1_rs_a_waiting_cdb2 <= p1_rs_a_waiting_cdb2 + 1;
            end
            if (operand_a_tag_1 == 3'd3) begin
               p1_rs_a_waiting_cdb3 <= p1_rs_a_waiting_cdb3 + 1;
            end

            // Check which CDB operand B is waiting for
            if (operand_b_tag_1 == 3'd0) begin
               p1_rs_b_waiting_cdb0 <= p1_rs_b_waiting_cdb0 + 1;
            end
            if (operand_b_tag_1 == 3'd1) begin
               p1_rs_b_waiting_cdb1 <= p1_rs_b_waiting_cdb1 + 1;
            end
            if (operand_b_tag_1 == 3'd2) begin
               p1_rs_b_waiting_cdb2 <= p1_rs_b_waiting_cdb2 + 1;
            end
            if (operand_b_tag_1 == 3'd3) begin
               p1_rs_b_waiting_cdb3 <= p1_rs_b_waiting_cdb3 + 1;
            end
         end

         if (!dispatch_valid_1) begin
            p1_total_dispatch_stalls <= p1_total_dispatch_stalls + 1;
            if(rs_active_1 & !misprediction_detected) begin
               // Check if blocked by dependency (dispatch_ready = 0)
               if (!prev_dispatch_ready_1) begin
                  p1_blocked_by_dependency <= p1_blocked_by_dependency + 1;
               end else if (prev_dispatch_ready_1) begin
                  if (rob_full) begin
                     p1_blocked_by_rob_full <= p1_blocked_by_rob_full + 1;
                  end else if (!instruction_available_1) begin
                     p1_blocked_by_no_instruction <= p1_blocked_by_no_instruction + 1;
                  end
               end
               else begin
                  p1_blocked_by_unknown <= p1_blocked_by_unknown + 1;
               end
            end else begin
               p1_blocked_by_misprediction <= p1_blocked_by_misprediction + 1;
            end
         end

         // ==================== PIPELINE 2 ANALYSIS ====================

         if (misprediction_detected) begin
            rs_active_2 <= 0;
         end else if (dispatch_valid_2 ) begin
            rs_active_2 <= 1;
         end

         if (rs_active_2 & !issue_valid_2 & !misprediction_detected & prev_dispatch_valid_2) begin
            // Check which CDB operand A is waiting for
            if (operand_a_tag_2 == 3'd0) begin
               p2_rs_a_waiting_cdb0 <= p2_rs_a_waiting_cdb0 + 1;
            end
            if (operand_a_tag_2 == 3'd1) begin
               p2_rs_a_waiting_cdb1 <= p2_rs_a_waiting_cdb1 + 1;
            end
            if (operand_a_tag_2 == 3'd2) begin
               p2_rs_a_waiting_cdb2 <= p2_rs_a_waiting_cdb2 + 1;
            end
            if (operand_a_tag_2 == 3'd3) begin
               p2_rs_a_waiting_cdb3 <= p2_rs_a_waiting_cdb3 + 1;
            end

            // Check which CDB operand B is waiting for
            if (operand_b_tag_2 == 3'd0) begin
               p2_rs_b_waiting_cdb0 <= p2_rs_b_waiting_cdb0 + 1;
            end
            if (operand_b_tag_2 == 3'd1) begin
               p2_rs_b_waiting_cdb1 <= p2_rs_b_waiting_cdb1 + 1;
            end
            if (operand_b_tag_2 == 3'd2) begin
               p2_rs_b_waiting_cdb2 <= p2_rs_b_waiting_cdb2 + 1;
            end
            if (operand_b_tag_2 == 3'd3) begin
               p2_rs_b_waiting_cdb3 <= p2_rs_b_waiting_cdb3 + 1;
            end
         end

         if (!dispatch_valid_2) begin
            p2_total_dispatch_stalls <= p2_total_dispatch_stalls + 1;
            if(rs_active_2 & !misprediction_detected) begin
               // Check if blocked by dependency (dispatch_ready = 0)
            
               if (!prev_dispatch_ready_2) begin
                  p2_blocked_by_dependency <= p2_blocked_by_dependency + 1;
               end else if (prev_dispatch_ready_2) begin
                  if (rob_full) begin
                     p2_blocked_by_rob_full <= p2_blocked_by_rob_full + 1;
                  end else if (!instruction_available_2) begin
                     p2_blocked_by_no_instruction <= p2_blocked_by_no_instruction + 1;
                  end
               end
               else begin
                  p2_blocked_by_unknown <= p2_blocked_by_unknown + 1;
               end
            end else begin
               p2_blocked_by_misprediction <= p2_blocked_by_misprediction + 1;
            end
            
         end

         // Save previous values
         prev_dispatch_valid_0 <= dispatch_valid_0;
         prev_dispatch_valid_1 <= dispatch_valid_1;
         prev_dispatch_valid_2 <= dispatch_valid_2;
         prev_dispatch_ready_0 <= dispatch_ready_0;
         prev_dispatch_ready_1 <= dispatch_ready_1;
         prev_dispatch_ready_2 <= dispatch_ready_2;

         // ==================== PERIODIC REPORTING ====================
         if (cycle_count % 1000 == 0 && cycle_count > 0) begin
            $fwrite(file_pointer, "============ Cycle %0d ============\n", cycle_count);

            // Pipeline 0 Report
            $fwrite(file_pointer, "\n--- PIPELINE 0 ---\n");
            $fwrite(file_pointer, "RS Dependency Blocking (Operand A):\n");
            $fwrite(file_pointer, "  Waiting for CDB0: %0d cycles\n", p0_rs_a_waiting_cdb0);
            $fwrite(file_pointer, "  Waiting for CDB1: %0d cycles\n", p0_rs_a_waiting_cdb1);
            $fwrite(file_pointer, "  Waiting for CDB2: %0d cycles\n", p0_rs_a_waiting_cdb2);
            $fwrite(file_pointer, "  Waiting for CDB3: %0d cycles\n", p0_rs_a_waiting_cdb3);
            $fwrite(file_pointer, "RS Dependency Blocking (Operand B):\n");
            $fwrite(file_pointer, "  Waiting for CDB0: %0d cycles\n", p0_rs_b_waiting_cdb0);
            $fwrite(file_pointer, "  Waiting for CDB1: %0d cycles\n", p0_rs_b_waiting_cdb1);
            $fwrite(file_pointer, "  Waiting for CDB2: %0d cycles\n", p0_rs_b_waiting_cdb2);
            $fwrite(file_pointer, "  Waiting for CDB3: %0d cycles\n", p0_rs_b_waiting_cdb3);
            $fwrite(file_pointer, "Dispatch Stalls:\n");
            $fwrite(file_pointer, "  Total stalls: %0d cycles (%.1f%%)\n",
               p0_total_dispatch_stalls, (p0_total_dispatch_stalls * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by dependency: %0d (%.1f%%)\n",
               p0_blocked_by_dependency, (p0_blocked_by_dependency * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by ROB full: %0d (%.1f%%)\n",
               p0_blocked_by_rob_full, (p0_blocked_by_rob_full * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by no instruction: %0d (%.1f%%)\n",
               p0_blocked_by_no_instruction, (p0_blocked_by_no_instruction * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by misprediction: %0d (%.1f%%)\n",
               p0_blocked_by_misprediction, (p0_blocked_by_misprediction * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by unknown: %0d (%.1f%%)\n",
               p0_blocked_by_unknown, (p0_blocked_by_unknown * 100.0) / cycle_count);

            // Pipeline 1 Report
            $fwrite(file_pointer, "\n--- PIPELINE 1 ---\n");
            $fwrite(file_pointer, "RS Dependency Blocking (Operand A):\n");
            $fwrite(file_pointer, "  Waiting for CDB0: %0d cycles\n", p1_rs_a_waiting_cdb0);
            $fwrite(file_pointer, "  Waiting for CDB1: %0d cycles\n", p1_rs_a_waiting_cdb1);
            $fwrite(file_pointer, "  Waiting for CDB2: %0d cycles\n", p1_rs_a_waiting_cdb2);
            $fwrite(file_pointer, "  Waiting for CDB3: %0d cycles\n", p1_rs_a_waiting_cdb3);
            $fwrite(file_pointer, "RS Dependency Blocking (Operand B):\n");
            $fwrite(file_pointer, "  Waiting for CDB0: %0d cycles\n", p1_rs_b_waiting_cdb0);
            $fwrite(file_pointer, "  Waiting for CDB1: %0d cycles\n", p1_rs_b_waiting_cdb1);
            $fwrite(file_pointer, "  Waiting for CDB2: %0d cycles\n", p1_rs_b_waiting_cdb2);
            $fwrite(file_pointer, "  Waiting for CDB3: %0d cycles\n", p1_rs_b_waiting_cdb3);
            $fwrite(file_pointer, "Dispatch Stalls:\n");
            $fwrite(file_pointer, "  Total stalls: %0d cycles (%.1f%%)\n",
               p1_total_dispatch_stalls, (p1_total_dispatch_stalls * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by dependency: %0d (%.1f%%)\n",
               p1_blocked_by_dependency, (p1_blocked_by_dependency * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by ROB full: %0d (%.1f%%)\n",
               p1_blocked_by_rob_full, (p1_blocked_by_rob_full * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by no instruction: %0d (%.1f%%)\n",
               p1_blocked_by_no_instruction, (p1_blocked_by_no_instruction * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by misprediction: %0d (%.1f%%)\n",
               p1_blocked_by_misprediction, (p1_blocked_by_misprediction * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by unknown: %0d (%.1f%%)\n",
               p1_blocked_by_unknown, (p1_blocked_by_unknown * 100.0) / cycle_count);
            

            // Pipeline 2 Report
            $fwrite(file_pointer, "\n--- PIPELINE 2 ---\n");
            $fwrite(file_pointer, "RS Dependency Blocking (Operand A):\n");
            $fwrite(file_pointer, "  Waiting for CDB0: %0d cycles\n", p2_rs_a_waiting_cdb0);
            $fwrite(file_pointer, "  Waiting for CDB1: %0d cycles\n", p2_rs_a_waiting_cdb1);
            $fwrite(file_pointer, "  Waiting for CDB2: %0d cycles\n", p2_rs_a_waiting_cdb2);
            $fwrite(file_pointer, "  Waiting for CDB3: %0d cycles\n", p2_rs_a_waiting_cdb3);
            $fwrite(file_pointer, "RS Dependency Blocking (Operand B):\n");
            $fwrite(file_pointer, "  Waiting for CDB0: %0d cycles\n", p2_rs_b_waiting_cdb0);
            $fwrite(file_pointer, "  Waiting for CDB1: %0d cycles\n", p2_rs_b_waiting_cdb1);
            $fwrite(file_pointer, "  Waiting for CDB2: %0d cycles\n", p2_rs_b_waiting_cdb2);
            $fwrite(file_pointer, "  Waiting for CDB3: %0d cycles\n", p2_rs_b_waiting_cdb3);
            $fwrite(file_pointer, "Dispatch Stalls:\n");
            $fwrite(file_pointer, "  Total stalls: %0d cycles (%.1f%%)\n",
               p2_total_dispatch_stalls, (p2_total_dispatch_stalls * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by dependency: %0d (%.1f%%)\n",
               p2_blocked_by_dependency, (p2_blocked_by_dependency * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by ROB full: %0d (%.1f%%)\n",
               p2_blocked_by_rob_full, (p2_blocked_by_rob_full * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by no instruction: %0d (%.1f%%)\n",
               p2_blocked_by_no_instruction, (p2_blocked_by_no_instruction * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by misprediction: %0d (%.1f%%)\n",
               p2_blocked_by_misprediction, (p2_blocked_by_misprediction * 100.0) / cycle_count);
            $fwrite(file_pointer, "  Blocked by unknown: %0d (%.1f%%)\n",
               p2_blocked_by_unknown, (p2_blocked_by_unknown * 100.0) / cycle_count);

            $fwrite(file_pointer, "\n");
            $fflush(file_pointer);
         end
      end
   end

   // Final report at end of simulation
   final begin
      total_rs_blocking = p0_rs_a_waiting_cdb0 + p0_rs_a_waiting_cdb1 + p0_rs_a_waiting_cdb2 + p0_rs_a_waiting_cdb3 +
         p0_rs_b_waiting_cdb0 + p0_rs_b_waiting_cdb1 + p0_rs_b_waiting_cdb2 + p0_rs_b_waiting_cdb3 +
         p1_rs_a_waiting_cdb0 + p1_rs_a_waiting_cdb1 + p1_rs_a_waiting_cdb2 + p1_rs_a_waiting_cdb3 +
         p1_rs_b_waiting_cdb0 + p1_rs_b_waiting_cdb1 + p1_rs_b_waiting_cdb2 + p1_rs_b_waiting_cdb3 +
         p2_rs_a_waiting_cdb0 + p2_rs_a_waiting_cdb1 + p2_rs_a_waiting_cdb2 + p2_rs_a_waiting_cdb3 +
         p2_rs_b_waiting_cdb0 + p2_rs_b_waiting_cdb1 + p2_rs_b_waiting_cdb2 + p2_rs_b_waiting_cdb3;

      total_dispatch_stalls = p0_total_dispatch_stalls + p1_total_dispatch_stalls + p2_total_dispatch_stalls;
      total_dependency_blocks = p0_blocked_by_dependency + p1_blocked_by_dependency + p2_blocked_by_dependency;
      total_rob_blocks = p0_blocked_by_rob_full + p1_blocked_by_rob_full + p2_blocked_by_rob_full;
      total_no_instr_blocks = p0_blocked_by_no_instruction + p1_blocked_by_no_instruction + p2_blocked_by_no_instruction;
      total_misprediction_blocks = p0_blocked_by_misprediction + p1_blocked_by_misprediction + p2_blocked_by_misprediction;
      total_unknown_blocks = p0_blocked_by_unknown + p1_blocked_by_unknown + p2_blocked_by_unknown;

      $fwrite(file_pointer, "\n\n========================================\n");
      $fwrite(file_pointer, "FINAL PERFORMANCE SUMMARY\n");
      $fwrite(file_pointer, "========================================\n");
      $fwrite(file_pointer, "Total Simulation Cycles: %0d\n\n", cycle_count);

      // Overall statistics
      $fwrite(file_pointer, "=== OVERALL BOTTLENECK ANALYSIS ===\n\n");

      $fwrite(file_pointer, "Total RS Dependency Blocking: %0d cycles\n", total_rs_blocking);
      $fwrite(file_pointer, "Total Dispatch Stalls: %0d cycles (%.1f%% of total)\n",
         total_dispatch_stalls, (total_dispatch_stalls * 100.0) / (cycle_count * 3));
      $fwrite(file_pointer, "  - Dependency blocking: %0d (%.1f%%)\n",
         total_dependency_blocks, (total_dependency_blocks * 100.0) / (cycle_count * 3));
      $fwrite(file_pointer, "  - ROB full blocking: %0d (%.1f%%)\n",
         total_rob_blocks, (total_rob_blocks * 100.0) / (cycle_count * 3));
      $fwrite(file_pointer, "  - No instruction available: %0d (%.1f%%)\n",
         total_no_instr_blocks, (total_no_instr_blocks * 100.0) / (cycle_count * 3));
      $fwrite(file_pointer, "  - Misprediction blocking: %0d (%.1f%%)\n",
         total_misprediction_blocks, (total_misprediction_blocks * 100.0) / (cycle_count * 3));
      $fwrite(file_pointer, "  - Unknown reasons: %0d (%.1f%%)\n",
         total_unknown_blocks, (total_unknown_blocks * 100.0) / (cycle_count * 3));

      $fwrite(file_pointer, "\n=== CDB CONTENTION HISTOGRAM ===\n");
      $fwrite(file_pointer, "CDB0 (Operand A): %0d cycles\n", p0_rs_a_waiting_cdb0 + p1_rs_a_waiting_cdb0 + p2_rs_a_waiting_cdb0);
      $fwrite(file_pointer, "CDB0 (Operand B): %0d cycles\n", p0_rs_b_waiting_cdb0 + p1_rs_b_waiting_cdb0 + p2_rs_b_waiting_cdb0);
      $fwrite(file_pointer, "CDB1 (Operand A): %0d cycles\n", p0_rs_a_waiting_cdb1 + p1_rs_a_waiting_cdb1 + p2_rs_a_waiting_cdb1);
      $fwrite(file_pointer, "CDB1 (Operand B): %0d cycles\n", p0_rs_b_waiting_cdb1 + p1_rs_b_waiting_cdb1 + p2_rs_b_waiting_cdb1);
      $fwrite(file_pointer, "CDB2 (Operand A): %0d cycles\n", p0_rs_a_waiting_cdb2 + p1_rs_a_waiting_cdb2 + p2_rs_a_waiting_cdb2);
      $fwrite(file_pointer, "CDB2 (Operand B): %0d cycles\n", p0_rs_b_waiting_cdb2 + p1_rs_b_waiting_cdb2 + p2_rs_b_waiting_cdb2);
      $fwrite(file_pointer, "CDB3 (Operand A): %0d cycles\n", p0_rs_a_waiting_cdb3 + p1_rs_a_waiting_cdb3 + p2_rs_a_waiting_cdb3);
      $fwrite(file_pointer, "CDB3 (Operand B): %0d cycles\n", p0_rs_b_waiting_cdb3 + p1_rs_b_waiting_cdb3 + p2_rs_b_waiting_cdb3);

      $fclose(file_pointer);
   end

endmodule
