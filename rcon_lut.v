module rcon_lut (
    input  [3:0]  round_num, // Round 1 to 10
    output [31:0] rcon_out
);

    // Rcon values are only applied to the MSB, the other 3 bytes are always 0x00
    reg [31:0] rcon_reg;

    always @(*) begin
        case (round_num)
            4'h1: rcon_reg = 32'h01000000;
            4'h2: rcon_reg = 32'h02000000;
            4'h3: rcon_reg = 32'h04000000;
            4'h4: rcon_reg = 32'h08000000;
            4'h5: rcon_reg = 32'h10000000;
            4'h6: rcon_reg = 32'h20000000;
            4'h7: rcon_reg = 32'h40000000;
            4'h8: rcon_reg = 32'h80000000;
            4'h9: rcon_reg = 32'h1B000000;
            4'hA: rcon_reg = 32'h36000000;
            default: rcon_reg = 32'h00000000;
        endcase
    end

    assign rcon_out = rcon_reg;

endmodule