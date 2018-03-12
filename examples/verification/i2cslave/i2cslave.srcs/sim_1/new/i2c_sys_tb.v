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
    reg  wb_inta;
    //reg  wb_ack;
    wire  wb_ack;


	reg start;
	wire done;
	
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
    
    //simulating ack
    //always @(posedge clk)
    //begin
    //    wb_ack <= wb_cyc & wb_stb;
    //end
    
    assign wb_ack = wb_cyc & wb_stb;

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
