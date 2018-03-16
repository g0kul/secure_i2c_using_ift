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

; assertions to be verified

(push)
(assert  (not(leq LOW  LOW)))    ; assign scl_sync = ((dSCL)&(~(sSCL)))&(scl_oen) @i2c_master_bit_ctrl.v:241
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign no_filter_cnt = |(filter_cnt) @i2c_master_bit_ctrl.v:298
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign scl_o = 0 @i2c_master_bit_ctrl.v:623
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign sda_o = 0 @i2c_master_bit_ctrl.v:624
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; dscl_oen <= scl_oen @i2c_master_bit_ctrl.v:231
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; slave_wait <= 0 @i2c_master_bit_ctrl.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; slave_wait <= (((scl_oen)&(~(dscl_oen)))&(~(sSCL)))|((slave_wait)&(~(sSCL))) @i2c_master_bit_ctrl.v:237
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cnt <= 0 @i2c_master_bit_ctrl.v:248
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; clk_en <= 1 @i2c_master_bit_ctrl.v:249
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cnt <= clk_cnt @i2c_master_bit_ctrl.v:254
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; clk_en <= 1 @i2c_master_bit_ctrl.v:255
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cnt <= cnt @i2c_master_bit_ctrl.v:259
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; clk_en <= 0 @i2c_master_bit_ctrl.v:260
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cnt <= (cnt)-(1) @i2c_master_bit_ctrl.v:264
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; clk_en <= 0 @i2c_master_bit_ctrl.v:265
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cSCL <= 0 @i2c_master_bit_ctrl.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; cSDA <= 0 @i2c_master_bit_ctrl.v:277
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cSCL <= 0 @i2c_master_bit_ctrl.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; cSDA <= 0 @i2c_master_bit_ctrl.v:282
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cSCL <= {cSCL[0], scl_i} @i2c_master_bit_ctrl.v:286
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cSDA <= {cSDA[0], sda_i} @i2c_master_bit_ctrl.v:287
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; filter_cnt <= 0 @i2c_master_bit_ctrl.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; filter_cnt <= 0 @i2c_master_bit_ctrl.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; filter_cnt <= (clk_cnt)>>(2) @i2c_master_bit_ctrl.v:295
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; filter_cnt <= (filter_cnt)-(1) @i2c_master_bit_ctrl.v:296
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; fSCL <= 7 @i2c_master_bit_ctrl.v:304
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; fSCL <= 7 @i2c_master_bit_ctrl.v:308
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; fSCL <= {fSCL[1:0], cSCL[1]} @i2c_master_bit_ctrl.v:312
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sSCL <= 1 @i2c_master_bit_ctrl.v:320
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; dSCL <= 1 @i2c_master_bit_ctrl.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sSCL <= 1 @i2c_master_bit_ctrl.v:326
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; dSCL <= 1 @i2c_master_bit_ctrl.v:328
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sSCL <= ((&(fSCL[2:1]))|(&(fSCL[1:0])))|((fSCL[2])&(fSCL[0])) @i2c_master_bit_ctrl.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; dSCL <= sSCL @i2c_master_bit_ctrl.v:334
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; fSDA <= 7 @i2c_master_bit_ctrl.v:341
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; fSDA <= 7 @i2c_master_bit_ctrl.v:345
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; fSDA <= {fSDA[1:0], cSDA[1]} @i2c_master_bit_ctrl.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sSDA <= 1 @i2c_master_bit_ctrl.v:357
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; dSDA <= 1 @i2c_master_bit_ctrl.v:359
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sSDA <= 1 @i2c_master_bit_ctrl.v:363
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; dSDA <= 1 @i2c_master_bit_ctrl.v:365
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain_i2c) (Ctrl domain_i2c))  (Ctrl domain_i2c))))    ; sSDA <= ((&(fSDA[2:1]))|(&(fSDA[1:0])))|((fSDA[2])&(fSDA[0])) @i2c_master_bit_ctrl.v:369
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; dSDA <= sSDA @i2c_master_bit_ctrl.v:371
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sta_condition <= 0 @i2c_master_bit_ctrl.v:379
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sto_condition <= 0 @i2c_master_bit_ctrl.v:380
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sta_condition <= 0 @i2c_master_bit_ctrl.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sto_condition <= 0 @i2c_master_bit_ctrl.v:385
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sta_condition <= (~(sSDA))&(dSDA) @i2c_master_bit_ctrl.v:389
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sto_condition <= (sSDA)&(~(dSDA)) @i2c_master_bit_ctrl.v:390
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sta_condition <= 0 @i2c_master_bit_ctrl.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sto_condition <= 0 @i2c_master_bit_ctrl.v:395
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; busy <= 0 @i2c_master_bit_ctrl.v:401
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; busy <= 0 @i2c_master_bit_ctrl.v:402
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  LOW)))    ; busy <= ((sta_condition)|(busy))&(~(sto_condition)) @i2c_master_bit_ctrl.v:403
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_stop <= 0 @i2c_master_bit_ctrl.v:412
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_stop <= 0 @i2c_master_bit_ctrl.v:414
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_stop <= = cmd 2 @i2c_master_bit_ctrl.v:416
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; al <= 0 @i2c_master_bit_ctrl.v:420
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; al <= 0 @i2c_master_bit_ctrl.v:422
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  LOW)))    ; al <= (((sda_chk)&(~(sSDA)))&(sda_oen))|(((|(c_state))&(sto_condition))&(~(cmd_stop))) @i2c_master_bit_ctrl.v:424
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  LOW)))    ; dout <= sSDA @i2c_master_bit_ctrl.v:429
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 0 @i2c_master_bit_ctrl.v:437
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:438
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:439
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:440
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:441
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 0 @i2c_master_bit_ctrl.v:445
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:446
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:447
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:448
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:449
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:453
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 1 @i2c_master_bit_ctrl.v:461
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 32 @i2c_master_bit_ctrl.v:462
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 8192 @i2c_master_bit_ctrl.v:463
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 512 @i2c_master_bit_ctrl.v:464
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 0 @i2c_master_bit_ctrl.v:465
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= scl_oen @i2c_master_bit_ctrl.v:468
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= sda_oen @i2c_master_bit_ctrl.v:469
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:470
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 2 @i2c_master_bit_ctrl.v:476
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= scl_oen @i2c_master_bit_ctrl.v:477
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:478
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:479
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 4 @i2c_master_bit_ctrl.v:484
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:486
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:487
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 8 @i2c_master_bit_ctrl.v:492
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:493
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:494
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:495
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 16 @i2c_master_bit_ctrl.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:501
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:502
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:503
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 0 @i2c_master_bit_ctrl.v:508
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:509
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:510
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:511
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:512
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 64 @i2c_master_bit_ctrl.v:518
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:519
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:520
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:521
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 128 @i2c_master_bit_ctrl.v:526
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:527
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:529
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 256 @i2c_master_bit_ctrl.v:534
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:535
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:536
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:537
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 0 @i2c_master_bit_ctrl.v:542
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:543
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:544
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:545
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:546
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 1024 @i2c_master_bit_ctrl.v:552
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:553
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:554
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:555
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 2048 @i2c_master_bit_ctrl.v:560
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:561
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:562
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:563
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 4096 @i2c_master_bit_ctrl.v:568
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:569
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:570
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:571
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 0 @i2c_master_bit_ctrl.v:576
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:577
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:578
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:579
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:580
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 16384 @i2c_master_bit_ctrl.v:586
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:587
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= din @i2c_master_bit_ctrl.v:588
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:589
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 32768 @i2c_master_bit_ctrl.v:594
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:595
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= din @i2c_master_bit_ctrl.v:596
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:597
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 65536 @i2c_master_bit_ctrl.v:603
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:604
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= din @i2c_master_bit_ctrl.v:605
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 1 @i2c_master_bit_ctrl.v:606
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 0 @i2c_master_bit_ctrl.v:611
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:612
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:613
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_oen <= din @i2c_master_bit_ctrl.v:614
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:615
(check-sat)
(pop)

