module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output reg [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
        localparam BYTE1 = 4'b0001,
    		   BYTE2 = 4'b0010,
    		   BYTE3 = 4'b0100,
    		   DONE = 4'b1000;
    reg [3:0] state, next_state;

    // State transition logic (combinational)
    always@(*)begin
        case(state)
            BYTE1: begin 
                if(in[3])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: begin
                if(in[3])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
        endcase
    end        		

    // State flip-flops (sequential)
    always@(posedge clk)begin
        if(reset)
            state <= BYTE1;
        else
            state <= next_state;
    end
 
    // Output logic
    assign done = (state == DONE);

    // New: Datapath to store incoming bytes.
    always@(posedge clk)begin
        if(reset)
            out_bytes <= 24'd0;
        else
            out_bytes <= {out_bytes[15:0],in};
    end  

endmodule