module subWord (
    input  [31:0] word_in,
    output [31:0] word_out
);

    sbox s0 (.in_byte(word_in[31:24]), .data(out_byte[31:24]));
    sbox s1 (.in_byte(word_in[23:16]), .data(out_byte[23:16]));
    sbox s2 (.in_byte(word_in[15:8]),  .data(out_byte[15:8]));
    sbox s3 (.in_byte(word_in[7:0]),   .data(out_byte[7:0]));

endmodule