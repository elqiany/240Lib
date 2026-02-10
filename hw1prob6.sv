`default_nettype none
module hw1prob6
    (input logic a, b, c, d,
     output logic prime, div3);

    logic a_not, b_not, c_not, d_not;

    not (a_not, a);
    not (b_not, b);
    not (c_not, c);
    not (d_not, d);

    logic m2, m3, m5, m7, m11, m13;

    and (m2, a_not, b_not, c, d_not);
    and (m3, a_not, b_not, c, d);
    and (m5, a_not, b, c_not, d);
    and (m7, a_not, b, c, d);
    and (m11, a, b_not, c, d);
    and (m13, a, b, c_not, d);
    or (prime, m2, m3, m5, m7, m11, m13);

    logic m0, dm3, m6, m9, m12, m15;

    and (m0, a_not, b_not, c_not, d_not);
    and (dm3, a_not, b_not, c, d);
    and (m6, a_not, b, c, d_not);
    and (m9, a, b_not, c_not, d);
    and (m12, a, b, c_not, d_not);
    and (m15, a, b, c, d);
    or (div3, m0, dm3, m6, m9, m12, m15);

endmodule

