module operatorgood
(
    input [7:0] {D1} in1,
    input [7:0] {D2} in2,
    input [7:0] {L}   sel,
    output [7:0] {H} out
);

always @ (*) begin
    if (~(|sel) == 1'b0)
    begin
        out = in1;
    end
    else
    begin
        out = in2;
    end
end

endmodule
