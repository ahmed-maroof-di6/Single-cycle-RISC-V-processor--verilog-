module instrMem (
   input [31:0] address,
   input reset,
   output [31:0] instruction
);
  reg [31:0] inst_mem [1023:0];  // Define a memory array to store instructions

  integer i;

  initial begin
  //  for (i = 0; i < 1023; i = i + 4 ) begin
      // Example R-type instruction: ADD R3, R1, R2 
      inst_mem[0] = 32'h00536823;   //0000 0000 0101 0011 0110 1000 0010 0011 - S
      inst_mem[4] = 32'h00536833;   //0000 0000 0101 0011 0110 1000 0011 0011 - R
      inst_mem[8] = 32'h00536803;   //0000 0000 0101 0011 0110 1000 0000 0011 - I
      inst_mem[12] = 32'h00536863;  //0000 0000 0101 0011 0110 1000 0110 0011 - SB
  // end
  end

  assign instruction = (reset == 1'b1) ? 32'b0 : inst_mem[address];

endmodule
