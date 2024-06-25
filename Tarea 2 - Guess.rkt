#lang racket

(define (start n m)
  (cond [(and (> n 0) (> m 0) (> m n)) 
         (change n m)]
        [else "Debe definir un rango válido"]))

(define (change lower upper)
  (define result (guess lower upper))
    (let ([input (read-line)])
      (cond [(string=? input "smaller")
             (change lower (sub1 result))
             result]
            [(string=? input "bigger")
             (change (add1 result) upper)
             result])))

(define (guess lower upper)
  (quotient (+ lower upper) 2))

