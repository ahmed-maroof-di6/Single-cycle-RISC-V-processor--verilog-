module immGen (
   input [31:0] inst,
   output reg [31:0] GenOut
);

   // Concatenate the bits as intended
   always @* begin
      
   if (inst[5]) begin
    GenOut = (inst[31] == 1'b1) ? {{20{1'b1}}, inst[31:25], inst[11:7]} : {{20{1'b0}}, inst[31:25], inst[11:7]};
   end else begin
    GenOut = (inst[31] == 1'b1) ? {{20{1'b1}}, inst[31:20]} : {{20{1'b0}}, inst[31:20]};
   end
   end

endmodule
