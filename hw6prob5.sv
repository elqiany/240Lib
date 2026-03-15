`default_nettype none

module hw6prob5
    (input logic start,
     input logic clock, reset_L,
     input logic [7:0] inputA,
     input logic inputB, inputC,
     output logic done,
     output logic [7:0] value);


    logic vload, vclear;
    logic [7:0] sum;
    logic cout;

    fsm control (
        .start(start),
        .inputB(inputB),
        .inputC(inputC),
        .done(done),
        .vload(vload),
        .vclear(vclear),
        .clock(clock),
        .reset_L(reset_L));

    Adder add (.cout(cout),
               .cin(1'b0),
               .sum(sum),
               .A(value),
               .B(inputA));

    Register #(8) vreg (.Q(value),
                        .en(vload),
                        .clera(vclear),
                        .clock(clock),
                        .D(sum));

endmodule : hw6prob5

module fsm
    (input logic start, inputB, inputC,
     input logic clock, reset_L,
     output logic done,
     output logic vload, vclear);

     enum logic {A = 1'b0, B = 1'b1} cur_state, n_state;

     always_comb begin
         case (cur_state)
             A: begin
                 n_state = start ? B : A;
                 done = 0;
                 vclear = 1;
                 vload = 0;
             end

             B: begin
                 n_state = inputC ? B : A;
                 done = inputC? 0 : 1;
                 vclear = 0;
                 vload = inputC ? inputB : 0;
             end
        endcase
    end

    always_ff @(posedge clock of negedge reset_L) begin
        if (!reset_L)
            cur_state <= A;
        else
            cur_state <=n_state;
        end

endmodule : fsm
