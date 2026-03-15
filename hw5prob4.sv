`default_nettype none
module hw5prob4;

    logic the_input, clock, reset_n;
    logic problem1;

    hw4prob4 dut (.the_input, .clock, .reset_n, .problem1);

    logic [1:0] Q, D;

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    always_ff @(posedge clock, negedge reset_n)
    if (~reset_n)
      Q <= 2'b00;
    else
      Q <= D;

    always_comb begin
        D[1] = (Q[0] & the_input) | (Q[1] & ~Q[0] & ~the_input);
        D[0] = ~the_input;
    end

    initial begin
        $monitor($time,,
            "Current State = %b, Next State = %b",
            Q, D);

        reset_n = 0;
        the_input = 0;
        @(posedge clock);
        reset_n = 1;

        the_input = 0;
        @(posedge clock); #1;
        the_input = 1;
        @(posedge clock); #1;
        the_input = 0;
        @(posedge clock); #1;
        the_input = 1;
        @(posedge clock); #1;
        the_input = 1;
        @(posedge clock); #1;
        the_input = 0;
        @(posedge clock); #1;
        $finish;
    end

endmodule : hw5prob4

