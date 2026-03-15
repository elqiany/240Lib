`default_nettype none

module hw4prob4
  (input  logic the_input, clock, reset_n,
   output logic problem1);
   
  logic [1:0] Q, D;
  
  always_ff @(posedge clock, negedge reset_n)
    if (~reset_n)
      Q <= 2'b00;
    else
      Q <= D;
      
  // Next state logic
  assign D[1] = (Q[0] & the_input) | (Q[1] & ~Q[0] & ~the_input);
  assign D[0] = ~the_input;
  
  // Output logic
  assign problem1 = Q[1] & Q[0];
   
endmodule : hw4prob4

