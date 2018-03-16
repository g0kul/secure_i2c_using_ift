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

module i2c_sys_top
#(parameter ADDR_WIDTH = 3, DATA_WIDTH = 8)
(clk, rst, start, done, slave_addr, read_data_out, wb_addr, wb_wr_data, wb_rd_data, wb_we, wb_stb, wb_cyc, wb_ack, wb_inta);

	//
	// wires && regs
	//
	input clk;
	input rst;
	input start;
	output done;
	
	input [6:0] slave_addr;
	output [DATA_WIDTH-1:0] read_data_out;
    
    //WB Intf
    output [ADDR_WIDTH-1:0] wb_addr;
    output [DATA_WIDTH-1:0] wb_wr_data;
    input  [DATA_WIDTH-1:0] wb_rd_data;
    output wb_we;
    output wb_stb;
    output wb_cyc;
    input  wb_ack;
    input  wb_inta;

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
	
	reg n_done, done_r;


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
	parameter SADDR1  = 7'b0010_000;
    parameter SADDR2  = 7'b0100_000;

    //state machine
	parameter ST_IDLE 			= 4'd0;
	parameter ST_WR_PRER_LO 	= 4'd1;
	parameter ST_WR_PRER_HI 	= 4'd2;
	parameter ST_WR_CTR 		= 4'd3;
	parameter ST_WR_SLADR_W 	= 4'd4;
	parameter ST_WR_CR 			= 4'd5;
	parameter ST_RD_ACK 		= 4'd6;
	parameter ST_WR_MEM_ADDR 	= 4'd7;
	parameter ST_WR_SLADR_R 	= 4'd8;
	parameter ST_RD_INIT 		= 4'd9;
	parameter ST_RD_DATA 		= 4'd10;



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
		
		n_done = 1'b0;

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
					n_wb_wr_data = {slave_addr,WR};
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
					n_wb_wr_data = {slave_addr,RD};
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

                    n_done = 1'b1;          //Assert Done
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
			wb_state_d1 <= ST_IDLE;
			wb_cr_data <= {DATA_WIDTH{1'b0}};
			wb_rd_data_r <= {DATA_WIDTH{1'bx}};

			wb_addr <= {ADDR_WIDTH{1'bx}};
			wb_wr_data <= {DATA_WIDTH{1'bx}};
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
