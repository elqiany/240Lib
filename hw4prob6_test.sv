`default_nettype none

module hw4prob6_test
  (output logic clock, the_input, reset_n);

  logic problem1;
  logic problem2;

  hw4prob4 moore (
      .the_input(the_input),
      .clock(clock),
      .reset_n(reset_n),
      .problem1(problem1)
  );

  hw4prob5 mealy (
      .the_input(the_input),
      .clock(clock),
      .reset_n(reset_n),
      .problem2(problem2)
  );

  initial clock = 0;
  always #5 clock = ~clock;

  initial begin
      reset_n = 0;
      #12 reset_n = 1;
  end

  initial begin
        the_input = 0;
    #10 the_input = 1;
    #20 the_input = 0;
    #10 the_input = 1;
    #10 the_input = 0;
    #20 the_input = 1;
    #10 the_input = 0;
    #10 the_input = 1;
    #10 the_input = 0;
    #10 the_input = 1;
    #15 $finish();
  end

endmodule : hw4prob6_test


