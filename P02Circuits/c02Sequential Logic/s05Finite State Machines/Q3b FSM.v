module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output reg z
);
    localparam s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100;
    reg [2:0] state, next_state;
    //transition logic
    always@(*)begin
        case(state)
            s0: next_state = x ? s1 : s0;
            s1: next_state = x ? s4 : s1;
            s2: next_state = x ? s1 : s2;
            s3: next_state = x ? s2 : s1;
            s4: next_state = x ? s4 : s3;
        endcase
    end
    //state ff
    always@(posedge clk)begin
        if(reset)
            state <= s0;
        else
            state <= next_state;
    end
    //output logic
    always@(*)begin
        case(state)
            s0: z = 0;
            s1: z = 0;
            s2: z = 0;
            s3: z = 1;
            s4: z = 1;
        endcase
    end
    
endmodule
