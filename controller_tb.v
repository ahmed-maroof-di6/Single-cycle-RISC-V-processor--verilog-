`include "controller.v"
`timescale 1ns / 1ps

module tb_controller;

    reg [6:0] opcode;
    wire ALUscr, memToReg, regWrite, memRead, memWrite, branch;
    wire [1:0] ALUop;

    // Instantiate the controller module
    controller controller_inst (
        .opcode(opcode),
        .ALUscr(ALUscr), .memToReg(memToReg), .regWrite(regWrite),
        .memRead(memRead), .memWrite(memWrite), .branch(branch), .ALUop(ALUop)
    );

    initial begin
        $monitor("opcode=%b, ALUscr=%b, memToReg=%b, regWrite=%b, memRead=%b, memWrite=%b, branch=%b, ALUop=%b",
                 opcode, ALUscr, memToReg, regWrite, memRead, memWrite, branch, ALUop);

        // Test R-type opcode
        opcode = 7'b0110011;
        #10;

        // Test I-type opcode
        opcode = 7'b0000011;
        #10;

        // Test S-type opcode
        opcode = 7'b0100011;
        #10;

        // Test SB-type opcode
        opcode = 7'b1100011;
        #10;

        $finish;
    end

endmodule
