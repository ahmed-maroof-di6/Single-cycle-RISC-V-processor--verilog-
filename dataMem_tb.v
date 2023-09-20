`include "dataMem.v"

`timescale 1ns/1ps

module tb_dataMem;

  // Define clock and reset signals
  reg clock;
  reg reset;
  reg wEn;
  reg [31:0] address;
  reg [31:0] dataWrite;

  // Instantiate your dataMem module
  dataMem datamem (
    .reset(reset),
    .clock(clock),
    .wEn(wEn),
    .address(address),
    .dataWrite(dataWrite),
    .dataRead(dataRead)  // Connect your dataRead output
  );

  // Clock generation
  always #5 clock = ~clock;

  // Reset generation
  initial begin
    #10;
    reset = 0;
    #10;
    reset = 0;
    wEn = 1;
    #10000;
    reset = 0;
    wEn = 1;
    $finish;
  end

  // Monitor for displaying signals
  always @(posedge clock) begin
    // Display relevant signals here for debugging
  end
  // Test cases
  initial begin
    #1000;

    // Test case 1: Write data to memory
    address = 31'h00000067;
    dataWrite = 32'h12345678;
    wEn = 1;
    #10;
    wEn = 0;
    $display("Memory at address %h: DataRead = %h", address, datamem.dataRead);

    // Test case 2: Read data from memory
    address = 32'h00000067;
    wEn = 0;
    #10;
    $display("Memory at address %h: DataRead = %h", address, datamem.dataRead);

    // Test case 3: Reset
    reset = 0;
    address = 32'h1;
    wEn = 0;
    dataWrite = 32'h87654321;
    #10;
    wEn = 0;
    #10;
    reset = 0;
    $display("Memory at address %h: DataRead = %h", address, datamem.dataRead);

    // Test case 4: Default dataRead value
    address = 32'h2;
    wEn = 0;
    #10;
    $display("Memory at address %h: DataRead = %h", address, datamem.dataRead);

    $finish;
  end

endmodule
