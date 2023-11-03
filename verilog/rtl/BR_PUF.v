
module BR_PUF(
input [31:0] challenge,
input reset,
output [31:0] rsp);

wire [31:0] net;

generate
    genvar i;
        for (i = 1; i <= 32; i = i + 1)
    begin : puf_block
        ring inst_ring_i(.challenge(challenge),
        .reset(reset),
        .rsp(net[i-1]));
    end
endgenerate

assign rsp = net;
endmodule


/*

module BR_PUF(
            input [31:0] challenge,
            input reset,
            output [31:0] rsp);
wire [31:0] x;
/*generate
genvar i;
for (i = 1; i <= 32; i = i + 1)
begin
ring inst_ring(.challenge(challenge),
            .reset(reset),
            .response(net[i-1])
            );
end
endgenerate


ring inst_ring(.challenge(challenge),
            .reset(reset),
            .rsp(x[0]));

assign rsp = {{(31){1'b0}},x[0]};
endmodule


*/