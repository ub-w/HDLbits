module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
	localparam A = 6'b000_001, B = 6'b000_010, C = 6'b000_100, D = 6'b001_000, E = 6'b010_000 , F = 6'b100_000;
    reg [6:1] next_state;
    always@(*)begin
        case(y)
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
            default: next_state = A;
        endcase
    end
    assign Y2 = y[1]&~w;
    assign Y4 = y[2]&w || y[3]&w || y[5]&w || y[6]&w;
endmodule
