#lang racket


;                                         --- Funciones auxiliares ---
;----------------------------------------------------------------------------------------------------------------------

; Definición de las estructuras
(define-struct nodo (valor hijos) #:mutable) ; Estructura nodo
(define-struct arbol (raiz) #:mutable) ; Estructura arbol


; Función para crear un nodo con un valor y una lista de hijos
(define (create-node valor hijos)
  (make-nodo valor hijos)
)


; Función para obtener el valor de un nodo
(define (value-from-node nodo)
  (nodo-valor nodo)
)


; Función para obtener la lista de hijos de un nodo
(define (sons-from-nodo nodo)
  (nodo-hijos nodo)
)


; Función para saber si un valor está almacenado en algún nodo de un surbarbol (recibe un struct nodo)
(define (BuscarEnSubarbol nodo valor)
  (define (BuscarEnSubarbol-rec nodo)
    (cond
      [(null? nodo) #f]
      [(equal? (value-from-node nodo) valor) #t]
      [else (ormap BuscarEnSubarbol-rec (sons-from-nodo nodo))]
      ) 
  )
  (BuscarEnSubarbol-rec nodo)
)

;----------------------------------------------------------------------------------------------------------------------


;                                         --- Funciones principales ---
;----------------------------------------------------------------------------------------------------------------------

; Crear el árbol (create-tree).
; Función que crea un arbol de altura 1.
; Recibe: Un entero que sirve como identificador (valor).
; Devuelve: Un arbol de altura 1, con un único nodo, cuya raiz tiene como identificador el valor entero ingresado.
(define (create-tree valor)
  (make-arbol (create-node valor '()))
)

; Función para obtener la raíz de un arbol
(define (root-from-tree arbol)
  (arbol-raiz arbol)
)

; Función para saber si un valor está almacenado en algún nodo de un arbol (recibe un struct arbol)
(define (BuscarEnArbol arbol valor)
  (BuscarEnSubarbol (root-from-tree arbol) valor)
)


; Listar todos los nodos (list-all-nodes).
; Función que imprime el arbol en su recorrido en profundidad, como una serie de listas.
; Recibe: Un arbol.
; Devuelve: Una lista que representa el arbol recorrido en profundidad.
(define (list-all-nodes arbol)
  (define (list-all-nodes-rec nodo)
    (format "~a (~a)" (nodo-valor nodo) (apply string-append (map list-all-nodes-rec (nodo-hijos nodo))))
  )
  (list-all-nodes-rec (arbol-raiz arbol))
)

  
; Buscar un nodo (find-node):
; Función que devuelve todos los datos asociados a un nodo.
; Recibe: El árbol y el nodo a buscar.
; Devuelve: Los datos asociados al nodo.
(define (find-node arbol valor)
  (if (equal? (BuscarEnArbol arbol valor) #f) (displayln "El nodo no se encuentra en el arbol. ") valor)
  (define altura 1)
  (define padre 0)
  (define (find-node-rec nodo)
    (cond
      [(equal? (value-from-node nodo) valor) (displayln "Nodo encontrado. ") (displayln (format "~a ~a" "Altura: " altura)) (displayln (format "~a ~a" "Valor: " valor)) (displayln (format "~a ~a" "Padre: " padre))  nodo]
      [else (set! altura (add1 altura)) (set! padre (value-from-node nodo)) (ormap find-node-rec (sons-from-nodo nodo))]
      ) 
  )
  (find-node-rec (root-from-tree arbol))
)


; Función para insertar un nuevo nodo en el árbol
(define (insert-node arbol nodo-padre nuevo-nodo)
  (define (insert-node-rec actual)
    (cond
      [(= (nodo-valor actual) nodo-padre)
       (create-node (nodo-valor actual)
                   (append (nodo-hijos actual) (list nuevo-nodo)))]
      [else
       (create-node (nodo-valor actual)
                   (map insert-node-rec (nodo-hijos actual)))]))
  
  (make-arbol (insert-node-rec (arbol-raiz arbol))))


; Función para eliminar un nodo del árbol
(define (delete-node arbol nodo-eliminar)
  (define (delete-node-rec actual)
    (if (= (nodo-valor actual) nodo-eliminar)
        #f
        (create-node (nodo-valor actual)
                    (filter-map delete-node-rec (nodo-hijos actual)))))
  
  (define (eliminar-arbol-vacio)
    (make-arbol (create-node 'arbol-vacio '())))
  
  (let* ((nuevo-arbol (create-node (nodo-valor (arbol-raiz arbol))
                                  (filter-map delete-node-rec (nodo-hijos (arbol-raiz arbol))))))
    (if nuevo-arbol
        (make-arbol nuevo-arbol)
        (eliminar-arbol-vacio))))

; Función para buscar el padre de un nodo en el árbol
(define (ancestor arbol nodo-buscar)
  (define (buscar-padre nodo)
    (cond
      [(null? nodo) #f]
      [(member nodo-buscar (map nodo-valor (nodo-hijos nodo))) (nodo-valor nodo)]
      [else (ormap buscar-padre (nodo-hijos nodo))]))
  
  (buscar-padre (arbol-raiz arbol))
)

;----------------------------------------------------------------------------------------------------------------------


; Pruebas
(define mi-arbol (create-tree 1))
(displayln (list-all-nodes mi-arbol))

(define nuevo-arbol (insert-node mi-arbol 1 (create-node 2 '())))
(define nuevo-arbol2 (insert-node nuevo-arbol 1 (create-node 3 '())))
(define nuevo-arbol3 (insert-node nuevo-arbol2 2 (create-node 4 '())))
(define nuevo-arbol4 (insert-node nuevo-arbol3 2 (create-node 5 '())))
(define nuevo-arbol5 (insert-node nuevo-arbol4 3 (create-node 6 '())))
(define nuevo-arbol6 (insert-node nuevo-arbol5 5 (create-node 7 '())))
(define nuevo-arbol7 (insert-node nuevo-arbol6 5 (create-node 8 '())))

(displayln (list-all-nodes nuevo-arbol7))

(define nuevo-arbol8 (delete-node nuevo-arbol7 3))
(displayln (list-all-nodes nuevo-arbol8))

(displayln (find-node nuevo-arbol8 9))
(displayln (find-node nuevo-arbol8 3))
(displayln (find-node nuevo-arbol8 4))
(displayln (find-node nuevo-arbol8 5))

(displayln (ancestor nuevo-arbol8 7)) ; Debería mostrar 5
(displayln (ancestor nuevo-arbol8 4)) ; Debería mostrar 2
(displayln (ancestor nuevo-arbol8 6)) ; Debería mostrar f