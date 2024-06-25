// Tarea 12
// Estudiantes:
// Valery Carvajal - 2022314299
// Anthony Rojas - 2018027141

#include <stdio.h>
#include <stdlib.h>

// Lee Matriz
void readMatrix(int matriz[][100], int rows, int cols) {
    printf("Introduce los elementos de la matriz (%d x %d):\n", rows, cols);
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            scanf("%d", &matriz[i][j]);
        }
    }
}

// Muestra Matriz
void showMatrix(int matriz[][100], int rows, int cols) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ", matriz[i][j]);
        }
        printf("\n");
    }
}

// Multiplica dos matrices
void multiply2Matrixs(int matriz1[][100], int rows1, int cols1, int matriz2[][100], int rows2, int cols2, int resultado[][100]) {
    for (int i = 0; i < rows1; i++) {
        for (int j = 0; j < cols2; j++) {
            resultado[i][j] = 0;
            for (int k = 0; k < cols1; k++) {
                resultado[i][j] += matriz1[i][k] * matriz2[k][j];
            }
        }
    }
}

// Verifica si se cumple la propiedad de matrices transpuestas
void evaluateProperty(int matriz1[][100], int rows1, int cols1, int matriz2[][100], int rows2, int cols2) {
    int resultado1[100][100], resultado2[100][100];

    multiply2Matrixs(matriz1, rows1, cols1, matriz2, rows2, cols2, resultado1);

    int transpuesta1[100][100], transpuesta2[100][100];
    for (int i = 0; i < cols1; i++) {
        for (int j = 0; j < rows1; j++) {
            transpuesta1[i][j] = matriz1[j][i];
        }
    }
    for (int i = 0; i < cols2; i++) {
        for (int j = 0; j < rows2; j++) {
            transpuesta2[i][j] = matriz2[j][i];
        }
    }
    multiply2Matrixs(transpuesta2, cols2, rows2, transpuesta1, cols1, rows1, resultado2);

    int iguales = 1;
    for (int i = 0; i < rows1; i++) {
        for (int j = 0; j < cols1; j++) {
            if (resultado1[i][j] != resultado2[i][j]) {
                iguales = 0;
                break;
            }
        }
        if (!iguales) {
            break;
        }
    }


    if (iguales) {
        printf("\nLa propiedad de las matrices transpuestas se cumple.\n");
    } else {
        printf("\nLa propiedad de las matrices transpuestas NO se cumple.\n");
    }
}


int main() {
    int rows1, cols1, rows2, cols2;

    // Tamaño matrices
    printf("Cantidad de filas para la 1ra matriz: ");
    scanf("%d", &rows1);
    printf("Cantidad de columnas para la 1ra matriz: ");
    scanf("%d", &cols1);

    printf("Cantidad de filas para la 2da matriz: ");
    scanf("%d", &rows2);
    printf("Cantidad de columnas para la 2da matriz: ");
    scanf("%d", &cols2);
    printf("\n");

    int matriz1[100][100], matriz2[100][100], resultado[100][100];

    // readMatrix
    printf("Matriz 1:\n");
    readMatrix(matriz1, rows1, cols1);
    printf("Matriz 2:\n");
    readMatrix(matriz2, rows2, cols2);

    // showMatrix
    printf("\nMatrices ingresadas:\n");
    printf("Matriz 1:\n");
    showMatrix(matriz1, rows1, cols1);
    printf("Matriz 2:\n");
    showMatrix(matriz2, rows2, cols2);

    // Verificar si las matrices son compatibles para la multiplicación
    if (cols1 != rows2) {
        printf("\nError:\n");
        printf("Las matrices no son compatibles para la multiplicacion.\n");
        printf("La propiedad de las matrices transpuestas NO se cumple.\n");
    } else {
        // multiply2Matrixs
        multiply2Matrixs(matriz1, rows1, cols1, matriz2, rows2, cols2, resultado);
        printf("\nResultado de la multiplicacion:\n");
        showMatrix(resultado, rows1, cols2);

        // evaluateProperty
        evaluateProperty(matriz1, rows1, cols1, matriz2, rows2, cols2);
    }

    return 0;
}

