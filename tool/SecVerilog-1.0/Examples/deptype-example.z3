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
(declare-fun cur_state () Int)
(assert (<= 0  cur_state))
(assert (<= cur_state 3))
(declare-fun next_state () Int)
(assert (<= 0  next_state))
(assert (<= next_state 3))

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
(declare-fun cur_state30 () Int)
(assert (<= 0  cur_state30))
(assert (<= cur_state30 3))
(assert (and (= cur_state30 next_state)  (not(leq (Par next_state)  (Par cur_state30)))))    ; cur_state <= next_state @deptype-example.v:30
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; cur_timer <= next_timer @deptype-example.v:31
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; mode <= ~(mode) @deptype-example.v:36
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; next_timer <= 10 @deptype-example.v:37
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Par next_state))))    ; no-sensitive-upgrade check next_state <= 1 @deptype-example.v:39
(check-sat)
(pop)


(push)
(declare-fun next_state39 () Int)
(assert (<= 0  next_state39))
(assert (<= next_state39 3))
(assert (and (= next_state39 1)  (not(leq LOW  (Par next_state39)))))    ; next_state <= 1 @deptype-example.v:39
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  (Par next_state))))    ; no-sensitive-upgrade check next_state <= 0 @deptype-example.v:42
(check-sat)
(pop)


(push)
(declare-fun next_state42 () Int)
(assert (<= 0  next_state42))
(assert (<= next_state42 3))
(assert (and (= next_state42 0)  (not(leq LOW  (Par next_state42)))))    ; next_state <= 0 @deptype-example.v:42
(check-sat)
(pop)


(push)
(assert  (not(leq LOW  LOW)))    ; next_timer <= (cur_timer)-(1) @deptype-example.v:46
(check-sat)
(pop)


(push)
(assert (and (= cur_state 0)  (not(leq (Par cur_state)  LOW))))    ; out <= 15 @deptype-example.v:49
(check-sat)
(pop)


(push)
(assert (and (= cur_state 0) (= cur_state 1)  (not(leq HIGH  (Par next_state)))))    ; no-sensitive-upgrade check next_state <= 2 @deptype-example.v:54
(check-sat)
(pop)


(push)
(declare-fun next_state54 () Int)
(assert (<= 0  next_state54))
(assert (<= next_state54 3))
(assert (and (= cur_state 0) (= cur_state 1) (= next_state54 2)  (not(leq HIGH  (Par next_state54)))))    ; next_state <= 2 @deptype-example.v:54
(check-sat)
(pop)


(push)
(assert (and (= cur_state 0) (= cur_state 1) (= cur_state 2)  (not(leq HIGH  (Par next_state)))))    ; no-sensitive-upgrade check next_state <= 1 @deptype-example.v:59
(check-sat)
(pop)


(push)
(declare-fun next_state59 () Int)
(assert (<= 0  next_state59))
(assert (<= next_state59 3))
(assert (and (= cur_state 0) (= cur_state 1) (= cur_state 2) (= next_state59 1)  (not(leq HIGH  (Par next_state59)))))    ; next_state <= 1 @deptype-example.v:59
(check-sat)
(pop)

