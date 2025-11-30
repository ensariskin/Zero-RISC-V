module tracer_3port(
    input clk_i,
    
    // Port 0 signals
    input valid_0,
    input [31:0] pc_0,
    input [31:0] instr_0,
    input [4:0] reg_addr_0,
    input [31:0] reg_data_0,
    input is_load_0, is_store_0, is_float_0,
    input [1:0] mem_size_0,
    input [31:0] mem_addr_0,
    input [31:0] mem_data_0,
    input [31:0] fpu_flags_0,
    
    // Port 1 signals
    input valid_1,
    input [31:0] pc_1,
    input [31:0] instr_1,
    input [4:0] reg_addr_1,
    input [31:0] reg_data_1,
    input is_load_1, is_store_1, is_float_1,
    input [1:0] mem_size_1,
    input [31:0] mem_addr_1,
    input [31:0] mem_data_1,
    input [31:0] fpu_flags_1,
    
    // Port 2 signals
    input valid_2,
    input [31:0] pc_2,
    input [31:0] instr_2,
    input [4:0] reg_addr_2,
    input [31:0] reg_data_2,
    input is_load_2, is_store_2, is_float_2,
    input [1:0] mem_size_2,
    input [31:0] mem_addr_2,
    input [31:0] mem_data_2,
    input [31:0] fpu_flags_2
);

// This module is used to trace the execution of the processor with 3 parallel ports.
// It writes the PC, instruction, register address, register data, memory operations to a file.
// Writing order: port 0 first, then port 1, then port 2.

integer file_pointer;
integer file_pointer2;

initial begin
    file_pointer = $fopen("trace.log", "w");
    forever begin
        @(posedge clk_i);
        
        // Port 0 - write first
        if(valid_0) begin
            $fwrite(file_pointer, "0x%8h (0x%8h)", pc_0, instr_0);
            if (is_store_0) begin
                if(mem_size_0 == 2'b00) begin
                    $fwrite(file_pointer, " mem 0x%8h 0x%2h", mem_addr_0, mem_data_0[7:0]);
                end
                else if(mem_size_0 == 2'b01) begin
                    $fwrite(file_pointer, " mem 0x%8h 0x%4h", mem_addr_0, mem_data_0[15:0]);
                end
                else begin
                    $fwrite(file_pointer, " mem 0x%8h 0x%8h", mem_addr_0, mem_data_0);
                end
            end
            else begin
                if (!is_float_0) begin
                    if (reg_addr_0 != 0) begin
                        if (reg_addr_0 > 9) begin
                            $fwrite(file_pointer, " x%0d 0x%8h", reg_addr_0, reg_data_0);
                        end else begin
                            $fwrite(file_pointer, " x%0d  0x%8h", reg_addr_0, reg_data_0);
                        end
                    end
                    if (is_load_0) 
                        $fwrite(file_pointer, " mem 0x%8h", mem_addr_0);
                end
                else begin
                    if (fpu_flags_0 != 0) $fwrite(file_pointer, " c1_fflags 0x%8h", fpu_flags_0);

                    if (reg_addr_0 > 9) begin
                        $fwrite(file_pointer, " f%0d 0x%8h", reg_addr_0, reg_data_0);
                        if (is_load_0) begin
                            $fwrite(file_pointer, " mem 0x%8h", mem_addr_0);
                        end
                    end else begin
                        $fwrite(file_pointer, " f%0d  0x%8h", reg_addr_0, reg_data_0);
                        if (is_load_0) begin
                            $fwrite(file_pointer, " mem 0x%8h", mem_addr_0);
                        end
                    end
                end
            end
            $fwrite(file_pointer, "\n");
        end
        
        // Port 1 - write second
        if(valid_1) begin
            $fwrite(file_pointer, "0x%8h (0x%8h)", pc_1, instr_1);
            if (is_store_1) begin
                if(mem_size_1 == 2'b00) begin
                    $fwrite(file_pointer, " mem 0x%8h 0x%2h", mem_addr_1, mem_data_1[7:0]);
                end
                else if(mem_size_1 == 2'b01) begin
                    $fwrite(file_pointer, " mem 0x%8h 0x%4h", mem_addr_1, mem_data_1[15:0]);
                end
                else begin
                    $fwrite(file_pointer, " mem 0x%8h 0x%8h", mem_addr_1, mem_data_1);
                end
            end
            else begin
                if (!is_float_1) begin
                    if (reg_addr_1 != 0) begin
                        if (reg_addr_1 > 9) begin
                            $fwrite(file_pointer, " x%0d 0x%8h", reg_addr_1, reg_data_1);
                        end else begin
                            $fwrite(file_pointer, " x%0d  0x%8h", reg_addr_1, reg_data_1);
                        end
                    end
                    if (is_load_1) 
                        $fwrite(file_pointer, " mem 0x%8h", mem_addr_1);
                end
                else begin
                    if (fpu_flags_1 != 0) $fwrite(file_pointer, " c1_fflags 0x%8h", fpu_flags_1);

                    if (reg_addr_1 > 9) begin
                        $fwrite(file_pointer, " f%0d 0x%8h", reg_addr_1, reg_data_1);
                        if (is_load_1) begin
                            $fwrite(file_pointer, " mem 0x%8h", mem_addr_1);
                        end
                    end else begin
                        $fwrite(file_pointer, " f%0d  0x%8h", reg_addr_1, reg_data_1);
                        if (is_load_1) begin
                            $fwrite(file_pointer, " mem 0x%8h", mem_addr_1);
                        end
                    end
                end
            end
            $fwrite(file_pointer, "\n");
        end
        
        // Port 2 - write third
        if(valid_2) begin
            $fwrite(file_pointer, "0x%8h (0x%8h)", pc_2, instr_2);
            if (is_store_2) begin
                if(mem_size_2 == 2'b00) begin
                    $fwrite(file_pointer, " mem 0x%8h 0x%2h", mem_addr_2, mem_data_2[7:0]);
                end
                else if(mem_size_2 == 2'b01) begin
                    $fwrite(file_pointer, " mem 0x%8h 0x%4h", mem_addr_2, mem_data_2[15:0]);
                end
                else begin
                    $fwrite(file_pointer, " mem 0x%8h 0x%8h", mem_addr_2, mem_data_2);
                end
            end
            else begin
                if (!is_float_2) begin
                    if (reg_addr_2 != 0) begin
                        if (reg_addr_2 > 9) begin
                            $fwrite(file_pointer, " x%0d 0x%8h", reg_addr_2, reg_data_2);
                        end else begin
                            $fwrite(file_pointer, " x%0d  0x%8h", reg_addr_2, reg_data_2);
                        end
                    end
                    if (is_load_2) 
                        $fwrite(file_pointer, " mem 0x%8h", mem_addr_2);
                end
                else begin
                    if (fpu_flags_2 != 0) $fwrite(file_pointer, " c1_fflags 0x%8h", fpu_flags_2);

                    if (reg_addr_2 > 9) begin
                        $fwrite(file_pointer, " f%0d 0x%8h", reg_addr_2, reg_data_2);
                        if (is_load_2) begin
                            $fwrite(file_pointer, " mem 0x%8h", mem_addr_2);
                        end
                    end else begin
                        $fwrite(file_pointer, " f%0d  0x%8h", reg_addr_2, reg_data_2);
                        if (is_load_2) begin
                            $fwrite(file_pointer, " mem 0x%8h", mem_addr_2);
                        end
                    end
                end
            end
            $fwrite(file_pointer, "\n");
        end
    end
end

initial begin
    file_pointer2 = $fopen("trace_timestamp.log", "w");
    forever begin
        @(posedge clk_i);
        
        // Port 0 - write first
        if(valid_0) begin
            $fwrite(file_pointer2, "%t - PIPE 0 - 0x%8h (0x%8h)", $time, pc_0, instr_0);
            if (is_store_0) begin
                if(mem_size_0 == 2'b00) begin
                    $fwrite(file_pointer2, " mem 0x%8h 0x%2h", mem_addr_0, mem_data_0[7:0]);
                end
                else if(mem_size_0 == 2'b01) begin
                    $fwrite(file_pointer2, " mem 0x%8h 0x%4h", mem_addr_0, mem_data_0[15:0]);
                end
                else begin
                    $fwrite(file_pointer2, " mem 0x%8h 0x%8h", mem_addr_0, mem_data_0);
                end
            end
            else begin
                if (!is_float_0) begin
                    if (reg_addr_0 != 0) begin
                        if (reg_addr_0 > 9) begin
                            $fwrite(file_pointer2, " x%0d 0x%8h", reg_addr_0, reg_data_0);
                        end else begin
                            $fwrite(file_pointer2, " x%0d  0x%8h", reg_addr_0, reg_data_0);
                        end
                    end
                    if (is_load_0) 
                        $fwrite(file_pointer2, " mem 0x%8h", mem_addr_0);
                end
                else begin
                    if (fpu_flags_0 != 0) $fwrite(file_pointer2, " c1_fflags 0x%8h", fpu_flags_0);

                    if (reg_addr_0 > 9) begin
                        $fwrite(file_pointer2, " f%0d 0x%8h", reg_addr_0, reg_data_0);
                        if (is_load_0) begin
                            $fwrite(file_pointer2, " mem 0x%8h", mem_addr_0);
                        end
                    end else begin
                        $fwrite(file_pointer2, " f%0d  0x%8h", reg_addr_0, reg_data_0);
                        if (is_load_0) begin
                            $fwrite(file_pointer2, " mem 0x%8h", mem_addr_0);
                        end
                    end
                end
            end
            $fwrite(file_pointer2, "\n");
        end
        
        // Port 1 - write second
        if(valid_1) begin
            $fwrite(file_pointer2, "%t - PIPE 1 - 0x%8h (0x%8h)", $time, pc_1, instr_1);
            if (is_store_1) begin
                if(mem_size_1 == 2'b00) begin
                    $fwrite(file_pointer2, " mem 0x%8h 0x%2h", mem_addr_1, mem_data_1[7:0]);
                end
                else if(mem_size_1 == 2'b01) begin
                    $fwrite(file_pointer2, " mem 0x%8h 0x%4h", mem_addr_1, mem_data_1[15:0]);
                end
                else begin
                    $fwrite(file_pointer2, " mem 0x%8h 0x%8h", mem_addr_1, mem_data_1);
                end
            end
            else begin
                if (!is_float_1) begin
                    if (reg_addr_1 != 0) begin
                        if (reg_addr_1 > 9) begin
                            $fwrite(file_pointer2, " x%0d 0x%8h", reg_addr_1, reg_data_1);
                        end else begin
                            $fwrite(file_pointer2, " x%0d  0x%8h", reg_addr_1, reg_data_1);
                        end
                    end
                    if (is_load_1) 
                        $fwrite(file_pointer2, " mem 0x%8h", mem_addr_1);
                end
                else begin
                    if (fpu_flags_1 != 0) $fwrite(file_pointer2, " c1_fflags 0x%8h", fpu_flags_1);

                    if (reg_addr_1 > 9) begin
                        $fwrite(file_pointer2, " f%0d 0x%8h", reg_addr_1, reg_data_1);
                        if (is_load_1) begin
                            $fwrite(file_pointer2, " mem 0x%8h", mem_addr_1);
                        end
                    end else begin
                        $fwrite(file_pointer2, " f%0d  0x%8h", reg_addr_1, reg_data_1);
                        if (is_load_1) begin
                            $fwrite(file_pointer2, " mem 0x%8h", mem_addr_1);
                        end
                    end
                end
            end
            $fwrite(file_pointer2, "\n");
        end
        
        // Port 2 - write third
        if(valid_2) begin
            $fwrite(file_pointer2, "%t - PIPE 2 - 0x%8h (0x%8h)", $time, pc_2, instr_2);
            if (is_store_2) begin
                if(mem_size_2 == 2'b00) begin
                    $fwrite(file_pointer2, " mem 0x%8h 0x%2h", mem_addr_2, mem_data_2[7:0]);
                end
                else if(mem_size_2 == 2'b01) begin
                    $fwrite(file_pointer2, " mem 0x%8h 0x%4h", mem_addr_2, mem_data_2[15:0]);
                end
                else begin
                    $fwrite(file_pointer2, " mem 0x%8h 0x%8h", mem_addr_2, mem_data_2);
                end
            end
            else begin
                if (!is_float_2) begin
                    if (reg_addr_2 != 0) begin
                        if (reg_addr_2 > 9) begin
                            $fwrite(file_pointer2, " x%0d 0x%8h", reg_addr_2, reg_data_2);
                        end else begin
                            $fwrite(file_pointer2, " x%0d  0x%8h", reg_addr_2, reg_data_2);
                        end
                    end
                    if (is_load_2) 
                        $fwrite(file_pointer2, " mem 0x%8h", mem_addr_2);
                end
                else begin
                    if (fpu_flags_2 != 0) $fwrite(file_pointer2, " c1_fflags 0x%8h", fpu_flags_2);

                    if (reg_addr_2 > 9) begin
                        $fwrite(file_pointer2, " f%0d 0x%8h", reg_addr_2, reg_data_2);
                        if (is_load_2) begin
                            $fwrite(file_pointer2, " mem 0x%8h", mem_addr_2);
                        end
                    end else begin
                        $fwrite(file_pointer2, " f%0d  0x%8h", reg_addr_2, reg_data_2);
                        if (is_load_2) begin
                            $fwrite(file_pointer2, " mem 0x%8h", mem_addr_2);
                        end
                    end
                end
            end
            $fwrite(file_pointer2, "\n");
        end
    end
end

endmodule
