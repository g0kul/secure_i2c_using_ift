; this part encodes a partial order on labels
(declare-sort Label)
(declare-fun leq (Label Label) Bool)
(declare-fun join (Label Label) Label)
(declare-fun meet (Label Label) Label)
(assert (forall ((x Label)) (leq x x)))
(assert (forall ((x Label) (y Label) (z Label)) (implies (and (leq x y) (leq y z)) (leq x z))))
(assert (forall ((x Label) (y Label)) (implies (and (leq x y) (leq y x)) (= x y))))

; axioms for join
(assert (forall ((x Label) (y Label) (z Label)) (implies (leq (join x y) z) (and (leq x z) (leq y z)))))
(assert (forall ((x Label) (y Label) (z Label)) (implies (and (leq x z) (leq y z)) (leq (join x y) z))))
(assert (forall ((x Label) (y Label)) (and (leq x (join x y)) (leq y (join x y)))))
(assert (forall ((x Label) (y Label)) (= (join x y) (join y x))))

; axioms for meet
(assert (forall ((x Label) (y Label) (z Label)) (implies (leq x (meet y z)) (and (leq x y) (leq x z)))))
(assert (forall ((x Label) (y Label) (z Label)) (implies (and (leq x y) (leq x z)) (leq x (meet y z)))))
(assert (forall ((x Label) (y Label)) (and (leq (meet x y) x) (leq (meet x y) y))))
(assert (forall ((x Label) (y Label)) (= (meet x y) (meet y x))))

; lattice elements
(declare-fun LOW () Label)
(declare-fun HIGH () Label)
(declare-fun D1 () Label)
(declare-fun D2 () Label)

; lattice structure
(assert (forall ((x Label)) (leq LOW x)))
(assert (forall ((x Label)) (leq x HIGH)))
(assert (not (= HIGH LOW))) ; the lattice cannot clapse

; new lattice elements L1 and L2
;(declare-fun L1 () Label)
;(declare-fun L2 () Label)

; lattice structure
;(assert (leq L1 L2))

; variables to be solved
(declare-fun domain () Int)
(assert (<= 0  domain))
(assert (<= domain 1))

; function that maps 0 to LOW; 1 to HIGH
(declare-fun LH (Int) Label)
(assert (= (LH 0) LOW))
(assert (= (LH 1) HIGH))
; Domain(0)=L1, Domain(1)=L2
;(declare-fun Domain (Int) Label)
;(assert (= (Domain 0) L1))
;(assert (= (Domain 1) L2))

; function for data signals
(declare-fun Data (Int) Label)
(assert (= (Data 0) D1))
(assert (= (Data 1) D2))
;(assert (= (Data 2) LOW))
;(assert (= (Data 3) HIGH))

; function for control signals
(declare-fun Ctrl (Int) Label)
(assert (= (Ctrl 0) D1))
(assert (= (Ctrl 1) D2))
;(assert (= (Ctrl 2) LOW))
;(assert (= (Ctrl 3) HIGH))

; assertions to be verified

(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign high_imp = 'bz @i2c_world_top.v:76
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign M_SEL_ADDR1 = 16 @i2c_world_top.v:87
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign M_SEL_ADDR2 = 32 @i2c_world_top.v:88
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign W_ST_IDLE = 0 @i2c_world_top.v:90
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign W_ST_RD1_START = 1 @i2c_world_top.v:91
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign W_ST_RD1_WAIT = 2 @i2c_world_top.v:92
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign W_ST_RD2_START = 3 @i2c_world_top.v:93
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign W_ST_RD2_WAIT = 4 @i2c_world_top.v:94
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; assign rd_data = rd_data_out @i2c_world_top.v:169
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; assign valid = rd_valid @i2c_world_top.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; assign done = done_r @i2c_world_top.v:171
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter rst in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter start in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter done in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter slave_addr in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter read_data_out in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_addr in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter wb_wr_data in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter wb_rd_data in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_we in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_stb in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_cyc in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_ack in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_inta in module i2c_sys_top @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter wb_clk_i in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter wb_rst_i in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter arst_i in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_adr_i in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter wb_dat_i in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter wb_dat_o in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_we_i in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_stb_i in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_cyc_i in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_ack_o in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter wb_inta_o in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter scl_pad_i in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter scl_pad_o in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter scl_padoen_o in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter sda_pad_i in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter sda_pad_o in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter sda_padoen_o in module i2c_master_top @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module i2cSlave @i2c_world_top.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter rst in module i2cSlave @i2c_world_top.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module i2cSlave @i2c_world_top.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  LOW)))    ; Instantiate parameter i2c_sl_address in module i2cSlave @i2c_world_top.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl 0))))    ; Instantiate parameter sda in module i2cSlave @i2c_world_top.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl 0))))    ; Instantiate parameter scl in module i2cSlave @i2c_world_top.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 0))))    ; Instantiate parameter myReg4 in module i2cSlave @i2c_world_top.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 0))))    ; Instantiate parameter myReg5 in module i2cSlave @i2c_world_top.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 0))))    ; Instantiate parameter myReg6 in module i2cSlave @i2c_world_top.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 0))))    ; Instantiate parameter myReg7 in module i2cSlave @i2c_world_top.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module i2cSlave @i2c_world_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter rst in module i2cSlave @i2c_world_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module i2cSlave @i2c_world_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  LOW)))    ; Instantiate parameter i2c_sl_address in module i2cSlave @i2c_world_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl 1))))    ; Instantiate parameter sda in module i2cSlave @i2c_world_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl 1))))    ; Instantiate parameter scl in module i2cSlave @i2c_world_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 1))))    ; Instantiate parameter myReg4 in module i2cSlave @i2c_world_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 1))))    ; Instantiate parameter myReg5 in module i2cSlave @i2c_world_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 1))))    ; Instantiate parameter myReg6 in module i2cSlave @i2c_world_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 1))))    ; Instantiate parameter myReg7 in module i2cSlave @i2c_world_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl = high_imp @i2c_world_top.v:249
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl = scl0_o @i2c_world_top.v:249
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda = high_imp @i2c_world_top.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda = sda0_o @i2c_world_top.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_world_state = world_state @i2c_world_top.v:98
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_i2c_slave_addr = i2c_slave_addr @i2c_world_top.v:99
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain))))    ; n_rd_data_out = 0 @i2c_world_top.v:100
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; n_rd_valid = 0 @i2c_world_top.v:101
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; n_start_sys = 0 @i2c_world_top.v:102
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; n_done_r = 0 @i2c_world_top.v:103
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_world_state = W_ST_RD1_START @i2c_world_top.v:110
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_i2c_slave_addr = M_SEL_ADDR1 @i2c_world_top.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_start_sys = 1 @i2c_world_top.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_world_state = W_ST_RD1_WAIT @i2c_world_top.v:117
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Data domain))))    ; n_rd_data_out = i2c_read_data_out @i2c_world_top.v:123
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_rd_valid = 1 @i2c_world_top.v:124
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_world_state = W_ST_RD2_START @i2c_world_top.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_i2c_slave_addr = M_SEL_ADDR2 @i2c_world_top.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_start_sys = 1 @i2c_world_top.v:131
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_world_state = W_ST_RD1_WAIT @i2c_world_top.v:132
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Data domain))))    ; n_rd_data_out = i2c_read_data_out @i2c_world_top.v:138
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_rd_valid = 1 @i2c_world_top.v:139
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_done_r = 1 @i2c_world_top.v:140
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; n_world_state = W_ST_IDLE @i2c_world_top.v:141
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; world_state <= W_ST_IDLE @i2c_world_top.v:151
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; i2c_slave_addr <= 0 @i2c_world_top.v:152
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain))))    ; rd_data_out <= 0 @i2c_world_top.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; rd_valid <= 0 @i2c_world_top.v:154
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; start_sys <= 0 @i2c_world_top.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; done_r <= 0 @i2c_world_top.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; world_state <= n_world_state @i2c_world_top.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; i2c_slave_addr <= n_i2c_slave_addr @i2c_world_top.v:161
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; rd_data_out <= n_rd_data_out @i2c_world_top.v:162
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; rd_valid <= n_rd_valid @i2c_world_top.v:163
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; start_sys <= n_start_sys @i2c_world_top.v:164
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; done_r <= n_done_r @i2c_world_top.v:165
(check-sat)
(pop)

