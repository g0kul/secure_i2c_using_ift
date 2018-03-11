`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
//
// Verilog Test Fixture created by ISE 14.7 for module: I2C_master
//
////////////////////////////////////////////////////////////////////////////////

module i2c_master_tb;

// Inputs
reg sys_clock;
reg reset;
reg [31:0] ctrl_data;
reg wr_ctrl;

// Outputs
wire [31:0] status;

// Bidirs
wire SDA;
wire SCL;

pullup (SDA);
pullup (SCL);

// Instantiate the Unit Under Test (UUT)
I2C_master
#(
  .freq         (100)
)
 uut
(
  .SDA          (SDA),
  .SCL          (SCL),
  .sys_clock    (sys_clock),
  .reset        (reset),
  .ctrl_data    (ctrl_data),
  .wr_ctrl      (wr_ctrl),
  .status       (status)
);

initial begin
  // Initialize Inputs
  sys_clock = 0;
  reset = 1;
  // Write 'h44 to register 'h55 in I2C slave 'h66
  ctrl_data = 32'h00665544;
  wr_ctrl = 0;
  // Wait 100 ns for global reset to finish
  #101;
  reset = 0;
  // Add stimulus here
  #220000
  @ (posedge sys_clock) wr_ctrl <= #1 1;
  @ (posedge sys_clock) wr_ctrl <= #1 0;
end

always sys_clock = #5 !sys_clock;

endmodule

