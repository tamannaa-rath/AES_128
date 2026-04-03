module keyExpansion (
    input  [127:0] prev_key,
    input  [3:0]   round_idx,
    output [127:0] next_key
);
    wire [31:0] w0, w1, w2, w3;
    wire [31:0] g_out;
    wire [31:0] rot_out, sub_out, rcon_out;

    // Split previous key into 4 words
    assign w0 = prev_key[127:96];
    assign w1 = prev_key[95:64];
    assign w2 = prev_key[63:32];
    assign w3 = prev_key[31:0];

    // G-function
    rotWord rot_i (.word_in(w3),      .word_out(rot_out));
    subWord sub_i (.word_in(rot_out), .word_out(sub_out));
    rcon_lut rcn_i (.round_num(round_idx), .rcon_out(rcon_out));
    
    assign g_out = sub_out ^ rcon_out;

    wire [31:0] next_w0 = w0 ^ g_out;
    wire [31:0] next_w1 = w1 ^ next_w0;
    wire [31:0] next_w2 = w2 ^ next_w1;
    wire [31:0] next_w3 = w3 ^ next_w2;

    // Final 128-bit key
    assign next_key = {next_w0, next_w1, next_w2, next_w3};

endmodule