`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: tmr_voter
//
// Description:
//     Generic Triple Modular Redundancy (TMR) Voter logic.
//     Takes 3 inputs and produces a single "majority voted" output.
//     Can also flag which inputs are in disagreement for healing purposes.
//
// Behavior:
//     - Secure Mode = 1:
//       - Checks equality (A==B), (B==C), (A==C).
//       - If 2 or 3 match, outputs the matching value.
//       - If all disagree, outputs Input A (primary) and flags a fatal mismatch.
//     - Secure Mode = 0:
//       - Bypass mode. Output = Input A.
//
//////////////////////////////////////////////////////////////////////////////////

module tmr_voter #(
      parameter DATA_WIDTH = 32
   )(
      input  logic secure_mode_i,
      input  logic [DATA_WIDTH-1:0] data_0_i,
      input  logic [DATA_WIDTH-1:0] data_1_i,
      input  logic [DATA_WIDTH-1:0] data_2_i,

      output logic [DATA_WIDTH-1:0] data_o,
      output logic mismatch_detected_o, // Indicates disagreement (even if correctable)
      output logic error_0_o,           // Data 0 is the minority/wrong one
      output logic error_1_o,           // Data 1 is the minority/wrong one
      output logic error_2_o,           // Data 2 is the minority/wrong one
      output logic fatal_error_o        // All 3 mismatch
   );

   // Equality Checks
   logic match_0_1;
   logic match_1_2;
   logic match_0_2;

   assign match_0_1 = (data_0_i == data_1_i);
   assign match_1_2 = (data_1_i == data_2_i);
   assign match_0_2 = (data_0_i == data_2_i);

   always_comb begin
      if (!secure_mode_i) begin
         // Non-secure mode: Bypass (Use Data 0)
         data_o = data_0_i;
         mismatch_detected_o = 1'b0;
         error_0_o = 1'b0;
         error_1_o = 1'b0;
         error_2_o = 1'b0;
         fatal_error_o = 1'b0;
      end else begin
         // Secure mode: Majority Vote logic
         mismatch_detected_o = 1'b0;
         error_0_o = 1'b0;
         error_1_o = 1'b0;
         error_2_o = 1'b0;
         fatal_error_o = 1'b0;

         if (match_0_1) begin
            // Case: 0 == 1 (Could be 0==1==2 or 0==1!=2)
            data_o = data_0_i;
            if (!match_1_2) begin // 0==1 != 2
               mismatch_detected_o = 1'b1;
               error_2_o = 1'b1;
            end
         end else if (match_0_2) begin
            // Case: 0 == 2 (and 0!=1 implies 2!=1)
            data_o = data_0_i;
            mismatch_detected_o = 1'b1;
            error_1_o = 1'b1;
         end else if (match_1_2) begin
            // Case: 1 == 2 (and 0!=1, 0!=2)
            data_o = data_1_i;
            mismatch_detected_o = 1'b1;
            error_0_o = 1'b1;
         end else begin
            // Case: All different (0!=1, 1!=2, 0!=2)
            // Fallback to Data 0, but signal fatal error
            data_o = data_0_i;
            mismatch_detected_o = 1'b1;
            fatal_error_o = 1'b1;
            error_0_o = 1'b1; // Logic debatable, but all marked as suspicious
            error_1_o = 1'b1;
            error_2_o = 1'b1;
         end
      end
   end

endmodule
