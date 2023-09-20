`include "regFile.v"

module regFile_testbench;

  // Declare the signals for the testbench
  reg clock, reset, wEn;
  reg [31:0] write_data;
  reg [4:0] read_reg1, read_reg2, write_reg;
  wire [31:0] read_data1, read_data2;

  // Instantiate the regFile module
  regFile reg_file_inst (
    .clock(clock),
    .reset(reset),
    .wEn(wEn),
    .write_data(write_data),
    .read_reg1(read_reg1),
    .read_reg2(read_reg2),
    .write_reg(write_reg),
    .read_data1(read_data1),
    .read_data2(read_data2)
  );
task expec;
  input [31:0] exp_out;
  if ((read_data1 == exp_out) || (read_data2 == exp_out)) begin
    $display("At time %0d reset=%b wEn=%b, write_reg=%b, write_data=%b, read_reg1=%b, read_reg2=%b, read_data1=%b, read_data2=%b",
       $time, reset, wEn, write_reg, write_data, read_reg1, read_reg2, read_data1, read_data2); 
    end
    else begin
      $display("TEST FAILED");
      $display("At time %0d reset=%b wEn=%b, write_reg=%b, write_data=%b, read_reg1=%b, read_reg2=%b, read_data1=%b, read_data2=%b",
       $time, reset, wEn, write_reg, write_data, read_reg1, read_reg2, read_data1, read_data2);
       $display("Data should be %b", exp_out);
      $finish;
    end
  endtask

  initial repeat (5) begin #5 clock=1; #5 clock=0; end
 
    initial @(posedge clock) begin
     reset = 0; write_data = 32'h66208c33; wEn = 1; write_reg =  5'b00010; read_reg1 = 2; read_reg2 = 5; @(posedge clock) expec (32'h66208c33);
     reset = 0; write_data = 32'h00000004; wEn = 1; write_reg =  5'b00110; read_reg1 = 2; read_reg2 = 6; @(posedge clock) expec (4);
     reset = 0; write_data = 32'h00000009; wEn = 1; write_reg =  5'b10100; read_reg1 = 20; read_reg2 = 2; @(posedge clock) expec (9);
     reset = 1; write_data = 32'h00000004; wEn = 1; write_reg =  5'b00111; read_reg1 = 7; read_reg2 = 5; @(posedge clock) expec (0);
     $display("TEST PASSED");
    $finish;
    end
    initial begin
  $dumpvars;
  $dumpfile("dump.vcd");
  end  

endmodule
