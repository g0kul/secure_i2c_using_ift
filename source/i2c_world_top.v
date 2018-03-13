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
`include "i2c_master_top.v"
`include "i2c_sys_top.v"

module i2c_world_top
(
    input           {L} clk,
    input           {L} rst,
    input           {L} domain,
    
    input           {Ctrl domain} start,
    output [7:0]    {Data domain} rd_data,
    output          {Ctrl domain} valid,
    output          {Ctrl domain} done
);

	//
	// wires && regs
	//	
	
	//WB Intf
    wire [2:0] {Ctrl domain} wb_addr;
    wire [7:0] {Data domain} wb_wr_data;
    wire [7:0] {Data domain} wb_rd_data;
    
    wire {Ctrl domain} wb_we;
    wire {Ctrl domain} wb_stb;
    wire {Ctrl domain} wb_cyc;
    //reg  wb_inta;
    wire {Ctrl domain} wb_inta;
    //reg  wb_ack;
    wire  {Ctrl domain} wb_ack;

	reg {Ctrl domain} start_sys;
	reg {Ctrl domain} n_start_sys;
	wire {Ctrl domain} done_sys;
	
	//I2C
    wire {Ctrl domain} scl;
    wire {Ctrl domain} scl0_o;
    wire {Ctrl domain} scl0_oen;
    wire {Ctrl domain} sda;
    wire {Ctrl domain} sda0_o;
    wire {Ctrl domain} sda0_oen;
    
    reg [6:0]  {Ctrl domain} i2c_slave_addr;
    wire [7:0] {Data domain} i2c_read_data_out;
    
    reg [6:0]  {Ctrl domain} n_i2c_slave_addr;
    reg [7:0]  {Data domain} rd_data_out;
    reg [7:0]  {Data domain} n_rd_data_out;
    
    wire {Ctrl domain} high_imp = 1'bz;
    
    //SM
    reg [2:0] {Ctrl domain} world_state;
    reg [2:0] {Ctrl domain} n_world_state;
    reg       {Ctrl domain} rd_valid;
    reg       {Ctrl domain} n_rd_valid;
    reg       {Ctrl domain} done_r;
    reg       {Ctrl domain} n_done_r;

	//Params
    wire [6:0] {Ctrl domain} M_SEL_ADDR1 = 7'h10;
    wire [6:0] {Ctrl domain} M_SEL_ADDR2 = 7'h20;
    
    wire [2:0] {Ctrl domain} W_ST_IDLE = 3'd0;
    wire [2:0] {Ctrl domain} W_ST_RD1_START = 3'd1;
    wire [2:0] {Ctrl domain} W_ST_RD1_WAIT = 3'd2;
    wire [2:0] {Ctrl domain} W_ST_RD2_START = 3'd3;
    wire [2:0] {Ctrl domain} W_ST_RD2_WAIT = 3'd4;
    
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

    
    i2c_sys_top i2c_master_ctrl0 (
        .clk(clk),
        .rst(rst),
        .domain(domain),

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
        .domain(domain),

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
      .domain(1'b0),

      .i2c_sl_address(M_SEL_ADDR1),
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
      .domain(1'b1),

      .i2c_sl_address(M_SEL_ADDR2),
      .sda(sda),
      .scl(scl),
      .myReg4(8'h90),
      .myReg5(8'h12),
      .myReg6(8'h34),
      .myReg7(8'h56)
    );
    
    assign scl = (scl0_oen == 1'b1) ? high_imp : scl0_o;
    assign sda = (sda0_oen == 1'b1) ? high_imp : sda0_o;
    
    pullup(scl);    //Non-synthesisable, for behavioral verification.
    pullup(sda);    //Non-synthesisable, for behavioral verification.

endmodule
