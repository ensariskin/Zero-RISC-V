// triple_priority_encoder_pp_nofunc.sv
// Parallel-prefix one-hot triple encoder (Design C) without functions.
// Single module, file name == module name. WIDTH fixed to 64 for compactness.

module triple_priority_encoder_ver3 #(
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
    logic [63:0] in0, in1, in2;
    assign in0 = data_in[63:0];

    // ---------- Stage 1: prefix lower OR and isolate first one-hot ----------
    logic [63:0] lower0_s1, lower0_s2, lower0_s3, lower0_s4, lower0_s5, lower0_s6;
    logic [63:0] lower0;
    logic [63:0] one0;
    logic        v0;
    // build prefix OR by doubling shifts
    assign lower0_s1 = in0 << 1;
    assign lower0_s2 = lower0_s1 | (lower0_s1 << 1);
    assign lower0_s3 = lower0_s2 | (lower0_s2 << 2);
    assign lower0_s4 = lower0_s3 | (lower0_s3 << 4);
    assign lower0_s5 = lower0_s4 | (lower0_s4 << 8);
    assign lower0_s6 = lower0_s5 | (lower0_s5 << 16);
    assign lower0    = lower0_s6 | (lower0_s6 << 32);
    assign one0      = in0 & ~lower0;
    assign v0        = |in0;

    // onehot -> index (hierarchical)
    logic [31:0] h32_0; logic b32_0;
    logic [15:0] h16_0; logic b16_0;
    logic  [7:0] h8_0;  logic b8_0;
    logic  [3:0] h4_0;  logic b4_0;
    logic  [1:0] h2_0;  logic b2_0;
    logic        b1_0;
    logic  [5:0] base_0;
    logic  [5:0] idx0_w;
    assign b32_0 = |one0[31:0];
    assign h32_0 = b32_0 ? one0[31:0] : one0[63:32];
    assign b16_0 = |h32_0[15:0];
    assign h16_0 = b16_0 ? h32_0[15:0] : h32_0[31:16];
    assign b8_0  = |h16_0[7:0];
    assign h8_0  = b8_0  ? h16_0[7:0]  : h16_0[15:8];
    assign b4_0  = |h8_0[3:0];
    assign h4_0  = b4_0  ? h8_0[3:0]   : h8_0[7:4];
    assign b2_0  = |h4_0[1:0];
    assign h2_0  = b2_0  ? h4_0[1:0]   : h4_0[3:2];
    assign b1_0  = |h2_0[0];
    assign base_0 = { (b32_0?1'b0:1'b1), (b16_0?1'b0:1'b1), (b8_0?1'b0:1'b1), (b4_0?1'b0:1'b1), (b2_0?1'b0:1'b1), 1'b0 };
    assign idx0_w = base_0 + {5'd0, ~b1_0};

    assign first_valid = first_enable ? v0 : 1'b0;
    assign first_index = first_valid ? idx0_w : '0;

    // ---------- Stage 2 input ----------
    assign in1 = in0 & ~one0;

    // ---------- Stage 2 ----------
    logic [63:0] lower1_s1, lower1_s2, lower1_s3, lower1_s4, lower1_s5, lower1_s6;
    logic [63:0] lower1;
    logic [63:0] one1;
    logic        v1;
    assign lower1_s1 = in1 << 1;
    assign lower1_s2 = lower1_s1 | (lower1_s1 << 1);
    assign lower1_s3 = lower1_s2 | (lower1_s2 << 2);
    assign lower1_s4 = lower1_s3 | (lower1_s3 << 4);
    assign lower1_s5 = lower1_s4 | (lower1_s4 << 8);
    assign lower1_s6 = lower1_s5 | (lower1_s5 << 16);
    assign lower1    = lower1_s6 | (lower1_s6 << 32);
    assign one1      = in1 & ~lower1;
    assign v1        = |in1;

    // onehot -> index 2
    logic [31:0] h32_1; logic b32_1;
    logic [15:0] h16_1; logic b16_1;
    logic  [7:0] h8_1;  logic b8_1;
    logic  [3:0] h4_1;  logic b4_1;
    logic  [1:0] h2_1;  logic b2_1;
    logic        b1_1;
    logic  [5:0] base_1;
    logic  [5:0] idx1_w;
    assign b32_1 = |one1[31:0];
    assign h32_1 = b32_1 ? one1[31:0] : one1[63:32];
    assign b16_1 = |h32_1[15:0];
    assign h16_1 = b16_1 ? h32_1[15:0] : h32_1[31:16];
    assign b8_1  = |h16_1[7:0];
    assign h8_1  = b8_1  ? h16_1[7:0]  : h16_1[15:8];
    assign b4_1  = |h8_1[3:0];
    assign h4_1  = b4_1  ? h8_1[3:0]   : h8_1[7:4];
    assign b2_1  = |h4_1[1:0];
    assign h2_1  = b2_1  ? h4_1[1:0]   : h4_1[3:2];
    assign b1_1  = |h2_1[0];
    assign base_1 = { (b32_1?1'b0:1'b1), (b16_1?1'b0:1'b1), (b8_1?1'b0:1'b1), (b4_1?1'b0:1'b1), (b2_1?1'b0:1'b1), 1'b0 };
    assign idx1_w = base_1 + {5'd0, ~b1_1};

    assign second_valid = second_enable ? v1 : 1'b0;
    assign second_index = second_valid ? idx1_w : '0;

    // ---------- Stage 3 input ----------
    assign in2 = in1 & ~one1;

    // ---------- Stage 3 ----------
    logic [63:0] lower2_s1, lower2_s2, lower2_s3, lower2_s4, lower2_s5, lower2_s6;
    logic [63:0] lower2;
    logic [63:0] one2;
    logic        v2;
    assign lower2_s1 = in2 << 1;
    assign lower2_s2 = lower2_s1 | (lower2_s1 << 1);
    assign lower2_s3 = lower2_s2 | (lower2_s2 << 2);
    assign lower2_s4 = lower2_s3 | (lower2_s3 << 4);
    assign lower2_s5 = lower2_s4 | (lower2_s4 << 8);
    assign lower2_s6 = lower2_s5 | (lower2_s5 << 16);
    assign lower2    = lower2_s6 | (lower2_s6 << 32);
    assign one2      = in2 & ~lower2;
    assign v2        = |in2;

    // onehot -> index 3
    logic [31:0] h32_2; logic b32_2;
    logic [15:0] h16_2; logic b16_2;
    logic  [7:0] h8_2;  logic b8_2;
    logic  [3:0] h4_2;  logic b4_2;
    logic  [1:0] h2_2;  logic b2_2;
    logic        b1_2;
    logic  [5:0] base_2;
    logic  [5:0] idx2_w;
    assign b32_2 = |one2[31:0];
    assign h32_2 = b32_2 ? one2[31:0] : one2[63:32];
    assign b16_2 = |h32_2[15:0];
    assign h16_2 = b16_2 ? h32_2[15:0] : h32_2[31:16];
    assign b8_2  = |h16_2[7:0];
    assign h8_2  = b8_2  ? h16_2[7:0]  : h16_2[15:8];
    assign b4_2  = |h8_2[3:0];
    assign h4_2  = b4_2  ? h8_2[3:0]   : h8_2[7:4];
    assign b2_2  = |h4_2[1:0];
    assign h2_2  = b2_2  ? h4_2[1:0]   : h4_2[3:2];
    assign b1_2  = |h2_2[0];
    assign base_2 = { (b32_2?1'b0:1'b1), (b16_2?1'b0:1'b1), (b8_2?1'b0:1'b1), (b4_2?1'b0:1'b1), (b2_2?1'b0:1'b1), 1'b0 };
    assign idx2_w = base_2 + {5'd0, ~b1_2};

    assign third_valid = third_enable ? v2 : 1'b0;
    assign third_index = third_valid ? idx2_w : '0;

endmodule
