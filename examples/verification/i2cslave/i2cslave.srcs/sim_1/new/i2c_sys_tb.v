`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2018 09:36:11 AM
// Design Name: 
// Module Name: i2c_sys_tb
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


module i2c_sys_tb();

	//
	// wires && regs
	//
	reg  clk;
	reg  rst;
	
		//WB Intf
    wire [ADDR_WIDTH-1:0] wb_addr;
    wire [DATA_WIDTH-1:0] wb_wr_data;
    wire [DATA_WIDTH-1:0] wb_rd_data;
    wire wb_we;
    wire wb_stb;
    wire wb_cyc;
    //reg  wb_inta;
    wire wb_inta;
    //reg  wb_ack;
    wire  wb_ack;

	reg start;
	wire done;
	
	//I2C
    wire scl, scl0_o, scl0_oen;
    wire sda, sda0_o, sda0_oen;
	
	//Params
    localparam ADDR_WIDTH = 3, DATA_WIDTH = 8, M_SEL_ADDR = 7'h20;

    // generate clock
    always #5 clk = ~clk;


    i2c_sys_top
    #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .M_SEL_ADDR(M_SEL_ADDR)
    )
    inst0
    (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done),
        
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
    
    i2cSlave i2c_slave0(
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
    
    assign scl = scl0_oen ? 1'bz : scl0_o;
    assign sda = sda0_oen ? 1'bz : sda0_o;
    
    pullup p1(scl); // pullup scl line
    pullup p2(sda); // pullup sda line
    
    //simulating ack
    //always @(posedge clk)
    //begin
    //    wb_ack <= wb_cyc & wb_stb;
    //end
    
    //assign wb_ack = wb_cyc & wb_stb;

    initial
    begin
        `ifdef WAVES
        $shm_open("waves");
        $shm_probe("AS",tst_bench_top,"AS");
        $display("INFO: Signal dump enabled ...\n\n");
        `endif
        
        //	      force i2c_slave.debug = 1'b1; // enable i2c_slave debug information
        //	      force i2c_slave.debug = 1'b0; // disable i2c_slave debug information
        
        $display("\nstatus: %t Testbench started\n\n", $time);
        
        //	      $dumpfile("bench.vcd");
        //	      $dumpvars(1, tst_bench_top);
        //	      $dumpvars(1, tst_bench_top.i2c_slave);
        
        // initially values
        clk = 0;
        
        // reset system
        rst = 1'b0; // negate reset
        start = 1'b0;
        #2;
        rst = 1'b1; // assert reset
        repeat(2) @(posedge clk);
        rst = 1'b0; // negate reset
        
        $display("status: %t done reset", $time);
        
        @(posedge clk);
        
        //
        // program core
        //
        
        
        //while (scl) #1;
        //force start= 1'b1;
        
        start = 1'b1; // assert start
        repeat(2) @(posedge clk);
        start = 1'b0; // deassert start
        
        while (done == 1'b0) #1;
        
//        #100000;
//        release scl;
        
        //#250000; // wait 250us
        $display("\n\nstatus: %t Testbench done", $time);
        //$finish;
    end

endmodule
