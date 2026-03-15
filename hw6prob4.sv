`default_nettype none

module hw6prob4
    (input logic A, clock, reset_L,
     output logic B);

    logic state;
    logic next_state;

    always_comb begin
        if (state == 0)
            B = A;
        else
            B = ~A;
    end

    always_comb begin
        if (state == 0 && A == 1)
            next_state = 1;
        else
            next_state = state;
    end

    DFlipFlop ff (.Q(state),
                  .D(next_state),
                  .clock(clock),
                  .preset_L(1'b1),
                  .reset_L(reset_L));

endmodule : hw6prob4
