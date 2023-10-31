module demux(i, isel, outa, outb);
    //Inputs and Outputs
    input i, isel;
    output outa, outb;

    //Wires
    wire outa, outb;

    //Demux logi Verilog
    assign outa = i & isel; // Route input i to output a if select signal is high
    assign outb = i & ~(isel); // Route input i to output b if select signal is low

    // Default cases to ensure that outa and outb always have valid values
    //default: assign outa = 1'b0;
    //default: assign outb = 1'b0;
endmodule
