module muxgp
(
	input {L1}          in1,
	input {L2}          in2,
	input {L}   sel,
	inout {Domain sel} out
);

wire	{Domain sel} out;
reg {L1} out2;

wire {L} const = 1'bz;

always @ (*) begin
	if (sel == 1'b0)
		out2 = out;
end

assign out = (sel == 1'b1) ? in2 : const;

endmodule
