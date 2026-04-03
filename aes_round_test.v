`timescale 1ns/1ps

module aes_round_test;
    reg  [127:0] state_in, round_key;
    wire [127:0] state_out;

    // Instantiate the wrapper
    aes_round uut (
        .state_in(state_in), 
        .round_key(round_key), 
        .state_out(state_out)
    );

    initial begin
        // Reset state
        state_in = 0; round_key = 0;
        #20;

        // Test Case: Simple hex pattern
        state_in  = 128'h0123456789ABCDEF0123456789ABCDEF;
        round_key = 128'hFFFFFFFFFFFFFFFF0000000000000000;
        
        #20;
        
        $display("Input:  %h", state_in);
        $display("Key:    %h", round_key);
        $display("Output: %h", state_out);
    end
endmodule