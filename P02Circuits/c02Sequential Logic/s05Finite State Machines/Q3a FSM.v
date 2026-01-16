module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    localparam a = 0, b = 1;
    
    reg state, next_state;
    always@(*)begin
        case(state)
            a: next_state = s ? b : a;
            b: next_state = b;
        endcase
    end
    
    always@(posedge clk)begin
        if(reset)
            state <= 0;
        else
            state <= next_state;
    end
    
    reg [2:0] rec;
    reg [2:0] cnt;
    always@(posedge clk)begin
        if(reset) begin
            rec <= 0;
        end
        else if(next_state) begin
            rec <= {w,rec[2:1]};
        end
    end
    
    always@(posedge clk)begin
        if(reset)
            cnt <= 0;
        else if(state && cnt == 3)begin
            cnt <= 1;
        end
        else if(state)begin
            cnt <= cnt + 1;
        end
    end
    
    assign z = (cnt == 3) ? ((rec == 3'b011) || (rec == 3'b101) || (rec == 3'b110)) : 0;
       
endmodule
