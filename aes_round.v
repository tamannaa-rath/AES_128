module aes_round (
    input  wire [127:0] state_in,
    input  wire [127:0] round_key,
    output wire [127:0] state_out
);

    // Intermediate wires to connect the modules
    wire [127:0] sub_to_shift;
    wire [127:0] shift_to_mix;
    wire [127:0] mix_to_add;

    // 1. SubBytes
    subBytes sb_inst (
        .data_in(state_in),
        .data_out(sub_to_shift)
    );

    // 2. ShiftRows
    shiftRows sr_inst (
        .data_in(sub_to_shift),
        .data_out(shift_to_mix)
    );

    // 3. MixColumns
    mixColumns mc_inst (
        .data_in(shift_to_mix),
        .data_out(mix_to_add)
    );

    // 4. AddRoundKey
    addRoundKey ark_inst (
        .data_in(mix_to_add),
        .round_key(round_key),
        .data_out(state_out)
    );

endmodule