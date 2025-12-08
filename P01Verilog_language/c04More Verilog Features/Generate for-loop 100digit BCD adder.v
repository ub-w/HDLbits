module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output reg [399:0] sum );
	genvar i;
    reg [99:0] cout_temp;
    generate
        for(i=0;i<=399;i=i+4)begin:adder
            if(i==0)
                bcd_fadd inist({a[i+3],a[i+2],a[i+1],a[i]},{b[i+3],b[i+2],b[i+1],b[i]},
                               cin,cout_temp[i/4],{sum[i+3],sum[i+2],sum[i+1],sum[i]});
            else
                bcd_fadd inist({a[i+3],a[i+2],a[i+1],a[i]},{b[i+3],b[i+2],b[i+1],b[i]},
                               cout_temp[i/4-1],cout_temp[i/4],{sum[i+3],sum[i+2],sum[i+1],sum[i]});
        end
    endgenerate
    assign cout = cout_temp[99];
endmodule
