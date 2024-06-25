% Tarea de Prolog: Ejercicios
% Desarrollado por:
% - Estudiante 1: Valery Carvajal, carn� 2022314299
% - Estudiante 2: Anthony Rojas, carn� 2018027141

% Definici�n de la jerarqu�a taxon�mica
especie(colibri, thalassinus).
especie(ceiba, pentandra).

ancestro(X, Y) :- especie(X, Y).
ancestro(X, Y) :- ancestro(Z, Y), especie(X, Z).

super(X, Y) :- ancestro(Y, X).

% Predicado para verificar si un elemento est� en una lista
miembro(X, [X | _]).
miembro(X, [_ | T]) :- miembro(X, T).

% Predicado para encontrar el m�ximo en una lista
maximo([X], X).
maximo([H|T], Max) :- maximo(T, MaxT), (H > MaxT -> Max = H ; Max = MaxT).

% Predicado para verificar si una lista es un subconjunto de otra lista
subconjunto([], _).
subconjunto([H|T], L) :- miembro(H, L), subconjunto(T, L).
