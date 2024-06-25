# Tarea de Prolog: Ejercicios
## Desarrollado por:
- **Estudiante 1:** Valery Carvajal, carn� 2022314299
- **Estudiante 2:** Anthony Rojas, carn� 2018027141

## Enunciado del Ejercicio

Implementaci�n de reglas en Prolog para manejar jerarqu�a taxon�mica y realizar operaciones en listas (buscar elementos, encontrar el m�ximo y verificar subconjuntos).

## C�mo Ejecutar el C�digo

Con SWI-Prolog instalado, se ejecuta el siguiente comando en la terminal:


## Ejemplos de Consultas

1. **Consultar si Colibr� es un ancestro de Animalia:**
?- super(colibri, animalia).
true.


2. **Consultar todos los superiores de Colibr�:**
?- super(colibri, Y).
Y = trochilidae ;
Y = apodiforme ;
Y = aves ;
Y = chordata ;
Y = animalia ;
Y = eukaryota ;
false.


3. **Consultar si 1 es miembro de la lista [1,2,3,4,5]:**
?- miembro(1, [1,2,3,4,5]).
true.


4. **Encontrar el m�ximo en la lista [1,2,3,4,5]:**
?- maximo([1,2,3,4,5], X).
X = 5.


5. **Verificar si [1,4,6] es un subconjunto de [1,2,3,4,5,6]:**
?- subconjunto([1,4,6], [1,2,3,4,5,6]).
true.