`default_nettype none
module hw5prob5;

    logic the_input, clock, reset_n;
    logic problem2;

    hw4prob5 dut(.the_input, .clock, .reset_n, .problem2);

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    logic [1:0] Q, D;

    always_ff @(posedge clock, negedge reset_n)
        if (~reset_n)
            Q <= 2'b00;
        else
            Q <= D;

  // Next state logic
    assign D[1] = Q[0] & the_input;
    assign D[0] = ~the_input;

    initial begin
        $monitor($time,,
            "Current State: %b, the_input = %b, Next State = %b, problem2 = %b",
            Q, the_input, D, problem2);

        reset_n = 0;
        the_input = 0;
        @(posedge clock);
        reset_n = 1;

        the_input = 0;
        @(posedge clock);
        #1;
        the_input = 1;
        @(posedge clock);
        #1;
        the_input = 0;
        @(posedge clock);
        #1;
        the_input = 1;
        @(posedge clock);
        #1;
        the_input = 1;
        @(posedge clock);
        #1;
        the_input = 0;
        @(posedge clock);
        #1;
        $finish;
    end

endmodule : hw5prob5
