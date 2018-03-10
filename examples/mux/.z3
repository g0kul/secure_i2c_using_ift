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
(declare-fun L1 () Label)
(declare-fun L2 () Label)

; lattice structure
(assert (leq L1 L2))

; variables to be solved
(declare-fun sel () Int)
(assert (<= 0  sel))
(assert (<= sel 1))

; function that maps 0 to LOW; 1 to HIGH
(declare-fun LH (Int) Label)
(assert (= (LH 0) LOW))
(assert (= (LH 1) HIGH))
; Domain(0)=L1, Domain(1)=L2
(declare-fun Domain (Int) Label)
(assert (= (Domain 0) L1))
(assert (= (Domain 1) L2))

; assertions to be verified

(push)
(assert  (not(leq LOW  LOW)))    ; assign const = 'bz @./muxgp.v:12
(check-sat)
(pop)


(push)
(assert (and (= sel 1)  (not(leq L2  (Domain sel)))))    ; out = in2 @./muxgp.v:19
(check-sat)
(pop)


(push)
(assert (and (not(= sel 1))  (not(leq LOW  (Domain sel)))))    ; out = const @./muxgp.v:19
(check-sat)
(pop)


(push)
(assert (and (= sel 0)  (not(leq (Domain sel)  L1))))    ; out2 = out @./muxgp.v:16
(check-sat)
(pop)

