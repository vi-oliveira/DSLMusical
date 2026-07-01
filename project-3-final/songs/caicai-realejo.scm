(add-to-load-path ".")
(use-modules (srfi srfi-1) (dsl) (audio) (notas))

;; "Cai Cai Balão" - Realejo (Street Organ) version
(let* ((bpm 80)
       (dur (bpm->dur bpm 2)) ;; quarter note is our base for this bpm?
       ;; let's use a faster subdivision
       (colcheia (bpm->dur bpm 4))) ;; 8th note duration
  
  (music bpm
    (sample melodia
      ;; Cai, cai, balão
      (som 'G4 colcheia 1.0)
      (atraso colcheia (som 'G4 colcheia 1.0))
      (atraso (* 2 colcheia) (som 'F4 colcheia 1.0))
      (atraso (* 3 colcheia) (som 'E4 colcheia 1.0))

      ;; Cai, cai, balão
      (atraso (* 4 colcheia) (som 'G4 colcheia 1.0))
      (atraso (* 5 colcheia) (som 'G4 colcheia 1.0))
      (atraso (* 6 colcheia) (som 'F4 colcheia 1.0))
      (atraso (* 7 colcheia) (som 'E4 colcheia 1.0))
      
      ;; Aqui na minha mão
      (atraso (* 8 colcheia) (som 'G4 colcheia 1.0))
      (atraso (* 9 colcheia) (som 'A4 colcheia 1.0))
      (atraso (* 10 colcheia) (som 'G4 colcheia 1.0))
      (atraso (* 11 colcheia) (som 'F4 colcheia 1.0))
      (atraso (* 12 colcheia) (som 'E4 colcheia 1.0))
      (atraso (* 13 colcheia) (som 'D4 (* 3 colcheia) 1.0))

      ;; Não cai não
      (atraso (* 16 colcheia) (som 'D4 colcheia 1.0))
      (atraso (* 17 colcheia) (som 'E4 colcheia 1.0))
      (atraso (* 18 colcheia) (som 'F4 (* 2 colcheia) 1.0))
      
      ;; Não cai não
      (atraso (* 20 colcheia) (som 'D4 colcheia 1.0))
      (atraso (* 21 colcheia) (som 'E4 colcheia 1.0))
      (atraso (* 22 colcheia) (som 'F4 (* 2 colcheia) 1.0))

      ;; Não cai não
      (atraso (* 24 colcheia) (som 'D4 colcheia 1.0))
      (atraso (* 25 colcheia) (som 'E4 colcheia 1.0))
      (atraso (* 26 colcheia) (som 'F4 (* 2 colcheia) 1.0))

      ;; Cai na rua do sabão
      (atraso (* 28 colcheia) (som 'G4 colcheia 1.0))
      (atraso (* 29 colcheia) (som 'A4 colcheia 1.0))
      (atraso (* 30 colcheia) (som 'G4 colcheia 1.0))
      (atraso (* 31 colcheia) (som 'F4 colcheia 1.0))
      (atraso (* 32 colcheia) (som 'E4 colcheia 1.0))
      (atraso (* 33 colcheia) (som 'D4 colcheia 1.0))
      (atraso (* 34 colcheia) (som 'C4 (* 2 colcheia) 1.0))
    )

    ;; Accompaniment (Oom-Pah pattern for Realejo feel)
    ;; C Major pattern (4 beats / 8 colcheias):
    (sample comp-C
      (som 'C3 colcheia 0.6)
      (atraso colcheia (som 'E3 colcheia 0.4))
      (atraso colcheia (som 'G3 colcheia 0.4))
      (atraso (* 2 colcheia) (som 'G2 colcheia 0.6))
      (atraso (* 3 colcheia) (som 'E3 colcheia 0.4))
      (atraso (* 3 colcheia) (som 'G3 colcheia 0.4))
      (atraso (* 4 colcheia) (som 'C3 colcheia 0.6))
      (atraso (* 5 colcheia) (som 'E3 colcheia 0.4))
      (atraso (* 5 colcheia) (som 'G3 colcheia 0.4))
      (atraso (* 6 colcheia) (som 'G2 colcheia 0.6))
      (atraso (* 7 colcheia) (som 'E3 colcheia 0.4))
      (atraso (* 7 colcheia) (som 'G3 colcheia 0.4))
    )

    ;; G Major pattern (4 beats / 8 colcheias):
    (sample comp-G
      (som 'G2 colcheia 0.6)
      (atraso colcheia (som 'D3 colcheia 0.4))
      (atraso colcheia (som 'F3 colcheia 0.4))
      (atraso colcheia (som 'B3 colcheia 0.4))
      (atraso (* 2 colcheia) (som 'D2 colcheia 0.6))
      (atraso (* 3 colcheia) (som 'D3 colcheia 0.4))
      (atraso (* 3 colcheia) (som 'F3 colcheia 0.4))
      (atraso (* 3 colcheia) (som 'B3 colcheia 0.4))
      (atraso (* 4 colcheia) (som 'G2 colcheia 0.6))
      (atraso (* 5 colcheia) (som 'D3 colcheia 0.4))
      (atraso (* 5 colcheia) (som 'F3 colcheia 0.4))
      (atraso (* 5 colcheia) (som 'B3 colcheia 0.4))
      (atraso (* 6 colcheia) (som 'D2 colcheia 0.6))
      (atraso (* 7 colcheia) (som 'D3 colcheia 0.4))
      (atraso (* 7 colcheia) (som 'F3 colcheia 0.4))
      (atraso (* 7 colcheia) (som 'B3 colcheia 0.4))
    )

    ;; Structure:
    ;; ms 1-2: C
    ;; ms 3-4: G (Wait, is "Aqui na minha mão" in G or C?)
    ;; Let's check chords:
    ;; Cai cai balão (C) | Cai cai balão (C)
    ;; Aqui na minha mão (G) | (G)
    ;; Não cai não (G) | Não cai não (G) | Não cai não (G)
    ;; Cai na rua do sabão (C)
    (sample acompanhamento
      comp-C
      (atraso (* 8 colcheia) comp-G)
      (atraso (* 16 colcheia) comp-G)
      (atraso (* 24 colcheia) comp-G) ;; Actually 24 is "Não cai não" 3
      ;; Let's do comp-G for 3 measures (12 beats? No, comp-G is 4 beats / 8 colcheias long)
      ;; So:
      ;; 0-7: comp-C (Cai cai balão, cai cai balão)
      ;; 8-15: comp-G (Aqui na minha mão)
      ;; 16-23: comp-G (Não cai não, não cai não)
      ;; 24-31: comp-G (Não cai não, cai na rua do) -> wait, "Cai na rua do sabão" is at 28.
      ;; So at 28 it should be C!
      ;; Let's split comp-G to be 2 beats (4 colcheias) each so it's easier to place.
    )
    
    (sample comp-C-half
      (som 'C3 colcheia 0.6)
      (atraso colcheia (som 'E3 colcheia 0.4))
      (atraso colcheia (som 'G3 colcheia 0.4))
      (atraso (* 2 colcheia) (som 'G2 colcheia 0.6))
      (atraso (* 3 colcheia) (som 'E3 colcheia 0.4))
      (atraso (* 3 colcheia) (som 'G3 colcheia 0.4))
    )
    
    (sample comp-G-half
      (som 'G2 colcheia 0.6)
      (atraso colcheia (som 'D3 colcheia 0.4))
      (atraso colcheia (som 'F3 colcheia 0.4))
      (atraso colcheia (som 'B3 colcheia 0.4))
      (atraso (* 2 colcheia) (som 'D2 colcheia 0.6))
      (atraso (* 3 colcheia) (som 'D3 colcheia 0.4))
      (atraso (* 3 colcheia) (som 'F3 colcheia 0.4))
      (atraso (* 3 colcheia) (som 'B3 colcheia 0.4))
    )

    (sample acompanhamento-realejo
      ;; 0-7: C (2 x half)
      comp-C-half
      (atraso (* 4 colcheia) comp-C-half)
      
      ;; 8-15: G (2 x half)
      (atraso (* 8 colcheia) comp-G-half)
      (atraso (* 12 colcheia) comp-G-half)
      
      ;; 16-23: G (2 x half)
      (atraso (* 16 colcheia) comp-G-half)
      (atraso (* 20 colcheia) comp-G-half)
      
      ;; 24-27: G (1 x half)
      (atraso (* 24 colcheia) comp-G-half)
      
      ;; 28-35: C (2 x half)
      (atraso (* 28 colcheia) comp-C-half)
      (atraso (* 32 colcheia) comp-C-half)
    )

    (sample song-final
      melodia
      acompanhamento-realejo
    )

    (play song-final 40 nota->freq)))
