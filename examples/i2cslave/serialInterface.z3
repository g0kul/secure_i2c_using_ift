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
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; NextState_SISt <= CurrState_SISt @serialInterface.v:145
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_streamSt <= streamSt @serialInterface.v:147
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_txData <= txData @serialInterface.v:148
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_rxData <= rxData @serialInterface.v:149
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_sdaOut <= sdaOut @serialInterface.v:150
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_writeEn <= writeEn @serialInterface.v:151
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Data domain))))    ; next_dataOut <= dataOut @serialInterface.v:152
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_bitCnt <= bitCnt @serialInterface.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_clearStartStopDet <= clearStartStopDet @serialInterface.v:154
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_regAddr <= regAddr @serialInterface.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_streamSt <= 0 @serialInterface.v:159
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_txData <= 0 @serialInterface.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_rxData <= 0 @serialInterface.v:161
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_sdaOut <= 1 @serialInterface.v:162
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_writeEn <= 0 @serialInterface.v:163
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Data domain))))    ; next_dataOut <= 0 @serialInterface.v:164
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_bitCnt <= 0 @serialInterface.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_clearStartStopDet <= 0 @serialInterface.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; NextState_SISt <= 1 @serialInterface.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 2 @serialInterface.v:173
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_txData <= dataIn @serialInterface.v:174
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_regAddr <= (regAddr)+(1) @serialInterface.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_bitCnt <= 1 @serialInterface.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 8 @serialInterface.v:180
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_rxData <= 0 @serialInterface.v:181
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 3 @serialInterface.v:188
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_sdaOut <= txData[7] @serialInterface.v:189
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_txData <= {txData[6:0], 0} @serialInterface.v:190
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 4 @serialInterface.v:197
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 5 @serialInterface.v:204
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 2 @serialInterface.v:208
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_bitCnt <= (bitCnt)+(1) @serialInterface.v:209
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 6 @serialInterface.v:216
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_sdaOut <= 1 @serialInterface.v:217
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 1 @serialInterface.v:224
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_streamSt <= 0 @serialInterface.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 15 @serialInterface.v:234
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_bitCnt <= (bitCnt)+(1) @serialInterface.v:237
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_streamSt <= 0 @serialInterface.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_rxData <= 0 @serialInterface.v:240
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_streamSt <= 0 @serialInterface.v:244
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_clearStartStopDet <= 1 @serialInterface.v:245
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; NextState_SISt <= 11 @serialInterface.v:249
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))))  (Ctrl domain))))    ; next_bitCnt <= (bitCnt)+(1) @serialInterface.v:252
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_streamSt <= 0 @serialInterface.v:254
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_rxData <= 0 @serialInterface.v:255
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 7 @serialInterface.v:265
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_rxData <= {rxData[6:0], sdaIn} @serialInterface.v:266
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_bitCnt <= 0 @serialInterface.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 14 @serialInterface.v:274
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_sdaOut <= 0 @serialInterface.v:275
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))))  (Ctrl domain))))    ; next_streamSt <= 1 @serialInterface.v:281
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))))  (Ctrl domain))))    ; next_streamSt <= 2 @serialInterface.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_sdaOut <= 1 @serialInterface.v:286
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_streamSt <= 3 @serialInterface.v:289
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_regAddr <= rxData @serialInterface.v:290
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Data domain))))    ; next_dataOut <= rxData @serialInterface.v:293
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_writeEn <= 1 @serialInterface.v:294
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_streamSt <= streamSt @serialInterface.v:297
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 11 @serialInterface.v:302
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_bitCnt <= (bitCnt)+(1) @serialInterface.v:303
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 9 @serialInterface.v:310
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 10 @serialInterface.v:317
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_rxData <= {rxData[6:0], sdaIn} @serialInterface.v:318
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 1 @serialInterface.v:325
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_sdaOut <= 1 @serialInterface.v:326
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_clearStartStopDet <= 0 @serialInterface.v:331
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 12 @serialInterface.v:334
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_regAddr <= (regAddr)+(1) @serialInterface.v:340
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_writeEn <= 0 @serialInterface.v:341
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_clearStartStopDet <= 1 @serialInterface.v:342
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; NextState_SISt <= 13 @serialInterface.v:343
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_clearStartStopDet <= 0 @serialInterface.v:347
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; NextState_SISt <= 1 @serialInterface.v:348
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; CurrState_SISt <= 0 @serialInterface.v:357
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; CurrState_SISt <= NextState_SISt @serialInterface.v:359
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaOut <= 1 @serialInterface.v:367
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; writeEn <= 0 @serialInterface.v:368
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Data domain))))    ; dataOut <= 0 @serialInterface.v:369
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clearStartStopDet <= 0 @serialInterface.v:370
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; streamSt <= 0 @serialInterface.v:372
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; txData <= 0 @serialInterface.v:373
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; rxData <= 0 @serialInterface.v:374
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; bitCnt <= 0 @serialInterface.v:375
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaOut <= next_sdaOut @serialInterface.v:379
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; writeEn <= next_writeEn @serialInterface.v:380
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Data domain))))    ; dataOut <= next_dataOut @serialInterface.v:381
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clearStartStopDet <= next_clearStartStopDet @serialInterface.v:382
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; regAddr <= next_regAddr @serialInterface.v:383
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; streamSt <= next_streamSt @serialInterface.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; txData <= next_txData @serialInterface.v:385
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; rxData <= next_rxData @serialInterface.v:386
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; bitCnt <= next_bitCnt @serialInterface.v:387
(check-sat)
(pop)

