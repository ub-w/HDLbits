module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
	localparam NONE = 10'b00000_00001,
               ONE = 10'b00000_00010,
               TWO = 10'b00000_00100,
    		   THREE = 10'b00000_01000,
    		   FOUR = 10'b00000_10000,
    		   FIVE = 10'b00001_00000,
    		   SIX = 10'b00010_00000,
      		   ERROR = 10'b00100_00000,
    		   DISCARD = 10'b01000_00000,
    		   FLAG = 10'b10000_00000;
    reg [9:0] state, next_state;
    //transition logic
    always@(*)begin
        case(state)
            NONE: next_state = in ? ONE : NONE;
            ONE: next_state = in ? TWO : NONE;
            TWO: next_state = in ? THREE : NONE;
            THREE: next_state = in ? FOUR : NONE;
            FOUR: next_state = in ? FIVE : NONE;
            FIVE: next_state = in ? SIX : DISCARD;
            SIX: next_state = in ? ERROR : FLAG;
            ERROR: next_state = in ? ERROR : NONE;
            DISCARD: next_state = in ? ONE : NONE;
            FLAG: next_state = in ? ONE : NONE;
        endcase
    end
    
    //state FF
    always@(posedge clk)begin
        if(reset)
            state = NONE;
        else
            state = next_state;
    end
    
    //output logic
    assign disc = (state == DISCARD);
    assign flag = (state == FLAG);
    assign err = (state == ERROR);
     
endmodule