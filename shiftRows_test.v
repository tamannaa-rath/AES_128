`timescale 1ns / 1ps

module shiftRows_test;

    // Inputs
    reg [127:0] data_in;
    // Outputs
    wire [127:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    shiftRows uut (
        .data_in(data_in), 
        .data_out(data_out)
    );

    initial begin
        // Each byte is its own index (00, 01, 02... 0F) so it'll be easy to see the positions change
        data_in = 128'h0f0e0d0c0b0a09080706050403020100;

        // After 10ns, look at data_out:
        // Row 0 [31:0]:   03 02 01 00 -> No change: 03 02 01 00
        // Row 1 [63:32]:  07 06 05 04 -> Shift 1:   04 07 06 05
        // Row 2 [95:64]:  0b 0a 09 08 -> Shift 2:   09 08 0b 0a
        // Row 3 [127:96]: 0f 0e 0d 0c -> Shift 3:   0c 0f 0e 0d
        
        #10;
    end
      
endmodule