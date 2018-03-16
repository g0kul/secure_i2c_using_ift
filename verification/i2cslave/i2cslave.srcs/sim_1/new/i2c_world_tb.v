`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2018 04:19:05 PM
// Design Name: 
// Module Name: i2c_world_tb
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


module i2c_world_tb();

	//
	// wires && regs
	//
	reg  clk;
	reg  rst;
	
	reg start;
	wire done;
	
	wire [7:0] rd_data;
	wire valid;
	
	// generate clock
    always #5 clk = ~clk;


    i2c_world_top inst0
    (
        .clk(clk),
        .rst(rst),
        .start(start),
        
        .rd_data(rd_data),
        .valid(valid),
        .done(done)
    );
    
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
        
        while (valid == 1'b0) #1;
        
        $display("\nREAD from 1 : %0h",rd_data);
        
        
        while (valid == 1'b0) #1;
        
        $display("\nREAD from 2 : %0h",rd_data);
        $display("\nDone? : %0h",done);

        //#250000; // wait 250us
        $display("\n\nstatus: %t Testbench done", $time);
        //$finish;
    end

endmodule
