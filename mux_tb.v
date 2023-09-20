`include "mux.v"
module mux_test;

  reg              sel  ;
  reg  [31:0] in0  ;
  reg  [31:0] in1  ;
  wire [31:0] mux_out;

  mux mux_inst
  (
    .sel     ( sel     ),
    .in0     ( in0     ),
    .in1     ( in1     ),
    .mux_out ( mux_out ) 
  );

  task expec;
    input [31:0] exp_out;
    if (mux_out !== exp_out) begin
      $display("TEST FAILED");
      $display("At time %0d sel=%b in0=%b in1=%b mux_out=%b",
               $time, sel, in0, in1, mux_out);
      $display("mux_out should be %b", exp_out);
      $finish;
    end
   else begin
      $display("At time %0d sel=%b in0=%b in1=%b, mux_out=%b",
               $time, sel, in0, in1, mux_out);
   end 
  endtask

  initial begin
    sel=1; in0=32'h15; in1=32'h00; #1 expec (32'h15);
    sel=1; in0=32'h0A; in1=32'h00; #1 expec (32'h0A);
    sel=0; in0=32'h00; in1=32'h15; #1 expec (32'h15);
    sel=0; in0=32'h00; in1=32'h0A; #1 expec (32'h0A);
    $display("TEST PASSED");
    $finish;
  end
  initial begin
  $dumpvars;
  $dumpfile("dump.vcd");
  end

endmodule
