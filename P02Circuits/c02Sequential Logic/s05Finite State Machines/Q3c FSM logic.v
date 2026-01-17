module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output reg z
);
    localparam s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100;
    reg [2:0] next_state;
    //transition logic
    always@(*)begin
        case(y)
            s0: next_state = x ? s1 : s0;
            s1: next_state = x ? s4 : s1;
            s2: next_state = x ? s1 : s2;
            s3: next_state = x ? s2 : s1;
            s4: next_state = x ? s4 : s3;
        endcase
    end
    //output logic
    always@(*)begin
        case(y)
            s0: z = 0;
            s1: z = 0;
            s2: z = 0;
            s3: z = 1;
            s4: z = 1;
        endcase
    end
    assign Y0 = next_state[0];
 
endmodule
