module rotWord (
    input  [31:0] word_in,
    output [31:0] word_out
);
    // Rotating [Byte0, Byte1, Byte2, Byte3] -> [Byte1, Byte2, Byte3, Byte0]
    // word_in[31:24] is Byte 0 and so on 
    
    assign word_out = {word_in[23:0], word_in[31:24]};

endmodule