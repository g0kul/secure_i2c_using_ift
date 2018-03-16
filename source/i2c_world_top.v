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


//Params
`define M_SEL_ADDR1    7'h10
`define M_SEL_ADDR2     7'h20

`define W_ST_IDLE      3'd0
`define W_ST_RD1_START 3'd1
`define W_ST_RD1_WAIT  3'd2
`define W_ST_RD2_START 3'd3
`define W_ST_RD2_WAIT  3'd4

`define MASTER_MUX_BIT0         19 //524288 clocks max (as per sim 410755) for rd one 8b reg from slave
`define MASTER_MUX_BIT_WIDTH    20 //MASTER_MUX_BIT0 + log_base2_of_number_of_slaves , here 2 slaves so +1;

module i2c_world_top
(
    input           {L} clk,
    input           {L} rst,
    output          {L} domain_i2c,
    
    input           {L} start,
    output [7:0]    {Data domain_i2c} rd_data,
    output          {Ctrl domain_i2c} valid,
    output          {Ctrl domain_i2c} done
);

	//
	// wires && regs
	//	

    //RD Data
    wire {L} domain_i2c; //0 - D1, 1 - D2;
	
	//WB Intf

    wire [2:0] {Ctrl domain_i2c} wb_addr;
    wire [7:0] {Ctrl domain_i2c} wb_wr_data;
    wire [7:0] {Ctrl domain_i2c} wb_rd_data;
    wire [7:0] {Data domain_i2c} wb_rd_i2c_data;
    
    wire {Ctrl domain_i2c} wb_we;
    wire {Ctrl domain_i2c} wb_stb;
    wire {Ctrl domain_i2c} wb_cyc;
    //reg  wb_inta;
    wire {Ctrl domain_i2c} wb_inta;
    //reg  wb_ack;
    wire  {Ctrl domain_i2c} wb_ack;

	reg {Ctrl domain_i2c} start_sys;
	reg {Ctrl domain_i2c} n_start_sys;
	wire {Ctrl domain_i2c} done_sys;
	
	//I2C
    wire {Ctrl domain_i2c} scl;
    wire {Ctrl domain_i2c} scl0_o;
    wire {Ctrl domain_i2c} scl0_oen;
    wire {Ctrl domain_i2c} sda;
    wire {Ctrl domain_i2c} sda0_o;
    wire {Ctrl domain_i2c} sda0_oen;
    
    reg [6:0]  {Ctrl domain_i2c} i2c_slave_addr;
    wire [7:0] {Data domain_i2c} i2c_read_data_out;
    
    reg [6:0]  {Ctrl domain_i2c} n_i2c_slave_addr;
    reg [7:0]  {Data domain_i2c} rd_data_out;
    reg [7:0]  {Data domain_i2c} n_rd_data_out;
    
    wire {L} high_imp = 1'bz;
    
    //SM
    reg [2:0] {Ctrl domain_i2c} world_state;
    reg [2:0] {Ctrl domain_i2c} n_world_state;
    reg       {Ctrl domain_i2c} rd_valid;
    reg       {Ctrl domain_i2c} n_rd_valid;
    reg       {Ctrl domain_i2c} done_r;
    reg       {Ctrl domain_i2c} n_done_r;


    //time mux
    reg [`MASTER_MUX_BIT_WIDTH-1:0] {L} master_tick_count;
    wire {D1} scl_S1;
    wire {D1} sda_S1;
    wire {D2} scl_S2;
    wire {D2} sda_S2;
    
    //Master mux count - time mux between different slaves
    always @(posedge clk or posedge rst)
    begin
        if (rst == 1'b1)
        begin
            master_tick_count <= {`MASTER_MUX_BIT_WIDTH{1'b0}};
        end
        else
        begin
            master_tick_count <= master_tick_count + {{(`MASTER_MUX_BIT_WIDTH-1){1'b0}},1'b1};
        end
    end

    //Master mux - can be scaled based on number of slaves, now only two slaves, so 1 bit
    assign domain_i2c = master_tick_count[`MASTER_MUX_BIT0];

    always @(posedge clk or posedge rst)
    begin
        if(rst == 1'b1)
        begin
            world_state <= `W_ST_IDLE;
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

    always @(*)
    begin
        n_world_state = world_state;
        n_i2c_slave_addr = i2c_slave_addr;
        n_rd_data_out = 8'd0; 
        n_rd_valid = 1'b0;
        n_start_sys = 1'b0;
        n_done_r = 1'b0;
        
        case (world_state)
            `W_ST_IDLE:
            begin
                if(start == 1'b1)
                begin
                    n_world_state = `W_ST_RD1_START;
                end
            end
            `W_ST_RD1_START:
            begin
                if (domain_i2c == 1'b0)     //Make sure master accesses respective slave in its time slot
                begin
                    n_i2c_slave_addr = `M_SEL_ADDR1;
                    n_start_sys = 1'b1;
                    n_world_state = `W_ST_RD1_WAIT;
                end
            end
            `W_ST_RD1_WAIT:
            begin
                if (domain_i2c == 1'b0)     //Make sure master accesses respective slave in its time slot
                begin
                    if(done_sys == 1'b1)
                    begin
                        n_rd_data_out = i2c_read_data_out;
                        n_rd_valid = 1'b1;
                        n_world_state = `W_ST_RD2_START;
                    end
                end
            end
            `W_ST_RD2_START:
            begin
                if(domain_i2c == 1'b1)     //Make sure master accesses respective slave in its time slot
                begin
                    n_i2c_slave_addr = `M_SEL_ADDR2;
                    n_start_sys = 1'b1;
                    n_world_state = `W_ST_RD1_WAIT;
                end
            end
            `W_ST_RD2_WAIT:
            begin
                if(domain_i2c == 1'b1)     //Make sure master accesses respective slave in its time slot
                begin
                    if(done_sys == 1'b1)
                    begin
                        n_rd_data_out = i2c_read_data_out;
                        n_rd_valid = 1'b1;
                        n_done_r = 1'b1;
                        n_world_state = `W_ST_IDLE;
                    end
                end
            end
        endcase
    end
    
    assign rd_data = rd_data_out;
    assign valid = rd_valid;
    assign done = done_r;

    //for time multiplexing
    // always @(posedge clk or posedge rst)
    // begin
    //     if (rst)
    //     begin
    //         // reset
    //         count <= 8'd0;
    //     end
    //     else
    //     begin
    //         count <= count + 8'd1;
    //     end
    // end

    //always @(*) 
    //begin
    //    if(domain_i2c == 1'b0)  //0 - D1 sec type
    //    begin
    //        scl_S1 = (count[7] == 1'b1) ? scl : high_imp;
    //        sda_S1 = (count[7] == 1'b1) ? sda : high_imp;
    //    end
    //    else                    //1 - D2 sec type
    //    begin
    //        scl_S2 = (count[7] == 1'b1) ? scl : high_imp;
    //        sda_S2 = (count[7] == 1'b1) ? sda : high_imp;
    //    end
    //end

    //assign scl_S1 = ((count[7] == 1'b1) & (domain_i2c == 1'b0)) ? scl : high_imp;
    //assign sda_S1 = ((count[7] == 1'b1) & (domain_i2c == 1'b0)) ? sda : high_imp;
    //assign scl_S2 = ((count[7] == 1'b1) & (domain_i2c == 1'b1)) ? scl : high_imp;
    //assign sda_S2 = ((count[7] == 1'b1) & (domain_i2c == 1'b1)) ? sda : high_imp;
    
    //To prevent explicit information flow - mux the scl and sda b/w slaves
    assign scl_S1 = (domain_i2c == 1'b0) ? scl : high_imp;
    assign sda_S1 = (domain_i2c == 1'b0) ? sda : high_imp;
    assign scl_S2 = (domain_i2c == 1'b1) ? scl : high_imp;
    assign sda_S2 = (domain_i2c == 1'b1) ? sda : high_imp;

    
    i2c_sys_top i2c_master_ctrl0 (
        .clk(clk),
        .rst(rst),
        .domain_i2c(domain_i2c),

        .start(start_sys),
        .done(done_sys),
        
        .slave_addr(i2c_slave_addr),
        .read_data_out(i2c_read_data_out),
        
        .wb_addr(wb_addr),
        .wb_wr_data(wb_wr_data),
        .wb_rd_data(wb_rd_data),
        .wb_rd_i2c_data(wb_rd_i2c_data),

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
        .domain_i2c(domain_i2c),

        .wb_adr_i(wb_addr),
        .wb_dat_i(wb_wr_data),
        .wb_dat_o(wb_rd_data),
        .wb_i2c_dat_o(wb_rd_i2c_data),
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

      .i2c_sl_address(`M_SEL_ADDR1),
      .sda(sda_S1),
      .scl(scl_S1),
      .myReg4(8'h12),
      .myReg5(8'h34),
      .myReg6(8'h56),
      .myReg7(8'h78)
    );
    
    i2cSlave i2c_slave2(
      .clk(clk),
      .rst(rst),
      .domain(1'b1),

      .i2c_sl_address(`M_SEL_ADDR2),
      .sda(sda_S2),
      .scl(scl_S2),
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

