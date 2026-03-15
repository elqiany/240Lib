`default_nettype none

module hw5prob1
    (input logic a, clock, reset_N,
     output logic found_it);

     enum logic [2:0] {S0 = 3'b001,
         S1 = 3'b010, S10 = 3'b100} state, nextState;

     always_ff @(posedge clock, negedge reset_N)
         if (~reset_N) state <= S0;
         else state <= nextState;

     always_comb
         unique case (state)
            S0 : nextState = (a) ? S1 : S0;
            S1 : nextState = (a) ? S1 : S10;
            S10 : nextState = (a) ? S1 : S0;
            default: nextState = S0;
        endcase

     always_comb begin
         found_it = (state == S10) & a;
     end

endmodule: hw5prob1

module hw5prob1_test;

    logic a, clock, reset_N;
    logic found_it;

    hw5prob1 dut(.*);

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        $monitor($time,,
            " a = %b found_it = %b", a, found_it);

        reset_N = 0;
        a = 0;
        @(posedge clock);
        reset_N = 1;

        a = 1;
        @(posedge clock);
        a = 0;
        @(posedge clock);
        a = 1;
        @(posedge clock);
        a = 0;
        @(posedge clock);
        a = 1;
        @(posedge clock);

        #10 $finish;
    end

endmodule : hw5prob1_test
