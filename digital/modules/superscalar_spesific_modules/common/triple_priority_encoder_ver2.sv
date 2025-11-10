// triple_priority_encoder_hier_nofunc.sv
// Hierarchical LSB-priority triple encoder (Design B) without functions.
// Single module, file name == module name. WIDTH fixed to 64 for compactness.

module triple_priority_encoder_ver2 #(
    parameter int WIDTH = 64,
    parameter int INDEX_WIDTH = 6
)(
    input  logic [WIDTH-1:0] data_in,
    input  logic             first_enable,
    input  logic             second_enable,
    input  logic             third_enable,
    output logic [INDEX_WIDTH-1:0] first_index,
    output logic [INDEX_WIDTH-1:0] second_index,
    output logic [INDEX_WIDTH-1:0] third_index,
    output logic             first_valid,
    output logic             second_valid,
    output logic             third_valid
);
    // Restrict to 64 for this no-function compact implementation
    logic [63:0] din64;
    assign din64 = data_in[63:0];

    // ---------- Stage 1 (hierarchical 64->idx) ----------
    // Build hierarchical selection for LSB-nearest '1'
    wire b32_0 = |din64[31:0];
    wire [63:0] s32_0 = b32_0 ? {32'b0, din64[31:0]} : {32'b0, din64[63:32]};
    wire [5:0]  base32_0 = b32_0 ? 6'd0 : 6'd32;

    wire b16_0 = |s32_0[15:0];
    wire [31:0] s16_0 = b16_0 ? s32_0[15:0] : s32_0[31:16];
    wire [5:0]  base16_0 = base32_0 + (b16_0 ? 6'd0 : 6'd16);

    wire b8_0 = |s16_0[7:0];
    wire [15:0] s8_0 = b8_0 ? s16_0[7:0] : s16_0[15:8];
    wire [5:0]  base8_0 = base16_0 + (b8_0 ? 6'd0 : 6'd8);

    wire b4_0 = |s8_0[3:0];
    wire [7:0] s4_0 = b4_0 ? s8_0[3:0] : s8_0[7:4];
    wire [5:0] base4_0 = base8_0 + (b4_0 ? 6'd0 : 6'd4);

    wire b2_0 = |s4_0[1:0];
    wire [3:0] s2_0 = b2_0 ? s4_0[1:0] : s4_0[3:2];
    wire [5:0] base2_0 = base4_0 + (b2_0 ? 6'd0 : 6'd2);

    wire b1_0 = |s2_0[0];
    wire add1_0 = ~b1_0; // if upper of the pair
    wire [5:0] idx0_w = base2_0 + {5'd0, add1_0};
    wire       v0_w   = |din64;

    // Apply enable
    assign first_valid = first_enable ? v0_w : 1'b0;
    assign first_index = first_valid ? idx0_w : '0;

    // Mask one-hot for first index via 6->64 decoder
    wire [63:0] mask0 = first_valid ? (64'h1 << first_index) : 64'h0;
    wire [63:0] rem1  = din64 & ~mask0;

    // ---------- Stage 2 ----------
    wire b32_1 = |rem1[31:0];
    wire [63:0] s32_1 = b32_1 ? {32'b0, rem1[31:0]} : {32'b0, rem1[63:32]};
    wire [5:0]  base32_1 = b32_1 ? 6'd0 : 6'd32;

    wire b16_1 = |s32_1[15:0];
    wire [31:0] s16_1 = b16_1 ? s32_1[15:0] : s32_1[31:16];
    wire [5:0]  base16_1 = base32_1 + (b16_1 ? 6'd0 : 6'd16);

    wire b8_1 = |s16_1[7:0];
    wire [15:0] s8_1 = b8_1 ? s16_1[7:0] : s16_1[15:8];
    wire [5:0]  base8_1 = base16_1 + (b8_1 ? 6'd0 : 6'd8);

    wire b4_1 = |s8_1[3:0];
    wire [7:0] s4_1 = b4_1 ? s8_1[3:0] : s8_1[7:4];
    wire [5:0] base4_1 = base8_1 + (b4_1 ? 6'd0 : 6'd4);

    wire b2_1 = |s4_1[1:0];
    wire [3:0] s2_1 = b2_1 ? s4_1[1:0] : s4_1[3:2];
    wire [5:0] base2_1 = base4_1 + (b2_1 ? 6'd0 : 6'd2);

    wire b1_1 = |s2_1[0];
    wire add1_1 = ~b1_1;
    wire [5:0] idx1_w = base2_1 + {5'd0, add1_1};
    wire       v1_w   = |rem1;

    assign second_valid = second_enable ? v1_w : 1'b0;
    assign second_index = second_valid ? idx1_w : '0;

    // Mask again
    wire [63:0] mask1 = second_valid ? (64'h1 << second_index) : 64'h0;
    wire [63:0] rem2  = rem1 & ~mask1;

    // ---------- Stage 3 ----------
    wire b32_2 = |rem2[31:0];
    wire [63:0] s32_2 = b32_2 ? {32'b0, rem2[31:0]} : {32'b0, rem2[63:32]};
    wire [5:0]  base32_2 = b32_2 ? 6'd0 : 6'd32;

    wire b16_2 = |s32_2[15:0];
    wire [31:0] s16_2 = b16_2 ? s32_2[15:0] : s32_2[31:16];
    wire [5:0]  base16_2 = base32_2 + (b16_2 ? 6'd0 : 6'd16);

    wire b8_2 = |s16_2[7:0];
    wire [15:0] s8_2 = b8_2 ? s16_2[7:0] : s16_2[15:8];
    wire [5:0]  base8_2 = base16_2 + (b8_2 ? 6'd0 : 6'd8);

    wire b4_2 = |s8_2[3:0];
    wire [7:0] s4_2 = b4_2 ? s8_2[3:0] : s8_2[7:4];
    wire [5:0] base4_2 = base8_2 + (b4_2 ? 6'd0 : 6'd4);

    wire b2_2 = |s4_2[1:0];
    wire [3:0] s2_2 = b2_2 ? s4_2[1:0] : s4_2[3:2];
    wire [5:0] base2_2 = base4_2 + (b2_2 ? 6'd0 : 6'd2);

    wire b1_2 = |s2_2[0];
    wire add1_2 = ~b1_2;
    wire [5:0] idx2_w = base2_2 + {5'd0, add1_2};
    wire       v2_w   = |rem2;

    assign third_valid = third_enable ? v2_w : 1'b0;
    assign third_index = third_valid ? idx2_w : '0;

endmodule
