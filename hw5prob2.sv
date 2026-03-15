`default_nettype none

module hw5prob2
    (input logic b, clock, reset,
     output logic found3zeros_N);

    enum logic [2:0] {S0 = 3'd000,
        S10 = 3'd001, S11 = 3'd010, S12 = 3'd011,
        S20 = 3'd100, S21 = 3'd101, S22 = 3'd110,
        S3 = 3'd111} state, nextState;

    always_ff @(posedge clock, negedge reset)
        if (~reset) state <= S0;
        else state <= nextState;

    always_comb
        unique case (state)
            S0 : nextState = (!b) ? S10 : S0;
            S10 : nextState = (!b) ? S20 : S11;
            S11 : nextState = (!b) ? S20 : S12;
            S12 : nextState = (!b) ? S20 : S0;
            S20 : nextState = (!b) ? S3 : S21;
            S21 : nextState = (!b) ? S3 : S22;
            S22 : nextState = (!b) ? S3 : S0;

            S3: nextState = (!b) ? S3 : S11;

            default: nextState = S0;
        endcase

    always_comb begin
        found3zeros_N = 1'b1;
        unique case (state)
            S3: found3zeros_N = 1'b0;
            default: ;
        endcase
    end

endmodule: hw5prob2

module hw5prob2_test;

    logic b, clock, reset;
    logic found3zeros_N;

    hw5prob2 dut(.*);

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        $monitor($time,,
            " b = %b, found3zeros_N = %b", b, found3zeros_N);

        reset = 0;
        b = 1;
        @(posedge clock);
        reset = 1;

        b = 1;
        @(posedge clock);
        b = 1;
        @(posedge clock);
        b = 1;
        @(posedge clock);
        b = 1;
        @(posedge clock);
        b = 0;
        @(posedge clock);
        b = 1;
        @(posedge clock);
        b = 0;
        @(posedge clock);
        b = 1;
        @(posedge clock);
        b = 1;
        @(posedge clock);
        b = 0;
        @(posedge clock);

        #10 $finish;
    end

endmodule : hw5prob2_test
