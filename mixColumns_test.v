`timescale 1ns / 1ps

module mixColumns_test;

    // Inputs
    reg [127:0] data_in;
    // Outputs
    wire [127:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    mixColumns uut (
        .data_in(data_in), 
        .data_out(data_out)
    );

    initial begin
        // Standard AES test vector (Input State)
        data_in = 128'hd4bf5d3026c1a4b9d2058204db13070e;
        
        #10;
        
        // Expected Output after MixColumns:
        // 046681e5 d0063229 047accad e8528204
    end
      
endmodule