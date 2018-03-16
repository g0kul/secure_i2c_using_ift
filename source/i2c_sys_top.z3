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
(assert  (not(leq LOW  LOW)))    ; assign done = done_r @i2c_sys_top.v:378
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  (Data domain_i2c))))    ; assign read_data_out = wb_rd_data_r @i2c_sys_top.v:379
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = wb_state @i2c_sys_top.v:119
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state_d1 = wb_state_d1 @i2c_sys_top.v:120
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cr_data = wb_cr_data @i2c_sys_top.v:121
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  (Data domain_i2c))))    ; n_wb_rd_data = wb_rd_data_r @i2c_sys_top.v:122
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_addr = {3{'bx}} @i2c_sys_top.v:124
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_wr_data = {8{'bx}} @i2c_sys_top.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 0 @i2c_sys_top.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 0 @i2c_sys_top.v:127
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 0 @i2c_sys_top.v:128
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_done = 0 @i2c_sys_top.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = 1 @i2c_sys_top.v:137
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_addr = 0 @i2c_sys_top.v:145
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_wr_data = 200 @i2c_sys_top.v:146
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 1 @i2c_sys_top.v:147
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 1 @i2c_sys_top.v:148
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 1 @i2c_sys_top.v:149
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 'bx @i2c_sys_top.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 'bx @i2c_sys_top.v:154
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 0 @i2c_sys_top.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = 2 @i2c_sys_top.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_addr = 1 @i2c_sys_top.v:164
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_wr_data = 0 @i2c_sys_top.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 1 @i2c_sys_top.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 1 @i2c_sys_top.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 1 @i2c_sys_top.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 'bx @i2c_sys_top.v:172
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 'bx @i2c_sys_top.v:173
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 0 @i2c_sys_top.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = 3 @i2c_sys_top.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_addr = 2 @i2c_sys_top.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_wr_data = 128 @i2c_sys_top.v:184
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 1 @i2c_sys_top.v:185
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 1 @i2c_sys_top.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 1 @i2c_sys_top.v:187
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 'bx @i2c_sys_top.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 'bx @i2c_sys_top.v:192
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 0 @i2c_sys_top.v:193
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = 4 @i2c_sys_top.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state_d1 = 7 @i2c_sys_top.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_addr = 3 @i2c_sys_top.v:205
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_wr_data = {slave_addr, 0} @i2c_sys_top.v:206
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 1 @i2c_sys_top.v:207
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 1 @i2c_sys_top.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 1 @i2c_sys_top.v:209
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 'bx @i2c_sys_top.v:213
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 'bx @i2c_sys_top.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 0 @i2c_sys_top.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = 5 @i2c_sys_top.v:217
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cr_data = 144 @i2c_sys_top.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_addr = 4 @i2c_sys_top.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_wr_data = wb_cr_data @i2c_sys_top.v:227
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 1 @i2c_sys_top.v:228
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 1 @i2c_sys_top.v:229
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 1 @i2c_sys_top.v:230
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 'bx @i2c_sys_top.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 'bx @i2c_sys_top.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 0 @i2c_sys_top.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = 6 @i2c_sys_top.v:238
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_addr = 4 @i2c_sys_top.v:246
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 0 @i2c_sys_top.v:247
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 1 @i2c_sys_top.v:248
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 1 @i2c_sys_top.v:249
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  LOW)))    ; n_wb_addr = 4 @i2c_sys_top.v:253
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  LOW)))    ; n_wb_we = 0 @i2c_sys_top.v:254
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  LOW)))    ; n_wb_stb = 1 @i2c_sys_top.v:255
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  LOW)))    ; n_wb_cyc = 1 @i2c_sys_top.v:256
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 'bx @i2c_sys_top.v:259
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 'bx @i2c_sys_top.v:260
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 0 @i2c_sys_top.v:261
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = wb_state_d1 @i2c_sys_top.v:263
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_addr = 3 @i2c_sys_top.v:271
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_wr_data = 6 @i2c_sys_top.v:272
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 1 @i2c_sys_top.v:273
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 1 @i2c_sys_top.v:274
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 1 @i2c_sys_top.v:275
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 'bx @i2c_sys_top.v:279
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 'bx @i2c_sys_top.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 0 @i2c_sys_top.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = 5 @i2c_sys_top.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cr_data = 16 @i2c_sys_top.v:284
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state_d1 = 8 @i2c_sys_top.v:285
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_addr = 3 @i2c_sys_top.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_wr_data = {slave_addr, 1} @i2c_sys_top.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 1 @i2c_sys_top.v:295
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 1 @i2c_sys_top.v:296
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 1 @i2c_sys_top.v:297
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 'bx @i2c_sys_top.v:301
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 'bx @i2c_sys_top.v:302
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 0 @i2c_sys_top.v:303
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = 5 @i2c_sys_top.v:305
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cr_data = 144 @i2c_sys_top.v:306
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state_d1 = 9 @i2c_sys_top.v:307
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = 5 @i2c_sys_top.v:313
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cr_data = 40 @i2c_sys_top.v:314
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state_d1 = 10 @i2c_sys_top.v:315
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_addr = 3 @i2c_sys_top.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 0 @i2c_sys_top.v:323
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 1 @i2c_sys_top.v:324
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 1 @i2c_sys_top.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  (Data domain_i2c))))    ; n_wb_rd_data = wb_rd_i2c_data @i2c_sys_top.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_we = 'bx @i2c_sys_top.v:330
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_stb = 'bx @i2c_sys_top.v:331
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_cyc = 0 @i2c_sys_top.v:332
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_done = 1 @i2c_sys_top.v:334
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; n_wb_state = 0 @i2c_sys_top.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_state <= 0 @i2c_sys_top.v:348
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_state_d1 <= 0 @i2c_sys_top.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_cr_data <= {8{0}} @i2c_sys_top.v:350
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain_i2c))))    ; wb_rd_data_r <= {8{'bx}} @i2c_sys_top.v:351
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_addr <= {3{'bx}} @i2c_sys_top.v:353
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_wr_data <= {8{'bx}} @i2c_sys_top.v:354
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_we <= 0 @i2c_sys_top.v:355
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_stb <= 0 @i2c_sys_top.v:356
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_cyc <= 0 @i2c_sys_top.v:357
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; done_r <= 0 @i2c_sys_top.v:359
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_state <= n_wb_state @i2c_sys_top.v:363
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_state_d1 <= n_wb_state_d1 @i2c_sys_top.v:364
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_cr_data <= n_wb_cr_data @i2c_sys_top.v:365
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain_i2c)  (Data domain_i2c))))    ; wb_rd_data_r <= n_wb_rd_data @i2c_sys_top.v:366
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_addr <= n_wb_addr @i2c_sys_top.v:368
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_wr_data <= n_wb_wr_data @i2c_sys_top.v:369
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_we <= n_wb_we @i2c_sys_top.v:370
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_stb <= n_wb_stb @i2c_sys_top.v:371
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wb_cyc <= n_wb_cyc @i2c_sys_top.v:372
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; done_r <= n_done @i2c_sys_top.v:374
(check-sat)
(pop)

