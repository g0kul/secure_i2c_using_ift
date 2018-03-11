//submodule_check_top
/* 
 * This example tests a submodule errors that arises when connecting a submodule
 */

 `include "submodule2.v"

module submodule_check_top(low, high, d1, d2);

input {L} low;
input {H} high;
input {D1} d1;
input {D2} d2;

// domains with dependent types
// notice there are only two domains, so x, y are 1-bit long
wire {D1} x;
wire {D2} y;

//This should fail
submodule2 inst0 (
    .d1 (d1),
    .d2 (d2),
    .sel (1'b0),
    .d3 (d1),      //d2 connecting to d1
    .out (x)
);

//This should pass
submodule2 inst1 (
    .d1 (d1),
    .d2 (d2),
    .sel (1'b1),
    .d3 (d2),      //d2 connecting to d2
    .out (y)
);

endmodule