//////////////////////////////////////////////////////////////////////
////                                                              ////
//// i2cSlave.v                                                   ////
////                                                              ////
//// This file is part of the i2cSlave opencores effort.
//// <http://www.opencores.org/cores//>                           ////
////                                                              ////
//// Module Description:                                          ////
//// You will need to modify this file to implement your 
//// interface.
////                                                              ////
//// To Do:                                                       ////
//// 
////                                                              ////
//// Author(s):                                                   ////
//// - Steve Fielding, sfielding@base2designs.com                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2008 Steve Fielding and OPENCORES.ORG          ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE. See the GNU Lesser General Public License for more  ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from <http://www.opencores.org/lgpl.shtml>                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//`include "i2cSlave_define.v"
`include "serialInterface.v"
`include "registerInterface.v"

module i2cSlave (
  clk,
  rst,
  domain,
  i2c_sl_address,
  sda,
  scl,
  myReg0,
  myReg1,
  myReg2,
  myReg3,
  myReg4,
  myReg5,
  myReg6,
  myReg7
);

input                   {L} clk;
input                   {L} rst;
input                   {L} domain;
input  [6:0]            {L} i2c_sl_address;

inout                   {Ctrl domain} sda;
input                   {Ctrl domain} scl;
output [7:0]            {Data domain} myReg0;
output [7:0]            {Data domain} myReg1;
output [7:0]            {Data domain} myReg2;
output [7:0]            {Data domain} myReg3;
input [7:0]             {Data domain} myReg4;
input [7:0]             {Data domain} myReg5;
input [7:0]             {Data domain} myReg6;
input [7:0]             {Data domain} myReg7;


// local wires and regs
reg                     {Ctrl domain} sdaDeb;
reg                     {Ctrl domain} sclDeb;
reg [9:0]  {Ctrl domain} sdaPipe;
reg [9:0]  {Ctrl domain} sclPipe;

reg [9:0]  {Ctrl domain} sclDelayed;
reg [9:0]  {Ctrl domain} sdaDelayed;
reg [1:0]               {Ctrl domain} startStopDetState;
wire                    {Ctrl domain} clearStartStopDet;
wire                    {Ctrl domain} sdaOut;
wire                    {Ctrl domain} sdaIn;
wire [7:0]              {Ctrl domain} regAddr;
wire [7:0]              {Data domain} dataToRegIF;
wire                    {Ctrl domain} writeEn;
wire [7:0]              {Data domain} dataFromRegIF;
reg [1:0]               {Ctrl domain} rstPipe;
wire                    {Ctrl domain} rstSyncToClk;
reg                     {Ctrl domain} startEdgeDet;

assign sda = (sdaOut == 1'b0) ? 1'b0 : 1'bz;
assign sdaIn = sda;

// sync rst rsing edge to clk
always @(posedge clk) begin
  if (rst == 1'b1)
    rstPipe <= 2'b11;
  else
    rstPipe <= {rstPipe[0], 1'b0};
end

assign rstSyncToClk = rstPipe[1];

// debounce sda and scl
always @(posedge clk) begin
  if (rstSyncToClk == 1'b1) begin
    sdaPipe <= {10{1'b1}};
    sdaDeb <= 1'b1;
    sclPipe <= {10{1'b1}};
    sclDeb <= 1'b1;
  end
  else begin
    sdaPipe <= {sdaPipe[8:0], sdaIn};
    sclPipe <= {sclPipe[8:0], scl};
    // if (&sclPipe[9:1] == 1'b1)
    if (sclPipe[9] == 1'b1)
      sclDeb <= 1'b1;
    // else if (|sclPipe[9:1] == 1'b0)
    else if (sclPipe[9] == 1'b0)
      sclDeb <= 1'b0;
    // if (&sdaPipe[9:1] == 1'b1)
    if (sdaPipe[9] == 1'b1)
      sdaDeb <= 1'b1;
    // else if (|sdaPipe[9:1] == 1'b0)
    else if (sdaPipe[9] == 1'b0)
      sdaDeb <= 1'b0;
  end
end


// delay scl and sda
// sclDelayed is used as a delayed sampling clock
// sdaDelayed is only used for start stop detection
// Because sda hold time from scl falling is 0nS
// sda must be delayed with respect to scl to avoid incorrect
// detection of start/stop at scl falling edge. 
always @(posedge clk) begin
  if (rstSyncToClk == 1'b1) begin
    sclDelayed <= {10{1'b1}};
    sdaDelayed <= {10{1'b1}};
  end
  else begin
    sclDelayed <= {sclDelayed[8:0], sclDeb};
    sdaDelayed <= {sdaDelayed[8:0], sdaDeb};
  end
end

// start stop detection
always @(posedge clk) begin
  if (rstSyncToClk == 1'b1) begin
    startStopDetState <= 2'b00;
    startEdgeDet <= 1'b0;
  end
  else begin
    if (sclDeb == 1'b1 && sdaDelayed[8] == 1'b0 && sdaDelayed[9] == 1'b1)
      startEdgeDet <= 1'b1;
    else
      startEdgeDet <= 1'b0;
    if (clearStartStopDet == 1'b1)
      startStopDetState <= 2'b00;
    else if (sclDeb == 1'b1) begin
      if (sdaDelayed[8] == 1'b1 && sdaDelayed[9] == 1'b0) 
        startStopDetState <= 2'b10;
      else if (sdaDelayed[8] == 1'b0 && sdaDelayed[9] == 1'b1)
        startStopDetState <= 2'b01;
    end
  end
end


registerInterface u_registerInterface(
  .clk(clk),
  .domain(domain),
  .addr(regAddr),
  .dataIn(dataToRegIF),
  .writeEn(writeEn),
  .dataOut(dataFromRegIF),
  .myReg0(myReg0),
  .myReg1(myReg1),
  .myReg2(myReg2),
  .myReg3(myReg3),
  .myReg4(myReg4),
  .myReg5(myReg5),
  .myReg6(myReg6),
  .myReg7(myReg7)
);

serialInterface u_serialInterface (
  .clk(clk), 
  .rst(rstSyncToClk | startEdgeDet), 
  .domain(domain),
  .i2c_sl_address(i2c_sl_address),
  .dataIn(dataFromRegIF), 
  .dataOut(dataToRegIF), 
  .writeEn(writeEn),
  .regAddr(regAddr), 
  .scl(sclDelayed[9]), 
  .sdaIn(sdaDeb), 
  .sdaOut(sdaOut), 
  .startStopDetState(startStopDetState),
  .clearStartStopDet(clearStartStopDet) 
);


endmodule


 
