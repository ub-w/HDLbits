module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    genvar i;
    generate
        for(i=0;i<=99;i=i+1)begin:adder
            if(i==0)
                Full_adder inist(a[i],b[i],cin,cout[i],sum[i]);
            else
                Full_adder inist(a[i],b[i],cout[i-1],cout[i],sum[i]);           
        end
    endgenerate

endmodule

module Full_adder( 
    input a, b, cin,
    output cout, sum );
    assign {cout,sum} = a + b + cin;
endmodule