`default_nettype none

module hw1prob11
    (input logic a, b, c,
     input logic loc1, loc0,
     output logic dir1, dir0);


     logic a_not, c_not, loc0_not;

     not (a_not, a);
     not (c_not, c);
     not (loc0_not, loc0);

    logic d1_1, d1_2, d1_3, d1_4;


    and (d1_1, c_not, loc0_not);
    and (d1_2, loc1, loc0_not);
    and (d1_3, a_not, loc0_not);
    and (d1_4, a_not, b, loc1);

    or (dir1, d1_1, d1_2, d1_3, d1_4);

    logic d0_1, d0_2, d0_3, d0_4;

    and (d0_1, b, loc1);
    and (d0_2, b, c_not, loc0);
    and (d0_3, loc1, loc0);
    and (d0_4, a, c_not, loc0);

    or (dir0, d0_1, d0_2, d0_3, d0_4);

endmodule
