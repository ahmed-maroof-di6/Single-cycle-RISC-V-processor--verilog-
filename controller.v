module controller (
    input [6:0] opcode,
    output reg ALUscr, memToReg, regWrite, memRead, memWrite, branch, 
    output reg [1:0] ALUop
);
    // --------METHOD 1--------
    //assign opcode = instruction[6:0];
    /*
    always @* begin
     if (opcode  == 7'b0110011) begin           // for R-type
      {ALUscr, memToReg, regWrite, memRead, memWrite, branch, ALUop} <= 8'b00100010;
    end else if (opcode == 7'b0000011) begin   // for I-type
      {ALUscr, memToReg, regWrite, memRead, memWrite, branch, ALUop} <= 8'b11110000;
    end else if (opcode == 7'b0100011) begin   // for S-type
      {ALUscr, memToReg, regWrite, memRead, memWrite, branch, ALUop} <= 8'b1x001000;
    end else if (opcode == 7'b1100011) begin   // for SB-type
      {ALUscr, memToReg, regWrite, memRead, memWrite, branch, ALUop} <= 8'b0x000101;
    end   
    end
    */
    // -------METHIOD 2---------  
     always @ (opcode or ALUscr or memToReg or regWrite or memRead or memWrite or branch or ALUop )  
     begin       
       case ( opcode )   
     7'b0110011  :   {ALUscr, memToReg, regWrite, memRead, memWrite, branch, ALUop} <= 8'b00100010;  // for R-type
     7'b0000011  :   {ALUscr, memToReg, regWrite, memRead, memWrite, branch, ALUop} <= 8'b11110000;  // for I-type
     7'b0100011  :   {ALUscr, memToReg, regWrite, memRead, memWrite, branch, ALUop} <= 8'b1x001000;  // for S-type
     7'b1100011  :   {ALUscr, memToReg, regWrite, memRead, memWrite, branch, ALUop} <= 8'b0x000101;  // for SB-type
       endcase          
     end 
  
endmodule