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
(declare-fun Domain (Int) Label)
(assert (= (Domain 0) D1))
(assert (= (Domain 1) D2))

; assertions to be verified

(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter d1 in module submodule2 @submodule2_check_top.v:21
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter d2 in module submodule2 @submodule2_check_top.v:21
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel in module submodule2 @submodule2_check_top.v:21
(check-sat)
(pop)


(push)
(assert  (not(leq D1  (Domain 0))))    ; Instantiate parameter d3 in module submodule2 @submodule2_check_top.v:21
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 0)  D1)))    ; Instantiate parameter out in module submodule2 @submodule2_check_top.v:21
(check-sat)
(pop)


(push)
(assert  (not(leq D1  D1)))    ; Instantiate parameter d1 in module submodule2 @submodule2_check_top.v:30
(check-sat)
(pop)


(push)
(assert  (not(leq D2  D2)))    ; Instantiate parameter d2 in module submodule2 @submodule2_check_top.v:30
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; Instantiate parameter sel in module submodule2 @submodule2_check_top.v:30
(check-sat)
(pop)


(push)
(assert  (not(leq D2  (Domain 1))))    ; Instantiate parameter d3 in module submodule2 @submodule2_check_top.v:30
(check-sat)
(pop)


(push)
(assert  (not(leq (Domain 1)  D2)))    ; Instantiate parameter out in module submodule2 @submodule2_check_top.v:30
(check-sat)
(pop)

