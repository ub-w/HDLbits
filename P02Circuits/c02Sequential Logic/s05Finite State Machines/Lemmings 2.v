module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
	parameter left = 4'b0001, right = 4'b0010, left_to_drop = 4'b0100, right_to_drop = 4'b1000;
    reg [3:0]state, next_state;
    
    //state transition logic
    always@(*)begin
        case(state)
            left: next_state = ground ? (bump_left ? right : left) : left_to_drop;
            right: next_state = ground ? (bump_right ? left : right) : right_to_drop;
            left_to_drop: next_state = ground ? left : left_to_drop;
            right_to_drop: next_state = ground ? right : right_to_drop;
            default: next_state = state;
        endcase
    end
    
    //state FF
    always@(posedge clk or posedge areset)begin
        if(areset)begin
            state <= left;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign walk_left = (state == left);
    assign walk_right = (state == right);
    assign aaah = (state == left_to_drop) || (state == right_to_drop);
    
endmodule