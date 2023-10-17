‘timescale 1ns / 1ps
(* keep_hierarchy = "true"*)module demux(
            input i,
            input isel,
            output outa,
            output outb);
wire outa;
wire outb;
assign outa = i & isel;
assign outb = i & ~(isel);
endmodule