/* 
 * This example tests a lattice with four labels: L < L1 <L2 < H.
 */

`include "muxgp.v"

module twomodule();

reg[1:0] {L} low;
reg[1:0] {H} high;
reg[1:0] {L1} d1;
reg[1:0] {L2} d2;


// domains with dependent types
// notice there are only two domains, so x, y are 1-bit long
reg {L} sl;
reg {L1} x;
reg {L2} y;

wire {Domain sl} out;

// this should work, since when x is 0, label of x is Domain 0 == L1
always @(*) begin
	if (sl == 0) begin
		d1 = x;
	end
end

// this should work
always @(*) begin
	if (sl == 1) begin
		d2 = x;
	end
end

// this should work
always @(*) begin
	d2 = d1;
end

// this should fail
/*
always @(*) begin
	d1 = d2;
end
*/

muxgp inst0 (
	.in1	(d1),
	.in2	(d2),
	.sel	(sl),
	.out	(out)
	);


endmodule
