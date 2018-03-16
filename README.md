# Secure I2C Master Controller using Information Flow Tracking  

I2C Information Flow Tracking using SecVerilog HDL.  
Noninterference proven secure I2C Master Controller.  

# Folders  
examples - Lists all the trials made using SecVerilog HDL  
source - contains the I2C Master, Controller with wishbone interface (sys_top), I2C Slave and I2C World (Main Top Module)  
tool - a copy of the secverilog tool downloaded from [2].  
verification - Behavioral verification of verilog modules using Xilinx Vivado. (PS: I2C Slave project has simulation of the project used in source).  

# Copyrights  
[1] I2C Master and Slave IPs used from OperCores Master and slave IP - copyrighted to OpenCores.  
Master IP - https://opencores.org/project,i2c  
Slave IP - https://opencores.org/project,i2cslave  

[2] SecVerilog HDL - copyrighted to Andrew Myers et al.  
Website - http://www.cs.cornell.edu/projects/secverilog/  

[3] Vivado - Copyrighted to Xilinx  
Website - www.xilinx.com  
