module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q ); 
    reg [255:0] q_next;
    integer i,j,di,dj,ni,nj;
    integer live_neighbors;
    integer neighbor_index;
    integer current_index;
    always@(*)begin
        for(i=0; i<=15; i=i+1)begin
            for(j=0; j<=15; j=j+1)begin
                live_neighbors = 0;
                for(di=-1; di<=1; di=di+1)begin
                    for(dj=-1; dj<=1; dj=dj+1)begin
                        if(di==0 && dj==0) continue;
                        ni = (i+di+16)%16;
                        nj = (j+dj+16)%16;
                        neighbor_index = ni*16+nj;
                        if(q[neighbor_index])
                            live_neighbors = live_neighbors + 1;
                    end
                end
                current_index = i*16+j;
                case(live_neighbors)
                    0,1: q_next[current_index] = 1'b0;
                    2: q_next[current_index] = q[current_index];
                    3: q_next[current_index] = 1'b1;
                    default: q_next[current_index] = 1'b0;
                endcase
            end
        end
    end
    always@(posedge clk)begin
        if(load)
            q <= data;
        else
            q <= q_next;
    end                                        
endmodule