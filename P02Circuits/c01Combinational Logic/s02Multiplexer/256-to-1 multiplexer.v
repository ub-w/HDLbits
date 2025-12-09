module top_module( 
    input [255:0] in,
    input [7:0] sel,
    output out );
    assign out = (sel>=8'd0&&sel<=8'd255) ? in[sel] : 0;
endmodule