(add-to-load-path ".")
(use-modules (dsl) (audio) (notas))

;; one note at an offset, with explicit duration
(define (n offset nota dur vol)
  (atraso offset (som nota dur vol)))

(let* ((bpm 76)
       (u (bpm->dur bpm 4))) ; unidade = semicolcheia
  (music bpm
    (sample se-essa-rua-melody
      (append
       ;; Se essa rua
       (n (* 0 u)  'E4 (* 2 u) 0.9)
       (n (* 2 u)  'E4 (* 2 u) 0.9)
       (n (* 4 u)  'A4 (* 2 u) 0.9)
       (n (* 6 u)  'A4 (* 4 u) 0.95)

       ;; Se essa rua
       (n (* 10 u) 'E4 (* 2 u) 0.9)
       (n (* 12 u) 'C4 (* 2 u) 0.9)
       (n (* 14 u) 'A4 (* 2 u) 0.9)
       (n (* 16 u) 'C4 (* 4 u) 0.95)

       ;; Fosse minha
       (n (* 20 u) 'G4 (* 2 u) 0.9)
       (n (* 22 u) 'F4 (* 2 u) 0.9)
       (n (* 24 u) 'E4 (* 2 u) 0.9)
       (n (* 26 u) 'B3 (* 6 u) 0.95)

       ;; Eu mandava
       (n (* 32 u) 'E4 (* 2 u) 0.9)
       (n (* 34 u) 'E4 (* 2 u) 0.9)
       (n (* 36 u) 'B3 (* 2 u) 0.9)
       (n (* 38 u) 'B3 (* 4 u) 0.95)

       ;; Eu mandava ladrilhar
       (n (* 42 u) 'G4  (* 2 u) 0.9)
       (n (* 44 u) 'E4  (* 2 u) 0.9)
       (n (* 46 u) 'F4  (* 2 u) 0.9)
       (n (* 48 u) 'E4  (* 2 u) 0.9)
       (n (* 50 u) 'C4  (* 2 u) 0.9)
       (n (* 52 u) 'B3  (* 2 u) 0.9)
       (n (* 54 u) 'A3  (* 6 u) 0.95)

       ;; Com pedrinhas
       (n (* 60 u) 'E4 (* 2 u) 0.9)
       (n (* 62 u) 'E4 (* 2 u) 0.9)
       (n (* 64 u) 'A4 (* 2 u) 0.9)
       (n (* 66 u) 'A4 (* 4 u) 0.95)

       ;; Com pedrinhas de brilhantes
       (n (* 70 u) 'C4 (* 2 u) 0.9)
       (n (* 72 u) 'B3 (* 2 u) 0.9)
       (n (* 74 u) 'A3 (* 2 u) 0.9)
       (n (* 76 u) 'G3 (* 2 u) 0.9)
       (n (* 78 u) 'F3 (* 2 u) 0.9)
       (n (* 80 u) 'E3 (* 2 u) 0.9)
       (n (* 82 u) 'G3 (* 2 u) 0.9)
       (n (* 84 u) 'F3 (* 4 u) 0.95)

       ;; Para o meu
       (n (* 88 u) 'F4 (* 2 u) 0.9)
       (n (* 90 u) 'F4 (* 2 u) 0.9)
       (n (* 92 u) 'E4 (* 4 u) 0.95)

       ;; Para o meu amor passar
       (n (* 96 u)  'B3 (* 2 u) 0.9)
       (n (* 98 u)  'G4 (* 2 u) 0.9)
       (n (* 100 u) 'E4 (* 2 u) 0.9)
       (n (* 102 u) 'D4 (* 2 u) 0.9)
       (n (* 104 u) 'C4 (* 2 u) 0.9)
       (n (* 106 u) 'B3 (* 2 u) 0.9)
       (n (* 108 u) 'A3 (* 8 u) 1.0)))
    (play se-essa-rua-melody bpm nota->freq)))