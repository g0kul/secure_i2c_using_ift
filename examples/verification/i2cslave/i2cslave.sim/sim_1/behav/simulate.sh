#!/bin/bash -f
xv_path="/opt/Xilinx/Vivado/2017.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim tst_bench_top_behav -key {Behavioral:sim_1:Functional:tst_bench_top} -tclbatch tst_bench_top.tcl -view /home/gokul/playground/secverilog/i2c_ift/examples/verification/i2cslave/results/tst_bench_top_behav.wcfg -view /home/gokul/playground/secverilog/i2c_ift/examples/verification/i2cslave/results/tst_bench_flow_det.wcfg -log simulate.log
