`timescale 1ns / 1ps

module shiftRows (
    input wire [127:0] data_in,
    output wire [127:0] data_out
);

    // Row 0: No Shift (Bytes 0, 1, 2, 3 stay put)
    assign data_out[7:0]     = data_in[7:0];
    assign data_out[15:8]    = data_in[15:8];
    assign data_out[23:16]   = data_in[23:16];
    assign data_out[31:24]   = data_in[31:24];

    // Row 1: Left Shift by 1 Byte, extreme left(4) falls off and moves in from the right
    assign data_out[39:32]   = data_in[47:40];  // Byte 5 moves to 4
    assign data_out[47:40]   = data_in[55:48];  // Byte 6 moves to 5
    assign data_out[55:48]   = data_in[63:56];  // Byte 7 moves to 6
    assign data_out[63:56]   = data_in[39:32];  // Byte 4 wraps to 7

    // Row 2: Left Shift by 2 Bytes, 8 and 9 fall off from the left and move in from the right
    assign data_out[71:64]   = data_in[87:80];  // Byte 10 moves to 8
    assign data_out[79:72]   = data_in[95:88];  // Byte 11 moves to 9
    assign data_out[87:80]   = data_in[71:64];  // Byte 8 moves to 10
    assign data_out[95:88]   = data_in[79:72];  // Byte 9 moves to 11

    // Row 3: Left Shift by 3 Bytes, 12, 13, and 14 fall off from the left and mpve in from the right
    assign data_out[103:96]  = data_in[127:120]; // Byte 15 moves to 12
    assign data_out[111:104] = data_in[103:96];  // Byte 12 moves to 13
    assign data_out[119:112] = data_in[111:104]; // Byte 13 moves to 14
    assign data_out[127:120] = data_in[119:112]; // Byte 14 moves to 15

endmodule