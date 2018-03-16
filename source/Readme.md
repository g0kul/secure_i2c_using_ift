#Secured I2C using IFT  
-------------------------  
i2c_world_top.v ~ Main top file, the I2C World.  
i2c_sys_top.v ~ An WishBone master that controls I2C Master.  
i2c_master_top.v ~ Top module of I2C Master with WishBone slave interface for control.  
i2c_master_byte_ctrl.v ~ I2C Master byte transfer.  
i2c_master_bit_ctrl.v ~ Transmits bits onto I2C lines.  
i2cSlave.v ~ Top module of the slave.  
serialInterface.v ~ Handles the I2C slave operation.  
registerInterface.v ~ Contains I2C slave registers - 8 registers of 8bit wide (4 of them are read only).  

#Format to run  
--------------------------  

./check_security.cp  

#Expected Result  
--------------------------  

Compiling file i2c_world_top.v  
Compiling file i2c_master_top.v  
Compiling file i2c_master_byte_ctrl.v  
Compiling file i2c_master_bit_ctrl.v  
Compiling file i2cSlave.v  
Compiling file serialInterface.v  
Compiling file registerInterface.v  
Compiling file i2c_sys_top.v  
Verifying module i2c_master_bit_ctrl verified  
Verifying module i2c_master_byte_ctrl verified  
Verifying module i2c_master_top verified  
Verifying module i2c_sys_top verified  
Verifying module i2c_world_top verified  
Verifying module i2cSlave verified  
Verifying module registerInterface verified  
Verifying module serialInterface verified  
Total: 0 assertions failed  

----------------------------  
