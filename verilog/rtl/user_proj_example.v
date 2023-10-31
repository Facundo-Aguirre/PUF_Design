// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [37:0] io_in,
    output [37:0] io_out,
    output [37:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    wire clk;
    wire rst;

    wire [BITS-1:0] rdata; 
    wire [BITS-1:0] wdata;

    wire valid;
    wire [3:0] wstrb;

    // WB MI A
    assign valid = wbs_cyc_i && wbs_stb_i; 
    assign wstrb = wbs_sel_i & {4{wbs_we_i}};
    assign wbs_dat_o = {{(32-BITS){1'b0}}, rdata};
    assign wdata = wbs_dat_i[BITS-1:0];
    assign rdata={(32){1'b0}};
    // IO
    assign io_oeb[37:6] = {(32){1'b1}};
    assign io_oeb[5] = 1'b0;
    assign io_oeb[4:0]={(5){1'b1}};

    // IRQ
    assign irq = 3'b000;	// Unused

    // LA
    assign la_data_out = {(128){1'b0}};
    assign clk = wb_clk_i;
    assign rst = wb_rst_i;
    

    wire [31:0] rsp;
   // assign io_out[5]= ^rsp;
    assign io_out[5]= rsp[5];
    assign io_out[37:6]={(32){1'b0}};
    assign io_out[4:0]={(5){1'b0}};

    BR_PUF PUF1(
            .challenge(io_in[31:0]),
            .reset(rst),
            .rsp(rsp));
    /*WrapPUF #(
        .BITS(BITS)
    ) WrapPUF(
        .clk(clk),
        .reset(rst),
        .ready(wbs_ack_o),
        .valid(valid),
        .rdata(rdata),
        .wdata(wbs_dat_i),
        .wstrb(wstrb),
        .io_in(io_in),
        .io_out(io_out));
    */

endmodule

module WrapPUF #(
    parameter BITS = 32
)(
    input clk,
    input reset,
    input valid,
    input [3:0] wstrb,
    input [37:0] io_in,
    input [31:0] wdata,
    output reg ready,
    output reg [31:0] rdata,
    output [37:0] io_out
);

wire [31:0] rsp;
assign io_out[5]= ^rsp;
assign rdata={(32){1'b0}};
assign ready={1'b0};
assign io_out[37:6]={(32){1'b0}};
assign io_out[4:0]={(5){1'b0}};

BR_PUF PUF1(
            .challenge(io_in[37:6]),
            .reset(reset),
            .rsp(rsp));

    //always @(posedge clk) begin
        //if (reset) begin
          //  count <= 0;
           // ready <= 0;
        //end else begin
            //ready <= 1'b0;
            //if (~|la_write) begin
               // count <= count + 1;
            //end
            //if (valid && !ready) begin
                //ready <= 1'b1;
                //rdata <= count;
               // if (wstrb[0]) count[7:0]   <= wdata[7:0];
               // if (wstrb[1]) count[15:8]  <= wdata[15:8];
            //end else if (|la_write) begin
              //  count <= la_write & la_input;
           // end
        //end
    //end

endmodule
`default_nettype wire
