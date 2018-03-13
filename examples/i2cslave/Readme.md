#I2C Slave Source

PS: This example has some connection issues, please check the source folder for the updated file.
-------------------------
Author: OpenCores - https://opencores.org/project,i2cslave

#Format to run
--------------------------

secverilog -F <DependentType_FnDef.fun> -l <SecLattice_Def.lattice> -z <file1.v file2.v ... > 

#Expected Result
--------------------------

./secverilog -F oneway.fun -l oneway.lattice -z twomodule.v muxgp.v 

Compiling file twomodule.v
Compiling file muxgp.v
Verifying file twomodule.v
verified
Verifying file muxgp.v
verified
Total: 0 assertions failed

----------------------------