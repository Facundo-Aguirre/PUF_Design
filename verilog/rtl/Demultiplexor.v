(* keep_hierarchy = "true"*)module demux(
            input i,
            input isel,
            output outa,
            output outb);
assign outa = i & isel;
assign outb = i & ~(isel);
endmodule
