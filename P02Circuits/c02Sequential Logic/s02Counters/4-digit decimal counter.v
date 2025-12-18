module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output reg [15:0] q);
    assign ena[1] = (q[3:0] == 4'd9) ? 1'b1 : 1'b0;
    assign ena[2] = (q[3:0] == 4'd9 && q[7:4] == 4'd9) ? 1'b1 : 1'b0;
    assign ena[3] = (q[3:0] == 4'd9 && q[7:4] == 4'd9 && q[11:8] == 4'd9) ? 1'b1 : 1'b0;
    BCD_cnt counter0(clk, reset, 1'b1, q[3:0]);
    BCD_cnt counter1(clk, reset, ena[1], q[7:4]);
    BCD_cnt counter2(clk, reset, ena[2], q[11:8]);
    BCD_cnt counter3(clk, reset, ena[3], q[15:12]);
endmodule

module BCD_cnt(input clk,
               input reset,
               input ena,
               output reg [3:0]q);
    always@(posedge clk)begin
        if(reset || (q==4'd9 && ena))
            q <= 4'd0;
        else if(ena)
            q <= q+ 4'd1;
        else
            q <= q;
    end
endmodule