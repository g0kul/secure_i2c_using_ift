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
;(assert (= (Data 2) LOW))
;(assert (= (Data 3) HIGH))

; function for control signals
(declare-fun Ctrl (Int) Label)
(assert (= (Ctrl 0) D1))
(assert (= (Ctrl 1) D2))
;(assert (= (Ctrl 2) LOW))
;(assert (= (Ctrl 3) HIGH))

; assertions to be verified

(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda = 0 @i2cSlave.v:103
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda = 'bz @i2cSlave.v:103
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; assign sdaIn = sda @i2cSlave.v:104
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; assign rstSyncToClk = rstPipe[1] @i2cSlave.v:114
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter addr in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter dataIn in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter writeEn in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter dataOut in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter myReg0 in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter myReg1 in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter myReg2 in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter myReg3 in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter myReg4 in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter myReg5 in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter myReg6 in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter myReg7 in module registerInterface @i2cSlave.v:183
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; Instantiate parameter clk in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter rst in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter i2c_sl_address in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter dataIn in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Data domain)  (Data domain))))    ; Instantiate parameter dataOut in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter writeEn in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter regAddr in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter scl in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter sdaIn in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter sdaOut in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter startStopDetState in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter clearStartStopDet in module serialInterface @i2cSlave.v:200
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; rstPipe <= 3 @i2cSlave.v:109
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; rstPipe <= {rstPipe[0], 0} @i2cSlave.v:111
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaPipe <= {10{1}} @i2cSlave.v:119
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaDeb <= 1 @i2cSlave.v:120
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclPipe <= {10{1}} @i2cSlave.v:121
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclDeb <= 1 @i2cSlave.v:122
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaPipe <= {sdaPipe[8:0], sdaIn} @i2cSlave.v:125
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclPipe <= {sclPipe[8:0], scl} @i2cSlave.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclDeb <= 1 @i2cSlave.v:129
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclDeb <= 0 @i2cSlave.v:132
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaDeb <= 1 @i2cSlave.v:135
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaDeb <= 0 @i2cSlave.v:138
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclDelayed <= {10{1}} @i2cSlave.v:151
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaDelayed <= {10{1}} @i2cSlave.v:152
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclDelayed <= {sclDelayed[8:0], sclDeb} @i2cSlave.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaDelayed <= {sdaDelayed[8:0], sdaDeb} @i2cSlave.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startStopDetState <= 0 @i2cSlave.v:163
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startEdgeDet <= 0 @i2cSlave.v:164
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startEdgeDet <= 1 @i2cSlave.v:168
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startEdgeDet <= 0 @i2cSlave.v:170
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startStopDetState <= 0 @i2cSlave.v:172
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startStopDetState <= 2 @i2cSlave.v:175
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startStopDetState <= 1 @i2cSlave.v:177
(check-sat)
(pop)

