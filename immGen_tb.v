`include "immGen.v"

module immGen_tb;

  // Declare the signals for the testbench
  reg [31:0] inst;
  wire [31:0] GenOut;

  // Instantiate the immGen module
  immGen immGen_inst (
   .inst(inst),
   .GenOut(GenOut)
  );

task expec;
  input [31:0] exp_out;
  if ( GenOut == exp_out ) begin
    $display("At time %0d inst = %b, GenOut = %b ",
       $time, inst, GenOut); 
    end
    else begin
      $display("TEST FAILED");
   $display("At time %0d inst = %b, GenOut = %b ",
       $time, inst, GenOut);
       $display("Data should be %b", exp_out);
      $finish;
    end
  endtask
 
    initial begin
      inst = 32'h66208c23; #1 expec (32'h00000678);  //0110 0110 0010 0000 1000 1100 0010 0011 - S
      inst = 32'ha1204883; #1 expec (32'hfffffa12);  //0000 0000 0110 0011 0100 1000 1000 0011 - I
      inst = 32'he6208b33; #1 expec (32'hfffffe76);  //1110 0110 0010 0000 1000 1011 0010 0011 - S
      inst = 32'h21204883; #1 expec (32'h00000212);  //0010 0001 0010 0000 0100 1000 1000 0011 - I
  
    $display("TEST PASSED");
    $finish;
    end
    initial begin
  $dumpvars;
  $dumpfile("dump.vcd");
  end  

endmodule
