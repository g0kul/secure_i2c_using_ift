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