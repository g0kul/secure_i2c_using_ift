/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE rev.B2 compliant I2C Master byte-controller       ////
////                                                             ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/projects/i2c/    ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001 Richard Herveille                        ////
////                    richard@asics.ws                         ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: i2c_master_byte_ctrl.v,v 1.8 2009-01-19 20:29:26 rherveille Exp $
//
//  $Date: 2009-01-19 20:29:26 $
//  $Revision: 1.8 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.7  2004/02/18 11:40:46  rherveille
//               Fixed a potential bug in the statemachine. During a 'stop' 2 cmd_ack signals were generated. Possibly canceling a new start command.
//
//               Revision 1.6  2003/08/09 07:01:33  rherveille
//               Fixed a bug in the Arbitration Lost generation caused by delay on the (external) sda line.
//               Fixed a potential bug in the byte controller's host-acknowledge generation.
//
//               Revision 1.5  2002/12/26 15:02:32  rherveille
//               Core is now a Multimaster I2C controller
//
//               Revision 1.4  2002/11/30 22:24:40  rherveille
//               Cleaned up code
//
//               Revision 1.3  2001/11/05 11:59:25  rherveille
//               Fixed wb_ack_o generation bug.
//               Fixed bug in the byte_controller statemachine.
//               Added headers.
//

// synopsys translate_off
`include "timescale.v"
// synopsys translate_on

`include "i2c_master_defines.v"
`include "i2c_master_bit_ctrl.v"


// statemachine
`define ST_IDLE  5'b0_0000
`define ST_START 5'b0_0001
`define ST_READ  5'b0_0010
`define ST_WRITE 5'b0_0100
`define ST_ACK   5'b0_1000
`define ST_STOP  5'b1_0000

module i2c_master_byte_ctrl (
	clk, rst, nReset, domain, domain_i2c, ena, clk_cnt, start, stop, read, write, ack_in, din,
	cmd_ack, ack_out, dout, i2c_busy, i2c_al, scl_i, scl_o, scl_oen, sda_i, sda_o, sda_oen );

	//
	// inputs & outputs
	//
	input 			{L} clk;     // master clock
	input 			{L} rst;     // synchronous active high reset
	input 			{L} nReset;  // asynchronous active low reset
	input 			{L} domain;
	input 			{L} domain_i2c;

	input 			{L} ena;     // core enable signal

	input [15:0] 	{L} clk_cnt; // 4x SCL

	// control inputs
	input       	{L} start;
	input       	{L} stop;
	input       	{L} read;
	input       	{L} write;
	input       	{L} ack_in;
	input [7:0] 	{L} din;

	// status outputs
	output       	{L} cmd_ack;
	reg 			{L} cmd_ack;
	output       	{L} ack_out;
	reg 			{L} ack_out;
	output       	{L} i2c_busy;
	output       	{L} i2c_al;
	output [7:0] 	{L} dout;

	// I2C signals
	input  			{L} scl_i;
	output 			{L} scl_o;
	output 			{L} scl_oen;
	input  			{Ctrl domain_i2c} sda_i;
	output 			{L} sda_o;
	output 			{L} sda_oen;


	//
	// Variable declarations
	//

	// signals for bit_controller
	reg  [3:0] 		{L} core_cmd;
	reg        		{L} core_txd;
	wire       		{L} core_ack;
	wire       		{L} core_rxd;

	// signals for shift register
	reg [7:0] 		{L} sr; //8bit shift register
	reg       		{L} shift;
	reg       		{L} ld;

	// signals for state machine
	wire       		{L} go;
	reg  [2:0] 		{L} dcnt;
	wire       		{L} cnt_done;

	reg [4:0] 		{L} c_state; // synopsys enum_state

	//
	// Module body
	//

	// hookup bit_controller
	i2c_master_bit_ctrl bit_controller (
		.clk     ( clk      ),
		.rst     ( rst      ),
		.nReset  ( nReset   ),
		.domain  ( domain   ),
		.domain_i2c( domain_i2c ),
		.ena     ( ena      ),
		.clk_cnt ( clk_cnt  ),
		.cmd     ( core_cmd ),
		.cmd_ack ( core_ack ),
		.busy    ( i2c_busy ),
		.al      ( i2c_al   ),
		.din     ( core_txd ),
		.dout    ( core_rxd ),
		.scl_i   ( scl_i    ),
		.scl_o   ( scl_o    ),
		.scl_oen ( scl_oen  ),
		.sda_i   ( sda_i    ),
		.sda_o   ( sda_o    ),
		.sda_oen ( sda_oen  )
	);

	// generate go-signal
	assign go = (read | write | stop) & ~cmd_ack;

	// assign dout output to shift-register
	assign dout = sr;

	// generate shift register
	always @(posedge clk or negedge nReset)
	  if (!nReset)
	    sr <= #1 8'h0;
	  else if (rst)
	    sr <= #1 8'h0;
	  else if (ld)
	    sr <= #1 din;
	  else if (shift)
	    sr <= #1 {sr[6:0], core_rxd};

	// generate counter
	always @(posedge clk or negedge nReset)
	  if (!nReset)
	    dcnt <= #1 3'h0;
	  else if (rst)
	    dcnt <= #1 3'h0;
	  else if (ld)
	    dcnt <= #1 3'h7;
	  else if (shift)
	    dcnt <= #1 dcnt - 3'h1;

	assign cnt_done = ~(|dcnt);

	//
	// state machine
	//

	always @(posedge clk or negedge nReset)
	  if (!nReset)
	    begin
	        core_cmd <= #1 `I2C_CMD_NOP;
	        core_txd <= #1 1'b0;
	        shift    <= #1 1'b0;
	        ld       <= #1 1'b0;
	        cmd_ack  <= #1 1'b0;
	        c_state  <= #1 `ST_IDLE;
	        ack_out  <= #1 1'b0;
	    end
	  else if (rst | i2c_al)
	   begin
	       core_cmd <= #1 `I2C_CMD_NOP;
	       core_txd <= #1 1'b0;
	       shift    <= #1 1'b0;
	       ld       <= #1 1'b0;
	       cmd_ack  <= #1 1'b0;
	       c_state  <= #1 `ST_IDLE;
	       ack_out  <= #1 1'b0;
	   end
	else
	  begin
	      // initially reset all signals
	      core_txd <= #1 sr[7];
	      shift    <= #1 1'b0;
	      ld       <= #1 1'b0;
	      cmd_ack  <= #1 1'b0;

	      case (c_state) // synopsys full_case parallel_case
	        `ST_IDLE:
	          if (go)
	            begin
	                if (start)
	                  begin
	                      c_state  <= #1 `ST_START;
	                      core_cmd <= #1 `I2C_CMD_START;
	                  end
	                else if (read)
	                  begin
	                      c_state  <= #1 `ST_READ;
	                      core_cmd <= #1 `I2C_CMD_READ;
	                  end
	                else if (write)
	                  begin
	                      c_state  <= #1 `ST_WRITE;
	                      core_cmd <= #1 `I2C_CMD_WRITE;
	                  end
	                else // stop
	                  begin
	                      c_state  <= #1 `ST_STOP;
	                      core_cmd <= #1 `I2C_CMD_STOP;
	                  end

	                ld <= #1 1'b1;
	            end

	        `ST_START:
	          if (core_ack)
	            begin
	                if (read)
	                  begin
	                      c_state  <= #1 `ST_READ;
	                      core_cmd <= #1 `I2C_CMD_READ;
	                  end
	                else
	                  begin
	                      c_state  <= #1 `ST_WRITE;
	                      core_cmd <= #1 `I2C_CMD_WRITE;
	                  end

	                ld <= #1 1'b1;
	            end

	        `ST_WRITE:
	          if (core_ack)
	            if (cnt_done)
	              begin
	                  c_state  <= #1 `ST_ACK;
	                  core_cmd <= #1 `I2C_CMD_READ;
	              end
	            else
	              begin
	                  c_state  <= #1 `ST_WRITE;       // stay in same state
	                  core_cmd <= #1 `I2C_CMD_WRITE; // write next bit
	                  shift    <= #1 1'b1;
	              end

	        `ST_READ:
	          if (core_ack)
	            begin
	                if (cnt_done)
	                  begin
	                      c_state  <= #1 `ST_ACK;
	                      core_cmd <= #1 `I2C_CMD_WRITE;
	                  end
	                else
	                  begin
	                      c_state  <= #1 `ST_READ;       // stay in same state
	                      core_cmd <= #1 `I2C_CMD_READ; // read next bit
	                  end

	                shift    <= #1 1'b1;
	                core_txd <= #1 ack_in;
	            end

	        `ST_ACK:
	          if (core_ack)
	            begin
	               if (stop)
	                 begin
	                     c_state  <= #1 `ST_STOP;
	                     core_cmd <= #1 `I2C_CMD_STOP;
	                 end
	               else
	                 begin
	                     c_state  <= #1 `ST_IDLE;
	                     core_cmd <= #1 `I2C_CMD_NOP;

	                     // generate command acknowledge signal
	                     cmd_ack  <= #1 1'b1;
	                 end

	                 // assign ack_out output to bit_controller_rxd (contains last received bit)
	                 ack_out <= #1 core_rxd;

	                 core_txd <= #1 1'b1;
	             end
	           else
	             core_txd <= #1 ack_in;

	        `ST_STOP:
	          if (core_ack)
	            begin
	                c_state  <= #1 `ST_IDLE;
	                core_cmd <= #1 `I2C_CMD_NOP;

	                // generate command acknowledge signal
	                cmd_ack  <= #1 1'b1;
	            end

	      endcase
	  end
endmodule
