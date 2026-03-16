`default_nettype none

module Decoder
    (input logic [2:0] I,
     input logic   en,
     output logic [7:0] D);

     always_comb begin
         if (en)
             D = 8'b1 << I;
         else
             D = 8'b0;
     end

endmodule : Decoder

module BarrelShifter
    (input logic [15:0] V,
     input logic   [3:0] by,
     output logic [15:0] S);

     always_comb begin
          S = V << by;
     end

endmodule : BarrelShifter

module Multiplexer
    (input logic [7:0] I,
     input logic [2:0] S,
     output logic Y);

    always_comb begin
        Y = I[S];
    end

endmodule : Multiplexer

module Mux2to1
    (input logic [7:0] I0,
     input logic [7:0] I1,
     input logic        S,
     output logic [7:0] Y);

        assign Y = (S) ? I1 : I0;

endmodule : Mux2to1

module MagComp
    (input logic [7:0] A,
     input logic [7:0] B,
     output logic AltB,
     output logic AeqB,
     output logic AgtB);

    always_comb begin
        AeqB = (A === B);
        AltB = (A < B);
        AgtB = (A > B);

    end

endmodule : MagComp

module Comparator
    (input logic [3:0] A,
     input logic [3:0] B,
     output logic AeqB);

    assign AeqB = (A === B);

endmodule : Comparator

module Adder
    (output logic cout,
     input logic cin,
     output logic [7:0] sum,
     input logic [7:0] A,
     input logic [7:0] B);

    assign {cout, sum} = A + B;

endmodule : Adder

module Subtracter
    (output logic bout,
     input logic bin,
     output logic [7:0] diff,
     input logic [7:0] A,
     input logic [7:0] B);

    assign {bout, diff} = A - B;

endmodule : Subtracter

module DFlipFlop
    (input logic D,
     input logic clock,
     input logic preset_L,
     input logic reset_L
     output logic Q);

    always_ff @(posedge clock or negedge preset_L or negedge reset_L) begin
        if (!reset_L)
            Q <= 0;
        else if (!preset_L)
            Q <= 1;
        else
            Q <= D;
    end

endmodule : DFlipFlop

module Register
    #(parameter WIDTH = 8)
    (input logic en,
     input logic clear,
     input logic clock,
     input logic [WIDTH-1:0] D
     output logic [WIDTH-1:0] Q);

    always_ff @(posedge clock) begin
        if (en)
            Q <= D;
        else if (clear)
            Q <= 0;
    end

endmodule : Register

module Counter
    #(parameter WIDTH = 8)
    (input logic en,
     input logic clear,
     input logic load,
     input logic up,
     input logic clock,
     input logic [WIDTH-1:0] D
     output logic [WIDTH-1:0] Q);

    always_ff @(posedge clock) begin
        if (clear)
            Q <= 0;
        else if (load)
            Q <= D;
        else if (en) begin
            if (up)
                Q <= Q + 1;
            else
                Q <= Q - 1;
        end
    end

endmodule : Counter

module Synchronizer
    (input logic async,
     input logic clock
     output logic sync);

    logic first;

    always_ff @(posedge clock) begin
        first <= async;
        sync <= first;
    end

endmodule : Synchronizer

module ShiftRegisterPIPO
    #(parameter WIDTH = 8)
    (input logic en,
     input logic left,
     input logic load,
     input logic clock,
     input logic [WIDTH-1:0] D
     output logic [WIDTH-1:0] Q);

    always_ff @(posedge clock) begin
        if (load)
            Q <= D;
        else if (en) begin
            if (left)
                Q <= Q << 1;
            else
                Q <= Q >> 1;
        end
    end

endmodule : ShiftRegisterPIPO

module ShiftRegisterSIPO
    #(parameter WIDTH = 8)
    (input logic en,
     input logic left,
     input logic serial,
     input logic clock
     output logic [WIDTH-1:0] Q);

    always_ff @(posedge clock) begin
        if (en) begin
            if (left)
                Q <= {Q[WIDTH-2:0], serial};
            else
                Q <= {serial, Q[WIDTH-1:1]};
        end
    end

endmodule : ShiftRegisterSIPO

module BarrelShiftRegister
    #(parameter WIDTH = 8)
    (input logic en,
     input logic load,
     input logic [1:0] by,
     input logic clock,
     input logic [WIDTH-1:0] D
     output logic [WIDTH-1:0] Q);

    always_ff @(posedge clock) begin
        if (load)
            Q <= D;
        else if (en)
            Q <= Q << by;
    end

endmodule : BarrelShiftRegister

module BusDriver
    #(parameter WIDTH = 8)
    (input logic en,
     input logic [WIDTH-1:0] buff,
     input logic [WIDTH-1:0] data
     output logic [WIDTH-1:0] bus);

    assign bus = en ? data : buff;

endmodule : BusDriver

module Memory
    #(parameter DW = 8, W = 256, parameter AW = 4)
    (input logic clock,
     input logic re,
     input logic we,
     input logic [AW-1:0] addr,
     inout tri [DW-1:0] data);

    logic [DW-1:0] M[W];
    logic [DW-1:0] rData;

    assign data = (re) ? rData: 'z;

    always_ff @(posedge clock)
        if (we)
            M[addr] <= data;

    always_comb
        rData = M[addr];

endmodule : Memory
