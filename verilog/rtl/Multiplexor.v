\‘timescale 1ns / 1ps
(* keep_hierarchy = "true"*)module mux(
            input ia,
            input ib,
            input isel,
            output oout
            );
wire oout;
assign oout = (isel) ? ia : ib;
endmodule
