`timescale 1ns/1ns

////////////////////////////////////////////////////////////
// Simple Fault Injector
// Injects transient faults into selected signals using
// force/release semantics. Target selection policy can be
// random or round-robin. The injection interval and random
// seed can be provided via plusargs.
////////////////////////////////////////////////////////////

module fault_injector #(
    // 0: random, 1: round-robin
    parameter int POLICY = 0
) (
    input  logic clk,
    input  logic rst_n,

    // Optional default values (overridden via plusargs)
    input  int   seed            = 1,
    input  int   fault_interval  = 100,

    // Target signals array (open array of references)
    ref logic [31:0] targets[]
);

    int local_seed;
    int interval;
    int inject_cnt;
    int sel_idx;
    int NUM_TARGETS;
    logic [31:0] rand_val;

    initial begin
        if (!$value$plusargs("fi_seed=%d", local_seed)) begin
            local_seed = seed;
        end
        if (!$value$plusargs("fi_interval=%d", interval)) begin
            interval = fault_interval;
        end
        NUM_TARGETS = targets.size();
        inject_cnt = 0;
        sel_idx = 0;
        rand_val = 0;
        void'(std::randomize() with {`__RANDOMIZE_INIT;});
        $display("Fault injector enabled: seed=%0d interval=%0d targets=%0d", local_seed, interval, NUM_TARGETS);
    end

    // Release all signals on reset
    always @(negedge rst_n) begin
        for (int i = 0; i < NUM_TARGETS; i++) begin
            release targets[i];
        end
        inject_cnt = 0;
    end

    // Main injection loop
    always @(posedge clk) begin
        if (rst_n) begin
            inject_cnt++;
            if (inject_cnt >= interval) begin
                inject_cnt = 0;
                if (POLICY == 0) begin
                    void'(std::randomize(sel_idx) with {sel_idx < NUM_TARGETS;});
                end else begin
                    sel_idx = (sel_idx + 1) % NUM_TARGETS;
                end
                void'(std::randomize(rand_val));
                force targets[sel_idx] = rand_val;
                #1;
                release targets[sel_idx];
            end
        end
    end

endmodule

