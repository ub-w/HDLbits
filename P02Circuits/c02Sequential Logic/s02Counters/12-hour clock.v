module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    wire [6:1] enable;
    wire [7:0] hh_r;
    assign enable[1] = ena;
    assign enable[2] = (ss[3:0] == 4'd9) & ena;
    counter #(.start(4'd0),.endd(4'd9)) ss9(clk , reset, enable[1], ss[3:0]);
    counter #(.start(4'd0),.endd(4'd5)) ss5(clk , reset, enable[2], ss[7:4]);
    assign enable[3] = (ss[7:4] == 4'd5) & enable[2];
    assign enable[4] = (mm[3:0] == 4'd9) & enable[3];
    counter #(.start(4'd0),.endd(4'd9)) mm9(clk , reset, enable[3], mm[3:0]);
    counter #(.start(4'd0),.endd(4'd5)) mm5(clk , reset, enable[4], mm[7:4]);
    assign enable[5] = (mm[7:4] == 4'd5) & enable[4];
    assign enable[6] = (hh_r[3:0] == 4'hb) & enable[5];
    counter #(.start(4'h0),.endd(4'hb)) hh12(clk , reset, enable[5], hh_r[3:0]);
    counter #(.start(4'h0),.endd(4'h1)) hh2(clk , reset, enable[6], hh_r[7:4]);

    assign pm = (hh_r[7:4] == 4'h1);
    assign hh = (hh_r[3:0] == 4'h0) ? 8'h12: (hh_r[3:0] > 4'h9) ? {4'h1, hh_r[3:0] - 4'ha} : {4'h0, hh_r[3:0]};

endmodule

module counter(
	input clk,
	input reset,
	input ena,
    output reg [3:0] q);
parameter start = 4'h0;
parameter endd = 4'hf;
    always@(posedge clk)begin
        if(reset)
            q <= start;
        else if(ena) begin
            if(q == endd)
                q <= start;
            else
                q <= q + 1;
        end
    end
endmodule