module top_module(
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] sum
);
    wire cout;
    reg [15:0]sum0,sum1;
    add16 inist0(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(cout));
    add16 inist1(.a(a[31:16]), .b(b[31:16]), .cin(1'b0), .sum(sum0[15:0]), .cout());
    add16 inist2(.a(a[31:16]), .b(b[31:16]), .cin(1'b1), .sum(sum1[15:0]), .cout());
    always@(*)
    begin
        case(cout)
            1'b0: sum[31:16] <= sum0[15:0];
            1'b1: sum[31:16] <= sum1[15:0];
        endcase
    end
endmodule
