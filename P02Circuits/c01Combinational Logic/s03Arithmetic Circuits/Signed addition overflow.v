module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
    assign s = a + b;
    wire a_sign = a[7];
    wire b_sign = b[7];
    wire s_sign = s[7];
    
    assign overflow = (a_sign & b_sign & ~s_sign) | (~a_sign & ~b_sign & s_sign);

endmodule