(define-module (dsl)
  #:use-module (srfi srfi-1)
  #:export (som atraso repetir sample music processar bpm->dur))

;; ============================================================
;; representação de nota: (inicio fim simbolo-da-nota volume)
;; ============================================================
(define (som nota duracao volume)
  (list (list 0.0 duracao nota volume)))

;; ============================================================
;; `atraso` — desloca um bloco de notas no tempo
;; ============================================================
(define (atrasar-nota valor s)
  (cons* (/ (+ (* 10 valor) (* 10 (car s))) 10)
         (/ (+ (* 10 valor) (* 10 (cadr s))) 10)
         (cddr s)))

(define (atrasar valor sons)
  (map (lambda (s) (atrasar-nota valor s)) sons))

(define-syntax atraso
  (syntax-rules ()
    ((_ valor corpo ...)
     (atrasar valor (append corpo ...)))))

;; ============================================================
;; `repetir` — repete um bloco N vezes com atraso cumulativo
;; ============================================================
(define (repetir-fn vezes atraso-val bloco)
  (if (= vezes 0)
      '()
      (append bloco (repetir-fn (- vezes 1) atraso-val (atrasar atraso-val bloco)))))

(define-syntax repetir
  (syntax-rules ()
    ((_ vezes atraso-val corpo ...)
     (repetir-fn vezes atraso-val (append corpo ...)))))

;; ============================================================
;; `sample` — agrupa vários blocos num nome só
;; ============================================================
(define-syntax sample
  (syntax-rules ()
    ((_ nome corpo ...)
     (define nome (append corpo ...)))))

;; ============================================================
;; `music` — apenas envolve o corpo (dur deve ser passado
;; explicitamente às funções que precisarem dele, por causa
;; da higiene de macros em syntax-rules)
;; ============================================================
(define-syntax music
  (syntax-rules ()
    ((_ bpm corpo ...)
     (begin corpo ...))))

(define (bpm->dur bpm subdivisao)
  (/ (/ 60.0 bpm) subdivisao))

;; ============================================================
;; `processar` — funde notas sobrepostas em acordes sequenciais.
;; Mantém as notas como LISTA de símbolos (não string) para
;; evitar o bug de split por caractere.
;; ============================================================
(define (processar bloco)
  (let* ((eventos (sort bloco (lambda (a b) (< (car a) (car b)))))
         (pontos (delete-duplicates
                  (sort (append-map (lambda (n) (list (car n) (cadr n))) eventos) <))))
    (filter (lambda (x) (not (= (car x) (cadr x))))
            (map (lambda (ini fim)
                   (let* ((ativos (filter (lambda (n) (and (<= (car n) ini) (>= (cadr n) fim))) eventos))
                          (notas (map caddr ativos))
                          (vol (if (null? ativos) 0 (apply max (map cadddr ativos)))))
                     (list ini fim notas vol)))
                 pontos (cdr pontos)))))