module domain_wire_check    
(
    output {L}          sel_out,
	input {L}           sel,
	input {Domain sel}  inp1,
    output {Domain sel_out} out1
);

wire {L} sel_out;
reg {Domain sel_out} out1;

assign sel_out = sel;

always @(*)
begin
    out1 = inp1;
end


endmodule
