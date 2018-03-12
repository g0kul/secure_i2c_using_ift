//submodule
module submodule
(
    input {D1}          in1,
    input {D2}          in2,
    input {L}           sel,
    input {Domain sel}  in3,    //dependent input
    output {Domain sel} out
);

reg    {Domain sel}    out;

always @ (*) begin
    case(sel)
        1'b0: out = in1;
        1'b1: out = in2;
    endcase
end

endmodule