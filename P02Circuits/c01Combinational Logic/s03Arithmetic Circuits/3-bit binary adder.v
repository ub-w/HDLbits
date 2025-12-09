module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
	genvar i;
    generate
        for(i=0;i<3;i=i+1)begin:adder3
        if(i == 0)
            adder inist(a[i],b[i],cin,cout[i],sum[i]);
        else
            adder inist(a[i],b[i],cout[i-1],cout[i],sum[i]);
        end
    endgenerate    
endmodule
module adder(input a,b,cin,
            output cout,sum);
    assign {cout,sum} = a + b + cin;
endmodule