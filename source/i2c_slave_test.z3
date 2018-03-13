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
(assert  (not(leq LOW  LOW)))    ; assign M_SEL_ADDR1 = 16 @i2c_slave_test.v:42
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; assign M_SEL_ADDR2 = 32 @i2c_slave_test.v:43
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module i2cSlave @i2c_slave_test.v:45
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter rst in module i2cSlave @i2c_slave_test.v:45
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module i2cSlave @i2c_slave_test.v:45
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter i2c_sl_address in module i2cSlave @i2c_slave_test.v:45
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter sda in module i2cSlave @i2c_slave_test.v:45
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter scl in module i2cSlave @i2c_slave_test.v:45
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain))))    ; Instantiate parameter myReg4 in module i2cSlave @i2c_slave_test.v:45
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain))))    ; Instantiate parameter myReg5 in module i2cSlave @i2c_slave_test.v:45
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain))))    ; Instantiate parameter myReg6 in module i2cSlave @i2c_slave_test.v:45
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain))))    ; Instantiate parameter myReg7 in module i2cSlave @i2c_slave_test.v:45
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter clk in module i2cSlave @i2c_slave_test.v:59
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter rst in module i2cSlave @i2c_slave_test.v:59
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter domain in module i2cSlave @i2c_slave_test.v:59
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter i2c_sl_address in module i2cSlave @i2c_slave_test.v:59
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter sda in module i2cSlave @i2c_slave_test.v:59
(check-sat)
(pop)


(push)
(assert  (not(leq (Ctrl domain)  (Ctrl domain))))    ; Instantiate parameter scl in module i2cSlave @i2c_slave_test.v:59
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain))))    ; Instantiate parameter myReg4 in module i2cSlave @i2c_slave_test.v:59
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain))))    ; Instantiate parameter myReg5 in module i2cSlave @i2c_slave_test.v:59
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain))))    ; Instantiate parameter myReg6 in module i2cSlave @i2c_slave_test.v:59
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Data domain))))    ; Instantiate parameter myReg7 in module i2cSlave @i2c_slave_test.v:59
(check-sat)
(pop)

