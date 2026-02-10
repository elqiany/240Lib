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
