‘timescale 1ns / 1ps
module ring(
            input [31:0]challenge,
            input reset,
            output response
            );
(*keep = "true"*) wire [96 : 0]net;
assign net[0] = net[96];
generate
genvar i;
for (i = 1; i <= 32; i = i + 1)
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
assign response = net[48];
endmodule                
