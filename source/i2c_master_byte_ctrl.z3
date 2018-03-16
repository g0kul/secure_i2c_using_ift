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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter rst in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter nReset in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain_i2c in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter ena in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk_cnt in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter cmd in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter cmd_ack in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter busy in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter al in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter din in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter dout in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter scl_i in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter scl_o in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter scl_oen in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter sda_i in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sda_o in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sda_oen in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign go = (((read)|(write))|(stop))&(~(cmd_ack)) @i2c_master_byte_ctrl.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; assign dout = sr_rx @i2c_master_byte_ctrl.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign cnt_done = ~(|(dcnt)) @i2c_master_byte_ctrl.v:211
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sr_tx <= 0 @i2c_master_byte_ctrl.v:185
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sr_tx <= 0 @i2c_master_byte_ctrl.v:187
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sr_tx <= din @i2c_master_byte_ctrl.v:189
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sr_rx <= 0 @i2c_master_byte_ctrl.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; sr_rx <= 0 @i2c_master_byte_ctrl.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; sr_rx <= {sr_rx[6:0], core_rxd} @i2c_master_byte_ctrl.v:198
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; dcnt <= 0 @i2c_master_byte_ctrl.v:203
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; dcnt <= 0 @i2c_master_byte_ctrl.v:205
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; dcnt <= 7 @i2c_master_byte_ctrl.v:207
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; dcnt <= (dcnt)-(1) @i2c_master_byte_ctrl.v:209
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 0 @i2c_master_byte_ctrl.v:220
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_txd <= 0 @i2c_master_byte_ctrl.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; shift <= 0 @i2c_master_byte_ctrl.v:222
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; ld <= 0 @i2c_master_byte_ctrl.v:223
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 0 @i2c_master_byte_ctrl.v:224
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 0 @i2c_master_byte_ctrl.v:225
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; ack_out <= 0 @i2c_master_byte_ctrl.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 0 @i2c_master_byte_ctrl.v:230
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_txd <= 0 @i2c_master_byte_ctrl.v:231
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; shift <= 0 @i2c_master_byte_ctrl.v:232
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; ld <= 0 @i2c_master_byte_ctrl.v:233
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 0 @i2c_master_byte_ctrl.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 0 @i2c_master_byte_ctrl.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain_i2c))))    ; ack_out <= 0 @i2c_master_byte_ctrl.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_txd <= sr_tx[7] @i2c_master_byte_ctrl.v:241
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; shift <= 0 @i2c_master_byte_ctrl.v:242
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; ld <= 0 @i2c_master_byte_ctrl.v:243
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 0 @i2c_master_byte_ctrl.v:244
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 1 @i2c_master_byte_ctrl.v:252
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 1 @i2c_master_byte_ctrl.v:253
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 2 @i2c_master_byte_ctrl.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 8 @i2c_master_byte_ctrl.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 4 @i2c_master_byte_ctrl.v:262
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 4 @i2c_master_byte_ctrl.v:263
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 16 @i2c_master_byte_ctrl.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 2 @i2c_master_byte_ctrl.v:268
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; ld <= 1 @i2c_master_byte_ctrl.v:271
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 2 @i2c_master_byte_ctrl.v:279
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 8 @i2c_master_byte_ctrl.v:280
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 4 @i2c_master_byte_ctrl.v:284
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 4 @i2c_master_byte_ctrl.v:285
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; ld <= 1 @i2c_master_byte_ctrl.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 8 @i2c_master_byte_ctrl.v:295
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 8 @i2c_master_byte_ctrl.v:296
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 4 @i2c_master_byte_ctrl.v:300
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 4 @i2c_master_byte_ctrl.v:301
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; shift <= 1 @i2c_master_byte_ctrl.v:302
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 8 @i2c_master_byte_ctrl.v:310
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 4 @i2c_master_byte_ctrl.v:311
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 2 @i2c_master_byte_ctrl.v:315
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 8 @i2c_master_byte_ctrl.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; shift <= 1 @i2c_master_byte_ctrl.v:319
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_txd <= ack_in @i2c_master_byte_ctrl.v:320
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 16 @i2c_master_byte_ctrl.v:328
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 2 @i2c_master_byte_ctrl.v:329
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 0 @i2c_master_byte_ctrl.v:333
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 0 @i2c_master_byte_ctrl.v:334
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 1 @i2c_master_byte_ctrl.v:337
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; ack_out <= core_rxd @i2c_master_byte_ctrl.v:341
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_txd <= 1 @i2c_master_byte_ctrl.v:343
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_txd <= ack_in @i2c_master_byte_ctrl.v:346
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; c_state <= 0 @i2c_master_byte_ctrl.v:351
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; core_cmd <= 0 @i2c_master_byte_ctrl.v:352
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cmd_ack <= 1 @i2c_master_byte_ctrl.v:355
(check-sat)
(pop)

