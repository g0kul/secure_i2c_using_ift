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
(assert  (not(leq LOW  LOW)))    ; assign scl_in = SCL @I2C_master.v:29
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; SCL = 'bz @I2C_master.v:30
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; SCL = 0 @I2C_master.v:30
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign sda_in = SDA @I2C_master.v:32
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; SDA = 'bz @I2C_master.v:33
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; SDA = 0 @I2C_master.v:33
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign t_hd_sta = (4)*(freq) @I2C_master.v:35
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign t_low = (5)*(freq) @I2C_master.v:36
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign t_high = (5)*(freq) @I2C_master.v:37
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign t_su_sta = (5)*(freq) @I2C_master.v:38
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign t_su_dat = ((freq)>>(2))+(1) @I2C_master.v:39
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign t_hold = ((freq)>>(1))+(1) @I2C_master.v:40
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign t_su_sto = (4)*(freq) @I2C_master.v:41
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign time_width = clogb2((t_low)+(1)) @I2C_master.v:43
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign pre_start_up = 0 @I2C_master.v:117
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign start_up = 1 @I2C_master.v:118
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign idle = 2 @I2C_master.v:119
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign start = 3 @I2C_master.v:120
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign clock_low = 4 @I2C_master.v:121
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign shift_data = 5 @I2C_master.v:122
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign clock_high = 6 @I2C_master.v:123
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign stop = 7 @I2C_master.v:124
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign spin = 15 @I2C_master.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_sr <= 15 @I2C_master.v:101
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda <= 1 @I2C_master.v:102
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_sr <= 15 @I2C_master.v:103
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl <= 1 @I2C_master.v:104
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda_sr <= {sda_sr[2:0], sda_in} @I2C_master.v:108
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda <= 0 @I2C_master.v:109
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; sda <= 1 @I2C_master.v:110
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_sr <= {scl_sr[2:0], scl_in} @I2C_master.v:111
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl <= 0 @I2C_master.v:112
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl <= 1 @I2C_master.v:113
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_low @I2C_master.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= pre_start_up @I2C_master.v:131
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; rtn_state <= pre_start_up @I2C_master.v:132
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; ctrl_reg <= 0 @I2C_master.v:133
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; status <= 2214592512 @I2C_master.v:134
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; shift_reg <= {27{1}} @I2C_master.v:135
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; bit_count <= 0 @I2C_master.v:136
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_sda <= 1 @I2C_master.v:137
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_scl <= 1 @I2C_master.v:138
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wr_cyc <= 1 @I2C_master.v:139
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; read_data <= 0 @I2C_master.v:140
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_startup_count <= 0 @I2C_master.v:141
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; status[27] <= 1 @I2C_master.v:149
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; ctrl_reg <= ctrl_data @I2C_master.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; status[27] <= 0 @I2C_master.v:154
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_startup_count <= 0 @I2C_master.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= start_up @I2C_master.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_scl <= 0 @I2C_master.v:172
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_low @I2C_master.v:173
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_startup_count <= (scl_startup_count)+(1) @I2C_master.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_scl <= 1 @I2C_master.v:179
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_low @I2C_master.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= (timer)-(1) @I2C_master.v:185
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_low @I2C_master.v:193
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; scl_startup_count <= (scl_startup_count)+(1) @I2C_master.v:194
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_sda <= 0 @I2C_master.v:195
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_sda <= 1 @I2C_master.v:196
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= idle @I2C_master.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= (timer)-(1) @I2C_master.v:201
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_sda <= 1 @I2C_master.v:206
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_scl <= 1 @I2C_master.v:207
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wr_cyc <= 1 @I2C_master.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; status[31] <= 0 @I2C_master.v:209
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; status[26] <= 0 @I2C_master.v:210
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= start @I2C_master.v:213
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; status[31] <= 1 @I2C_master.v:214
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_sda <= 0 @I2C_master.v:221
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_scl <= 1 @I2C_master.v:222
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; shift_reg <= {ctrl_reg[23:17], 0, 1, ctrl_reg[15:8], 1, ctrl_reg[30], 0, 0} @I2C_master.v:231
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; shift_reg <= {ctrl_reg[23:17], 1, 1, 255, 1, 0, 0} @I2C_master.v:233
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; shift_reg <= {ctrl_reg[23:17], 0, 1, ctrl_reg[15:8], 1, ctrl_reg[7:0], 1} @I2C_master.v:235
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; bit_count <= 0 @I2C_master.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_hd_sta @I2C_master.v:237
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; rtn_state <= clock_low @I2C_master.v:238
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= spin @I2C_master.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_scl <= 0 @I2C_master.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_hold @I2C_master.v:248
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; rtn_state <= shift_data @I2C_master.v:249
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= spin @I2C_master.v:250
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_sda <= shift_reg[26] @I2C_master.v:256
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; shift_reg <= {shift_reg[25:0], 0} @I2C_master.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_low @I2C_master.v:258
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; rtn_state <= clock_high @I2C_master.v:259
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= spin @I2C_master.v:260
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_scl <= 1 @I2C_master.v:266
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; bit_count <= (bit_count)+(1) @I2C_master.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; status[30] <= sda @I2C_master.v:272
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; status[29] <= sda @I2C_master.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_su_sto @I2C_master.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; rtn_state <= stop @I2C_master.v:282
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= spin @I2C_master.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; read_data <= {read_data[6:0], sda} @I2C_master.v:287
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_high @I2C_master.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; rtn_state <= clock_low @I2C_master.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= spin @I2C_master.v:290
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; float_sda <= 1 @I2C_master.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= (t_su_sta)-(t_su_sto) @I2C_master.v:307
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_su_sta @I2C_master.v:309
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; rtn_state <= start @I2C_master.v:310
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; status[7:0] <= read_data @I2C_master.v:314
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; status[28] <= 1 @I2C_master.v:315
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_su_sta @I2C_master.v:316
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; rtn_state <= idle @I2C_master.v:317
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; wr_cyc <= 0 @I2C_master.v:319
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= spin @I2C_master.v:320
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; status[28] <= 0 @I2C_master.v:324
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= t_su_sta @I2C_master.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; rtn_state <= idle @I2C_master.v:326
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= spin @I2C_master.v:327
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; timer <= (timer)-(1) @I2C_master.v:336
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; state <= rtn_state @I2C_master.v:340
(check-sat)
(pop)

