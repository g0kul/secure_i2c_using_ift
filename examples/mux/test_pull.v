//submodule
module subm
(
    input {D1}          in1,
    input {D2}          in2,
    input {L}           sel,
    output {H}          out
);


always @ (*) begin
    case(sel)
        1'b0: out = in1;
        1'b1: out = in2;
    endcase
end

pullup(out);

endmodule
