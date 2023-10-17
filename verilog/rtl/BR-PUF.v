‘timescale 1ns / 1ps
module BR_PUF(
            input [31:0] challenge,
            input reset,
            output [31:0] response
            );
(*keep = "true"*)wire [31:0] net;
generate
genvar i;
for (i = 1; i <= 32; i = i + 1)
begin
ring inst_ring(.challenge(challenge),
            .reset(reset),
            .response(net[i-1])
            );
end
endgenerate
assign response = net;
endmodule