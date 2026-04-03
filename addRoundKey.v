`timescale 1ns / 1ps

module addRoundKey (
    input  wire [127:0] data_in,   // Output from MixColumns
    input  wire [127:0] round_key, // Key for the current round
    output wire [127:0] data_out
);

    // bitwise XOR
    assign data_out = data_in ^ round_key;

endmodule