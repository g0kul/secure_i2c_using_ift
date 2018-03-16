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
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; NextState_SISt <= CurrState_SISt @serialInterface.v:147
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_streamSt <= streamSt @serialInterface.v:149
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_txData <= txData @serialInterface.v:150
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_rxData <= rxData @serialInterface.v:151
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_sdaOut <= sdaOut @serialInterface.v:152
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_writeEn <= writeEn @serialInterface.v:153
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Data domain))))    ; next_dataOut <= dataOut @serialInterface.v:154
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_bitCnt <= bitCnt @serialInterface.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_clearStartStopDet <= clearStartStopDet @serialInterface.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_regAddr <= regAddr @serialInterface.v:157
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_streamSt <= 0 @serialInterface.v:161
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_txData <= 0 @serialInterface.v:162
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_rxData <= 0 @serialInterface.v:163
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_sdaOut <= 1 @serialInterface.v:164
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_writeEn <= 0 @serialInterface.v:165
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Data domain))))    ; next_dataOut <= 0 @serialInterface.v:166
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_bitCnt <= 0 @serialInterface.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_clearStartStopDet <= 0 @serialInterface.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; NextState_SISt <= 1 @serialInterface.v:169
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 2 @serialInterface.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_txData <= dataIn @serialInterface.v:176
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_regAddr <= (regAddr)+(1) @serialInterface.v:177
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_bitCnt <= 1 @serialInterface.v:178
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 8 @serialInterface.v:182
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_rxData <= 0 @serialInterface.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 3 @serialInterface.v:190
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_sdaOut <= txData[7] @serialInterface.v:191
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_txData <= {txData[6:0], 0} @serialInterface.v:192
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 4 @serialInterface.v:199
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 5 @serialInterface.v:206
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 2 @serialInterface.v:210
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_bitCnt <= (bitCnt)+(1) @serialInterface.v:211
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 6 @serialInterface.v:218
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_sdaOut <= 1 @serialInterface.v:219
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 1 @serialInterface.v:226
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_streamSt <= 0 @serialInterface.v:228
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 15 @serialInterface.v:236
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_bitCnt <= (bitCnt)+(1) @serialInterface.v:239
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_streamSt <= 0 @serialInterface.v:241
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_rxData <= 0 @serialInterface.v:242
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_streamSt <= 0 @serialInterface.v:246
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_clearStartStopDet <= 1 @serialInterface.v:247
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; NextState_SISt <= 11 @serialInterface.v:251
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))))  (Ctrl domain))))    ; next_bitCnt <= (bitCnt)+(1) @serialInterface.v:254
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_streamSt <= 0 @serialInterface.v:256
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_rxData <= 0 @serialInterface.v:257
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 7 @serialInterface.v:267
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_rxData <= {rxData[6:0], sdaIn} @serialInterface.v:268
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_bitCnt <= 0 @serialInterface.v:269
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 14 @serialInterface.v:276
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_sdaOut <= 0 @serialInterface.v:277
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))))  (Ctrl domain))))    ; next_streamSt <= 1 @serialInterface.v:283
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))))  (Ctrl domain))))    ; next_streamSt <= 2 @serialInterface.v:285
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_sdaOut <= 1 @serialInterface.v:288
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_streamSt <= 3 @serialInterface.v:291
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_regAddr <= rxData @serialInterface.v:292
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Data domain))))    ; next_dataOut <= rxData @serialInterface.v:295
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_writeEn <= 1 @serialInterface.v:296
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))))  (Ctrl domain))))    ; next_streamSt <= streamSt @serialInterface.v:299
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 11 @serialInterface.v:304
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_bitCnt <= (bitCnt)+(1) @serialInterface.v:305
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 9 @serialInterface.v:312
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 10 @serialInterface.v:319
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_rxData <= {rxData[6:0], sdaIn} @serialInterface.v:320
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 1 @serialInterface.v:327
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; next_sdaOut <= 1 @serialInterface.v:328
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_clearStartStopDet <= 0 @serialInterface.v:333
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain))))  (Ctrl domain))))    ; NextState_SISt <= 12 @serialInterface.v:336
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (Ctrl domain) (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))))  (Ctrl domain))))    ; next_regAddr <= (regAddr)+(1) @serialInterface.v:342
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_writeEn <= 0 @serialInterface.v:343
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_clearStartStopDet <= 1 @serialInterface.v:344
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; NextState_SISt <= 13 @serialInterface.v:345
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; next_clearStartStopDet <= 0 @serialInterface.v:349
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Ctrl domain) (join (join (join (join (join (join (Ctrl domain) (Data domain)) (Ctrl domain)) (Ctrl domain)) (Data domain)) (Ctrl domain)) (Ctrl domain)))  (Ctrl domain))))    ; NextState_SISt <= 1 @serialInterface.v:350
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; CurrState_SISt <= 0 @serialInterface.v:359
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; CurrState_SISt <= NextState_SISt @serialInterface.v:361
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaOut <= 1 @serialInterface.v:369
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; writeEn <= 0 @serialInterface.v:370
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Data domain))))    ; dataOut <= 0 @serialInterface.v:371
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clearStartStopDet <= 0 @serialInterface.v:372
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; streamSt <= 0 @serialInterface.v:374
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; txData <= 0 @serialInterface.v:375
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; rxData <= 0 @serialInterface.v:376
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; bitCnt <= 0 @serialInterface.v:377
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaOut <= next_sdaOut @serialInterface.v:381
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; writeEn <= next_writeEn @serialInterface.v:382
(check-sat)
(pop)


(push)
(assert  (not(leq (join (Data domain) (Ctrl domain))  (Data domain))))    ; dataOut <= next_dataOut @serialInterface.v:383
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; clearStartStopDet <= next_clearStartStopDet @serialInterface.v:384
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; regAddr <= next_regAddr @serialInterface.v:385
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; streamSt <= next_streamSt @serialInterface.v:386
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; txData <= next_txData @serialInterface.v:387
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; rxData <= next_rxData @serialInterface.v:388
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; bitCnt <= next_bitCnt @serialInterface.v:389
(check-sat)
(pop)

