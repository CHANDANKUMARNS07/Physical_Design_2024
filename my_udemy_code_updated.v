module my_module (
in,
clk,
out
);

// primary inputs
input in;
input clk;

// primary outputs
output out;

// wires
wire n1;
wire n2;
wire n3;
wire n4;
wire n5;
wire n6;
wire in;
wire clk;
wire out;
wire c1;
wire c2;
wire c3;
wire c4;
wire c4_1;
wire c4_2;
wire c4_3;
wire c4_4;

// cells
my_dff_xsize80 f1 (.d(in), .ck(c4), .q(n1));
my_inv_xsize1 u3 (.a(n1), .o(n2));
my_inv_xsize2 u4 (.a(n2), .o(n3));
my_nand2_xsize1 u6 ( .a(n1), .b(n3), .o(n4));
my_nand4_xsize1 u5 ( .a(n3), .b(n2), .o(n5));
my_nor2_xsize1 u7 ( .a(n4), .b(n5), .o(n6) );
my_dff_xsize80 f2 ( .d(n6), .ck(c2), .q(out) );

//clock path
my_inv_xsize1 u8 (.a(clk), .o(c1));
my_inv_xsize1 u9 (.a(c1), .o(c2));
my_inv_xsize1 u10 (.a(c2), .o(c3));
my_inv_xsize1 u11 (.a(c3), .o(c4_1));
my_inv_xsize1 u12 (.a(c4_1), .o(c4_2));
my_inv_xsize1 u13 (.a(c4_2), .o(c4_3));
my_inv_xsize1 u14 (.a(c4_3), .o(c4_4));
my_inv_xsize1 u15 (.a(c4_4), .o(c4));

endmodule


