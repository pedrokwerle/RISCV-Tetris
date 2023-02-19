/* matrix operations for binary 2D arrays that are treated as matrices */
#include "matrix.h"

void bit_or_matrix(int size, int matrix1[size], int matrix2[size], int* result){
    for (int i = 0; i < size; i++) {
        result[i] = matrix1[i] | matrix2[i];
    }
}

void bit_and_matrix(int size, int matrix1[size], int matrix2[size], int* result){
    for (int i = 0; i < size; i++) {
        result[i] = matrix1[i] & matrix2[i];
    }
}


