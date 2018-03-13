module muxgp
(
);


reg {L1}            in1;
reg {L2}            in2;
reg {L}             sel;
reg {Domain sel}    out;


always @ (*) begin
	if (sel == 1'b0)
		out = in1;
    else if (sel == 1'b1)
        out = in2;
end

initial
begin
    sel = 0;
    #20
    sel = 1;
    #20
    sel = 0;
end

endmodule
