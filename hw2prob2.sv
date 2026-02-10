`default_nettype none

module hw2prob2_if
    (input logic [7:0] A,
     output logic [2:0] Y,
     output logic valid);

     always_comb begin
         valid = 0;
         Y = 3'b000;

         if (A[7]) begin
             valid = 1;
             Y = 3'b111;
         end
         else if (A[6]) begin
             valid = 1;
             Y = 3'b110;
         end
         else if (A[5]) begin
             valid = 1;
             Y = 3'b101;
         end
         else if (A[4]) begin
             valid = 1;
             Y = 3'b100;
         end
         else if (A[3]) begin
             valid = 1;
             Y = 3'b011;
         end
         else if (A[2]) begin
             valid = 1;
             Y = 3'b010;
         end
         else if (A[1]) begin
             valid = 1;
             Y = 3'b001;
         end
         else if (A[0]) begin
             valid = 1;
             Y = 3'b000;
        end
    end

endmodule : hw2prob2_if

module hw2prob2_case
    (input logic [7:0] A,
     output logic [2:0] Y,
     output logic valid);

     always_comb begin
         valid = 0;
         Y = 3'b000;

         casez (A)
         8'b1???????: begin valid = 1; Y = 3'b111; end
         8'b01??????: begin valid = 1; Y = 3'b110; end
         8'b001?????: begin valid = 1; Y = 3'b101; end
         8'b0001????: begin valid = 1; Y = 3'b100; end
         8'b00001???: begin valid = 1; Y = 3'b011; end
         8'b000001??: begin valid = 1; Y = 3'b010; end
         8'b0000001?: begin valid = 1; Y = 3'b001; end
         8'b00000001: begin valid = 1; Y = 3'b000; end
         default: begin valid = 1'b0; Y = 3'b000; end
        endcase
    end

endmodule : hw2prob2_case

module hw2prob2_tern
    (input logic [7:0] A,
     output logic [2:0] Y,
     output logic valid);

    assign valid =
        A[7] ? 1 :
        A[6] ? 1 :
        A[5] ? 1 :
        A[4] ? 1 :
        A[3] ? 1 :
        A[2] ? 1 :
        A[1] ? 1 :
        A[0] ? 1 :
        0;

    assign Y =
        A[7] ? 3'b111 :
        A[6] ? 3'b110 :
        A[5] ? 3'b101 :
        A[4] ? 3'b100 :
        A[3] ? 3'b011 :
        A[2] ? 3'b010 :
        A[1] ? 3'b001 :
        A[0] ? 3'b000 :
        3'b000;

endmodule : hw2prob2_tern

module hw2prob2_test;

    logic [7:0] A;
    logic [2:0] Y_if, Y_case, Y_tern;
    logic valid_if, valid_case, valid_tern;

    hw2prob2_if DUT1 (.Y(Y_if),
                     .valid(valid_if),
                     .A(A));
    hw2prob2_case DUT2 (.Y(Y_case),
                       .valid(valid_case),
                       .A(A));
    hw2prob2_tern DUT3 (.Y(Y_tern),
                       .valid(valid_tern),
                       .A(A));

    initial begin
        $monitor($time,,
            "A=%b | if: v=%b Y=%b |case: v=%b Y=%b | tern: v=%b Y=%b",
             A, valid_if, Y_if, valid_case, Y_case, valid_tern, Y_tern);

        A = 8'b0000_0000;
        #10 A = 8'b0000_0001;
        #10 A = 8'b0000_0010;
        #10 A = 8'b0000_0100;
        #10 A = 8'b0000_1000;
        #10 A = 8'b0001_0000;
        #10 A = 8'b0010_0000;
        #10 A = 8'b0100_0000;
        #10 A = 8'b1000_0000;

        #10 A = 8'b1000_1000;
        #10 A = 8'b0000_0111;
        #10 A = 8'b0010_0001;

        #10 A = 8'b1111_1111;
        #10 A = 8'b0111_1111;
        #10 A = 8'b0001_0010;
        #10 A = 8'b0000_1100;
        #10 A = 8'b0000_1001;

        #10 $finish;
    end

endmodule : hw2prob2_test

