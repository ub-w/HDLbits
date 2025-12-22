module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output reg out);
    reg in_r1,in_r2,in_r3;
    always@(posedge clk)begin
        if(!resetn) begin
            in_r1 <= 1'b0;
            in_r2 <= 1'b0;
            in_r3 <= 1'b0;
            out <= 1'b0;
        end
        else begin
            in_r1 <= in;
            in_r2 <= in_r1;
            in_r3 <= in_r2;
            out <= in_r3;
        end
    end
endmodule