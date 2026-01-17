module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output reg z);
    localparam A = 6'b000_001, B = 6'b000_010, C = 6'b000_100, D = 6'b001_000, E = 6'b010_000 , F = 6'b100_000;
    reg [6:1] state, next_state;
    always@(*)begin
        case(state)
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
            default: next_state = A;
        endcase
    end
    always@(posedge clk)begin
        if(reset)
            state <= A;
        else
            state <= next_state;
    end
    always@(*)begin
        case(state)
            A: z = 0;
            B: z = 0;
            C: z = 0;
            D: z = 0;
            E: z = 1;
            F: z = 1;
        endcase
    end
endmodule
