 `include "CSP_RISCV_main.v"

`timescale 1ns/1ps

module tb_CSP_RISCV_main;

  // Define clock and reset signals
  reg clock , reset, wEn;
  reg [31:0] address;

  // Instantiate your CSP_RISCV_main processor
  CSP_RISCV_main csp (
    .clock(clock),
    .wEn(wEn),
    .reset(reset),
    .address(address) // Connect your 32-bit address input
  );

  initial repeat (8) begin #5 clock=1; #5 clock=0; end
 
    initial @(posedge clock ) begin

     $display("--------SINGLE CYCLE RISC-V PROCESSOR TESTING--------");

    $monitor("At time %0d reset=%b wEn=%b, address %h: PC = %h, Instruction = %h, alu_opcode = %b, alu_out = %h, DataRead = %h",
           $time, reset, wEn, address, csp.PC, csp.instruction1, csp.alu_opcode1, csp.alu_out1, csp.dataRead1); 

    reset = 1; wEn = 1; address = 32'h00000001;  @(posedge clock) 
    reset = 0; wEn = 1; address = 32'h00000002;  @(posedge clock) 
    reset = 1; wEn = 0; address = 32'h00000004;  @(posedge clock) 
    reset = 0; wEn = 1; address = 32'h00000008;  @(posedge clock) 
    reset = 0; wEn = 0; address = 32'h0000000b;  @(posedge clock) 
    reset = 0; wEn = 1; address = 32'h00000010;  @(posedge clock) 
    reset = 0; wEn = 1; address = 32'h00000016;  @(posedge clock) 
    reset = 1; wEn = 1; address = 32'h00000000;  @(posedge clock) 
  
    $display("TEST PASSED");
    $finish;
    end
    
    initial begin
    $dumpvars;
    $dumpfile("dump.vcd");
    end  

endmodule
