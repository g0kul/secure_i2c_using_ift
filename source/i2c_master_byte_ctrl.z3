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
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain_i2c in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter ena in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter clk_cnt in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter cmd in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter cmd_ack in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter busy in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter al in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Data domain))))    ; Instantiate parameter din in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Ctrl domain))))    ; Instantiate parameter dout in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter scl_i in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter scl_o in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter scl_oen in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain_i2c)  (Ctrl domain_i2c))))    ; Instantiate parameter sda_i in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter sda_o in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter sda_oen in module i2c_master_bit_ctrl @i2c_master_byte_ctrl.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (join (join (join (Ctrl domain) (Ctrl domain)) (Ctrl domain)) (Ctrl domain))  (Ctrl domain))))    ; assign go = (((read)|(write))|(stop))&(~(cmd_ack)) @i2c_master_byte_ctrl.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Data domain))))    ; assign dout = sr @i2c_master_byte_ctrl.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; assign cnt_done = ~(|(dcnt)) @i2c_master_byte_ctrl.v:205
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sr <= 0 @i2c_master_byte_ctrl.v:186
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; sr <= 0 @i2c_master_byte_ctrl.v:188
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Ctrl domain))))    ; sr <= din @i2c_master_byte_ctrl.v:190
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sr <= {sr[6:0], core_rxd} @i2c_master_byte_ctrl.v:192
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dcnt <= 0 @i2c_master_byte_ctrl.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; dcnt <= 0 @i2c_master_byte_ctrl.v:199
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; dcnt <= 7 @i2c_master_byte_ctrl.v:201
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; dcnt <= (dcnt)-(1) @i2c_master_byte_ctrl.v:203
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; core_cmd <= 0 @i2c_master_byte_ctrl.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; core_txd <= 0 @i2c_master_byte_ctrl.v:215
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; shift <= 0 @i2c_master_byte_ctrl.v:216
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; ld <= 0 @i2c_master_byte_ctrl.v:217
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_byte_ctrl.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; c_state <= 0 @i2c_master_byte_ctrl.v:219
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; ack_out <= 0 @i2c_master_byte_ctrl.v:220
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 0 @i2c_master_byte_ctrl.v:224
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_txd <= 0 @i2c_master_byte_ctrl.v:225
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; shift <= 0 @i2c_master_byte_ctrl.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; ld <= 0 @i2c_master_byte_ctrl.v:227
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_byte_ctrl.v:228
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_byte_ctrl.v:229
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; ack_out <= 0 @i2c_master_byte_ctrl.v:230
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_txd <= sr[7] @i2c_master_byte_ctrl.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; shift <= 0 @i2c_master_byte_ctrl.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; ld <= 0 @i2c_master_byte_ctrl.v:237
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 0 @i2c_master_byte_ctrl.v:238
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 1 @i2c_master_byte_ctrl.v:246
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 1 @i2c_master_byte_ctrl.v:247
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 2 @i2c_master_byte_ctrl.v:251
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 8 @i2c_master_byte_ctrl.v:252
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 4 @i2c_master_byte_ctrl.v:256
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 4 @i2c_master_byte_ctrl.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 16 @i2c_master_byte_ctrl.v:261
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 2 @i2c_master_byte_ctrl.v:262
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; ld <= 1 @i2c_master_byte_ctrl.v:265
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 2 @i2c_master_byte_ctrl.v:273
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 8 @i2c_master_byte_ctrl.v:274
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 4 @i2c_master_byte_ctrl.v:278
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 4 @i2c_master_byte_ctrl.v:279
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; ld <= 1 @i2c_master_byte_ctrl.v:282
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 8 @i2c_master_byte_ctrl.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 8 @i2c_master_byte_ctrl.v:290
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 4 @i2c_master_byte_ctrl.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 4 @i2c_master_byte_ctrl.v:295
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; shift <= 1 @i2c_master_byte_ctrl.v:296
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 8 @i2c_master_byte_ctrl.v:304
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 4 @i2c_master_byte_ctrl.v:305
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 2 @i2c_master_byte_ctrl.v:309
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 8 @i2c_master_byte_ctrl.v:310
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; shift <= 1 @i2c_master_byte_ctrl.v:313
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_txd <= ack_in @i2c_master_byte_ctrl.v:314
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 16 @i2c_master_byte_ctrl.v:322
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 2 @i2c_master_byte_ctrl.v:323
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_byte_ctrl.v:327
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 0 @i2c_master_byte_ctrl.v:328
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_byte_ctrl.v:331
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; ack_out <= core_rxd @i2c_master_byte_ctrl.v:335
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_txd <= 1 @i2c_master_byte_ctrl.v:337
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_txd <= ack_in @i2c_master_byte_ctrl.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; c_state <= 0 @i2c_master_byte_ctrl.v:345
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; core_cmd <= 0 @i2c_master_byte_ctrl.v:346
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; cmd_ack <= 1 @i2c_master_byte_ctrl.v:349
(check-sat)
(pop)

