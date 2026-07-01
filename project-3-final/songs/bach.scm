(add-to-load-path ".")
(use-modules (srfi srfi-1) (dsl) (audio) (notas))

;; Arpeja um acorde de 5 notas usando o padrão 1-2-3-4-5-3-4-5
(define (arpejar-acorde notas offset-medida dur)
  (let ((padrao (list 0 1 2 3 4 2 3 4)))
    (apply append
      (map (lambda (idx pos)
             (atraso (+ offset-medida (* pos dur))
                     (som (list-ref notas idx) dur 0.7)))
           padrao (iota 8)))))

(define acordes
  (list
   '(C3 E3 G3 C4 E4)   ;; m1  C
   '(C3 D3 A3 D4 F4)   ;; m2  Dm7/C
   '(B2 D3 G3 D4 F4)   ;; m3  G7/B
   '(C3 E3 G3 C4 E4)   ;; m4  C
   '(C3 E3 A3 E4 A4)   ;; m5  Am/C
   '(C3 D3 F#3 A3 D4)  ;; m6  D7/C
   '(B2 D3 G3 D4 G4)   ;; m7  G/B
   '(B2 D3 G3 D4 F4)   ;; m8  C/B (passing)
   '(A2 C3 E3 G3 C4)   ;; m9  Am7
   '(D3 F#3 A3 C4 D4)  ;; m10 D7
   ))

(let ((dur (bpm->dur 90 4)))
  (music 40
    (sample bwv846
      (apply append
        (map (lambda (acorde i) (arpejar-acorde acorde (* i 8 dur) dur))
             acordes (iota (length acordes)))))
    (play bwv846 40 nota->freq)))