module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
	parameter left = 6'b000001, right = 6'b000010, left_to_drop = 6'b000100, right_to_drop = 6'b001000, left_to_dig = 6'b010000, right_to_dig = 6'b100000;
    reg [5:0]state, next_state;
    
    //state transition logic
    always@(*)begin
        case(state)
            left: next_state = ground ? (dig ? left_to_dig : (bump_left ? right : left)) : left_to_drop;
            right: next_state = ground ? (dig ? right_to_dig : (bump_right ? left : right)) : right_to_drop;
            left_to_drop: next_state = ground ? left : left_to_drop;
            right_to_drop: next_state = ground ? right : right_to_drop;
            left_to_dig: next_state = ground ? left_to_dig : left_to_drop;
            right_to_dig: next_state = ground ? right_to_dig : right_to_drop;
            default: next_state = state;
        endcase
    end
    
    //state FF
    always@(posedge clk or posedge areset)begin
        if(areset)
            state <= left;
        else
            state <= next_state;
    end
    
    //output logic
    assign walk_left = (state == left);
    assign walk_right = (state == right);
    assign aaah = (state == left_to_drop) || (state == right_to_drop);
    assign digging = (state == left_to_dig) || (state == right_to_dig);
endmodule
