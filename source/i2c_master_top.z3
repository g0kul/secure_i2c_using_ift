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
(assert  (not(leq LOW  LOW)))    ; assign ARST_LVL = 0 @i2c_master_top.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign rst_i = (arst_i)^(ARST_LVL) @i2c_master_top.v:118
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign wb_wacc = (wb_we_i)&(wb_ack_o) @i2c_master_top.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign sta = cr[7] @i2c_master_top.v:159
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign sto = cr[6] @i2c_master_top.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign rd = cr[5] @i2c_master_top.v:161
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign wr = cr[4] @i2c_master_top.v:162
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign ack = cr[3] @i2c_master_top.v:163
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign iack = cr[0] @i2c_master_top.v:164
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign core_en = ctr[7] @i2c_master_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign ien = ctr[6] @i2c_master_top.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter rst in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter nReset in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter ena in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk_cnt in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter start in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter stop in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter read in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter write in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter ack_in in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter din in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter cmd_ack in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter ack_out in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter dout in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter i2c_busy in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter i2c_al in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter scl_i in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter scl_o in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter scl_oen in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter sda_i in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sda_o in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sda_oen in module i2c_master_byte_ctrl @i2c_master_top.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; assign sr[7] = rxack @i2c_master_top.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; assign sr[6] = i2c_busy @i2c_master_top.v:300
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; assign sr[5] = al @i2c_master_top.v:301
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; assign sr[4:2] = 0 @i2c_master_top.v:302
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; assign sr[1] = tip @i2c_master_top.v:303
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; assign sr[0] = irq_flag @i2c_master_top.v:304
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_ack_o <= ((wb_cyc_i)&(wb_stb_i))&(~(wb_ack_o)) @i2c_master_top.v:172
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_dat_o <= prer[7:0] @i2c_master_top.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_dat_o <= prer[15:8] @i2c_master_top.v:179
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_dat_o <= ctr @i2c_master_top.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  LOW)))    ; wb_dat_o <= rxr @i2c_master_top.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  LOW)))    ; wb_dat_o <= sr @i2c_master_top.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_dat_o <= txr @i2c_master_top.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_dat_o <= cr @i2c_master_top.v:184
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_dat_o <= 0 @i2c_master_top.v:185
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; prer <= 65535 @i2c_master_top.v:193
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; ctr <= 0 @i2c_master_top.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; txr <= 0 @i2c_master_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; prer <= 65535 @i2c_master_top.v:199
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; ctr <= 0 @i2c_master_top.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; txr <= 0 @i2c_master_top.v:201
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; prer[7:0] <= wb_dat_i @i2c_master_top.v:206
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; prer[15:8] <= wb_dat_i @i2c_master_top.v:207
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; ctr <= wb_dat_i @i2c_master_top.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; txr <= wb_dat_i @i2c_master_top.v:209
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cr <= 0 @i2c_master_top.v:216
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cr <= 0 @i2c_master_top.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cr <= wb_dat_i @i2c_master_top.v:222
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cr[7:4] <= 0 @i2c_master_top.v:227
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cr[2:1] <= 0 @i2c_master_top.v:229
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cr[0] <= 0 @i2c_master_top.v:230
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; al <= 0 @i2c_master_top.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; rxack <= 0 @i2c_master_top.v:270
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; tip <= 0 @i2c_master_top.v:271
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; irq_flag <= 0 @i2c_master_top.v:272
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; al <= 0 @i2c_master_top.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; rxack <= 0 @i2c_master_top.v:277
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; tip <= 0 @i2c_master_top.v:278
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; irq_flag <= 0 @i2c_master_top.v:279
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; al <= (i2c_al)|((al)&(~(sta))) @i2c_master_top.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; rxack <= irxack @i2c_master_top.v:284
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; tip <= (rd)|(wr) @i2c_master_top.v:285
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; irq_flag <= (((done)|(i2c_al))|(irq_flag))&(~(iack)) @i2c_master_top.v:286
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_inta_o <= 0 @i2c_master_top.v:292
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_inta_o <= 0 @i2c_master_top.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_inta_o <= and (irq_flag) (ien) @i2c_master_top.v:296
(check-sat)
(pop)

