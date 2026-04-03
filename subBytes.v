`timescale 1ns / 1ps

module subBytes (
    input wire [127:0] data_in,   // 128-bit input block
    output wire [127:0] data_out  // 128-bit output block
);

    // --- Row 0 ---
    sbox sbox_0  ( .in_byte(data_in[7:0]),     .out_byte(data_out[7:0])   );
    sbox sbox_1  ( .in_byte(data_in[15:8]),    .out_byte(data_out[15:8])  );
    sbox sbox_2  ( .in_byte(data_in[23:16]),   .out_byte(data_out[23:16]) );
    sbox sbox_3  ( .in_byte(data_in[31:24]),   .out_byte(data_out[31:24]) );

    // --- Row 1 ---
    sbox sbox_4  ( .in_byte(data_in[39:32]),   .out_byte(data_out[39:32]) );
    sbox sbox_5  ( .in_byte(data_in[47:40]),   .out_byte(data_out[47:40]) );
    sbox sbox_6  ( .in_byte(data_in[55:48]),   .out_byte(data_out[55:48]) );
    sbox sbox_7  ( .in_byte(data_in[63:56]),   .out_byte(data_out[63:56]) );

    // --- Row 2 ---
    sbox sbox_8  ( .in_byte(data_in[71:64]),   .out_byte(data_out[71:64]) );
    sbox sbox_9  ( .in_byte(data_in[79:72]),   .out_byte(data_out[79:72]) );
    sbox sbox_10 ( .in_byte(data_in[87:80]),   .out_byte(data_out[87:80]) );
    sbox sbox_11 ( .in_byte(data_in[95:88]),   .out_byte(data_out[95:88]) );

    // --- Row 3 ---
    sbox sbox_12 ( .in_byte(data_in[103:96]),  .out_byte(data_out[103:96]) );
    sbox sbox_13 ( .in_byte(data_in[111:104]), .out_byte(data_out[111:104]) );
    sbox sbox_14 ( .in_byte(data_in[119:112]), .out_byte(data_out[119:112]) );
    sbox sbox_15 ( .in_byte(data_in[127:120]), .out_byte(data_out[127:120]) );

endmodule