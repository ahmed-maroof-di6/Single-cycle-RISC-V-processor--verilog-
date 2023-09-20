module regFile (
  input clock, reset, wEn,
  input [31:0] write_data,
  input [4:0] read_reg1, read_reg2, write_reg,
  output [31:0] read_data1, read_data2
);

  reg [31:0] reg_file[31:0];
  integer k;
  
always @(posedge clock ) begin
        if (wEn) begin
            reg_file[write_reg] <= write_data;
        end
    end
  
    assign read_data1 = (reset == 0) ? reg_file[read_reg1] : 0;
    assign read_data2 = (reset == 0) ? reg_file[read_reg2] : 0;

    initial begin
        reg_file[6] = 32'h00000007;
        reg_file[5] = 32'h0000000d;    
    end

endmodule