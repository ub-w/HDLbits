module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
    assign out_sop = (~a&~b&c) | (c&d);//积之和
    assign out_pos = c & (~a|d) & (~b|d);//和之积
	
endmodule