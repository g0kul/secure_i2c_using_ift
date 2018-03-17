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
(declare-fun domain_i2c () Int)
(assert (<= 0  domain_i2c))
(assert (<= domain_i2c 1))

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
(assert (= (Data 2) LOW))
(assert (= (Data 3) HIGH))

; function for control signals
(declare-fun Ctrl (Int) Label)
(assert (= (Ctrl 0) D1))
(assert (= (Ctrl 1) D2))
(assert (= (Ctrl 2) LOW))
(assert (= (Ctrl 3) HIGH))

; function for wish bone data bus
;(declare-fun WBData (Int Int) Label)
;(assert (= (WBData 0 0) LOW))
;(assert (= (WBData 0 1) LOW))
;(assert (= (WBData 0 2) LOW))
;(assert (= (WBData 0 3) LOW))

;(assert (= (WBData 1 0) LOW))
;(assert (= (WBData 1 1) LOW))
;(assert (= (WBData 1 2) LOW))
;(assert (= (WBData 1 3) LOW))

;(assert (= (WBData 2 0) LOW))
;(assert (= (WBData 2 1) LOW))
;(assert (= (WBData 2 2) LOW))
;(assert (= (WBData 2 3) LOW))

;3 rxr
;(assert (= (WBData 3 0) D1))
;(assert (= (WBData 3 1) D2))
;(assert (= (WBData 3 2) LOW))
;(assert (= (WBData 3 3) HIGH))

;4 sr
;(assert (= (WBData 4 0) D1))
;(assert (= (WBData 4 1) D2))
;(assert (= (WBData 4 2) LOW))
;(assert (= (WBData 4 3) HIGH))

;(assert (= (WBData 5 0) LOW))
;(assert (= (WBData 5 1) LOW))
;(assert (= (WBData 5 2) LOW))
;(assert (= (WBData 5 3) LOW))

;(assert (= (WBData 6 0) LOW))
;(assert (= (WBData 6 1) LOW))
;(assert (= (WBData 6 2) LOW))
;(assert (= (WBData 6 3) LOW))

;(assert (= (WBData 7 0) LOW))
;(assert (= (WBData 7 1) LOW))
;(assert (= (WBData 7 2) LOW))
;(assert (= (WBData 7 3) LOW))

; assertions to be verified

(push)
(assert  (not(leq LOW  LOW)))    ; assign high_imp = 'bz @i2c_world_top.v:95
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign domain_i2c = master_tick_count[16] @i2c_world_top.v:127
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  (Data domain_i2c))))    ; assign rd_data = rd_data_out @i2c_world_top.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; assign valid = rd_valid @i2c_world_top.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; assign done = done_r @i2c_world_top.v:216
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 0)  (not(leq (Ctrl domain_i2c)  D1))))    ; scl_S1 = scl @i2c_world_top.v:252
(check-sat)
(pop)


(push)
(assert (and (not(= domain_i2c 0))  (not(leq LOW  D1))))    ; scl_S1 = high_imp @i2c_world_top.v:252
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 0)  (not(leq (Ctrl domain_i2c)  D1))))    ; sda_S1 = sda @i2c_world_top.v:253
(check-sat)
(pop)


(push)
(assert (and (not(= domain_i2c 0))  (not(leq LOW  D1))))    ; sda_S1 = high_imp @i2c_world_top.v:253
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 1)  (not(leq (Ctrl domain_i2c)  D2))))    ; scl_S2 = scl @i2c_world_top.v:254
(check-sat)
(pop)


(push)
(assert (and (not(= domain_i2c 1))  (not(leq LOW  D2))))    ; scl_S2 = high_imp @i2c_world_top.v:254
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 1)  (not(leq (Ctrl domain_i2c)  D2))))    ; sda_S2 = sda @i2c_world_top.v:255
(check-sat)
(pop)


(push)
(assert (and (not(= domain_i2c 1))  (not(leq LOW  D2))))    ; sda_S2 = high_imp @i2c_world_top.v:255
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter rst in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain_i2c in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter start in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter done in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter slave_addr in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  (Data domain_i2c))))    ; Instantiate parameter read_data_out in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_addr in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_wr_data in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_rd_data in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  (Data domain_i2c))))    ; Instantiate parameter wb_rd_i2c_data in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_we in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_stb in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_cyc in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_ack in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_inta in module i2c_sys_top @i2c_world_top.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter wb_clk_i in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter wb_rst_i in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter arst_i in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain_i2c in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_adr_i in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_dat_i in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_dat_o in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  (Data domain_i2c))))    ; Instantiate parameter wb_i2c_dat_o in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_we_i in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_stb_i in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_cyc_i in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_ack_o in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter wb_inta_o in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter scl_pad_i in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter scl_pad_o in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter scl_padoen_o in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Data domain_i2c))))    ; Instantiate parameter sda_pad_i in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter sda_pad_o in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter sda_padoen_o in module i2c_master_top @i2c_world_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module i2cSlave @i2c_world_top.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter rst in module i2cSlave @i2c_world_top.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module i2cSlave @i2c_world_top.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter i2c_sl_address in module i2cSlave @i2c_world_top.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Ctrl 0))))    ; Instantiate parameter sda in module i2cSlave @i2c_world_top.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Ctrl 0))))    ; Instantiate parameter scl in module i2cSlave @i2c_world_top.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 0))))    ; Instantiate parameter myReg4 in module i2cSlave @i2c_world_top.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 0))))    ; Instantiate parameter myReg5 in module i2cSlave @i2c_world_top.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 0))))    ; Instantiate parameter myReg6 in module i2cSlave @i2c_world_top.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 0))))    ; Instantiate parameter myReg7 in module i2cSlave @i2c_world_top.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module i2cSlave @i2c_world_top.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter rst in module i2cSlave @i2c_world_top.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module i2cSlave @i2c_world_top.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter i2c_sl_address in module i2cSlave @i2c_world_top.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Ctrl 1))))    ; Instantiate parameter sda in module i2cSlave @i2c_world_top.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Ctrl 1))))    ; Instantiate parameter scl in module i2cSlave @i2c_world_top.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 1))))    ; Instantiate parameter myReg4 in module i2cSlave @i2c_world_top.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 1))))    ; Instantiate parameter myReg5 in module i2cSlave @i2c_world_top.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 1))))    ; Instantiate parameter myReg6 in module i2cSlave @i2c_world_top.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data 1))))    ; Instantiate parameter myReg7 in module i2cSlave @i2c_world_top.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl = high_imp @i2c_world_top.v:336
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl = scl0_o @i2c_world_top.v:336
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda = high_imp @i2c_world_top.v:337
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda = sda0_o @i2c_world_top.v:337
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; master_tick_count <= {17{0}} @i2c_world_top.v:118
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; master_tick_count <= (master_tick_count)+({{(17)-(1){0}}, 1}) @i2c_world_top.v:122
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; world_state <= 0 @i2c_world_top.v:133
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; i2c_slave_addr <= 0 @i2c_world_top.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; rd_data_out <= 0 @i2c_world_top.v:135
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; rd_valid <= 0 @i2c_world_top.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; start_sys <= 0 @i2c_world_top.v:137
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; done_r <= 0 @i2c_world_top.v:138
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; world_state <= n_world_state @i2c_world_top.v:142
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; i2c_slave_addr <= n_i2c_slave_addr @i2c_world_top.v:143
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  (Data domain_i2c))))    ; rd_data_out <= n_rd_data_out @i2c_world_top.v:144
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; rd_valid <= n_rd_valid @i2c_world_top.v:145
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; start_sys <= n_start_sys @i2c_world_top.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; done_r <= n_done_r @i2c_world_top.v:147
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; n_world_state = world_state @i2c_world_top.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; n_i2c_slave_addr = i2c_slave_addr @i2c_world_top.v:154
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; n_rd_data_out = 0 @i2c_world_top.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; n_rd_valid = 0 @i2c_world_top.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; n_start_sys = 0 @i2c_world_top.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; n_done_r = 0 @i2c_world_top.v:158
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; n_world_state = 1 @i2c_world_top.v:165
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 0)  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c)))))    ; n_i2c_slave_addr = 16 @i2c_world_top.v:172
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 0)  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c)))))    ; n_start_sys = 1 @i2c_world_top.v:173
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 0)  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c)))))    ; n_world_state = 2 @i2c_world_top.v:174
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 0)  (not(leq (join (Data domain_i2c) (Ctrl domain_i2c))  (Data domain_i2c)))))    ; n_rd_data_out = i2c_read_data_out @i2c_world_top.v:183
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 0)  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c)))))    ; n_rd_valid = 1 @i2c_world_top.v:184
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 0)  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c)))))    ; n_world_state = 3 @i2c_world_top.v:185
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 1)  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c)))))    ; n_i2c_slave_addr = 32 @i2c_world_top.v:193
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 1)  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c)))))    ; n_start_sys = 1 @i2c_world_top.v:194
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 1)  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c)))))    ; n_world_state = 2 @i2c_world_top.v:195
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 1)  (not(leq (join (Data domain_i2c) (Ctrl domain_i2c))  (Data domain_i2c)))))    ; n_rd_data_out = i2c_read_data_out @i2c_world_top.v:204
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 1)  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c)))))    ; n_rd_valid = 1 @i2c_world_top.v:205
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 1)  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c)))))    ; n_done_r = 1 @i2c_world_top.v:206
(check-sat)
(pop)


(push)
(assert (and (= domain_i2c 1)  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c)))))    ; n_world_state = 0 @i2c_world_top.v:207
(check-sat)
(pop)

