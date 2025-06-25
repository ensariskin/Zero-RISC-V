`timescale 1ns/1ns

module rv32i_decoder #(parameter size = 32)(
    input  logic [size-1 : 0] instruction,
    input  logic buble,                      // bubble signal
	output logic [25:0] control_word,        // TODO : put branch_sel into contro
    output logic [2:0] branch_sel            // branch selection
    );

    logic r_type;
    logic i_type;
    logic s_type;
    logic b_type;
    logic u_type;
    logic j_type;
    logic [2:0] func3;
    //logic [2:0] inst_type; // 0 : Invalid, 1 : R-type, 2 : I-type, 3 : S-type, 4 : B-type, 5 : U-type, 6 : J-type
    //assign inst_type = r_type ? 3'b001 : i_type ? 3'b010 : s_type ? 3'b011 : b_type ? 3'b100 : u_type ? 3'b101 : j_type ? 3'b110 : 3'b000;

    logic load;                          // load instruction
    logic jalr;                          // JALR instruction
    logic save_pc;                       // save PC value for JAL, JALR or AUIPC

    logic use_immediate;                 // use immediate value in ALU operation
    logic we;                            // write enable for register file

    logic [3:0] function_select;         // function select for ALU operation
    //logic [2:0] branch_sel;              // branch selection
    logic [2:0] mem_width_sel;           // load and store width selection

    logic [$clog2(size)-1 : 0] a_select; // operand A address selection
    logic [$clog2(size)-1 : 0] b_select; // operand B address selection
    logic [$clog2(size)-1 : 0] d_addr;   // destination address selection

    assign func3 = instruction[14:12];

    assign use_immediate = i_type | s_type | u_type | j_type;
    assign we            = r_type | i_type | u_type | j_type;  // write enable for register file

    assign d_addr        = we ? instruction[11:7] : 'h0;       // destination register address
    assign a_select      = (u_type & j_type)? 'h0 : instruction[19:15];   // operand A address selection
    assign b_select      = instruction[24:20];                            // operand B address selection
    assign mem_width_sel = s_type & load ? func3[14:12] : 'h0;      // memory width selection for load/store instructions

    always_comb
    begin
        case(instruction[6:0])

            7'b0110011:                          // R-type
            begin
                r_type = 1'b1;
                i_type = 1'b0;
                s_type = 1'b0;
                b_type = 1'b0;
                u_type = 1'b0;
                j_type = 1'b0;

                load    = 1'b0;
                jalr    = 1'b0;
                save_pc = 1'b0;
            end

            7'b0010011:             // I-type 1
            begin
                r_type = 1'b0;
                i_type = 1'b1;
                s_type = 1'b0;
                b_type = 1'b0;
                u_type = 1'b0;
                j_type = 1'b0;

                load = 1'b0;
                jalr = 1'b0;
                save_pc = 1'b0;
            end
            7'b0000011:              // I-type 2 (Load)
            begin
                r_type = 1'b0;
                i_type = 1'b1;
                s_type = 1'b0;
                b_type = 1'b0;
                u_type = 1'b0;
                j_type = 1'b0;

                load = 1'b1;
                jalr = 1'b0;
                save_pc = 1'b0;
            end
            7'b1100111:             // I-type 3 (JALR)
            begin
                r_type = 1'b0;
                i_type = 1'b1;
                s_type = 1'b0;
                b_type = 1'b0;
                u_type = 1'b0;
                j_type = 1'b0;

                load = 1'b0;
                jalr = 1'b1;
                save_pc = 1'b1;
            end
            7'b0100011: // S-type
            begin
                r_type = 1'b0;
                i_type = 1'b0;
                s_type = 1'b1;
                b_type = 1'b0;
                u_type = 1'b0;
                j_type = 1'b0;

                load = 1'b0;
                jalr = 1'b0;
                save_pc = 1'b0;
            end
            7'b1100011: // B-type
            begin
                r_type = 1'b0;
                i_type = 1'b0;
                s_type = 1'b0;
                b_type = 1'b1;
                u_type = 1'b0;
                j_type = 1'b0;

                load = 1'b0;
                jalr = 1'b0;
                save_pc = 1'b0;
            end
            7'b0110111:         // U-type
            begin
                r_type = 1'b0;
                i_type = 1'b0;
                s_type = 1'b0;
                b_type = 1'b0;
                u_type = 1'b1;
                j_type = 1'b0;

                load = 1'b0;
                jalr = 1'b0;
                save_pc = 1'b0;
            end
            7'b0010111:        // U-type (AUIPC)
            begin
                r_type = 1'b0;
                i_type = 1'b0;
                s_type = 1'b0;
                b_type = 1'b0;
                u_type = 1'b1;
                j_type = 1'b0;

                load = 1'b0;
                jalr = 1'b0;
                save_pc = 1'b1;
            end
            7'b1101111: // J-type
            begin
                r_type = 1'b0;
                i_type = 1'b0;
                s_type = 1'b0;
                b_type = 1'b0;
                u_type = 1'b0;
                j_type = 1'b1;

                load = 1'b0;
                jalr = 1'b0;
                save_pc = 1'b1;
            end
            default:
            begin // Invalid instruction
                r_type = 1'b0;
                i_type = 1'b0;
                s_type = 1'b0;
                b_type = 1'b0;
                u_type = 1'b0;
                j_type = 1'b0;

                load = 1'b0;
                jalr = 1'b0;
            end
        endcase
    end

    always_comb
    begin
        if(jalr)
            branch_sel = 3'b111;
        else if(j_type)
            branch_sel = 3'b110;
        else if(b_type)
            case(func3)
                3'b000: branch_sel = 3'b010; // BEQ
                3'b001: branch_sel = 3'b011; // BNE
                3'b100: branch_sel = 3'b100; // BLT
                3'b101: branch_sel = 3'b101; // BGE
                3'b110: branch_sel = 3'b100; // BLTU
                3'b111: branch_sel = 3'b101; // BGEU
                default: branch_sel = 3'b000; // no branch
            endcase
        else
            branch_sel = 3'b000; // No branching for other types
    end

    always_comb
    begin
        if(r_type | i_type)
        begin
            if(load | jalr)
                function_select = 4'd0;
            else
            begin
                case(func3)
                    3'b000: function_select =  instruction[30] ? 4'b0001 : 4'b0000; // ADD/SUB
                    3'b100: function_select = 4'b0100; // XOR
                    3'b110: function_select = 4'b0101; // OR
                    3'b111: function_select = 4'b0110; // AND

                    3'b001: function_select = 4'b1000; // SLL
                    3'b101: function_select =  instruction[30] ? 4'b1001 : 4'b1010; // SRL/SRA

                    3'b010: function_select = 4'b0010; // SLT
                    3'b011: function_select = 4'b0011; // SLTU
                endcase
            end
        end
        else if(s_type)
            function_select = 4'd0;          // S-type: add operation
        else if(b_type)
        begin
            if(func3[2:1] == 2'b11)
                function_select = 4'b0011;
            else
                function_select = 4'b0001;
        end
        else if(u_type)
            function_select = 4'b0000;
        else if(j_type)
            function_select = 4'b0000; // J-type: no ALU operation
        else
            function_select = 4'b0000; // Invalid instruction
    end

    assign control_word = buble ? 26'd0 : {
        d_addr,          // 25:21
        b_select,        // 20:16
        a_select,        // 15:11
        function_select, // 10:7
        we,              // 6
        save_pc,         // 5
        load,            // 4
        use_immediate,   // 3,
        mem_width_sel    // 2:0
        } ;

endmodule
