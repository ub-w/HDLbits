module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output reg z);
    localparam A = 6'b000_001, B = 6'b000_010, C = 6'b000_100, D = 6'b001_000, E = 6'b010_000 , F = 6'b100_000;
    reg [6:1] state, next_state;
    always@(*)begin
        case(state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
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
