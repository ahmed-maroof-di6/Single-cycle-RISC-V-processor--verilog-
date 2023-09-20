`include "instrMem.v"

`timescale 1ns/1ps

module tb_instrMem;

  // Define clock and reset signals
  
  reg reset = 1;
  reg [31:0]address;
  wire [31:0] instruction;

  // Instantiate your instrMem module
  instrMem mem (
    .reset(reset),
    .address(address), // Connect your address input
    .instruction(instruction)
  );
  integer i;
  

  // Reset generation
  initial begin
    #10 reset = 1;
    #100;
    reset = 0;
    #10;
    reset = 0;  
    #10000;
    $finish;
  end

  // Test address input and reset
  initial begin
    #1000;

    // Test different address values
    for (i = 0; i < 10; i = i + 1) begin
      address = i * 4; // Increment address by 4 each time
      #1000;
      $display("Instruction at address %h: %h", address, instruction);
    end

    // Test reset functionality
    #1000;
    reset = 1;
    #10;
    reset = 0;
    #1000;
    $display("Instruction after reset: %h", instruction);

    $finish;
  end

endmodule
