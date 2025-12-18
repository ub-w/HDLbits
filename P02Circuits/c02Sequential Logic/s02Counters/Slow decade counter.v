module top_module (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);
    always@(posedge clk)begin
        if(reset)
            q <= 4'd0;
        else if(slowena == 1 && q == 4'd9)
            q <= 4'd0;
        else if(slowena === 1)
            q <= q + 4'b1;
    end
endmodule