module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire [3:0] cout;
    genvar i;
    generate
        for(i=0;i<4;i=i+1)begin:Adder4
            if(i == 0)
                adder inist(x[i],y[i],1'b0,cout[i],sum[i]);
            else
                adder inist(x[i],y[i],cout[i-1],cout[i],sum[i]);
        end
        assign sum[4] = cout[3];
    endgenerate
endmodule

module adder(input a, b ,cin,
             output cout,sum);
    assign {cout , sum} = a + b + cin;
endmodule