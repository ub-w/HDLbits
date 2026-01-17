module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    localparam Idle = 8'b0000_0000, A = 8'b0000_0001, B = 8'b0000_0010, C = 8'b0000_0100, D = 8'b0000_1000, 
    		   E = 8'b0001_0000, F = 8'b0010_0000, G = 8'b0100_0000, H = 8'b1000_0000; 
    reg [7:0] state, next_state;
    
    always@(*)begin
        case(state)
            Idle: next_state = A;
            A: next_state = B;
            B: next_state = x ? C : B;
            C: next_state = ~x ? D : C;
            D: next_state = x ? E : B;
            E: next_state = y ? F : G;
            F: next_state = F;
            G: next_state = y ? F : H;
            H: next_state = H;
            default: next_state = Idle;
        endcase
    end
    
    always@(posedge clk)begin
        if(!resetn)
            state <= Idle;
        else
            state <= next_state;
    end 
    
    assign f = (state == A);
    assign g = (state == F || state == G || state == E);
    
endmodule
