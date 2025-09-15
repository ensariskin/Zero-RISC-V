`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////
// Module: triple_priority_encoder
//
// Description:
//     Simple 64-bit triple priority encoder without loops
//     Finds first 3 set bits using pure combinational logic
//     Fully synthesizable with no combinational loops
//////////////////////////////////////////////////////////////////////////////////
// TODO : Find more efficient implementation :( 
module triple_priority_encoder #(
    parameter WIDTH = 64,
    parameter INDEX_WIDTH = 6
)(
    input  logic [WIDTH-1:0] data_in,
    input  logic first_enable,
    input  logic second_enable,
    input  logic third_enable,
    output logic [INDEX_WIDTH-1:0] first_index,
    output logic [INDEX_WIDTH-1:0] second_index,
    output logic [INDEX_WIDTH-1:0] third_index,
    output logic first_valid,
    output logic second_valid,
    output logic third_valid
);

    // First priority encoder - find lowest set bit
    always_comb begin
        if (!first_enable) begin
            first_index = 6'd0;
            first_valid = 1'b0;
        end else begin
            first_index = 6'd0;
            first_valid = 1'b0;
            
            // Check each bit from 0 to 63
            if      (data_in[0])  begin first_index = 6'd0;  first_valid = 1'b1; end
            else if (data_in[1])  begin first_index = 6'd1;  first_valid = 1'b1; end
            else if (data_in[2])  begin first_index = 6'd2;  first_valid = 1'b1; end
            else if (data_in[3])  begin first_index = 6'd3;  first_valid = 1'b1; end
            else if (data_in[4])  begin first_index = 6'd4;  first_valid = 1'b1; end
            else if (data_in[5])  begin first_index = 6'd5;  first_valid = 1'b1; end
            else if (data_in[6])  begin first_index = 6'd6;  first_valid = 1'b1; end
            else if (data_in[7])  begin first_index = 6'd7;  first_valid = 1'b1; end
            else if (data_in[8])  begin first_index = 6'd8;  first_valid = 1'b1; end
            else if (data_in[9])  begin first_index = 6'd9;  first_valid = 1'b1; end
            else if (data_in[10]) begin first_index = 6'd10; first_valid = 1'b1; end
            else if (data_in[11]) begin first_index = 6'd11; first_valid = 1'b1; end
            else if (data_in[12]) begin first_index = 6'd12; first_valid = 1'b1; end
            else if (data_in[13]) begin first_index = 6'd13; first_valid = 1'b1; end
            else if (data_in[14]) begin first_index = 6'd14; first_valid = 1'b1; end
            else if (data_in[15]) begin first_index = 6'd15; first_valid = 1'b1; end
            else if (data_in[16]) begin first_index = 6'd16; first_valid = 1'b1; end
            else if (data_in[17]) begin first_index = 6'd17; first_valid = 1'b1; end
            else if (data_in[18]) begin first_index = 6'd18; first_valid = 1'b1; end
            else if (data_in[19]) begin first_index = 6'd19; first_valid = 1'b1; end
            else if (data_in[20]) begin first_index = 6'd20; first_valid = 1'b1; end
            else if (data_in[21]) begin first_index = 6'd21; first_valid = 1'b1; end
            else if (data_in[22]) begin first_index = 6'd22; first_valid = 1'b1; end
            else if (data_in[23]) begin first_index = 6'd23; first_valid = 1'b1; end
            else if (data_in[24]) begin first_index = 6'd24; first_valid = 1'b1; end
            else if (data_in[25]) begin first_index = 6'd25; first_valid = 1'b1; end
            else if (data_in[26]) begin first_index = 6'd26; first_valid = 1'b1; end
            else if (data_in[27]) begin first_index = 6'd27; first_valid = 1'b1; end
            else if (data_in[28]) begin first_index = 6'd28; first_valid = 1'b1; end
            else if (data_in[29]) begin first_index = 6'd29; first_valid = 1'b1; end
            else if (data_in[30]) begin first_index = 6'd30; first_valid = 1'b1; end
            else if (data_in[31]) begin first_index = 6'd31; first_valid = 1'b1; end
            else if (data_in[32]) begin first_index = 6'd32; first_valid = 1'b1; end
            else if (data_in[33]) begin first_index = 6'd33; first_valid = 1'b1; end
            else if (data_in[34]) begin first_index = 6'd34; first_valid = 1'b1; end
            else if (data_in[35]) begin first_index = 6'd35; first_valid = 1'b1; end
            else if (data_in[36]) begin first_index = 6'd36; first_valid = 1'b1; end
            else if (data_in[37]) begin first_index = 6'd37; first_valid = 1'b1; end
            else if (data_in[38]) begin first_index = 6'd38; first_valid = 1'b1; end
            else if (data_in[39]) begin first_index = 6'd39; first_valid = 1'b1; end
            else if (data_in[40]) begin first_index = 6'd40; first_valid = 1'b1; end
            else if (data_in[41]) begin first_index = 6'd41; first_valid = 1'b1; end
            else if (data_in[42]) begin first_index = 6'd42; first_valid = 1'b1; end
            else if (data_in[43]) begin first_index = 6'd43; first_valid = 1'b1; end
            else if (data_in[44]) begin first_index = 6'd44; first_valid = 1'b1; end
            else if (data_in[45]) begin first_index = 6'd45; first_valid = 1'b1; end
            else if (data_in[46]) begin first_index = 6'd46; first_valid = 1'b1; end
            else if (data_in[47]) begin first_index = 6'd47; first_valid = 1'b1; end
            else if (data_in[48]) begin first_index = 6'd48; first_valid = 1'b1; end
            else if (data_in[49]) begin first_index = 6'd49; first_valid = 1'b1; end
            else if (data_in[50]) begin first_index = 6'd50; first_valid = 1'b1; end
            else if (data_in[51]) begin first_index = 6'd51; first_valid = 1'b1; end
            else if (data_in[52]) begin first_index = 6'd52; first_valid = 1'b1; end
            else if (data_in[53]) begin first_index = 6'd53; first_valid = 1'b1; end
            else if (data_in[54]) begin first_index = 6'd54; first_valid = 1'b1; end
            else if (data_in[55]) begin first_index = 6'd55; first_valid = 1'b1; end
            else if (data_in[56]) begin first_index = 6'd56; first_valid = 1'b1; end
            else if (data_in[57]) begin first_index = 6'd57; first_valid = 1'b1; end
            else if (data_in[58]) begin first_index = 6'd58; first_valid = 1'b1; end
            else if (data_in[59]) begin first_index = 6'd59; first_valid = 1'b1; end
            else if (data_in[60]) begin first_index = 6'd60; first_valid = 1'b1; end
            else if (data_in[61]) begin first_index = 6'd61; first_valid = 1'b1; end
            else if (data_in[62]) begin first_index = 6'd62; first_valid = 1'b1; end
            else if (data_in[63]) begin first_index = 6'd63; first_valid = 1'b1; end
        end
    end

    // Create mask for second encoder (exclude first found bit)
    logic [WIDTH-1:0] mask_for_second;
    always_comb begin
        if (!second_enable) begin
            mask_for_second = '0;
        end else begin
            mask_for_second = data_in;
            if (first_valid) begin
                mask_for_second[first_index] = 1'b0;
            end
        end
    end

    // Second priority encoder - find second lowest set bit
    always_comb begin
        if (!second_enable) begin
            second_index = 6'd0;
            second_valid = 1'b0;
        end else begin
            second_index = 6'd0;
            second_valid = 1'b0;
            
            // Check each bit from 0 to 63 in masked input
            if      (mask_for_second[0])  begin second_index = 6'd0;  second_valid = 1'b1; end
            else if (mask_for_second[1])  begin second_index = 6'd1;  second_valid = 1'b1; end
            else if (mask_for_second[2])  begin second_index = 6'd2;  second_valid = 1'b1; end
            else if (mask_for_second[3])  begin second_index = 6'd3;  second_valid = 1'b1; end
            else if (mask_for_second[4])  begin second_index = 6'd4;  second_valid = 1'b1; end
            else if (mask_for_second[5])  begin second_index = 6'd5;  second_valid = 1'b1; end
            else if (mask_for_second[6])  begin second_index = 6'd6;  second_valid = 1'b1; end
            else if (mask_for_second[7])  begin second_index = 6'd7;  second_valid = 1'b1; end
            else if (mask_for_second[8])  begin second_index = 6'd8;  second_valid = 1'b1; end
            else if (mask_for_second[9])  begin second_index = 6'd9;  second_valid = 1'b1; end
            else if (mask_for_second[10]) begin second_index = 6'd10; second_valid = 1'b1; end
            else if (mask_for_second[11]) begin second_index = 6'd11; second_valid = 1'b1; end
            else if (mask_for_second[12]) begin second_index = 6'd12; second_valid = 1'b1; end
            else if (mask_for_second[13]) begin second_index = 6'd13; second_valid = 1'b1; end
            else if (mask_for_second[14]) begin second_index = 6'd14; second_valid = 1'b1; end
            else if (mask_for_second[15]) begin second_index = 6'd15; second_valid = 1'b1; end
            else if (mask_for_second[16]) begin second_index = 6'd16; second_valid = 1'b1; end
            else if (mask_for_second[17]) begin second_index = 6'd17; second_valid = 1'b1; end
            else if (mask_for_second[18]) begin second_index = 6'd18; second_valid = 1'b1; end
            else if (mask_for_second[19]) begin second_index = 6'd19; second_valid = 1'b1; end
            else if (mask_for_second[20]) begin second_index = 6'd20; second_valid = 1'b1; end
            else if (mask_for_second[21]) begin second_index = 6'd21; second_valid = 1'b1; end
            else if (mask_for_second[22]) begin second_index = 6'd22; second_valid = 1'b1; end
            else if (mask_for_second[23]) begin second_index = 6'd23; second_valid = 1'b1; end
            else if (mask_for_second[24]) begin second_index = 6'd24; second_valid = 1'b1; end
            else if (mask_for_second[25]) begin second_index = 6'd25; second_valid = 1'b1; end
            else if (mask_for_second[26]) begin second_index = 6'd26; second_valid = 1'b1; end
            else if (mask_for_second[27]) begin second_index = 6'd27; second_valid = 1'b1; end
            else if (mask_for_second[28]) begin second_index = 6'd28; second_valid = 1'b1; end
            else if (mask_for_second[29]) begin second_index = 6'd29; second_valid = 1'b1; end
            else if (mask_for_second[30]) begin second_index = 6'd30; second_valid = 1'b1; end
            else if (mask_for_second[31]) begin second_index = 6'd31; second_valid = 1'b1; end
            else if (mask_for_second[32]) begin second_index = 6'd32; second_valid = 1'b1; end
            else if (mask_for_second[33]) begin second_index = 6'd33; second_valid = 1'b1; end
            else if (mask_for_second[34]) begin second_index = 6'd34; second_valid = 1'b1; end
            else if (mask_for_second[35]) begin second_index = 6'd35; second_valid = 1'b1; end
            else if (mask_for_second[36]) begin second_index = 6'd36; second_valid = 1'b1; end
            else if (mask_for_second[37]) begin second_index = 6'd37; second_valid = 1'b1; end
            else if (mask_for_second[38]) begin second_index = 6'd38; second_valid = 1'b1; end
            else if (mask_for_second[39]) begin second_index = 6'd39; second_valid = 1'b1; end
            else if (mask_for_second[40]) begin second_index = 6'd40; second_valid = 1'b1; end
            else if (mask_for_second[41]) begin second_index = 6'd41; second_valid = 1'b1; end
            else if (mask_for_second[42]) begin second_index = 6'd42; second_valid = 1'b1; end
            else if (mask_for_second[43]) begin second_index = 6'd43; second_valid = 1'b1; end
            else if (mask_for_second[44]) begin second_index = 6'd44; second_valid = 1'b1; end
            else if (mask_for_second[45]) begin second_index = 6'd45; second_valid = 1'b1; end
            else if (mask_for_second[46]) begin second_index = 6'd46; second_valid = 1'b1; end
            else if (mask_for_second[47]) begin second_index = 6'd47; second_valid = 1'b1; end
            else if (mask_for_second[48]) begin second_index = 6'd48; second_valid = 1'b1; end
            else if (mask_for_second[49]) begin second_index = 6'd49; second_valid = 1'b1; end
            else if (mask_for_second[50]) begin second_index = 6'd50; second_valid = 1'b1; end
            else if (mask_for_second[51]) begin second_index = 6'd51; second_valid = 1'b1; end
            else if (mask_for_second[52]) begin second_index = 6'd52; second_valid = 1'b1; end
            else if (mask_for_second[53]) begin second_index = 6'd53; second_valid = 1'b1; end
            else if (mask_for_second[54]) begin second_index = 6'd54; second_valid = 1'b1; end
            else if (mask_for_second[55]) begin second_index = 6'd55; second_valid = 1'b1; end
            else if (mask_for_second[56]) begin second_index = 6'd56; second_valid = 1'b1; end
            else if (mask_for_second[57]) begin second_index = 6'd57; second_valid = 1'b1; end
            else if (mask_for_second[58]) begin second_index = 6'd58; second_valid = 1'b1; end
            else if (mask_for_second[59]) begin second_index = 6'd59; second_valid = 1'b1; end
            else if (mask_for_second[60]) begin second_index = 6'd60; second_valid = 1'b1; end
            else if (mask_for_second[61]) begin second_index = 6'd61; second_valid = 1'b1; end
            else if (mask_for_second[62]) begin second_index = 6'd62; second_valid = 1'b1; end
            else if (mask_for_second[63]) begin second_index = 6'd63; second_valid = 1'b1; end
        end
    end

    // Create mask for third encoder (exclude first and second found bits)
    logic [WIDTH-1:0] mask_for_third;
    always_comb begin
        if (!third_enable) begin
            mask_for_third = '0;
        end else begin
            mask_for_third = data_in;
            if (first_valid) begin
                mask_for_third[first_index] = 1'b0;
            end
            if (second_valid) begin
                mask_for_third[second_index] = 1'b0;
            end
        end
    end

    // Third priority encoder - find third lowest set bit
    always_comb begin
        if (!third_enable) begin
            third_index = 6'd0;
            third_valid = 1'b0;
        end else begin
            third_index = 6'd0;
            third_valid = 1'b0;
            
            // Check each bit from 0 to 63 in double-masked input
            if      (mask_for_third[0])  begin third_index = 6'd0;  third_valid = 1'b1; end
            else if (mask_for_third[1])  begin third_index = 6'd1;  third_valid = 1'b1; end
            else if (mask_for_third[2])  begin third_index = 6'd2;  third_valid = 1'b1; end
            else if (mask_for_third[3])  begin third_index = 6'd3;  third_valid = 1'b1; end
            else if (mask_for_third[4])  begin third_index = 6'd4;  third_valid = 1'b1; end
            else if (mask_for_third[5])  begin third_index = 6'd5;  third_valid = 1'b1; end
            else if (mask_for_third[6])  begin third_index = 6'd6;  third_valid = 1'b1; end
            else if (mask_for_third[7])  begin third_index = 6'd7;  third_valid = 1'b1; end
            else if (mask_for_third[8])  begin third_index = 6'd8;  third_valid = 1'b1; end
            else if (mask_for_third[9])  begin third_index = 6'd9;  third_valid = 1'b1; end
            else if (mask_for_third[10]) begin third_index = 6'd10; third_valid = 1'b1; end
            else if (mask_for_third[11]) begin third_index = 6'd11; third_valid = 1'b1; end
            else if (mask_for_third[12]) begin third_index = 6'd12; third_valid = 1'b1; end
            else if (mask_for_third[13]) begin third_index = 6'd13; third_valid = 1'b1; end
            else if (mask_for_third[14]) begin third_index = 6'd14; third_valid = 1'b1; end
            else if (mask_for_third[15]) begin third_index = 6'd15; third_valid = 1'b1; end
            else if (mask_for_third[16]) begin third_index = 6'd16; third_valid = 1'b1; end
            else if (mask_for_third[17]) begin third_index = 6'd17; third_valid = 1'b1; end
            else if (mask_for_third[18]) begin third_index = 6'd18; third_valid = 1'b1; end
            else if (mask_for_third[19]) begin third_index = 6'd19; third_valid = 1'b1; end
            else if (mask_for_third[20]) begin third_index = 6'd20; third_valid = 1'b1; end
            else if (mask_for_third[21]) begin third_index = 6'd21; third_valid = 1'b1; end
            else if (mask_for_third[22]) begin third_index = 6'd22; third_valid = 1'b1; end
            else if (mask_for_third[23]) begin third_index = 6'd23; third_valid = 1'b1; end
            else if (mask_for_third[24]) begin third_index = 6'd24; third_valid = 1'b1; end
            else if (mask_for_third[25]) begin third_index = 6'd25; third_valid = 1'b1; end
            else if (mask_for_third[26]) begin third_index = 6'd26; third_valid = 1'b1; end
            else if (mask_for_third[27]) begin third_index = 6'd27; third_valid = 1'b1; end
            else if (mask_for_third[28]) begin third_index = 6'd28; third_valid = 1'b1; end
            else if (mask_for_third[29]) begin third_index = 6'd29; third_valid = 1'b1; end
            else if (mask_for_third[30]) begin third_index = 6'd30; third_valid = 1'b1; end
            else if (mask_for_third[31]) begin third_index = 6'd31; third_valid = 1'b1; end
            else if (mask_for_third[32]) begin third_index = 6'd32; third_valid = 1'b1; end
            else if (mask_for_third[33]) begin third_index = 6'd33; third_valid = 1'b1; end
            else if (mask_for_third[34]) begin third_index = 6'd34; third_valid = 1'b1; end
            else if (mask_for_third[35]) begin third_index = 6'd35; third_valid = 1'b1; end
            else if (mask_for_third[36]) begin third_index = 6'd36; third_valid = 1'b1; end
            else if (mask_for_third[37]) begin third_index = 6'd37; third_valid = 1'b1; end
            else if (mask_for_third[38]) begin third_index = 6'd38; third_valid = 1'b1; end
            else if (mask_for_third[39]) begin third_index = 6'd39; third_valid = 1'b1; end
            else if (mask_for_third[40]) begin third_index = 6'd40; third_valid = 1'b1; end
            else if (mask_for_third[41]) begin third_index = 6'd41; third_valid = 1'b1; end
            else if (mask_for_third[42]) begin third_index = 6'd42; third_valid = 1'b1; end
            else if (mask_for_third[43]) begin third_index = 6'd43; third_valid = 1'b1; end
            else if (mask_for_third[44]) begin third_index = 6'd44; third_valid = 1'b1; end
            else if (mask_for_third[45]) begin third_index = 6'd45; third_valid = 1'b1; end
            else if (mask_for_third[46]) begin third_index = 6'd46; third_valid = 1'b1; end
            else if (mask_for_third[47]) begin third_index = 6'd47; third_valid = 1'b1; end
            else if (mask_for_third[48]) begin third_index = 6'd48; third_valid = 1'b1; end
            else if (mask_for_third[49]) begin third_index = 6'd49; third_valid = 1'b1; end
            else if (mask_for_third[50]) begin third_index = 6'd50; third_valid = 1'b1; end
            else if (mask_for_third[51]) begin third_index = 6'd51; third_valid = 1'b1; end
            else if (mask_for_third[52]) begin third_index = 6'd52; third_valid = 1'b1; end
            else if (mask_for_third[53]) begin third_index = 6'd53; third_valid = 1'b1; end
            else if (mask_for_third[54]) begin third_index = 6'd54; third_valid = 1'b1; end
            else if (mask_for_third[55]) begin third_index = 6'd55; third_valid = 1'b1; end
            else if (mask_for_third[56]) begin third_index = 6'd56; third_valid = 1'b1; end
            else if (mask_for_third[57]) begin third_index = 6'd57; third_valid = 1'b1; end
            else if (mask_for_third[58]) begin third_index = 6'd58; third_valid = 1'b1; end
            else if (mask_for_third[59]) begin third_index = 6'd59; third_valid = 1'b1; end
            else if (mask_for_third[60]) begin third_index = 6'd60; third_valid = 1'b1; end
            else if (mask_for_third[61]) begin third_index = 6'd61; third_valid = 1'b1; end
            else if (mask_for_third[62]) begin third_index = 6'd62; third_valid = 1'b1; end
            else if (mask_for_third[63]) begin third_index = 6'd63; third_valid = 1'b1; end
        end
    end

endmodule
