`include "timescale.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2018 11:04:09 PM
// Design Name: 
// Module Name: i2c_sys_top
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

//`include "i2c_sys_defines.vh"

`define PRER_LO 3'b000
`define PRER_HI 3'b001
`define CTR     3'b010
`define RXR     3'b011
`define TXR     3'b011
`define CR      3'b100
`define SR      3'b100

`define TXR_R   3'b101 // undocumented / reserved output
`define CR_R    3'b110 // undocumented / reserved output

`define RD      1'b1
`define WR      1'b0
`define SADDR1  7'b0010_000
`define SADDR2  7'b0100_000

//state machine
`define ST_IDLE 			4'd0
`define ST_WR_PRER_LO 	4'd1
`define ST_WR_PRER_HI 	4'd2
`define ST_WR_CTR 		4'd3
`define ST_WR_SLADR_W 	4'd4
`define ST_WR_CR 			4'd5
`define ST_RD_ACK 		4'd6
`define ST_WR_MEM_ADDR 	4'd7
`define ST_WR_SLADR_R 	4'd8
`define ST_RD_INIT 		4'd9
`define ST_RD_DATA 		4'd10


module i2c_sys_top
(clk, rst, domain, start, done, slave_addr, read_data_out, wb_addr, wb_wr_data, wb_rd_data, wb_we, wb_stb, wb_cyc, wb_ack, wb_inta);

	//
	// wires && regs
	//
	input 					{L} clk;
	input 					{L} rst;
	input					{L} domain;

	input 					{Ctrl domain} start;
	output 					{Ctrl domain} done;
	
	input [6:0] 			{Ctrl domain} slave_addr;
	output [7:0]	{Data domain} read_data_out;
    
    //WB Intf
    output [2:0] {Ctrl domain} wb_addr;
    output [7:0] {Data domain} wb_wr_data;
    input  [7:0] {Data domain} wb_rd_data;
    output {Ctrl domain} wb_we;
    output {Ctrl domain} wb_stb;
    output {Ctrl domain} wb_cyc;
    input  {Ctrl domain} wb_ack;
    input  {Ctrl domain} wb_inta;

	//WB Intf
	reg [2:0] {Ctrl domain} wb_addr;
	reg [7:0] {Data domain} wb_wr_data;
	reg [2:0] {Ctrl domain} n_wb_addr;
	reg [7:0] {Data domain} n_wb_wr_data;
	wire [7:0] {Data domain} wb_rd_data;
	reg [7:0] {Data domain} n_wb_rd_data;
	reg [7:0] {Ctrl domain} wb_rd_data_r;
	reg {Ctrl domain} wb_we;
	reg {Ctrl domain} wb_stb;
	reg {Ctrl domain} wb_cyc;
	reg {Ctrl domain} n_wb_we;
	reg {Ctrl domain} n_wb_stb;
	reg {Ctrl domain} n_wb_cyc;
	wire {Ctrl domain} wb_ack;
	wire {Ctrl domain} wb_inta;

	reg [3:0] {Ctrl domain} wb_state;
	reg [3:0] {Ctrl domain} wb_state_d1;
	reg [3:0] {Ctrl domain} n_wb_state;
	reg [3:0] {Ctrl domain} n_wb_state_d1;

	reg [7:0] {Ctrl domain} wb_cr_data;
	reg [7:0] {Ctrl domain} n_wb_cr_data;
	
	reg {Ctrl domain} n_done;
	reg {Ctrl domain} done_r;


	//params
	//wb



	always @(*)
	begin
		n_wb_state = wb_state;
		n_wb_state_d1 = wb_state_d1;
		n_wb_cr_data = wb_cr_data;
		n_wb_rd_data = wb_rd_data_r;

		n_wb_addr = {3{1'bx}};
		n_wb_wr_data = {8{1'bx}};
		n_wb_we = 1'b0;
		n_wb_stb = 1'b0;
		n_wb_cyc = 1'b0;
		
		n_done = 1'b0;

		case (wb_state)
			ST_IDLE:
			begin
				if(start == 1'b1)
				begin
					n_wb_state = `ST_WR_PRER_LO;
				end
			end

			`ST_WR_PRER_LO:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = `PRER_LO;
					n_wb_wr_data = 8'hc8;
					n_wb_we = 1'b1;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else
				begin
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;
					n_wb_state = `ST_WR_PRER_HI;
				end
			end

			`ST_WR_PRER_HI:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = `PRER_HI;
					n_wb_wr_data = 8'h00;
					n_wb_we = 1'b1;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else
				begin
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;
					n_wb_state = `ST_WR_CTR;
				end
			end

			`ST_WR_CTR:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = `CTR;
					n_wb_wr_data = 8'h80;
					n_wb_we = 1'b1;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else
				begin
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;

					n_wb_state = `ST_WR_SLADR_W;	//Write sl addr with write bit, write cr reg
												//and also checks for ack
					n_wb_state_d1 = `ST_WR_MEM_ADDR;
				end
			end

			`ST_WR_SLADR_W:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = `TXR;
					n_wb_wr_data = {slave_addr,`WR};
					n_wb_we = 1'b1;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else
				begin
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;

					n_wb_state = `ST_WR_CR;	//write to CR and check for ack
					n_wb_cr_data = 8'h90;
				end
			end

			`ST_WR_CR:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = `CR;
					n_wb_wr_data = wb_cr_data;
					n_wb_we = 1'b1;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else
				begin
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;
				
					n_wb_state = `ST_RD_ACK;
				end
			end

			`ST_RD_ACK:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = `SR;
					n_wb_we = 1'b0;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else if (wb_rd_data[1] == 1'b1)
				begin
					n_wb_addr = `SR;
					n_wb_we = 1'b0;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				begin
					n_wb_rd_data = wb_rd_data;	//cap from ip
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;

					n_wb_state = wb_state_d1;
				end
			end

			`ST_WR_MEM_ADDR:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = `TXR;
					n_wb_wr_data = 8'h06;  //mem addr
					n_wb_we = 1'b1;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else
				begin
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;

					n_wb_state = `ST_WR_CR;	//write to CR and check for ack
					n_wb_cr_data = 8'h10;
					n_wb_state_d1 = `ST_WR_SLADR_R;
				end
			end

			`ST_WR_SLADR_R:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = `TXR;
					n_wb_wr_data = {slave_addr,`RD};
					n_wb_we = 1'b1;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else
				begin
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;

					n_wb_state = `ST_WR_CR;	//write to CR and check for ack
					n_wb_cr_data = 8'h90;
					n_wb_state_d1 = `ST_RD_INIT;
				end
			end

			`ST_RD_INIT:
			begin
				n_wb_state = `ST_WR_CR;	//write to CR and check for ack
				n_wb_cr_data = 8'h28;
				n_wb_state_d1 = `ST_RD_DATA;
			end

			`ST_RD_DATA:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = `RXR;
					n_wb_we = 1'b0;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else
				begin
					n_wb_rd_data = wb_rd_data;	//cap from ip
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;

                    n_done = 1'b1;          //Assert Done
					n_wb_state = `ST_IDLE;
				end
				//read similar to RD_ACK
			end
		endcase
	end

	//SM
	always @(posedge clk or posedge rst)
	begin
		if (rst)
		begin
			// reset
			wb_state <= `ST_IDLE;
			wb_state_d1 <= `ST_IDLE;
			wb_cr_data <= {8{1'b0}};
			wb_rd_data_r <= {8{1'bx}};

			wb_addr <= {3{1'bx}};
			wb_wr_data <= {8{1'bx}};
			wb_we <= 1'b0;
			wb_stb <= 1'b0;
			wb_cyc <= 1'b0;
			
			done_r <= 1'b0;
		end
		else
		begin
			wb_state <= n_wb_state;
			wb_state_d1 <= n_wb_state_d1;
			wb_cr_data <= n_wb_cr_data;
			wb_rd_data_r <= n_wb_rd_data;

			wb_addr <= n_wb_addr;
			wb_wr_data <= n_wb_wr_data;
			wb_we <= n_wb_we;
			wb_stb <= n_wb_stb;
			wb_cyc <= n_wb_cyc;
			
			done_r <= n_done;
		end
	end
	
	assign done = done_r;
	assign read_data_out = wb_rd_data_r;
	
endmodule
