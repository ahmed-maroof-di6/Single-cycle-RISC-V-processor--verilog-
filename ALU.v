module alu ( 
   input [3:0]  alu_opcode,
   input [31:0] in_a , in_b, 
   output reg [31:0] alu_out  
 );
    always @ ( in_a or in_b or alu_opcode or alu_out )  
     begin       
       case ( alu_opcode )   
     4'h0   :  alu_out = in_a & in_b;
     4'h1   :  alu_out = in_a | in_b;
     4'h2   :  alu_out = in_a + in_b;
     4'h6   :  alu_out = in_a - in_b;   
       endcase          
     end 
  
 endmodule 