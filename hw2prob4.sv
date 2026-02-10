`default_nettype none

module hw2prob4
    (input logic a, b, c, d, e, f,
     output logic g, g00, g01, g10, g11);

    always_comb begin

        g = (c & ~d & ~f) |
            (a & ~c & d & f) |
            (~b & ~d & e & ~f);

        g00 = (~d & ~f) & (c | e);

        g01 = (c & ~d & ~f);

        g10 = (c & ~d & ~f) |
              (~c & d & f) |
              (~d & e & ~f);

        g11 = (c & ~d & ~f) |
              (~c & d & f);
    end

endmodule : hw2prob4

module hw2prob4_test;

    logic a, b, c, d, e ,f;
    logic g, g00, g01, g10, g11;

    hw2prob4 DUT(.a(a),
                 .b(b),
                 .c(c),
                 .d(d),
                 .e(e),
                 .f(f),
                 .g(g),
                 .g00(g00),
                 .g01(g01),
                 .g10(g10),
                 .g11(g11));

    logic g_shannon;
    assign g_shannon =
        (~a & ~b & g00) |
        (~a & b & g01) |
        ( a & ~b & g10) |
        ( a & b & g11);

    integer i;
    initial begin
        $monitor($time,,
            " a = %b b = %b c = %b d = %b e = %b f = %b g = %b shannon = %b",
            a, b, c, d, e, f, g, g_shannon);

        for (i = 0; i < 64; i++) begin
            {a, b, c, d, e ,f} = i[5:0];
            #10;
            if (g != g_shannon) begin
                $display("Ooops!");
            end
        end

        $finish;
    end

endmodule : hw2prob4_test
