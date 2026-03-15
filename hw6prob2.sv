`default_nettype none

module top
    #(parameter W = 16)
    (input logic [W-1:0] inputA,
     input logic clock, rst_L,
     output logic [W-1:0] sum);

    logic cl_L, ld_L;
    logic [W-1:0] addOut;

    adder #(W) a1 (inputA, sum, 1'b0, addOut, );
    regLoad #(W) r1 (addOut, ld_L, cl_L, clock,
                     rst_L, sum);

    fsm c1 (clock, rst_L, ld_L, cl_L);

endmodule : top

module regLoad
    #(parameter W = 3)
    (input logic [W-1:0] D,
     input logic ld_L, cl_L,
     input logic clock, reset_L,
     output logic [W-1:0] Q);

    always_ff @(posedge clock, negedge reset_L)
        if (~reset_L)
            Q <= 0;
        else if (~cl_L)
            Q <= 0;
        else if (~ld_L)
            Q <= D;

endmodule : regLoad

module fsm
    (input logic clock, reset_L,
     output logic ld_L, cl_L);

    enum logic [2:0] {A=3'b100, B=3'b010, C=3'b001}ns,cs;

    always_ff @(posedge clock, negedge reset_L)
        if (~reset_L)
            cs <= A;
        else
            cs <= ns;

    always_comb
        unique case (cs)
            A: ns = B;
            B: ns = C;
            C: ns = A;
        endcase

    assign ld_L = (cs == A) ? 1'b1 : 1'b0;
    assign cl_L = (cs == A) ? 1'b0 : 1'b1;

endmodule : fsm

module adder
    #(parameter W = 16)
    (input logic [W-1:0] a,
     input logic [W-1:0] b,
     input logic cin,
     output logic [W-1:0] sum,
     output logic cout);

     assign {cout, sum} = a + b + cin;

endmodule : adder

