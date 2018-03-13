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
(assert  (not(leq LOW  (Ctrl domain))))    ; assign idle = 0 @i2c_master_bit_ctrl.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign start_a = 1 @i2c_master_bit_ctrl.v:198
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign start_b = 2 @i2c_master_bit_ctrl.v:199
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign start_c = 4 @i2c_master_bit_ctrl.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign start_d = 8 @i2c_master_bit_ctrl.v:201
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign start_e = 16 @i2c_master_bit_ctrl.v:202
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign stop_a = 32 @i2c_master_bit_ctrl.v:203
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign stop_b = 64 @i2c_master_bit_ctrl.v:204
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign stop_c = 128 @i2c_master_bit_ctrl.v:205
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign stop_d = 256 @i2c_master_bit_ctrl.v:206
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign rd_a = 512 @i2c_master_bit_ctrl.v:207
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign rd_b = 1024 @i2c_master_bit_ctrl.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign rd_c = 2048 @i2c_master_bit_ctrl.v:209
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign rd_d = 4096 @i2c_master_bit_ctrl.v:210
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign wr_a = 8192 @i2c_master_bit_ctrl.v:211
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign wr_b = 16384 @i2c_master_bit_ctrl.v:212
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign wr_c = 32768 @i2c_master_bit_ctrl.v:213
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign wr_d = 65536 @i2c_master_bit_ctrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; assign scl_sync = ((dSCL)&(~(sSCL)))&(scl_oen) @i2c_master_bit_ctrl.v:233
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign scl_o = 0 @i2c_master_bit_ctrl.v:580
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign sda_o = 0 @i2c_master_bit_ctrl.v:581
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; dscl_oen <= scl_oen @i2c_master_bit_ctrl.v:223
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; slave_wait <= 0 @i2c_master_bit_ctrl.v:228
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain)) (join (Ctrl domain) (Ctrl domain)))  (Ctrl domain))))    ; slave_wait <= (((scl_oen)&(~(dscl_oen)))&(~(sSCL)))|((slave_wait)&(~(sSCL))) @i2c_master_bit_ctrl.v:229
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cnt <= 0 @i2c_master_bit_ctrl.v:240
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; clk_en <= 1 @i2c_master_bit_ctrl.v:241
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cnt <= clk_cnt @i2c_master_bit_ctrl.v:246
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clk_en <= 1 @i2c_master_bit_ctrl.v:247
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cnt <= cnt @i2c_master_bit_ctrl.v:251
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clk_en <= 0 @i2c_master_bit_ctrl.v:252
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cnt <= (cnt)-(1) @i2c_master_bit_ctrl.v:256
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clk_en <= 0 @i2c_master_bit_ctrl.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cSCL <= 0 @i2c_master_bit_ctrl.v:268
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cSDA <= 0 @i2c_master_bit_ctrl.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cSCL <= 0 @i2c_master_bit_ctrl.v:273
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cSDA <= 0 @i2c_master_bit_ctrl.v:274
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cSCL <= {cSCL[0], scl_i} @i2c_master_bit_ctrl.v:278
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cSDA <= {cSDA[0], sda_i} @i2c_master_bit_ctrl.v:279
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; filter_cnt <= 0 @i2c_master_bit_ctrl.v:285
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; filter_cnt <= 0 @i2c_master_bit_ctrl.v:286
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; filter_cnt <= (clk_cnt)>>(2) @i2c_master_bit_ctrl.v:287
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; filter_cnt <= (filter_cnt)-(1) @i2c_master_bit_ctrl.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; fSCL <= 7 @i2c_master_bit_ctrl.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; fSDA <= 7 @i2c_master_bit_ctrl.v:295
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; fSCL <= 7 @i2c_master_bit_ctrl.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; fSDA <= 7 @i2c_master_bit_ctrl.v:300
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; fSCL <= {fSCL[1:0], cSCL[1]} @i2c_master_bit_ctrl.v:304
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; fSDA <= {fSDA[1:0], cSDA[1]} @i2c_master_bit_ctrl.v:305
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sSCL <= 1 @i2c_master_bit_ctrl.v:313
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sSDA <= 1 @i2c_master_bit_ctrl.v:314
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dSCL <= 1 @i2c_master_bit_ctrl.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dSDA <= 1 @i2c_master_bit_ctrl.v:317
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sSCL <= 1 @i2c_master_bit_ctrl.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sSDA <= 1 @i2c_master_bit_ctrl.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dSCL <= 1 @i2c_master_bit_ctrl.v:324
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dSDA <= 1 @i2c_master_bit_ctrl.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (Ctrl domain))  (Ctrl domain))))    ; sSCL <= ((&(fSCL[2:1]))|(&(fSCL[1:0])))|((fSCL[2])&(fSCL[0])) @i2c_master_bit_ctrl.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (Ctrl domain))  (Ctrl domain))))    ; sSDA <= ((&(fSDA[2:1]))|(&(fSDA[1:0])))|((fSDA[2])&(fSDA[0])) @i2c_master_bit_ctrl.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; dSCL <= sSCL @i2c_master_bit_ctrl.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; dSDA <= sSDA @i2c_master_bit_ctrl.v:333
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sta_condition <= 0 @i2c_master_bit_ctrl.v:341
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sto_condition <= 0 @i2c_master_bit_ctrl.v:342
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sta_condition <= 0 @i2c_master_bit_ctrl.v:346
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sto_condition <= 0 @i2c_master_bit_ctrl.v:347
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; sta_condition <= ((~(sSDA))&(dSDA))&(sSCL) @i2c_master_bit_ctrl.v:351
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; sto_condition <= ((sSDA)&(~(dSDA)))&(sSCL) @i2c_master_bit_ctrl.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; busy <= 0 @i2c_master_bit_ctrl.v:358
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; busy <= 0 @i2c_master_bit_ctrl.v:359
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; busy <= ((sta_condition)|(busy))&(~(sto_condition)) @i2c_master_bit_ctrl.v:360
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cmd_stop <= 0 @i2c_master_bit_ctrl.v:369
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cmd_stop <= 0 @i2c_master_bit_ctrl.v:371
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_stop <= = cmd 2 @i2c_master_bit_ctrl.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; al <= 0 @i2c_master_bit_ctrl.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; al <= 0 @i2c_master_bit_ctrl.v:379
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; al <= (((sda_chk)&(~(sSDA)))&(sda_oen))|(((|(c_state))&(sto_condition))&(~(cmd_stop))) @i2c_master_bit_ctrl.v:381
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Data domain))))    ; dout <= sSDA @i2c_master_bit_ctrl.v:386
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= idle @i2c_master_bit_ctrl.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:395
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:396
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:397
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:398
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= idle @i2c_master_bit_ctrl.v:402
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:403
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:404
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:405
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:406
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= start_a @i2c_master_bit_ctrl.v:418
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= stop_a @i2c_master_bit_ctrl.v:419
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= wr_a @i2c_master_bit_ctrl.v:420
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= rd_a @i2c_master_bit_ctrl.v:421
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= idle @i2c_master_bit_ctrl.v:422
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= scl_oen @i2c_master_bit_ctrl.v:425
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= sda_oen @i2c_master_bit_ctrl.v:426
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:427
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= start_b @i2c_master_bit_ctrl.v:433
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= scl_oen @i2c_master_bit_ctrl.v:434
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:435
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:436
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= start_c @i2c_master_bit_ctrl.v:441
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:442
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:443
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:444
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= start_d @i2c_master_bit_ctrl.v:449
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:450
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:451
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:452
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= start_e @i2c_master_bit_ctrl.v:457
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:458
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:459
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:460
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= idle @i2c_master_bit_ctrl.v:465
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:466
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:467
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:468
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:469
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= stop_b @i2c_master_bit_ctrl.v:475
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:476
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:477
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:478
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= stop_c @i2c_master_bit_ctrl.v:483
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:484
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:486
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= stop_d @i2c_master_bit_ctrl.v:491
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:492
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:493
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:494
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= idle @i2c_master_bit_ctrl.v:499
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:501
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:502
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:503
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= rd_b @i2c_master_bit_ctrl.v:509
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:510
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:511
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:512
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= rd_c @i2c_master_bit_ctrl.v:517
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:518
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:519
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:520
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= rd_d @i2c_master_bit_ctrl.v:525
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:526
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:527
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= idle @i2c_master_bit_ctrl.v:533
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:534
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:535
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:536
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:537
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= wr_b @i2c_master_bit_ctrl.v:543
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:544
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:545
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:546
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= wr_c @i2c_master_bit_ctrl.v:551
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:552
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:553
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:554
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= wr_d @i2c_master_bit_ctrl.v:560
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:561
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:562
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 1 @i2c_master_bit_ctrl.v:563
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= idle @i2c_master_bit_ctrl.v:568
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:569
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:570
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:571
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:572
(check-sat)
(pop)

