`default_nettype none

module hw1prob6_test;

    logic a, b, c, d;
    logic prime, div3;

    hw1prob6 DUT (.a(a),
                  .b(b),
                  .c(c),
                  .d(d),
                  .prime(prime),
                  .div3(div3));

    initial begin
        $monitor($time,,
            "a = %b, b = %b, c = %b, d = %b, prime = %b, div3 = %b",
            a, b, c, d, prime, div3);

             a = 0; b = 0; c = 0; d = 0;
        #10  a = 0; b = 0; c = 0; d = 1;
        #10  a = 0; b = 0; c = 1; d = 0;
        #10  a = 0; b = 0; c = 1; d = 1;
        #10  a = 0; b = 1; c = 0; d = 0;
        #10  a = 0; b = 1; c = 0; d = 1;
        #10  a = 0; b = 1; c = 1; d = 0;
        #10  a = 0; b = 1; c = 1; d = 1;
        #10  a = 1; b = 0; c = 0; d = 0;
        #10  a = 1; b = 0; c = 0; d = 1;
        #10  a = 1; b = 0; c = 1; d = 0;
        #10  a = 1; b = 0; c = 1; d = 1;
        #10  a = 1; b = 1; c = 0; d = 0;
        #10  a = 1; b = 1; c = 0; d = 1;
        #10  a = 1; b = 1; c = 1; d = 0;
        #10  a = 1; b = 1; c = 1; d = 1;
        #10 $finish;
    end

endmodule
