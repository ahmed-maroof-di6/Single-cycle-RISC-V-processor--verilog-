module mux (
input sel,
input [31:0] in0, in1,
output [31:0] mux_out
);

assign  mux_out = (sel) ? in0 : in1;

endmodule