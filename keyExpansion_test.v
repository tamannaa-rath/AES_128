`timescale 1ns/1ps

module keyExpansion_test;
    reg  [127:0] prev_key;
    reg  [3:0]   round_idx;
    wire [127:0] next_key;

    // Instantiate your Row-Major Key Expansion
    key_expansion uut (
        .prev_key(prev_key),
        .round_idx(round_idx),
        .next_key(next_key)
    );

    initial begin
        prev_key = 128'h00010203_04050607_08090A0B_0C0D0E0F;
        round_idx = 4'h1; // Rcon = 01000000
        
        #20;
        
        $display("Input Key:  %h", prev_key);
        $display("Round Idx:  %0d", round_idx);
        $display("Output Key: %h", next_key);
    end
endmodule