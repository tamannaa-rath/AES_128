`timescale 1ns / 1ps

module mixColumns (
    input  wire [127:0] data_in,
    output wire [127:0] data_out
);

    // Galois Field Multiplication by 2 (xtime)
    function [7:0] xtime;
        input [7:0] b;
        begin
            xtime = (b[7] == 1'b1) ? ((b << 1) ^ 8'h1b) : (b << 1);
        end
    endfunction

    // --- COLUMN 0 (Vertical slice of the first byte of each row) ---
    wire [7:0] c0_r0 = data_in[7:0];      // Row 0, Byte 0
    wire [7:0] c0_r1 = data_in[39:32];    // Row 1, Byte 4
    wire [7:0] c0_r2 = data_in[71:64];    // Row 2, Byte 8
    wire [7:0] c0_r3 = data_in[103:96];   // Row 3, Byte 12

    assign data_out[7:0]     = xtime(c0_r0) ^ (xtime(c0_r1) ^ c0_r1) ^ c0_r2 ^ c0_r3;
    assign data_out[39:32]   = c0_r0 ^ xtime(c0_r1) ^ (xtime(c0_r2) ^ c0_r2) ^ c0_r3;
    assign data_out[71:64]   = c0_r0 ^ c0_r1 ^ xtime(c0_r2) ^ (xtime(c0_r3) ^ c0_r3);
    assign data_out[103:96]  = (xtime(c0_r0) ^ c0_r0) ^ c0_r1 ^ c0_r2 ^ xtime(c0_r3);

    // --- COLUMN 1 (Vertical slice of the second byte of each row) ---
    wire [7:0] c1_r0 = data_in[15:8];     // Row 0, Byte 1
    wire [7:0] c1_r1 = data_in[47:40];    // Row 1, Byte 5
    wire [7:0] c1_r2 = data_in[79:72];    // Row 2, Byte 9
    wire [7:0] c1_r3 = data_in[111:104];  // Row 3, Byte 13

    assign data_out[15:8]    = xtime(c1_r0) ^ (xtime(c1_r1) ^ c1_r1) ^ c1_r2 ^ c1_r3;
    assign data_out[47:40]   = c1_r0 ^ xtime(c1_r1) ^ (xtime(c1_r2) ^ c1_r2) ^ c1_r3;
    assign data_out[79:72]   = c1_r0 ^ c1_r1 ^ xtime(c1_r2) ^ (xtime(c1_r3) ^ c1_r3);
    assign data_out[111:104] = (xtime(c1_r0) ^ c1_r0) ^ c1_r1 ^ c1_r2 ^ xtime(c1_r3);

    // --- COLUMN 2 (Vertical slice of the third byte of each row) ---
    wire [7:0] c2_r0 = data_in[23:16];    // Row 0, Byte 2
    wire [7:0] c2_r1 = data_in[55:48];    // Row 1, Byte 6
    wire [7:0] c2_r2 = data_in[87:80];    // Row 2, Byte 10
    wire [7:0] c2_r3 = data_in[119:112];  // Row 3, Byte 14

    assign data_out[23:16]   = xtime(c2_r0) ^ (xtime(c2_r1) ^ c2_r1) ^ c2_r2 ^ c2_r3;
    assign data_out[55:48]   = c2_r0 ^ xtime(c2_r1) ^ (xtime(c2_r2) ^ c2_r2) ^ c2_r3;
    assign data_out[87:80]   = c2_r0 ^ c2_r1 ^ xtime(c2_r2) ^ (xtime(c2_r3) ^ c2_r3);
    assign data_out[119:112] = (xtime(c2_r0) ^ c2_r0) ^ c2_r1 ^ c2_r2 ^ xtime(c2_r3);

    // --- COLUMN 3 (Vertical slice of the fourth byte of each row) ---
    wire [7:0] c3_r0 = data_in[31:24];    // Row 0, Byte 3
    wire [7:0] c3_r1 = data_in[63:56];    // Row 1, Byte 7
    wire [7:0] c3_r2 = data_in[95:88];    // Row 2, Byte 11
    wire [7:0] c3_r3 = data_in[127:120];  // Row 3, Byte 15

    assign data_out[31:24]   = xtime(c3_r0) ^ (xtime(c3_r1) ^ c3_r1) ^ c3_r2 ^ c3_r3;
    assign data_out[63:56]   = c3_r0 ^ xtime(c3_r1) ^ (xtime(c3_r2) ^ c3_r2) ^ c3_r3;
    assign data_out[95:88]   = c3_r0 ^ c3_r1 ^ xtime(c3_r2) ^ (xtime(c3_r3) ^ c3_r3);
    assign data_out[127:120] = (xtime(c3_r0) ^ c3_r0) ^ c3_r1 ^ c3_r2 ^ xtime(c3_r3);

endmodule