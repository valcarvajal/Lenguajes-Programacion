#lang racket
(require "shisima3.rkt")
(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)

(define (make-scene)
  (define arista 300)
  (define centro (make-posn 0 0))
  (define frame (empty-scene 800 800))

  (define punto-0 (make-posn 0 (- arista)))
  (define punto-1 (make-posn (sqrt (/ (sqr arista) 2)) (-(sqrt (/ (sqr arista) 2)))))
  (define punto-2 (make-posn arista 0))
  (define punto-3 (make-posn (sqrt (/ (sqr arista) 2)) (sqrt (/ (sqr arista) 2))))
  (define punto-4 (make-posn 0 arista))
  (define punto-5 (make-posn (-(sqrt (/ (sqr arista) 2))) (sqrt (/ (sqr arista) 2))))
  (define punto-6 (make-posn (- arista) 0))
  (define punto-7 (make-posn (-(sqrt (/ (sqr arista) 2))) (-(sqrt (/ (sqr arista) 2)))))

  (define octagrama (polygon (list
                              centro punto-0 punto-1
                              centro punto-1 punto-2
                              centro punto-2 punto-3
                              centro punto-3 punto-4
                              centro punto-4 punto-5
                              centro punto-5 punto-6
                              centro punto-6 punto-7
                              centro punto-7 punto-0
                              )
                             "outline"
                             "black"))

  (define tablero (overlay (circle 100 "solid" "darkgray") octagrama frame))

  ; Define los círculos
  (define circulo-centro (circle 50 "solid" "lightgray"))
  (define circulo-0 (circle 50 "solid" "yellow"))
  (define circulo-1 (circle 50 "solid" "yellow"))
  (define circulo-2 (circle 50 "solid" "yellow"))
  (define circulo-3 (circle 50 "solid" "lightgray"))
  (define circulo-4 (circle 50 "solid" "red"))
  (define circulo-5 (circle 50 "solid" "red"))
  (define circulo-6 (circle 50 "solid" "red"))
  (define circulo-7 (circle 50 "solid" "lightgray"))

  ; Crea una lista de pares de coordenadas para los círculos
  (define circle-positions
    (list (cons circulo-centro (make-posn 400 400))
          (cons circulo-0      (make-posn 400 (+ 400 (- arista))))
          (cons circulo-1      (make-posn (+ 400 (sqrt (/ (sqr arista) 2))) (+ 400 (-(sqrt (/ (sqr arista) 2))))))
          (cons circulo-2      (make-posn (+ 400 arista) 400))
          (cons circulo-3      (make-posn (+ 400 (sqrt (/ (sqr arista) 2))) (+ 400 (sqrt (/ (sqr arista) 2)))))
          (cons circulo-4      (make-posn 400 (+ 400 arista)))
          (cons circulo-5      (make-posn (+ 400 (-(sqrt (/ (sqr arista) 2)))) (+ 400 (sqrt (/ (sqr arista) 2)))))
          (cons circulo-6      (make-posn (+ 400 (- arista)) 400))
          (cons circulo-7      (make-posn (+ 400 (-(sqrt (/ (sqr arista) 2)))) (+ 400 (-(sqrt (/ (sqr arista) 2))))))))

  ; Función para dibujar los círculos encima del octagrama
  (define (draw-circles scene)
    (foldl (lambda (pair acc)
             (place-image (car pair) (posn-x (cdr pair)) (posn-y (cdr pair)) acc)) tablero circle-positions))

  ; Llama a la función draw-circles para agregar los círculos
  (draw-circles frame))

(define (draw-scene scene) scene)
(big-bang (make-scene) (on-draw draw-scene))
