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

`define DATA_WIDTH 8
`define ADDR_WIDTH 3

`include "i2cSlaveTop.v"
`include "i2c_master_top.v"

module i2c_sys_top(clk, rstn, start, done);

	//
	// wires && regs
	//
	input clk;
	input rst;
	input start;
	output done;


	//WB Intf
	reg [ADDR_WIDTH-1:0] wb_addr;
	reg [DATA_WIDTH-1:0] wb_wr_data;
	reg [ADDR_WIDTH-1:0] n_wb_addr;
	reg [DATA_WIDTH-1:0] n_wb_wr_data;
	wire [DATA_WIDTH-1:0] wb_rd_data;
	reg [DATA_WIDTH-1:0] n_wb_rd_data;
	reg [DATA_WIDTH-1:0] wb_rd_data_r;
	reg wb_we;
	reg wb_stb;
	reg wb_cyc;
	reg n_wb_we;
	reg n_wb_stb;
	reg n_wb_cyc;
	wire wb_ack;
	wire wb_inta;

	reg [3:0] wb_state;
	reg [3:0] wb_state_d1;
	reg [3:0] n_wb_state;
	reg [3:0] n_wb_state_d1;

	reg [DATA_WIDTH-1:0] wb_cr_data;
	reg [DATA_WIDTH-1:0] n_wb_cr_data;


	//params
	//wb
	parameter PRER_LO = 3'b000;
	parameter PRER_HI = 3'b001;
	parameter CTR     = 3'b010;
	parameter RXR     = 3'b011;
	parameter TXR     = 3'b011;
	parameter CR      = 3'b100;
	parameter SR      = 3'b100;

	parameter TXR_R   = 3'b101; // undocumented / reserved output
	parameter CR_R    = 3'b110; // undocumented / reserved output

	parameter RD      = 1'b1;
	parameter WR      = 1'b0;
	parameter SADDR1    = 7'b0010_000;
    parameter SADDR2    = 7'b0100_000;

    //state machine
	parameter ST_IDLE = 4'd0;


	always @(*)
	begin
		n_wb_state = wb_state;
		n_wb_state_d1 = wb_state_d1;
		n_wb_cr_data = wb_cr_data;
		n_wb_rd_data = wb_rd_data_r;

		n_wb_addr = {ADDR_WIDTH{1'bx}};
		n_wb_wr_data = {DATA_WIDTH{1'bx}};
		n_wb_we = 1'b0;
		n_wb_stb = 1'b0;
		n_wb_cyc = 1'b0;

		case (wb_state)
			ST_IDLE:
			begin
				if(start == 1'b1)
				begin
					n_wb_state = ST_WR_PRER_LO;
				end
			end

			ST_WR_PRER_LO:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = PRER_LO;
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
					n_wb_state = ST_WR_PRER_HI;
				end
			end

			ST_WR_PRER_HI:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = PRER_HI;
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
					n_wb_state = ST_WR_CTR;
				end
			end

			ST_WR_CTR:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = CTR;
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

					n_wb_state = ST_WR_SLADR_W;	//Write sl addr with write bit, write cr reg
												//and also checks for ack
					n_wb_state_d1 = ST_WR_MEM_ADDR;
				end
			end

			ST_WR_SLADR_W:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = TXR;
					n_wb_wr_data = {M_SEL_ADDR,WR};
					n_wb_we = 1'b1;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else
				begin
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;

					n_wb_state = ST_WR_CR;	//write to CR and check for ack
					n_wb_cr_data = 8'h90;
				end
			end

			ST_WR_CR:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = CR;
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
				
					n_wb_state = ST_RD_ACK;
				end
			end

			ST_RD_ACK:
			begin
				if((wb_ack == 1'b0)|(wb_rd_data[1] == 1'b1))
				begin
					n_wb_addr = SR;
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

					n_wb_state = wb_state_d1;
				end
			end

			ST_WR_MEM_ADDR:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = TXR;
					n_wb_wr_data = 8'h01;
					n_wb_we = 1'b1;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else
				begin
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;

					n_wb_state = ST_WR_CR;	//write to CR and check for ack
					n_wb_cr_data = 8'h10;
					n_wb_state_d1 = ST_WR_SLADR_R;
				end
			end

			ST_WR_SLADR_R:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = TXR;
					n_wb_wr_data = {M_SEL_ADDR,RD};
					n_wb_we = 1'b1;
					n_wb_stb = 1'b1;
					n_wb_cyc = 1'b1;
				end
				else
				begin
					n_wb_we = 1'bx;
					n_wb_stb = 1'bx;
					n_wb_cyc = 1'b0;

					n_wb_state = ST_WR_CR;	//write to CR and check for ack
					n_wb_cr_data = 8'h90;
					n_wb_state_d1 = ST_RD_INIT;
				end
			end

			ST_RD_INIT:
			begin
				n_wb_state = ST_WR_CR;	//write to CR and check for ack
				n_wb_cr_data = 8'h28;
				n_wb_state_d1 = ST_RD_DATA;
			end

			ST_RD_DATA:
			begin
				if(wb_ack == 1'b0)
				begin
					n_wb_addr = RXR;
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

					n_wb_state = ST_IDLE;
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
			wb_state <= ST_IDLE;
		end
		else
			wb_state <= n_wb_state;
		end
	end