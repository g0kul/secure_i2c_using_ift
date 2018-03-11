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
    if (sel == 1'b0) begin
        out = in1;
    end
    else begin
        out = in2;
    end
end

endmodule