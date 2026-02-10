`default_nettype none

module BCDtoSevenSegment
    (input logic [3:0] number,
     output logic [6:0] segment);

    always_comb begin
        unique case (number)
        4'd0: segment = 7'b0111111;
        4'd1: segment = 7'b0000110;
        4'd2: segment = 7'b1011011;
        4'd3: segment = 7'b1001111;
        4'd4: segment = 7'b1100110;
        4'd5: segment = 7'b1101101;
        4'd6: segment = 7'b1111101;
        4'd7: segment = 7'b0000111;
        4'd8: segment = 7'b1111111;
        4'd9: segment = 7'b1101111;

        default : segment = 7'b0000000;
     endcase
    end

endmodule : BCDtoSevenSegment


module SevenSegmentDisplay
    (input logic [3:0] number7, number6, number5, number4,
                       number3, number2, number1, number0,
     input logic [7:0] blank, dpoints,
     output logic [7:0] digit7, digit6, digit5, digit4,
                        digit3, digit2, digit1, digit0);

    logic [6:0] seg7, seg6, seg5, seg4, seg3, seg2, seg1, seg0;

    BCDtoSevenSegment s7(.number(number7), .segment(seg7));

    BCDtoSevenSegment s6(.number(number6), .segment(seg6));
    BCDtoSevenSegment s5(.number(number5), .segment(seg5));
    BCDtoSevenSegment s4(.number(number4), .segment(seg4));
    BCDtoSevenSegment s3(.number(number3), .segment(seg3));
    BCDtoSevenSegment s2(.number(number2), .segment(seg2));
    BCDtoSevenSegment s1(.number(number1), .segment(seg1));
    BCDtoSevenSegment s0(.number(number0), .segment(seg0));

    assign digit7[6:0] = blank[7] ? 7'b1111111 : ~seg7;
    assign digit7[7] = blank[7] ? 1'b1 : dpoints[7];

    assign digit6[6:0] = blank[6] ? 7'b1111111 : ~seg6;
    assign digit6[7] = blank[6] ? 1'b1 : dpoints[6];

    assign digit5[6:0] = blank[5] ? 7'b1111111 : ~seg5;
    assign digit5[7] = blank[5] ? 1'b1 : dpoints[5];

    assign digit4[6:0] = blank[4] ? 7'b1111111 : ~seg4;
    assign digit4[7] = blank[4] ? 1'b1 : dpoints[4];

    assign digit3[6:0] = blank[3] ? 7'b1111111 : ~seg3;
    assign digit3[7] = blank[3] ? 1'b1 : dpoints[3];

    assign digit2[6:0] = blank[2] ? 7'b1111111 : ~seg2;
    assign digit2[7] = blank[2] ? 1'b1 : dpoints[2];

    assign digit1[6:0] = blank[1] ? 7'b1111111 : ~seg1;
    assign digit1[7] = blank[1] ? 1'b1 : dpoints[1];

    assign digit0[6:0] = blank[0] ? 7'b1111111 : ~seg0;
    assign digit0[7] = blank[0] ? 1'b1 : dpoints[0];


endmodule : SevenSegmentDisplay

