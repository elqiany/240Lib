`default_nettype none
module OnesCount
 #(parameter w = 30)
 (input  logic         d_in_ready, clock, reset,
  input  logic [w-1:0] d_in,
  output logic         dor,
  output logic [$clog2(w+1)-1:0] d_out);

  logic lowBit, done, Cclr_L, Cinc_L;
  logic Sload_L, Sshift_L, Oclr_L;
  logic Oinc_L;

  logic [$clog2(w)-1:0] SC;

  fsm #(w) control (.*);


  always_comb begin
      if (!Sload_L)
          next_value = d_in;
      else if (!Sshift_L)
          next_value = value & (value - {{w-1}{1'b0}}, 1'b1});
      else
          next_value = value;
    end

    Register #(w) vreg (.Q(value),
                        .en(!Sload_L || !Sshift_L),
                        .clear(1'b0),
                        .clock(clock),
                        .D(next_value));

    Counter #($clog2(w+1)) oct (.Q(d_out),
                                .en(!Oinc_L),
                                .clear(!Oclr_L),
                                .load(1'b0),
                                .up(1'b1),
                                .clock(clock),
                                .D('0));

endmodule: OnesCount

module fsm
 #(parameter w = 30)
  (input  logic clock, reset, done,
   input  logic d_in_ready, lowBit,
   output logic Cclr_L, Cinc_L, Sload_L, Sshift_L, Oclr_L, Oinc_L, dor);

  enum logic {A = 1'b0, B = 1'b1} cur_state, n_state;

  always_comb begin
    case (cur_state)
      A: begin  //State A
         n_state = d_in_ready ? B : A;
         Cclr_L  = d_in_ready ? 0 : 1;
         Sload_L = d_in_ready ? 0 : 1;
         Oclr_L  = d_in_ready ? 0 : 1;
         Sshift_L = 1;
         Cinc_L   = 1;
         Oinc_L   = 1;
         dor = 0; // D_out_ready
         end
      B: begin  //State B
         n_state  = (done)? A : B;
         dor      = (done)? 1 : 0;
         Cclr_L   = 1;
         Sload_L  = 1;
         Oclr_L   = 1;
         Cinc_L   = (done) ? 1 : 0;
         Sshift_L = (done) ? 1 : 0;
         Oinc_L = (done)? 1:~lowBit;
         end
    endcase
  end

  always_ff @(posedge clock, posedge reset)
    if (reset)
      cur_state <= A;
    else
      cur_state <= n_state;

endmodule: fsm
