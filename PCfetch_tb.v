`include "PCfetch.v"
module PCfetch_tb;

   reg clock;
   reg reset;
   reg branch;
   reg [31:0] target_PC;
   wire [31:0] PC;

   PCfetch pc_fetch (
      .clock(clock),
      .reset(reset),
      .branch(branch),
      .target_PC(target_PC),
      .PC(PC)
   );

   initial begin
      clock = 0;
     
      reset = 0; branch = 0; target_PC = 0;
      
      #10;  // Wait for a few clock cycles
      $display("Instruction at address %h, PC = %h", target_PC, PC);
      // Test case 1: Normal operation with target_PC, PC should update
      reset = 0; branch = 1; target_PC = 32'h1234;  
      #10;
      if (PC !== 32'h1234) $display("Test case 1 failed");
      $display("Instruction at address %h, PC = %h", target_PC, PC);
      // Test case 2: Reset, PC should be 0
      reset = 1; branch = 0; target_PC = 32'h1309;
      #10;
      if (PC !== 0) $display("Test case 2 failed");
      $display("Instruction at address %h, PC = %h", target_PC, PC);
      
      // Test case 3: Branch should set plus 4 to PC 
      reset = 0;  branch = 0; target_PC = 32'h5678; 
      #10;
      if (PC !== 4) $display("Test case 3 failed");
      $display("Instruction at address %h, PC = %h", target_PC, PC);
     
      // Test case 4: Branch 1 should set PC to target PC 
      reset = 0;  branch = 1; target_PC = 32'h5674; 
      #10;
      if (PC !== 32'h5674) $display("Test case 3 failed");
      $display("Instruction at address %h, PC = %h", target_PC, PC);
     
     // Test case 5:  Branch 0 should set plus 4 to PC 
      reset = 0;  branch = 0; target_PC = 32'h5674; 
      #10;
      if (PC !== 32'h5678) $display("Test case 3 failed");
      $display("Instruction at address %h, PC = %h", target_PC, PC);
     
      $display("Test Passed!");
      $finish;
   end

   always #5 clock = ~clock;

endmodule
