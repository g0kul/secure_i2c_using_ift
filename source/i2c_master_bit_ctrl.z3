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
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; assign scl_sync = ((dSCL)&(~(sSCL)))&(scl_oen) @i2c_master_bit_ctrl.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign scl_o = 0 @i2c_master_bit_ctrl.v:582
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign sda_o = 0 @i2c_master_bit_ctrl.v:583
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; dscl_oen <= scl_oen @i2c_master_bit_ctrl.v:225
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; slave_wait <= 0 @i2c_master_bit_ctrl.v:230
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain)) (join (Ctrl domain) (Ctrl domain)))  (Ctrl domain))))    ; slave_wait <= (((scl_oen)&(~(dscl_oen)))&(~(sSCL)))|((slave_wait)&(~(sSCL))) @i2c_master_bit_ctrl.v:231
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cnt <= 0 @i2c_master_bit_ctrl.v:242
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; clk_en <= 1 @i2c_master_bit_ctrl.v:243
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cnt <= clk_cnt @i2c_master_bit_ctrl.v:248
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clk_en <= 1 @i2c_master_bit_ctrl.v:249
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cnt <= cnt @i2c_master_bit_ctrl.v:253
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clk_en <= 0 @i2c_master_bit_ctrl.v:254
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cnt <= (cnt)-(1) @i2c_master_bit_ctrl.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clk_en <= 0 @i2c_master_bit_ctrl.v:259
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cSCL <= 0 @i2c_master_bit_ctrl.v:270
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cSDA <= 0 @i2c_master_bit_ctrl.v:271
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cSCL <= 0 @i2c_master_bit_ctrl.v:275
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cSDA <= 0 @i2c_master_bit_ctrl.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cSCL <= {cSCL[0], scl_i} @i2c_master_bit_ctrl.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cSDA <= {cSDA[0], sda_i} @i2c_master_bit_ctrl.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; filter_cnt <= 0 @i2c_master_bit_ctrl.v:287
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; filter_cnt <= 0 @i2c_master_bit_ctrl.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; filter_cnt <= (clk_cnt)>>(2) @i2c_master_bit_ctrl.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; filter_cnt <= (filter_cnt)-(1) @i2c_master_bit_ctrl.v:290
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; fSCL <= 7 @i2c_master_bit_ctrl.v:296
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; fSDA <= 7 @i2c_master_bit_ctrl.v:297
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; fSCL <= 7 @i2c_master_bit_ctrl.v:301
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; fSDA <= 7 @i2c_master_bit_ctrl.v:302
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; fSCL <= {fSCL[1:0], cSCL[1]} @i2c_master_bit_ctrl.v:306
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; fSDA <= {fSDA[1:0], cSDA[1]} @i2c_master_bit_ctrl.v:307
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sSCL <= 1 @i2c_master_bit_ctrl.v:315
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sSDA <= 1 @i2c_master_bit_ctrl.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dSCL <= 1 @i2c_master_bit_ctrl.v:318
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dSDA <= 1 @i2c_master_bit_ctrl.v:319
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sSCL <= 1 @i2c_master_bit_ctrl.v:323
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sSDA <= 1 @i2c_master_bit_ctrl.v:324
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dSCL <= 1 @i2c_master_bit_ctrl.v:326
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dSDA <= 1 @i2c_master_bit_ctrl.v:327
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (Ctrl domain))  (Ctrl domain))))    ; sSCL <= ((&(fSCL[2:1]))|(&(fSCL[1:0])))|((fSCL[2])&(fSCL[0])) @i2c_master_bit_ctrl.v:331
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (Ctrl domain))  (Ctrl domain))))    ; sSDA <= ((&(fSDA[2:1]))|(&(fSDA[1:0])))|((fSDA[2])&(fSDA[0])) @i2c_master_bit_ctrl.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; dSCL <= sSCL @i2c_master_bit_ctrl.v:334
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; dSDA <= sSDA @i2c_master_bit_ctrl.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sta_condition <= 0 @i2c_master_bit_ctrl.v:343
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sto_condition <= 0 @i2c_master_bit_ctrl.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sta_condition <= 0 @i2c_master_bit_ctrl.v:348
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sto_condition <= 0 @i2c_master_bit_ctrl.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; sta_condition <= ((~(sSDA))&(dSDA))&(sSCL) @i2c_master_bit_ctrl.v:353
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; sto_condition <= ((sSDA)&(~(dSDA)))&(sSCL) @i2c_master_bit_ctrl.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; busy <= 0 @i2c_master_bit_ctrl.v:360
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; busy <= 0 @i2c_master_bit_ctrl.v:361
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; busy <= ((sta_condition)|(busy))&(~(sto_condition)) @i2c_master_bit_ctrl.v:362
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cmd_stop <= 0 @i2c_master_bit_ctrl.v:371
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cmd_stop <= 0 @i2c_master_bit_ctrl.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_stop <= = cmd 2 @i2c_master_bit_ctrl.v:375
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; al <= 0 @i2c_master_bit_ctrl.v:379
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; al <= 0 @i2c_master_bit_ctrl.v:381
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; al <= (((sda_chk)&(~(sSDA)))&(sda_oen))|(((|(c_state))&(sto_condition))&(~(cmd_stop))) @i2c_master_bit_ctrl.v:383
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Data domain))))    ; dout <= sSDA @i2c_master_bit_ctrl.v:388
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:396
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:397
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:398
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:399
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:400
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:404
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:405
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:406
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:407
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:408
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:412
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 1 @i2c_master_bit_ctrl.v:420
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 32 @i2c_master_bit_ctrl.v:421
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 8192 @i2c_master_bit_ctrl.v:422
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 512 @i2c_master_bit_ctrl.v:423
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:424
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= scl_oen @i2c_master_bit_ctrl.v:427
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= sda_oen @i2c_master_bit_ctrl.v:428
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:429
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 2 @i2c_master_bit_ctrl.v:435
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= scl_oen @i2c_master_bit_ctrl.v:436
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:437
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:438
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 4 @i2c_master_bit_ctrl.v:443
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:444
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:445
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:446
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 8 @i2c_master_bit_ctrl.v:451
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:452
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:453
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:454
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 16 @i2c_master_bit_ctrl.v:459
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:460
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:461
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:462
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:467
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:468
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:469
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:470
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:471
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 64 @i2c_master_bit_ctrl.v:477
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:478
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:479
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:480
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 128 @i2c_master_bit_ctrl.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:486
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:487
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:488
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 256 @i2c_master_bit_ctrl.v:493
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:494
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:495
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:496
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:501
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:502
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:503
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:504
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:505
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 1024 @i2c_master_bit_ctrl.v:511
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:512
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:513
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:514
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 2048 @i2c_master_bit_ctrl.v:519
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:520
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:521
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:522
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 4096 @i2c_master_bit_ctrl.v:527
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:529
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:530
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:535
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:536
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:537
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:538
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:539
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 16384 @i2c_master_bit_ctrl.v:545
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:546
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:547
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:548
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 32768 @i2c_master_bit_ctrl.v:553
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:554
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:555
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:556
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 65536 @i2c_master_bit_ctrl.v:562
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:563
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:564
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 1 @i2c_master_bit_ctrl.v:565
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:570
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:571
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:572
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:573
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:574
(check-sat)
(pop)

