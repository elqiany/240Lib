`default_nettype none

module hw5prob3
    (input logic A, B, clock, reset_N,
     output logic F);

    enum logic [2:0] {
        S0 = 3'd000, A1 = 3'd001, A2 = 3'd010,
        A3 = 3'd011, B1 = 3'd100, B2 = 3'd101,
        B3 = 3'd111} state, nextState;

    always_ff @(posedge clock, negedge reset_N)
        if (~reset_N) state <= S0;
        else state <= nextState;

    always_comb
        unique case (state)
            S0 : nextState = (A) ? A1 :
                             (B) ? B1 : S0;
            A1 : nextState = (A) ? A2 : A1;
            A2 : nextState = (A) ? A3 : A2;
            A3 : nextState = S0;
            B1 : nextState = (B) ? B2 : B1;
            B2 : nextState = (B) ? B3 : B2;
            B3 : nextState = S0;
            default : nextState = S0;
        endcase

    always_comb begin
        F = 1'b0;
        unique case (state)
            A3 : F = 1'b1;
            B3 : F = 1'b1;
            default : ;
        endcase
    end

endmodule: hw5prob3
