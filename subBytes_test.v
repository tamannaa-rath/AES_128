`timescale 1ns / 1ps

module subBytes_test;

    // Inputs
    reg [127:0] data_in;
    // Outputs
    wire [127:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    subBytes uut (
        .data_in(data_in), 
        .data_out(data_out)
    );

    initial begin
        data_in = 128'h00000000000000000000000000000000;
        #10;
        // Verfication: Result should be 16 copies of 63 (because the S-Box value for 00 = 63)
        
        // Testing with a random pattern
        data_in = 128'h0102030405060708090a0b0c0d0e0f10;
        #10;
        
        $finish;
    end
      
endmodule