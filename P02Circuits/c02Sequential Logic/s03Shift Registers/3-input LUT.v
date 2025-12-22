module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output reg Z ); 
    reg [7:0] q;
    always@(posedge clk)begin
        if(enable)
            q <= {q[6:0],S};
        else
            q <= q;
    end
    always@(*)begin
        case({A, B, C})
            3'b000: Z = q[0];
            3'b001: Z = q[1];
            3'b010: Z = q[2];
            3'b011: Z = q[3];
            3'b100: Z = q[4];
            3'b101: Z = q[5];
            3'b110: Z = q[6];
            3'b111: Z = q[7];
        endcase
    end
    // 组合逻辑：LUT输出（用三元运算符替代case，更简洁）
    //assign Z = q[{A,B,C}];  // 直接用3位地址{A,B,C}索引q，等价于case逻辑
endmodule