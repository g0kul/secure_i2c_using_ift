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

`include "i2c_sys_defines.vh"
`include "i2cSlaveTop.v"
`include "i2c_master_top.v"

module i2c_world_top
(
    input           clk,
    input           rst,
    
    input           start,
    output [7:0]    rd_data,
    output          valid,
    output          done
);

	//
	// wires && regs
	//	
	
	//WB Intf
    wire [2:0] wb_addr;
    wire [7:0] wb_wr_data;
    wire [7:0] wb_rd_data;
    
    wire wb_we;
    wire wb_stb;
    wire wb_cyc;
    //reg  wb_inta;
    wire wb_inta;
    //reg  wb_ack;
    wire  wb_ack;

	reg start_sys;
	reg n_start_sys;
	wire done_sys;
	
	//I2C
    wire scl;
    wire scl0_o;
    wire scl0_oen;
    wire sda;
    wire sda0_o;
    wire sda0_oen;
    
    reg [6:0]  i2c_slave_addr;
    wire [7:0] i2c_read_data_out;
    
    reg [6:0]  n_i2c_slave_addr;
    reg [7:0]  rd_data_out;
    reg [7:0]  n_rd_data_out;
    
    wire high_imp = 1'bz;
    
    //SM
    reg [2:0] world_state;
    reg [2:0] n_world_state;
    reg       rd_valid;
    reg       n_rd_valid;
    reg       done_r;
    reg       n_done_r;

	//Params
    wire [6:0] M_SEL_ADDR1 = 7'h10;
    wire [6:0] M_SEL_ADDR2 = 7'h20;
    
    wire [2:0] W_ST_IDLE = 3'd0;
    wire [2:0] W_ST_RD1_START = 3'd1;
    wire [2:0] W_ST_RD1_WAIT = 3'd2;
    wire [2:0] W_ST_RD2_START = 3'd3;
    wire [2:0] W_ST_RD2_WAIT = 3'd4;
    
    always @(*)
    begin
        n_world_state = world_state;
        n_i2c_slave_addr = i2c_slave_addr;
        n_rd_data_out = 8'd0; 
        n_rd_valid = 1'b0;
        n_start_sys = 1'b0;
        n_done_r = 1'b0;
        
        case (world_state)
            W_ST_IDLE:
            begin
                if(start == 1'b1)
                begin
                    n_world_state = W_ST_RD1_START;
                end
            end
            W_ST_RD1_START:
            begin
                n_i2c_slave_addr = M_SEL_ADDR1;
                n_start_sys = 1'b1;
                n_world_state = W_ST_RD1_WAIT;
            end
            W_ST_RD1_WAIT:
            begin
                if(done_sys == 1'b1)
                begin
                    n_rd_data_out = i2c_read_data_out;
                    n_rd_valid = 1'b1;
                    n_world_state = W_ST_RD2_START;
                end
            end
            W_ST_RD2_START:
            begin
                n_i2c_slave_addr = M_SEL_ADDR2;
                n_start_sys = 1'b1;
                n_world_state = W_ST_RD1_WAIT;
            end
            W_ST_RD2_WAIT:
            begin
                if(done_sys == 1'b1)
                begin
                    n_rd_data_out = i2c_read_data_out;
                    n_rd_valid = 1'b1;
                    n_done_r = 1'b1;
                    n_world_state = W_ST_IDLE;
                end
            end
        endcase
    end
    
    always @(posedge clk or posedge rst)
    begin
        if(rst == 1'b1)
        begin
            world_state <= W_ST_IDLE;
            i2c_slave_addr <= 7'd0;
            rd_data_out <= 8'd0;
            rd_valid    <= 1'b0;
            start_sys   <= 1'b0;
            done_r      <= 1'b0;
        end
        else
        begin
            world_state <= n_world_state;
            i2c_slave_addr <= n_i2c_slave_addr;
            rd_data_out <= n_rd_data_out;
            rd_valid    <= n_rd_valid;
            start_sys   <= n_start_sys;
            done_r      <= n_done_r;
        end
    end
    
    assign rd_data = rd_data_out;
    assign valid = rd_valid;
    assign done = done_r;


    i2c_sys_top
    #(
        .ADDR_WIDTH(3),
        .DATA_WIDTH(8)
    )
    inst0
    (
        .clk(clk),
        .rst(rst),
        .start(start_sys),
        .done(done_sys),
        
        .slave_addr(i2c_slave_addr),
        .read_data_out(i2c_read_data_out),
        
        .wb_addr(wb_addr),
        .wb_wr_data(wb_wr_data),
        .wb_rd_data(wb_rd_data),
        .wb_we(wb_we),
        .wb_stb(wb_stb),
        .wb_cyc(wb_cyc),
        .wb_ack(wb_ack),
        .wb_inta(wb_inta)
    );
    
    
    i2c_master_top i2c_top (

        // wishbone interface
        .wb_clk_i(clk),
        .wb_rst_i(1'b0),
        .arst_i(!rst),
        .wb_adr_i(wb_addr),
        .wb_dat_i(wb_wr_data),
        .wb_dat_o(wb_rd_data),
        .wb_we_i(wb_we),
        .wb_stb_i(wb_stb),
        .wb_cyc_i(wb_cyc),
        .wb_ack_o(wb_ack),
        .wb_inta_o(wb_inta),

        // i2c signals
        .scl_pad_i(scl),
        .scl_pad_o(scl0_o),
        .scl_padoen_o(scl0_oen),
        .sda_pad_i(sda),
        .sda_pad_o(sda0_o),
        .sda_padoen_o(sda0_oen)
    );
    
    i2cSlave i2c_slave1(
      .clk(clk),
      .rst(rst),
      .i2c_sl_address(7'h10),
      .sda(sda),
      .scl(scl),
      .myReg0(),
      .myReg1(),
      .myReg2(),
      .myReg3(),
      .myReg4(8'h12),
      .myReg5(8'h34),
      .myReg6(8'h56),
      .myReg7(8'h78)
    );
    
    i2cSlave i2c_slave2(
      .clk(clk),
      .rst(rst),
      .i2c_sl_address(7'h20),
      .sda(sda),
      .scl(scl),
      .myReg0(),
      .myReg1(),
      .myReg2(),
      .myReg3(),
      .myReg4(8'h90),
      .myReg5(8'h12),
      .myReg6(8'h34),
      .myReg7(8'h56)
    );
    
    assign scl = (scl0_oen == 1'b1) ? high_imp : scl0_o;
    assign sda = (sda0_oen == 1'b1) ? high_imp : sda0_o;
    
    pullup(scl);
    pullup(sda);

endmodule

