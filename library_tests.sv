module Decoder_test;

    logic [2:0] I;
    logic en;
    logic [7:0] D;

    Decoder DUT (.I(I),
                 .en(en),
                 .D(D));

    initial begin
        $monitor($time,,
            "I = %b, en = %b, D = %b",
            I, en, D);

        en = 0; I = 3'b000;
        #10 I = 3'b001;
        #10 I = 3'b010;
        #10 I = 3'b111;

        #10 en = 1; I = 3'b000;
        #10 I = 3'b001;
        #10 I = 3'b010;
        #10 I = 3'b011;
        #10 I = 3'b100;
        #10 I = 3'b101;
        #10 I = 3'b110;
        #10 I = 3'b111;

        #10 $finish;

    end

endmodule : Decoder_test


module BarrelShifter_test;

    logic [15:0] V;
    logic [3:0] by;
    logic [15:0] S;

    BarrelShifter DUT (.V(V),
                       .by(by),
                       .S(S));

    initial begin
        $monitor($time,,
            "V = %b, by = %b, S = %b",
            V, by, S);

        V = 16'h0001; by = 0;
        #10 by = 1;
        #10 by = 4;
        #10 by = 8;
        #10 by = 15;

        #10 V = 16'h00F0; by = 4;
        #10 V = 16'H8001; by = 1;
        #10 V = 16'H1234; by = 3;
        #10 $finish;

    end

endmodule : BarrelShifter_test


module Multiplexer_test;

    logic [7:0] I;
    logic [2:0]S;
    logic Y;

    Multiplexer DUT (.I(I),
                     .S(S),
                     .Y(Y));

    initial begin
        $monitor($time,,
            "I = %b, S = %b, Y = %b",
            I, S, Y);

        I = 8'b1010_1100; S = 3'b000;
        #10 S = 3'b001;
        #10 S = 3'b010;
        #10 S = 3'b011;
        #10 S = 3'b100;
        #10 S = 3'b101;
        #10 S = 3'b110;
        #10 S = 3'b111;

        #10 I = 8'b0000_0001; S = 3'b000;
        #10 S = 3'b111;
        #10 $finish;

    end

endmodule : Multiplexer_test


module Mux2to1_test;

    logic [7:0] I0, I1;
    logic S;
    logic [7:0] Y;

    Mux2to1 DUT (.I0(I0),
                 .I1(I1),
                 .S(S),
                 .Y(Y));

    initial begin
        $monitor($time,,
            "I0 = %b, I1 = %b, S = %b, Y = %b",
            I0, I1, S, Y);

        I0 = 8'hAA; I1 = 8'h55; S = 0;
        #10 S = 1;
        #10 I0 = 8'h00; I1 = 8'hFF; S = 0;
        #10 S = 1;

        #10 I0 = 8'h12; I1 = 8'h34; S = 0;
        #10 S = 1;

        #10 $finish;

    end

endmodule : Mux2to1_test

module MagComp_test;

    logic [7:0] A, B;
    logic AltB, AeqB, AgtB;

    MagComp  DUT (.A(A),
                  .B(B),
                  .AltB(AltB),
                  .AeqB(AeqB),
                  .AgtB(AgtB));

    initial begin
        $monitor($time,,
            "A=%b, B=%b, AltB=%b, AeqB=%b, AgtB=%b",
             A, B, AltB, AeqB, AgtB);

         A = 8'd0; B = 8'd0;
         #10 A = 8'd0; B = 8'd1;
         #10 A = 8'd1; B = 8'd0;
         #10 A = 8'd42; B = 8'd42;
         #10 A = 8'd100; B = 8'd99;
         #10 A = 8'd99; B = 8'd100;
         #10 A = 8'd255; B = 8'd0;

         #10 $finish;

    end

endmodule : MagComp_test


module Comparator_test;

    logic [3:0] A;
    logic [3:0] B;
    logic AeqB;

    Comparator DUT (.A(A),
                    .B(B),
                    .AeqB(AeqB));

    initial begin
        $monitor($time,,
            "A = %b, B = %b, AeqB = %b",
             A, B, AeqB);

         A = 4'b0000; B = 4'b0000;
         #10 A = 4'b0000; B = 4'b0001;
         #10 A = 4'b1010; B = 4'b1010;
         #10 A = 4'b1111; B = 4'b0111;
         #10 A = 4'b1100; B = 4'b0011;

         #10 $finish;

    end

endmodule : Comparator_test

module Adder_test;

    logic [7:0] A;
    logic [7:0] B;
    logic [7:0] sum;
    logic cin;
    logic cout;

    Adder  DUT (.A(A),
                .B(B),
                .cin(cin),
                .cout(cout),
                .sum(sum));

    initial begin
        $monitor($time,,
            "A = %b, B = %b, cin = %b, cout = %b, sum = %b",
             A, B, cin, cout, sum);

         #10 cin = 0; A = 8'd0; B = 8'd0;
         #10 cin = 0; A = 8'd5; B = 8'd3;
         #10 cin = 1; A = 8'd5; B = 8'd3;
         #10 cin = 0; A = 8'd255; B = 8'd1;
         #10 $finish;

    end

endmodule : Adder_test

module Subtracter_test;

    logic [7:0] A;
    logic [7:0] B;
    logic [7:0] diff;
    logic bin;
    logic bout;

    Subtracter  DUT (.A(A),
                     .B(B),
                     .bin(bin),
                     .bout(bout),
                     .diff(diff));

    initial begin
        $monitor($time,,
            "A = %b, B = %b, bin = %b, bout = %b, diff = %b",
             A, B, bin, bout, diff);

         #10 bin = 0; A = 8'd0; B = 8'd0;
         #10 bin = 0; A = 8'd10; B = 8'd3;
         #10 bin = 1; A = 8'd10; B = 8'd3;
         #10 bin = 0; A = 8'd3; B = 8'd10;
         #10 $finish;

   end

endmodule : Subtracter_test

module DFlipFlop_test;

    logic D;
    logic clock;
    logic preset_L;
    logic reset_L;
    logic Q;

    DFlipFlop DUT (.D(D),
                   .clock(clock),
                   .preset_L(preset_L),
                   .reset_L(reset_L),
                   .Q(Q));

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        $monitor($time,,
            "D = %b, preset_L = %b, reset_L = %b, Q = %b",
            D, preset_L, reset_L, Q);

        #10 D = 0; preset_L = 1; reset_L = 1;
        #10 D = 1; preset_L = 1; reset_L = 1;
        #10 D = 0; preset_L = 0; reset_L = 1;
        #10 D = 0; preset_L = 1; reset_L = 0;
        #10 $finish;
    end

endmodule : DFlipFlop_test

module Register_test;

    logic en;
    logic clear;
    logic clock;
    logic [7:0] D;
    logic [7:0] Q;

    Register DUT (.en(en),
                  .clear(clear),
                  .clock(clock),
                  .D(D),
                  .Q(Q));

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        $monitor($time,,
            "en = %b, clear = %b, D = %b, Q = %b",
        en, clear, D, Q);

        #10 en = 0; clear = 0; D = 8'd0;
        #10 en = 1; clear = 0; D = 8'd12;
        #10 en = 1; clear = 0; D = 8'd25;
        #10 en = 0; clear = 1; D = 8'd50;
        #10 $finish;

    end

endmodule : Register_test

module Counter_test;

    logic en;
    logic clear;
    logic load;
    logic up;
    logic clock;
    logic [7:0] D;
    logic [7:0] Q;

    Counter DUT (.en(en),
                 .clear(clear),
                 .load(load),
                 .up(up),
                 .clock(clock),
                 .D(D),
                 .Q(Q));

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        $monitor($time,,
            "en = %b, clear = %b, load = %b, up = %b, D = %b, Q = %b",
            en, clear, load, up, D, Q);

        #10 en = 0; clear = 1; load = 0; up = 1; D = 8'd0;
        #10 en = 0; clear = 0; load = 1; up = 1; D = 8'd5;
        #10 en = 1; clear = 0; load = 0; up = 1; D = 8'd0;
        #10 en = 1; clear = 0; load = 0; up = 0; D = 8'd0;
        #10 $finish;

    end

endmodule : Counter_test

module Synchronizer_test;

    logic async;
    logic clock;
    logic sync;

    Synchronizer DUT (.async(async),
                      .clock(clock),
                      .sync(sync));

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        $monitor($time,,
            "async = %b, sync = %b",
            async, sync);

        #10 async = 0;
        #10 async = 1;
        #10 async = 0;
        #10 async = 1;
        #10 $finish;

    end

endmodule : Synchronizer_test

module ShiftRegisterPIPO_test;

    logic en;
    logic left;
    logic load;
    logic clock;
    logic [7:0] D;
    logic [7:0] Q;

    ShiftRegisterPIPO DUT (.en(en),
                           .left(left),
                           .load(load),
                           .clock(clock),
                           .D(D),
                           .Q(Q));

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        $monitor($time,,
            "en = %b, left = %b, load = %b, D = %b, Q = %b",
            en, left, load, D, Q);

        #10 en = 0; left = 0; load = 1; D = 8'b10101010;
        #10 en = 1; left = 1; load = 0; D = 8'b10101010;
        #10 en = 1; left = 0; load = 0; D = 8'b10101010;
        #10 en = 0; left = 0; load = 0; D = 8'b10101010;
        #10 $finish;

    end

endmodule : ShiftRegisterPIPO_test

module ShiftRegisterSIPO_test;

    logic en;
    logic left;
    logic serial;
    logic clock;
    logic [7:0] Q;

    ShiftRegisterSIPO DUT (.en(en),
                           .left(left),
                           .serial(serial),
                           .clock(clock),
                           .Q(Q));

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        $monitor($time,,
            "en = %b, left = %b, serial = %b, Q = %b",
            en, left, serial, Q);

        #10 en = 1; left = 1; serial = 1;
        #10 en = 1; left = 1; serial = 0;
        #10 en = 1; left = 0; serial = 1;
        #10 en = 0; left = 0; serial = 0;
        #10 $finish;

    end

endmodule : ShiftRegisterSIPO_test

module BarrelShiftRegister_test;

    logic en;
    logic load;
    logic clock;
    logic [1:0] by;
    logic [7:0] D;
    logic [7:0] Q;

    BarrelShiftRegister DUT (.en(en),
                           .left(left),
                           .by(by),
                           .clock(clock),
                           .D(D),
                           .Q(Q));

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        $monitor($time,,
            "en = %b, load = %b,by = %b,  D = %b, Q = %b",
            en, load, by, D, Q);

        #10 en = 0; load = 1; by = 2'b00; D = 8'b00001111;
        #10 en = 1; load = 0; by = 2'b01; D = 8'b00000000;
        #10 en = 1; load = 0; by = 2'b10; D = 8'b00000000;
        #10 en = 1; load = 0; by = 2'b11; D = 8'b00000000;
        #10 $finish;

    end

endmodule : BarrelShiftRegister_test

module BusDriver_test;

    logic en;
    logic [7:0] data;
    logic [7:0] buff;
    logic [7:0] bus;

    BusDriver DUT (.en(en),
                   .data(data),
                   .buff(buff),
                   .bus(bus));

    initial begin
        $monitor($time,,
            "en = %b, data = %b, buff = %b, bus = %b",
            en, data, buff, bus);

        #10 en = 0; data = 8'b11110000; buff = 8'b00001111;
        #10 en = 1; data = 8'b11110000; buff = 8'b00001111;
        #10 en = 0; data = 8'b10101010; buff = 8'b00110011;
        #10 en = 1; data = 8'b10101010; buff = 8'b00110011;
        #10 $finish;

    end

endmodule : BusDriver_test

module Memory_test;

    logic [7:0] data;
    logic clock;
    logic re;
    logic we;
    logic [7:0] addr;

    Memory    DUT (.data(data),
                   .clock(clock),
                   .re(re),
                   .we(we)
                   .addr(addr));

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        $monitor($time,,
            "re = %b, we = %b, addr = %b, data = %b",
            re, we, addr, data);

        #10 re = 0; we = 0; addr = 8'd0;
        #10 re = 1; we = 0; addr = 8'd0;
        #10 re = 0; we = 1; addr = 8'd1;
        #10 re = 1; we = 0; addr = 8'd1;
        #10 $finish;

    end

endmodule : Memory_test



