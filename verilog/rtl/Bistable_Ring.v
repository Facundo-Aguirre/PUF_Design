module ring(
            input [31:0]challenge,
            input reset,
            output rsp);
wire [96:0] x;
wire high;
wire test;
assign high = 1'b1;
assign test = challenge[0];
 
//assign net[0] = net[96];


/*generate
genvar i;
for (i = 1; i <= 31; i = i + 1)
begin
    demux inst_demux(
                        .i(net[i * 3 - 3]),
                        .isel(challenge[i - 1]),
                        .outa(net[i * 3 - 2]),
                        .outb(net[i * 3 - 1])
                        );
                        
    mux inst_mux(
                        .ia(~(net[i * 3 - 2]|reset)),
                        .ib(~(net[i * 3 - 1]|reset)),
                        .isel(challenge[i - 1]),
                        .oout(net[i * 3])
                       );
                  
        end
    endgenerate
   */ 
demux inst_demux(
                        .i(test),
                        .isel(test),
                        .outa(x[1 * 3 - 2]),
                        .outb(x[1 * 3 - 1]));
mux inst_mux(
                        .ia(test),
                        .ib(high),
                        .isel(test),
                        .oout(x[3]));
//assign response = net[48];
//assign rsp = 1'b0;
assign rsp = x[3];
endmodule                
