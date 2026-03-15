`default_nettype none

module top
 #(parameter W = 16)
  (input logic [W-1:0] inputA,
   input logic         clock, rst_L);

  logic         cl_L, ld_L;
  logic [W-1:0] sum, addOut;
  logic [W-1:0] addOut2;

  Adder #(W)   a1 (inputA, sum, 1'b0, addOut2, );

  assign #1 addOut = addOut2;

  regLoad #(W) r1 (addOut, ld_L, cl_L, clock,
                   rst_L, sum);

  fsm          c1 (.clock, .rst_L, .ld_L, .cl_L);

endmodule: top

module fsm
  (input  logic clock, rst_L,
   output logic ld_L, cl_L);

    typedef enum logic [2:0] {A=3'b100, B=3'b010, C=3'b001} state_t;

  state_t cs_reg, cs, ns;

  always_ff @(posedge clock, negedge rst_L)
    if (~rst_L) cs_reg<= A;
    else cs_reg <= ns;

  assign #1 cs = cs_reg;

  assign #1 ns =
      (cs == A) ? B:
      (cs == B) ? C:
      A;

  assign #1 cl_L = (cs == A) ? 1'b0 : 1'b1;

  assign #1 ld_L = (cs == A) ? 1'b1 : 1'b0;

endmodule : fsm

module regLoad
  #(parameter W = 3)
  (input  logic [W-1:0]  D,
   input  logic          ld_L, cl_L,
   input  logic          clock, reset_L,
   output logic [W-1:0]  Q);

  logic [W-1:0] Q_reg;

  always_ff @(posedge clock,
              negedge reset_L)
    if (~reset_L)
      Q_reg <= 0;
    else  if (~cl_L)
      Q_reg <= 0;
    else if (~ld_L)
      Q_reg <= D;

  assign #1 Q = Q_reg;

endmodule: regLoad

module Adder
    #(parameter W = 16)
    (input logic [W-1:0] a,
     input logic [W-1:0] b,
     input logic cin,
     output logic [W-1:0] sum,
     output logic cout);

     assign {cout, sum} = a + b + cin;

endmodule : Adder

module top_test();

  logic [15:0] inputA;
  logic        clock, rst_L;

  top dut(.*);

  initial begin
    clock = 0;
    rst_L = 0;
    rst_L <= 1;
    forever #5 clock = ~clock;
  end

  initial begin
    $monitor("Input(%h) Sum(%h) AdderOut(%h) CS(%s)",
             inputA, dut.sum, dut.addOut, dut.c1.cs.name);
    inputA <= 16'hF0F0;
    @(posedge clock);
    inputA <= 16'hF001;
    @(posedge clock);
    inputA <= 16'h00FF;
    @(posedge clock);
    inputA <= 16'h4321;
    @(posedge clock);
    #1 $finish;
  end
endmodule : top_test

