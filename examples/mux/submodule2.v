//submodule2
/* 
 * This example tests a submodule errors that arises when connecting a submodule
 */

 `include "submodule.v"

module submodule2(sel, d1, d2, d3, out);

input {L} sel;
input {D1} d1;
input {D2} d2;
input {Domain sel} d3;
output {Domain sel} out;

wire {D1} x;
wire {D2} y;

//This should fail
submodule inst0 (
    .in1 (d1),
    .in2 (d2),
    .sel (1'b0),
    .in3 (d1),      //d2 connecting to d1
    .out (y)
);

//This should pass
submodule inst1 (
    .in1 (d1),
    .in2 (d2),
    .sel (1'b1),
    .in3 (d2),      //d2 connecting to d2
    .out (y)
);

endmodule