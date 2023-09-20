
`include "ALU.v"
module alu_tb;

  // Inputs
  reg [3:0] alu_opcode;
  reg [31:0] in_a, in_b;

  // Outputs
  wire [31:0] alu_out;

  // Instantiate the ALU module
  alu alu (
    .alu_opcode(alu_opcode),
    .in_a(in_a),
    .in_b(in_b),
    .alu_out(alu_out)
  );

  // Stimulus
  initial begin
    // Test case 1
    alu_opcode = 4'b0000;
    in_a = 32'hAAAA5555;
    in_b = 32'h5555AAAA;
    #10; // Wait for 10 time units
    $display("ALU Result (AND): %h", alu_out);

    // Test case 2
    alu_opcode = 4'b0001;
    in_a = 32'hAAAA5555;
    in_b = 32'h5555AAAA;
    #10; // Wait for 10 time units
    $display("ALU Result (XOR): %h", alu_out);

    // Add more test cases here...

    $finish; // End simulation
  end
 initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0);
    end
endmodule
