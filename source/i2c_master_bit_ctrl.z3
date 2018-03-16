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
(assert  (not(leq (join (join (Ctrl domain_i2c) (Ctrl domain_i2c)) (Ctrl domain_i2c))  (Ctrl domain_i2c))))    ; assign scl_sync = ((dSCL)&(~(sSCL)))&(scl_oen) @i2c_master_bit_ctrl.v:240
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; assign no_filter_cnt = |(filter_cnt) @i2c_master_bit_ctrl.v:297
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; assign scl_o = 0 @i2c_master_bit_ctrl.v:623
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; assign sda_o = 0 @i2c_master_bit_ctrl.v:624
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; dscl_oen <= scl_oen @i2c_master_bit_ctrl.v:230
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; slave_wait <= 0 @i2c_master_bit_ctrl.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (Ctrl domain_i2c) (Ctrl domain_i2c)) (Ctrl domain_i2c)) (join (Ctrl domain_i2c) (Ctrl domain_i2c)))  (Ctrl domain_i2c))))    ; slave_wait <= (((scl_oen)&(~(dscl_oen)))&(~(sSCL)))|((slave_wait)&(~(sSCL))) @i2c_master_bit_ctrl.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; cnt <= 0 @i2c_master_bit_ctrl.v:247
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; clk_en <= 1 @i2c_master_bit_ctrl.v:248
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cnt <= clk_cnt @i2c_master_bit_ctrl.v:253
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; clk_en <= 1 @i2c_master_bit_ctrl.v:254
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cnt <= cnt @i2c_master_bit_ctrl.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; clk_en <= 0 @i2c_master_bit_ctrl.v:259
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cnt <= (cnt)-(1) @i2c_master_bit_ctrl.v:263
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; clk_en <= 0 @i2c_master_bit_ctrl.v:264
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; cSCL <= 0 @i2c_master_bit_ctrl.v:275
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; cSDA <= 0 @i2c_master_bit_ctrl.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; cSCL <= 0 @i2c_master_bit_ctrl.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; cSDA <= 0 @i2c_master_bit_ctrl.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cSCL <= {cSCL[0], scl_i} @i2c_master_bit_ctrl.v:285
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  (Data domain_i2c))))    ; cSDA <= {cSDA[0], sda_i} @i2c_master_bit_ctrl.v:286
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; filter_cnt <= 0 @i2c_master_bit_ctrl.v:292
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; filter_cnt <= 0 @i2c_master_bit_ctrl.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; filter_cnt <= (clk_cnt)>>(2) @i2c_master_bit_ctrl.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; filter_cnt <= (filter_cnt)-(1) @i2c_master_bit_ctrl.v:295
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; fSCL <= 7 @i2c_master_bit_ctrl.v:303
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; fSCL <= 7 @i2c_master_bit_ctrl.v:307
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; fSCL <= {fSCL[1:0], cSCL[1]} @i2c_master_bit_ctrl.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sSCL <= 1 @i2c_master_bit_ctrl.v:319
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; dSCL <= 1 @i2c_master_bit_ctrl.v:321
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sSCL <= 1 @i2c_master_bit_ctrl.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; dSCL <= 1 @i2c_master_bit_ctrl.v:327
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain_i2c) (Ctrl domain_i2c))  (Ctrl domain_i2c))))    ; sSCL <= ((&(fSCL[2:1]))|(&(fSCL[1:0])))|((fSCL[2])&(fSCL[0])) @i2c_master_bit_ctrl.v:331
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; dSCL <= sSCL @i2c_master_bit_ctrl.v:333
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; fSDA <= 7 @i2c_master_bit_ctrl.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; fSDA <= 7 @i2c_master_bit_ctrl.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain_i2c) (Ctrl domain_i2c))  (Data domain_i2c))))    ; fSDA <= {fSDA[1:0], cSDA[1]} @i2c_master_bit_ctrl.v:348
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; sSDA <= 1 @i2c_master_bit_ctrl.v:356
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; dSDA <= 1 @i2c_master_bit_ctrl.v:358
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; sSDA <= 1 @i2c_master_bit_ctrl.v:362
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; dSDA <= 1 @i2c_master_bit_ctrl.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain_i2c) (Data domain_i2c))  (Data domain_i2c))))    ; sSDA <= ((&(fSDA[2:1]))|(&(fSDA[1:0])))|((fSDA[2])&(fSDA[0])) @i2c_master_bit_ctrl.v:368
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  (Data domain_i2c))))    ; dSDA <= sSDA @i2c_master_bit_ctrl.v:370
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; sta_condition <= 0 @i2c_master_bit_ctrl.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; sto_condition <= 0 @i2c_master_bit_ctrl.v:379
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; sta_condition <= 0 @i2c_master_bit_ctrl.v:383
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; sto_condition <= 0 @i2c_master_bit_ctrl.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Data domain_i2c) (Data domain_i2c)) (Ctrl domain_i2c))  (Data domain_i2c))))    ; sta_condition <= (~(sSDA))&(dSDA) @i2c_master_bit_ctrl.v:388
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Data domain_i2c) (Data domain_i2c)) (Ctrl domain_i2c))  (Data domain_i2c))))    ; sto_condition <= (sSDA)&(~(dSDA)) @i2c_master_bit_ctrl.v:389
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Data domain_i2c))))    ; sta_condition <= 0 @i2c_master_bit_ctrl.v:393
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Data domain_i2c))))    ; sto_condition <= 0 @i2c_master_bit_ctrl.v:394
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; busy <= 0 @i2c_master_bit_ctrl.v:400
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; busy <= 0 @i2c_master_bit_ctrl.v:401
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (Data domain_i2c) (Data domain_i2c)) (Data domain_i2c))  (Data domain_i2c))))    ; busy <= ((sta_condition)|(busy))&(~(sto_condition)) @i2c_master_bit_ctrl.v:402
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; cmd_stop <= 0 @i2c_master_bit_ctrl.v:411
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; cmd_stop <= 0 @i2c_master_bit_ctrl.v:413
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cmd_stop <= = cmd 2 @i2c_master_bit_ctrl.v:415
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; al <= 0 @i2c_master_bit_ctrl.v:419
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; al <= 0 @i2c_master_bit_ctrl.v:421
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; al <= 0 @i2c_master_bit_ctrl.v:423
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain_i2c) (Ctrl domain_i2c))  (Data domain_i2c))))    ; dout <= sSDA @i2c_master_bit_ctrl.v:429
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:437
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:438
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:439
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:440
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:441
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:445
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:446
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:447
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:448
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:449
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cmd_ack <= 0 @i2c_master_bit_ctrl.v:453
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 1 @i2c_master_bit_ctrl.v:461
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 32 @i2c_master_bit_ctrl.v:462
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 8192 @i2c_master_bit_ctrl.v:463
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 512 @i2c_master_bit_ctrl.v:464
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:465
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= scl_oen @i2c_master_bit_ctrl.v:468
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= sda_oen @i2c_master_bit_ctrl.v:469
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:470
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 2 @i2c_master_bit_ctrl.v:476
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= scl_oen @i2c_master_bit_ctrl.v:477
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:478
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:479
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 4 @i2c_master_bit_ctrl.v:484
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:486
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:487
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 8 @i2c_master_bit_ctrl.v:492
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:493
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:494
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:495
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 16 @i2c_master_bit_ctrl.v:500
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:501
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:502
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:503
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:508
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:509
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:510
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:511
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:512
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 64 @i2c_master_bit_ctrl.v:518
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:519
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:520
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:521
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 128 @i2c_master_bit_ctrl.v:526
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:527
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:528
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:529
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 256 @i2c_master_bit_ctrl.v:534
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:535
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 0 @i2c_master_bit_ctrl.v:536
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:537
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:542
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:543
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:544
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:545
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:546
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 1024 @i2c_master_bit_ctrl.v:552
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:553
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:554
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:555
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 2048 @i2c_master_bit_ctrl.v:560
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:561
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:562
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:563
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 4096 @i2c_master_bit_ctrl.v:568
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:569
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:570
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:571
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:576
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:577
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:578
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= 1 @i2c_master_bit_ctrl.v:579
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:580
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 16384 @i2c_master_bit_ctrl.v:586
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:587
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:588
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:589
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 32768 @i2c_master_bit_ctrl.v:594
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:595
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:596
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:597
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 65536 @i2c_master_bit_ctrl.v:603
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 1 @i2c_master_bit_ctrl.v:604
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:605
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 1 @i2c_master_bit_ctrl.v:606
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; c_state <= 0 @i2c_master_bit_ctrl.v:611
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; cmd_ack <= 1 @i2c_master_bit_ctrl.v:612
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; scl_oen <= 0 @i2c_master_bit_ctrl.v:613
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_oen <= din @i2c_master_bit_ctrl.v:614
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sda_chk <= 0 @i2c_master_bit_ctrl.v:615
(check-sat)
(pop)

