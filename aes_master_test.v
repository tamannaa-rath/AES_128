`timescale 1ns/1ps

module aes_master_test;
    // Inputs
    reg clk;
    reg reset;
    reg start;
    reg [127:0] plaintext;
    reg [127:0] key;

    // Outputs
    wire [127:0] ciphertext;
    wire done;

    // Instantiate the Top-Level Wrapper
    aes_top uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .plaintext(plaintext),
        .key(key),
        .ciphertext(ciphertext),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        start = 0;
        plaintext = 0;
        key = 0;

        // Release Reset
        #20 reset = 0;
        #10;


        plaintext = 128'h01234567_89ABCDEF_01234567_89ABCDEF;
        key       = 128'hFFFFFFFF_00000000_FFFFFFFF_00000000;
        
        $display("AES ENCRYPTION START");
        $display("Plaintext: %h", plaintext);
        $display("Key:       %h", key);

        start = 1;
        #10 start = 0;

        // Wait for the 'done' flag
        // In an 11-round FSM, this takes ~11-12 clock cycles
        wait(done == 1'b1);
        
        #5; // For stable output
        $display("ENCRYPTION COMPLETE");
        $display("Ciphertext: %h", ciphertext);
        $display("Time Taken: %t", $time);

    end
endmodule