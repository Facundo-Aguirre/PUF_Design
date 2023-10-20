(* keep_hierarchy = "true"*)module mux(
            input ia,
            input ib,
            input isel,
            output oout
            );
assign oout = (isel) ? ia : ib;
endmodule

