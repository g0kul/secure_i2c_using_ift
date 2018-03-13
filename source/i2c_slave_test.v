//`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2018 03:32:00 PM
// Design Name: 
// Module Name: i2c_world_top
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
`include "timescale.v"

//`include "i2c_sys_defines.vh"
`include "i2cSlave.v"

module i2c_world_top
(
    input           {L} clk,
    input           {L} rst,
    input           {L} domain,
    
    input           {Ctrl domain} scl,
    inout           {Ctrl domain} sda
);

    //
    // wires && regs
    //  


    //Params
    wire [6:0] {L} M_SEL_ADDR1 = 7'h10;
    wire [6:0] {L} M_SEL_ADDR2 = 7'h20;
    
    i2cSlave i2c_slave1(
      .clk(clk),
      .rst(rst),
      .domain(domain),

      .i2c_sl_address(7'h10),
      .sda(sda),
      .scl(scl),
      .myReg4(8'h12),
      .myReg5(8'h34),
      .myReg6(8'h56),
      .myReg7(8'h78)
    );
    
    i2cSlave i2c_slave2(
      .clk(clk),
      .rst(rst),
      .domain(domain),

      .i2c_sl_address(7'h20),
      .sda(sda),
      .scl(scl),
      .myReg4(8'h90),
      .myReg5(8'h12),
      .myReg6(8'h34),
      .myReg7(8'h56)
    );
    
    //assign scl = (scl0_oen == 1'b1) ? high_imp : scl0_o;
    //assign sda = (sda0_oen == 1'b1) ? high_imp : sda0_o;
    
    //pullup(scl);    //Non-synthesisable, for behavioral verification.
    //pullup(sda);    //Non-synthesisable, for behavioral verification.

endmodule

