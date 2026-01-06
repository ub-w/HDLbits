module top_module(
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
    always@(*)begin
        if(state == A)begin
            case(in)
                0: next_state = A;
                1: next_state = B;
            endcase
        end
        if(state == B)begin
            case(in)
                0: next_state = C;
                1: next_state = B;
            endcase
        end
        if(state == C)begin
            case(in)
                0: next_state = A;
                1: next_state = D;
            endcase
        end
        if(state == D)begin
            case(in)
                0: next_state = C;
                1: next_state = B;
            endcase
        end
    end

    // Output logic:  out = f(state) for a Moore state machine
    assign out = (state == D);

endmodule