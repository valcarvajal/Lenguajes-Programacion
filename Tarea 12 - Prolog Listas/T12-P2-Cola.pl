% |=============================================|
% | Parte 2 :                                   |
% | Recursividad de cola                        |
% |=============================================|
% | Valery Michel Carvajal Oreamuno - 2022314299|
% | Anthony Josué Rojas Fuentes - 2018027141    |
% |=============================================|
 
% -------------------------------------------------------------------------------------------------------------------------------------
% Sumatoria de una lista de números:
sumarLista([], Suma, Suma).
sumarLista([H|T], Acumulador, Suma) :- NuevoAcumulador is Acumulador + H, sumarLista(T, NuevoAcumulador, Suma).
sumarLista(L, Suma) :- sumarLista(L, 0, Suma).
% -------------------------------------------------------------------------------------------------------------------------------------
% Producto interno de dos vectores:
prodint([], [], Producto, Producto).
prodint([H1|T1], [H2|T2], Acumulador, Producto) :- NuevoAcumulador is Acumulador + H1 * H2, prodint(T1, T2, NuevoAcumulador, Producto).
prodint(V1, V2, PI) :- prodint(V1, V2, 0, PI).
% -------------------------------------------------------------------------------------------------------------------------------------
fibonacci(N, F1, F2, N, F1).
fibonacci(N, F1, F2, Actual, X) :- Siguiente is Actual + 1, NuevoFib is F1 + F2, fibonacci(N, F2, NuevoFib, Siguiente, X).
fibonacci(N, X) :- N > 1, fibonacci(N, 0, 1, 2, X).
% -------------------------------------------------------------------------------------------------------------------------------------