`include "ALUcntrl.v"
module ALUcntrl_tb;

    reg [1:0] ALUop_tb;
    reg [6:0] func7_tb;
    reg [2:0] func3_tb;
    wire [3:0] alu_opcode_tb;

    ALUcntrl uut (
        .ALUop(ALUop_tb),
        .func7(func7_tb),
        .func3(func3_tb),
        .alu_opcode(alu_opcode_tb)
    );

    initial begin
        $monitor("ALUop = %b, func7 = %b, func3 = %b, alu_opcode = %b", ALUop_tb, func7_tb, func3_tb, alu_opcode_tb);

        // Test all conditions
        ALUop_tb = 2'b00; func7_tb = 7'b1; func3_tb = 3'b0; #20;
        ALUop_tb = 2'b01; func7_tb = 7'b0; func3_tb = 3'bx; #20;
        ALUop_tb = 2'b10; func7_tb = 7'b0; func3_tb = 3'b0; #20;
        ALUop_tb = 2'b10; func7_tb = 7'b0100000; func3_tb = 3'b0; #20;
        ALUop_tb = 2'b10; func7_tb = 7'b0; func3_tb = 3'b111; #20;
        ALUop_tb = 2'b10; func7_tb = 7'b0; func3_tb = 3'b110; #20;

        $finish;
    end

endmodule
