#lang scheme
(define (fibonacci n)
  (if (< n 2)
      n
      (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

(define (es-impar? num)
  (= 1 (modulo num 2)))

(define (factorial num)
  (if (= num 0)
      1
      (* num (factorial (- num 1)))))

(define (respuesta x)
  (define (fibonacci-hasta n)
    (if (< n x)
        (cons (fibonacci n) (fibonacci-hasta (+ n 1)))
        '()))
  
  (let ((numeros-fibonacci (fibonacci-hasta 0)))
    (display "Los primeros ")
    (display x)
    (display " números de Fibonacci son: ")
    (display numeros-fibonacci)
    (newline)
    
    (let ((impares (filter es-impar? numeros-fibonacci)))
      (display "Los números impares de la secuencia son: ")
      (display impares)
      (newline)
      
      (let ((ultimo-impar (last impares)))
        (display "El último número impar es: ")
        (display ultimo-impar)
        (newline)
        
        (let ((factorial-ultimo-impar (factorial ultimo-impar)))
          (display "El factorial del último número impar es: ")
          (display factorial-ultimo-impar)
          (newline))))))

(display "Ingrese el valor de x: ")
(define x (read))
(respuesta x)
