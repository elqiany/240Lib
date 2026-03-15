`default_nettype none

module hw4prob5
  (input  logic the_input, clock, reset_n,
   output logic problem2);
   
  logic [1:0] Q, D;
  
  always_ff @(posedge clock, negedge reset_n)
    if (~reset_n)
      Q <= 2'b00;
    else
      Q <= D;
      
  // Next state logic
  assign D[1] = Q[0] & the_input;
  assign D[0] = ~the_input;
  
  // Output logic
  assign problem2 = Q[1] & ~the_input;
   
endmodule : hw4prob5

