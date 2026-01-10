module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    localparam idle = 3'b000,
               start = 3'b001,
    		   receive = 3'b010,
               stop = 3'b100;
    reg [2:0] state, next_state;
    reg [7:0] cnt;
    
    //logic transitions
    always@(*)begin
        case(state)
            idle:begin
                if(!in)
                    next_state = start;
                else
                    next_state = idle;
            end
            start: next_state = receive;
            receive:begin
                if(cnt == 8'd7 && in)
                    next_state = stop;
                else if(cnt > 8'd7 && in)
                    next_state = idle;
                else
                    next_state = receive;
            end
            stop:begin
                if(!in)
                    next_state = start;
                else
                    next_state = idle;
            end
        endcase
    end
    
    //FF
    always@(posedge clk)begin
        if(reset)
            state = idle;
        else
            state = next_state;
    end
    
    //cnt logic
    always@(posedge clk)begin
        if(reset)
            cnt <= 8'd0;
        else if(state == receive)
            cnt <= cnt + 1;
        else if(state == start)
            cnt <= 8'd0;
    end
    
    // Output logic
    assign done = (state == stop);
    
endmodule

