module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output reg [3:0] LEDR
); //
	genvar i;
    generate
        for(i=0;i<4;i=i+1)begin:MUXDFF
            if(i == 0)
            	MUXDFF inist(KEY[0],KEY[3],SW[3-i],KEY[1],KEY[2],LEDR[3-i]);
            else
                MUXDFF inist(KEY[0],LEDR[4-i],SW[3-i],KEY[1],KEY[2],LEDR[3-i]);
        end
    endgenerate
endmodule

module MUXDFF (input clk, input w, R, E, L, output reg Q);
    always@(posedge clk)begin
        Q <= L ? R : (E ? w : Q);
    end
endmodule