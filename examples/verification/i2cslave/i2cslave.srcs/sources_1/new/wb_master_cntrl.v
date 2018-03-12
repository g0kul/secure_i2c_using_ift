`include "timescale.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2018 11:11:18 PM
// Design Name: 
// Module Name: wb_master_cntrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module wb_master_cntrl
    #(
        parameter dwidth = 32;
        parameter awidth = 32;
    )
    (
        input                   clk,
        input                   rst,
        output [awidth-1:0]     adr,
        input  [dwidth-1:0]     din,
        output [dwidth-1:0]     dout,
        output                  cyc,
        output                  stb,
        output                  we,
        output [(dwidth/8)-1:0] sel
    );
endmodule
