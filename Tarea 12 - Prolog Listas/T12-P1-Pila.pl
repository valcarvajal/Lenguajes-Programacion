% |=============================================|
% | Parte 1 :                                   |
% | Recursividad de pila                        |
% |=============================================|
% | Valery Michel Carvajal Oreamuno - 2022314299|
% | Anthony Josué Rojas Fuentes - 2018027141    |
% |=============================================|
 
% ------------------------------------------------------------------------------------------------------
% Sumatoria de una lista de números:
sumarLista([], 0).
sumarLista([H|T], Suma) :- sumarLista(T, Resto), Suma is H + Resto.
% ------------------------------------------------------------------------------------------------------
% Producto interno de dos vectores:
prodint([], [], 0).
prodint([H1|T1], [H2|T2], PI) :- prodint(T1, T2, Resto), PI is H1 * H2 + Resto.
% ------------------------------------------------------------------------------------------------------
% Fibonacci:
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, X) :- N > 1, N1 is N - 1, N2 is N - 2, fibonacci(N1, F1), fibonacci(N2, F2), X is F1 + F2.
% ------------------------------------------------------------------------------------------------------