module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0]min_temp1;
    wire [7:0]min_temp2;
    assign min_temp1 = (a<b)?a:b;
    assign min_temp2 = (min_temp1<c)?min_temp1:c;
    assign min = (min_temp2<d)?min_temp2:d;
endmodule