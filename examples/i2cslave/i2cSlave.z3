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
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda = 0 @i2cSlave.v:99
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sda = 'bz @i2cSlave.v:99
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; assign sdaIn = sda @i2cSlave.v:100
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; assign rstSyncToClk = rstPipe[1] @i2cSlave.v:110
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Ctrl domain))))    ; rstPipe <= 3 @i2cSlave.v:105
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; rstPipe <= {rstPipe[0], 0} @i2cSlave.v:107
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaPipe <= {((10)*(48))/(48){1}} @i2cSlave.v:115
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaDeb <= 1 @i2cSlave.v:116
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclPipe <= {((10)*(48))/(48){1}} @i2cSlave.v:117
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclDeb <= 1 @i2cSlave.v:118
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaPipe <= {sdaPipe[(((10)*(48))/(48))-(2):0], sdaIn} @i2cSlave.v:121
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclPipe <= {sclPipe[(((10)*(48))/(48))-(2):0], scl} @i2cSlave.v:122
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclDeb <= 1 @i2cSlave.v:124
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclDeb <= 0 @i2cSlave.v:126
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaDeb <= 1 @i2cSlave.v:128
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaDeb <= 0 @i2cSlave.v:130
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclDelayed <= {((10)*(48))/(48){1}} @i2cSlave.v:143
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaDelayed <= {((4)*(48))/(48){1}} @i2cSlave.v:144
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sclDelayed <= {sclDelayed[(((10)*(48))/(48))-(2):0], sclDeb} @i2cSlave.v:147
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; sdaDelayed <= {sdaDelayed[(((4)*(48))/(48))-(2):0], sdaDeb} @i2cSlave.v:148
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startStopDetState <= 0 @i2cSlave.v:155
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startEdgeDet <= 0 @i2cSlave.v:156
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startEdgeDet <= 1 @i2cSlave.v:160
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startEdgeDet <= 0 @i2cSlave.v:162
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startStopDetState <= 0 @i2cSlave.v:164
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startStopDetState <= 2 @i2cSlave.v:167
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; startStopDetState <= 1 @i2cSlave.v:169
(check-sat)
(pop)

