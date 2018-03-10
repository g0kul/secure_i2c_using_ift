module mux
(
	input {L}			s_d,
	input {L1}          in1,
	input {L2}          in2,
	input {Domain s_d}   sel,
	output {Domain sel} out
);

reg	{Domain sel} out;

always @ (*) begin
	if (sel == 1'b0)
		out = in1;
	else
		out = in2;
end
endmodule
