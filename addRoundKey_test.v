`timescale 1ns/1ps

module addRoundKey_tb;
    reg  [127:0] in, key;
    wire [127:0] out;

    addRoundKey uut (.data_in(in), .round_key(key), .data_out(out));

    initial begin
        // Case 1: Identity
        in = 128'hABC; key = 128'h0; #10;
        
        // Case 2: Inversion
        in = 128'h0; key = {128{1'b1}}; 
    end
endmodule