module mux(ia, ib, isel, oout);
    //Inputs and Outputs
    input ia, ib, isel;
    output oout;

    //Wires
    wire oout;

    //Multiplexor Logic Verilog
    assign oout = (isel) ? ia : ib; // Select between input a and input b based on the select signal

    // Default case to ensure that oout always has a valid value
    //default: assign oout = 1'b0;
endmodule
