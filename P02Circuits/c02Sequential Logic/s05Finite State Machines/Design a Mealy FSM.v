module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    localparam s0 = 3'b001,
    		   s1 = 3'b010,
    		   s2 = 3'b100;
    reg [2:0] state, next_state;
    
    //transition logic
    always@(*)begin
        case(state)
            s0: next_state = x ? s1 : s0;
            s1: next_state = x ? s1 : s2;
            s2: next_state = x ? s1 : s0;
        endcase
    end
    
    //state ff
    always@(posedge clk or negedge aresetn)begin
        if(!aresetn)
            state <= s0;
        else
            state <= next_state;
    end
    
    //ouput logic
    assign z = (state == s2) ? (x ? 1 : 0) : 0; 
    

endmodule