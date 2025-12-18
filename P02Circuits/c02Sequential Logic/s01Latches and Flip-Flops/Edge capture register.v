module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    reg [31:0] in_r;
    always@(posedge clk)begin
        in_r <= in;
        if(reset)
            out <= 32'd0;
        else
            out <= (in_r & ~in) | out;//捕获
    end
endmodule