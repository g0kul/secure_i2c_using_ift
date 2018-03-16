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
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; assign scl_sync = ((dSCL)&(~(sSCL)))&(scl_oen) @i2c_master_bit_ctrl.v:240
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign scl_o = 0 @i2c_master_bit_ctrl.v:587
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; assign sda_o = 0 @i2c_master_bit_ctrl.v:588
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; dscl_oen <= scl_oen @i2c_master_bit_ctrl.v:230
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; slave_wait <= 0 @i2c_master_bit_ctrl.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain)) (join (Ctrl domain) (Ctrl domain)))  (Ctrl domain))))    ; slave_wait <= (((scl_oen)&(~(dscl_oen)))&(~(sSCL)))|((slave_wait)&(~(sSCL))) @i2c_master_bit_ctrl.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cnt <= 0 @i2c_master_bit_ctrl.v:247
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; clk_en <= 1 @i2c_master_bit_ctrl.v:248
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cnt <= clk_cnt @i2c_master_bit_ctrl.v:253
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clk_en <= 1 @i2c_master_bit_ctrl.v:254
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cnt <= cnt @i2c_master_bit_ctrl.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clk_en <= 0 @i2c_master_bit_ctrl.v:259
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cnt <= (cnt)-(1) @i2c_master_bit_ctrl.v:263
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clk_en <= 0 @i2c_master_bit_ctrl.v:264
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cSCL <= 0 @i2c_master_bit_ctrl.v:275
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; cSDA <= 0 @i2c_master_bit_ctrl.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cSCL <= 0 @i2c_master_bit_ctrl.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; cSDA <= 0 @i2c_master_bit_ctrl.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cSCL <= {cSCL[0], scl_i} @i2c_master_bit_ctrl.v:285
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cSDA <= {cSDA[0], sda_i} @i2c_master_bit_ctrl.v:286
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; filter_cnt <= 0 @i2c_master_bit_ctrl.v:292
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; filter_cnt <= 0 @i2c_master_bit_ctrl.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; filter_cnt <= (clk_cnt)>>(2) @i2c_master_bit_ctrl.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; filter_cnt <= (filter_cnt)-(1) @i2c_master_bit_ctrl.v:295
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; fSCL <= 7 @i2c_master_bit_ctrl.v:301
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; fSDA <= 7 @i2c_master_bit_ctrl.v:302
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; fSCL <= 7 @i2c_master_bit_ctrl.v:306
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; fSDA <= 7 @i2c_master_bit_ctrl.v:307
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; fSCL <= {fSCL[1:0], cSCL[1]} @i2c_master_bit_ctrl.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain_i2c) (Ctrl domain))  (Ctrl domain_i2c))))    ; fSDA <= {fSDA[1:0], cSDA[1]} @i2c_master_bit_ctrl.v:312
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sSCL <= 1 @i2c_master_bit_ctrl.v:320
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sSDA <= 1 @i2c_master_bit_ctrl.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dSCL <= 1 @i2c_master_bit_ctrl.v:323
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; dSDA <= 1 @i2c_master_bit_ctrl.v:324
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sSCL <= 1 @i2c_master_bit_ctrl.v:328
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sSDA <= 1 @i2c_master_bit_ctrl.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dSCL <= 1 @i2c_master_bit_ctrl.v:331
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; dSDA <= 1 @i2c_master_bit_ctrl.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (Ctrl domain))  (Ctrl domain))))    ; sSCL <= ((&(fSCL[2:1]))|(&(fSCL[1:0])))|((fSCL[2])&(fSCL[0])) @i2c_master_bit_ctrl.v:336
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain_i2c) (Ctrl domain_i2c))  (Ctrl domain_i2c))))    ; sSDA <= ((&(fSDA[2:1]))|(&(fSDA[1:0])))|((fSDA[2])&(fSDA[0])) @i2c_master_bit_ctrl.v:337
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; dSCL <= sSCL @i2c_master_bit_ctrl.v:339
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; dSDA <= sSDA @i2c_master_bit_ctrl.v:340
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
(assert  (not(leq LOW  (Ctrl domain))))    ; sta_condition <= 0 @i2c_master_bit_ctrl.v:353
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sto_condition <= 0 @i2c_master_bit_ctrl.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain_i2c) (Ctrl domain_i2c)) (Ctrl domain))  (Ctrl domain))))    ; sta_condition <= ((~(sSDA))&(dSDA))&(sSCL) @i2c_master_bit_ctrl.v:358
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain_i2c) (Ctrl domain_i2c)) (Ctrl domain))  (Ctrl domain))))    ; sto_condition <= ((sSDA)&(~(dSDA)))&(sSCL) @i2c_master_bit_ctrl.v:359
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; busy <= 0 @i2c_master_bit_ctrl.v:365
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; busy <= 0 @i2c_master_bit_ctrl.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; busy <= ((sta_condition)|(busy))&(~(sto_condition)) @i2c_master_bit_ctrl.v:367
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cmd_stop <= 0 @i2c_master_bit_ctrl.v:376
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cmd_stop <= 0 @i2c_master_bit_ctrl.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_stop <= = cmd 2 @i2c_master_bit_ctrl.v:380
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; al <= 0 @i2c_master_bit_ctrl.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; al <= 0 @i2c_master_bit_ctrl.v:386
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (Ctrl domain) (Ctrl domain_i2c)) (Ctrl domain)) (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; al <= (((sda_chk)&(~(sSDA)))&(sda_oen))|(((|(c_state))&(sto_condition))&(~(cmd_stop))) @i2c_master_bit_ctrl.v:388
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain_i2c) (Ctrl domain))  (Data domain))))    ; dout <= sSDA @i2c_master_bit_ctrl.v:393
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:401
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:402
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:403
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:404
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:405
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:409
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:410
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:411
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:412
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:413
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:417
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 1 @i2c_master_bit_ctrl.v:425
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 32 @i2c_master_bit_ctrl.v:426
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 8192 @i2c_master_bit_ctrl.v:427
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 512 @i2c_master_bit_ctrl.v:428
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:429
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= scl_oen @i2c_master_bit_ctrl.v:432
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= sda_oen @i2c_master_bit_ctrl.v:433
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:434
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 2 @i2c_master_bit_ctrl.v:440
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= scl_oen @i2c_master_bit_ctrl.v:441
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:442
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:443
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 4 @i2c_master_bit_ctrl.v:448
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:449
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:450
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:451
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 8 @i2c_master_bit_ctrl.v:456
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:457
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:458
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:459
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 16 @i2c_master_bit_ctrl.v:464
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:465
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:466
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:467
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:473
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:474
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:475
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:476
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 64 @i2c_master_bit_ctrl.v:482
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:483
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:484
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 128 @i2c_master_bit_ctrl.v:490
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:491
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:492
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:493
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 256 @i2c_master_bit_ctrl.v:498
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:499
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:501
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:506
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:507
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:508
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:509
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:510
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 1024 @i2c_master_bit_ctrl.v:516
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:517
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:518
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:519
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 2048 @i2c_master_bit_ctrl.v:524
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:525
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:526
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:527
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 4096 @i2c_master_bit_ctrl.v:532
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:533
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:534
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:535
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:540
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:541
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:542
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:543
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:544
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 16384 @i2c_master_bit_ctrl.v:550
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:551
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:552
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:553
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 32768 @i2c_master_bit_ctrl.v:558
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:559
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:560
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:561
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 65536 @i2c_master_bit_ctrl.v:567
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:568
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:569
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 1 @i2c_master_bit_ctrl.v:570
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:575
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:576
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:577
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:578
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:579
(check-sat)
(pop)

