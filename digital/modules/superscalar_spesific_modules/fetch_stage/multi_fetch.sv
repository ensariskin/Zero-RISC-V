`timescale 1ns/1ns

module multi_fetch #(parameter size = 32)(
      input  logic clk,
      input  logic reset,

      output logic [size-1 : 0] inst_addr_0,
      input  logic [size-1 : 0] instruction_i_0,

      output logic [size-1 : 0] inst_addr_1,
      input  logic [size-1 : 0] instruction_i_1,

      output logic [size-1 : 0] inst_addr_2,
      input  logic [size-1 : 0] instruction_i_2,

      output logic [size-1 : 0] inst_addr_3,
      input  logic [size-1 : 0] instruction_i_3,

      output logic [size-1 : 0] inst_addr_4,
      input  logic [size-1 : 0] instruction_i_4,

      // Pipeline control signals
      input  logic flush,
      input  logic [size-1 : 0] correct_pc,
      input logic               jalr_prediction_valid_0,
	   input logic [size-1 : 0]  jalr_update_prediction_pc_0,
      input  logic buble,

      // TODO : We will need branch prediction signals here
      input  logic update_prediction_valid_i_0,
      input  logic [size-1 : 0] update_prediction_pc_0,
      input  logic misprediction_0,
      input  logic [size-1 : 0] correct_pc_0,

      input  logic update_prediction_valid_i_1,
      input  logic [size-1 : 0] update_prediction_pc_1,
      input  logic misprediction_1,
      input  logic [size-1 : 0] correct_pc_1,

      input  logic update_prediction_valid_i_2,
      input  logic [size-1 : 0] update_prediction_pc_2,
      input  logic misprediction_2,
      input logic [size-1 : 0] correct_pc_2,

      

      // New interface for instruction buffer integration
      output logic [4:0] fetch_valid_o,        // Which of the 3 instructions are valid
      input  logic fetch_ready_i,              // Instruction buffer can accept instructions
      output logic [size-1 : 0] pc_o_0, pc_o_1, pc_o_2, pc_o_3, pc_o_4,  // PC values for each instruction
      
      // Legacy pipeline outputs (will be removed when buffer is integrated)
      output logic [size-1 : 0] instruction_o_0,
      output logic [size-1 : 0] imm_o_0,
      output logic [size-1 : 0] pc_value_at_prediction_0, // PC value used for prediction
      output logic branch_prediction_o_0,

      output logic [size-1 : 0] instruction_o_1,
      output logic [size-1 : 0] imm_o_1,
      output logic [size-1 : 0] pc_value_at_prediction_1, // PC value used for prediction
      output logic branch_prediction_o_1,

      output logic [size-1 : 0] instruction_o_2,
      output logic [size-1 : 0] imm_o_2,
      output logic [size-1 : 0] pc_value_at_prediction_2, // PC value used for prediction
      output logic branch_prediction_o_2,

      output logic [size-1 : 0] instruction_o_3,
      output logic [size-1 : 0] imm_o_3,
      output logic [size-1 : 0] pc_value_at_prediction_3, // PC value used for prediction
      output logic branch_prediction_o_3,

      output logic [size-1 : 0] instruction_o_4,
      output logic [size-1 : 0] imm_o_4,
      output logic [size-1 : 0] pc_value_at_prediction_4, // PC value used for prediction
      output logic branch_prediction_o_4

   );

   //localparam D = 1; // Delay for simulation purposes

   // Add parallel_mode control signal for pc_ctrl_super
   logic parallel_mode;
   assign parallel_mode = 1'b1; // Always enable 3-instruction parallel mode

   // Add misprediction logic (combine all three mispredictions)
   logic misprediction_combined;
   assign misprediction_combined = flush; //misprediction_0 | misprediction_1 | misprediction_2;

   // For now inst addr 1 is inst addr 0 + 4
   // inst addr 2 is inst addr 1 + 4

   // Internal signals
   logic [size-1 : 0] current_pc_0;
   logic jump_0;
   logic [size-1 : 0] imm_0;
   logic jalr_0;

   logic [size-1 : 0] current_pc_1;
   logic jump_1;
   logic [size-1 : 0] imm_1;
   logic jalr_1;

   logic [size-1 : 0] current_pc_2;
   logic jump_2;
   logic [size-1 : 0] imm_2;
   logic jalr_2;

   logic [size-1 : 0] current_pc_3;
   logic jump_3;
   logic [size-1 : 0] imm_3;
   logic jalr_3;

   logic [size-1 : 0] current_pc_4;
   logic jump_4;
   logic [size-1 : 0] imm_4;
   logic jalr_4;

   logic jalr_prediction_valid;
   logic [size-1:0] jalr_predicition_target;
   
   // New buffer interface signals
   logic internal_bubble; // Combine bubble with buffer backpressure
   

   // Smart fetch valid signals based on branch prediction
   // If a branch is predicted taken, don't fetch instructions after it
   logic base_valid;
   logic block_0;  // Invalidate inst_1 and inst_2 if inst_0 branches
   logic block_1;    // Invalidate inst_2 if inst_1 branches
   logic block_2;    
   logic block_3;  
   
   // Base validity: instruction is valid if not flushed, buffer ready, and in reset
   assign base_valid = ~flush & fetch_ready_i & reset;
   
   // Branch prediction invalidation logic
   assign block_0 = jump_0 | jalr_0;  // If inst_0 is predicted taken, invalidate inst_1 and inst_2
   assign block_1 = jump_1 | jalr_1;    // If inst_1 is predicted taken, invalidate inst_2
   assign block_2 = jump_2 | jalr_2;
   assign block_3 = jump_3 | jalr_3;

   // Final fetch valid signals
   assign fetch_valid_o[0] = base_valid;                                    // inst_0 always valid (if base conditions met)
   assign fetch_valid_o[1] = base_valid & ~block_0;                 // inst_1 invalid if inst_0 branches
   assign fetch_valid_o[2] = base_valid & ~block_0 & ~block_1; // inst_2 invalid if inst_0 or inst_1 branches
   assign fetch_valid_o[3] = base_valid & ~block_0 & ~block_1 & ~block_2; // inst_3 invalid if inst_0, inst_1, or inst_2 branches
   assign fetch_valid_o[4] = base_valid & ~block_0 & ~block_1 & ~block_2 & ~block_3; // inst_4 invalid if any prior instruction branches
   
   // Combine pipeline bubble with buffer backpressure
   assign internal_bubble = buble | ~fetch_ready_i;
   // Immediate decoders
   early_stage_immediate_decoder  early_stage_imm_dec_0(
      .instruction(instruction_i_0),
      .imm_o(imm_0));

   early_stage_immediate_decoder  early_stage_imm_dec_1(
      .instruction(instruction_i_1),
      .imm_o(imm_1));

   early_stage_immediate_decoder  early_stage_imm_dec_2(
      .instruction(instruction_i_2),
      .imm_o(imm_2));
   
   early_stage_immediate_decoder  early_stage_imm_dec_3(
      .instruction(instruction_i_3),
      .imm_o(imm_3));

   early_stage_immediate_decoder  early_stage_imm_dec_4(
      .instruction(instruction_i_4),
      .imm_o(imm_4));

   // Jump controller
   jump_controller_super jump_ctrl(
      .clk(clk),
      .reset(reset),

      .current_pc_0(current_pc_0),
      .current_pc_1(current_pc_1),
      .current_pc_2(current_pc_2),
      .current_pc_3(current_pc_3),
      .current_pc_4(current_pc_4),

      .instruction_0(instruction_i_0),
      .instruction_1(instruction_i_1),
      .instruction_2(instruction_i_2),
      .instruction_3(instruction_i_3),
      .instruction_4(instruction_i_4),

      .update_prediction_pc_0(update_prediction_pc_0),
      .update_prediction_pc_1(update_prediction_pc_1),
      .update_prediction_pc_2(update_prediction_pc_2),

      .update_prediction_valid_i_0(update_prediction_valid_i_0),
      .update_prediction_valid_i_1(update_prediction_valid_i_1),
      .update_prediction_valid_i_2(update_prediction_valid_i_2),

      .misprediction_0(misprediction_0),
      .misprediction_1(misprediction_1),
      .misprediction_2(misprediction_2),

      .correct_pc_0(correct_pc_0),
      .correct_pc_1(correct_pc_1),
      .correct_pc_2(correct_pc_2),

      .jalr_correct_pc_0(correct_pc),
      .jalr_misprediction_0(flush),
      .jalr_prediction_valid_0(jalr_prediction_valid_0),
      .jalr_update_prediction_pc_0(jalr_update_prediction_pc_0),

      .jump_0(jump_0),
      .jump_1(jump_1),
      .jump_2(jump_2),
      .jump_3(jump_3),
      .jump_4(jump_4),

      .jalr_0(jalr_0),
      .jalr_1(jalr_1),
      .jalr_2(jalr_2),
      .jalr_3(jalr_3),
      .jalr_4(jalr_4),

      .jalr_prediction_valid(jalr_prediction_valid),
      .jalr_prediction_target(jalr_predicition_target)

   );

   // PC Control Super Module
   pc_ctrl_super #(.size(size)) PC_super (
      .clk(clk),
      .reset(reset),
      .buble(internal_bubble),  // Use combined bubble signal
      .parallel_mode(parallel_mode),

      .jump_0(jump_0),
      .jump_1(jump_1),
      .jump_2(jump_2),
      .jump_3(jump_3),
      .jump_4(jump_4),

      .jalr_0(jalr_0),
      .jalr_1(jalr_1),
      .jalr_2(jalr_2),
      .jalr_3(jalr_3),
      .jalr_4(jalr_4),

      .jalr_prediction_valid(jalr_prediction_valid),
      .jalr_prediction_target(jalr_predicition_target),

      .imm_i_0(imm_0),
      .imm_i_1(imm_1),
      .imm_i_2(imm_2),
      .imm_i_3(imm_3),
      .imm_i_4(imm_4),

      .misprediction(misprediction_combined),
      .correct_pc(correct_pc),

      .inst_addr_0(inst_addr_0),
      .inst_addr_1(inst_addr_1),
      .inst_addr_2(inst_addr_2),
      .inst_addr_3(inst_addr_3),
      .inst_addr_4(inst_addr_4),

      .current_pc_0(current_pc_0),
      .current_pc_1(current_pc_1),
      .current_pc_2(current_pc_2),
      .current_pc_3(current_pc_3),
      .current_pc_4(current_pc_4),

      .pc_save_0(pc_o_0),
      .pc_save_1(pc_o_1),
      .pc_save_2(pc_o_2),
      .pc_save_3(pc_o_3),
      .pc_save_4(pc_o_4)
   );

   assign instruction_o_0 =  instruction_i_0;
   assign instruction_o_1 =  instruction_i_1;
   assign instruction_o_2 =  instruction_i_2;
   assign instruction_o_3 =  instruction_i_3;
   assign instruction_o_4 =  instruction_i_4;

   assign imm_o_0 = imm_0;
   assign imm_o_1 = imm_1;
   assign imm_o_2 = imm_2;
   assign imm_o_3 = imm_3;
   assign imm_o_4 = imm_4;

   assign pc_value_at_prediction_0 = jalr_0 & jalr_prediction_valid ? jalr_predicition_target : current_pc_0;
   assign pc_value_at_prediction_1 = jalr_1 & jalr_prediction_valid ? jalr_predicition_target : current_pc_1;
   assign pc_value_at_prediction_2 = jalr_2 & jalr_prediction_valid ? jalr_predicition_target : current_pc_2;
   assign pc_value_at_prediction_3 = jalr_3 & jalr_prediction_valid ? jalr_predicition_target : current_pc_3;
   assign pc_value_at_prediction_4 = jalr_4 & jalr_prediction_valid ? jalr_predicition_target : current_pc_4;

   assign branch_prediction_o_0 = jump_0 | jalr_0;
   assign branch_prediction_o_1 = jump_1 | jalr_1;
   assign branch_prediction_o_2 = jump_2 | jalr_2;;
   assign branch_prediction_o_3 = jump_3 | jalr_3;
   assign branch_prediction_o_4 = jump_4 | jalr_4;
   //assign pc_plus_o = pc_save;

endmodule