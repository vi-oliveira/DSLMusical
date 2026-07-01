(add-to-load-path ".")
(use-modules (dsl) (audio) (notas))

(let* ((bpm 120)
       (u (bpm->dur bpm 4))) ; unidade rítmica
  (music bpm
    (sample se-essa-rua-melody

      ;; Se essa rua
      (atraso (* 0 u)  (som 'A4 (* 2 u) 0.9))
      (atraso (* 2 u)  (som 'A4 (* 2 u) 0.9))
      (atraso (* 4 u)  (som 'D5 (* 2 u) 0.9))
      (atraso (* 6 u)  (som 'D5 (* 2 u) 0.9))

      ;; Se essa rua fosse minha
      (atraso (* 8 u)  (som 'A4 (* 2 u) 0.9))
      (atraso (* 10 u) (som 'F4 (* 2 u) 0.9))
      (atraso (* 12 u) (som 'D4 (* 2 u) 0.9))
      (atraso (* 14 u) (som 'A4 (* 2 u) 0.9))
      (atraso (* 16 u) (som 'C5 (* 2 u) 0.9))
      (atraso (* 18 u) (som 'Bb4 (* 2 u) 0.9))
      (atraso (* 20 u) (som 'A4 (* 2 u) 0.9))
      (atraso (* 22 u) (som 'E4 (* 4 u) 0.95))

      ;; Eu mandava
      (atraso (* 26 u) (som 'A4 (* 2 u) 0.9))
      (atraso (* 28 u) (som 'A4 (* 2 u) 0.9))
      (atraso (* 30 u) (som 'E4 (* 2 u) 0.9))
      (atraso (* 32 u) (som 'E4 (* 4 u) 0.95))

      ;; Eu mandava ladrilhar
      (atraso (* 36 u) (som 'C#5 (* 2 u) 0.9))
      (atraso (* 38 u) (som 'A4  (* 2 u) 0.9))
      (atraso (* 40 u) (som 'Bb4 (* 2 u) 0.9))
      (atraso (* 42 u) (som 'A4  (* 2 u) 0.9))
      (atraso (* 44 u) (som 'F4  (* 2 u) 0.9))
      (atraso (* 46 u) (som 'E4  (* 2 u) 0.9))
      (atraso (* 48 u) (som 'D4  (* 4 u) 0.95))

      ;; Com pedrinhas
      (atraso (* 52 u) (som 'A4 (* 2 u) 0.9))
      (atraso (* 54 u) (som 'A4 (* 2 u) 0.9))
      (atraso (* 56 u) (som 'D5 (* 2 u) 0.9))
      (atraso (* 58 u) (som 'D5 (* 2 u) 0.9))

      ;; Com pedrinhas de brilhante
      (atraso (* 60 u) (som 'F4  (* 2 u) 0.9))
      (atraso (* 62 u) (som 'E4  (* 2 u) 0.9))
      (atraso (* 64 u) (som 'D4  (* 2 u) 0.9))
      (atraso (* 66 u) (som 'C4  (* 2 u) 0.9))
      (atraso (* 68 u) (som 'Bb3 (* 2 u) 0.9))
      (atraso (* 70 u) (som 'A3  (* 2 u) 0.9))
      (atraso (* 72 u) (som 'C4  (* 2 u) 0.9))
      (atraso (* 74 u) (som 'Bb3 (* 4 u) 0.95))

      ;; Para o meu
      (atraso (* 78 u) (som 'Bb4 (* 2 u) 0.9))
      (atraso (* 80 u) (som 'Bb4 (* 2 u) 0.9))
      (atraso (* 82 u) (som 'A4  (* 4 u) 0.95))

      ;; Para o meu amor passar
      (atraso (* 86 u) (som 'E4  (* 2 u) 0.9))
      (atraso (* 88 u) (som 'C#5 (* 2 u) 0.9))
      (atraso (* 90 u) (som 'A4  (* 2 u) 0.9))
      (atraso (* 92 u) (som 'G4  (* 2 u) 0.9))
      (atraso (* 94 u) (som 'F4  (* 2 u) 0.9))
      (atraso (* 96 u) (som 'E4  (* 2 u) 0.9))
      (atraso (* 98 u) (som 'D4  (* 8 u) 1.0)))

    (play se-essa-rua-melody bpm nota->freq)))