`include "PCfetch.v"
`include "regFile.v"
`include "instrMem.v"
`include "dataMem.v"
`include "ALU.v"
`include "mux.v"
`include "ALUcntrl.v"
`include "controller.v"
`include "immGen.v"

module SCP_RISCV_main (clock, wEn, reset, address);
    input  clock, reset, wEn;
    input  [31:0] address;  

    wire ALUscr, memToReg, regWrite, memRead, memWrite, branch;
    wire [1:0] ALUop1;
    wire [31:0] PC, instruction1, read_data01, read_data02, dataRead1, alu_out1, mux_out1, mux_out2, immGen_out;
    wire [3:0] alu_opcode1 ;


 PCfetch PC1(
        .clock(clock),
        .reset(reset),
        .branch(branch),
        .target_PC(address),
        .PC(PC)       
    );

 instrMem Instmem(
        .address(PC),
        .reset(reset),
        .instruction(instruction1)
    );

 regFile Regfile(
        .clock(clock),
        .reset(reset),
        .wEn(regWrite),
        .write_data(mux_out2),
        .read_reg1(instruction1[19:15]), 
        .read_reg2(instruction1[24:20]), 
        .write_reg(instruction1[11:7]),
        .read_data1(read_data01), 
        .read_data2(read_data02)
    );

 immGen immi_gen (
       .inst(instruction1),
       .GenOut(immGen_out)
);

 mux mux1(
        .sel(ALUscr),
        .in0(immGen_out), 
        .in1(read_data02),
        .mux_out(mux_out1)
    );

 mux mux2(
        .sel(memToReg),
        .in0(dataRead1), 
        .in1(alu_out1),
        .mux_out(mux_out2)
    );

 alu alu1( 
        .alu_opcode(alu_opcode1),
        .in_a(read_data01),
        .in_b(mux_out1), 
        .alu_out(alu_out1) 
    );

 dataMem DataMem(
        .clock(clock),
        .reset(reset),
        .wEn(memWrite),
        .address(alu_out1), 
        .dataWrite(read_data02),
        .dataRead(dataRead1)
    );
    
 ALUcntrl ALUcontrol (
        .ALUop(ALUop1),
        .func7(instruction1[31:25]),
        .func3(instruction1[14:12]),
        .alu_opcode(alu_opcode1)
    );
 
 controller mainController(
        .opcode(instruction1[6:0]),
        .ALUscr(ALUscr), 
        .memToReg(memToReg), 
        .regWrite(regWrite), 
        .memRead(memRead), 
        .memWrite(memWrite), 
        .branch(branch), 
        .ALUop(ALUop1)
);
    
endmodule