module aes_top (
    input  wire         clk,
    input  wire         reset,
    input  wire         start,
    input  wire [127:0] plaintext,
    input  wire [127:0] key,
    output reg  [127:0] ciphertext,
    output reg          done
);

    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam ROUND = 2'b10;
    localparam FINAL = 2'b11;

    reg [1:0] curr_state, next_state;
    reg [3:0] round_count;
    
    reg [127:0] state_reg;
    reg [127:0] key_reg;

    wire [127:0] round_out;
    wire [127:0] next_round_key;
    wire [127:0] sub_out, shift_out, final_out;

    // 1. Instantiate Key Expansion 
    key_expansion ke_inst (
        .prev_key(key_reg),
        .round_idx(round_count),
        .next_key(next_round_key)
    );

    // 2. Instantiate Standard Round (Rounds 1-9)
    aes_round ar_inst (
        .state_in(state_reg),
        .round_key(next_round_key),
        .state_out(round_out)
    );

    // 3. Logic for Final Round (No MixColumns)
    subBytes   sb_f (.data_in(state_reg), .data_out(sub_out));
    shiftRows  sr_f (.data_in(sub_out),   .data_out(shift_out));
    assign final_out = shift_out ^ next_round_key;

    // FSM State Transitions
    always @(posedge clk or posedge reset) begin
        if (reset) curr_state <= IDLE;
        else       curr_state <= next_state;
    end

    always @(*) begin
        next_state = curr_state;
        case (curr_state)
            IDLE:  if (start) next_state = START;
            START: next_state = ROUND;
            ROUND: if (round_count == 4'h9) next_state = FINAL;
            FINAL: next_state = IDLE;
        endcase
    end

    // Sequential Logic (The Loop)
    always @(posedge clk) begin
        if (reset) begin
            round_count <= 4'h0;
            done <= 1'b0;
        end else begin
            case (curr_state)
                IDLE: begin
                    done <= 1'b0;
                    round_count <= 4'h0;
                end
                
                START: begin
                    state_reg <= plaintext ^ key; // Initial AddRoundKey (Round 0)
                    key_reg   <= key;
                    round_count <= 4'h1;
                end

                ROUND: begin
                    state_reg   <= round_out;
                    key_reg     <= next_round_key;
                    round_count <= round_count + 1;
                end

                FINAL: begin
                    ciphertext <= final_out;
                    done       <= 1'b1;
                end
            endcase
        end
    end
endmodule