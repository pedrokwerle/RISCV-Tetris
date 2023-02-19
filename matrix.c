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

void rotate_cw(int matrix[SQUARESIZE]){     // pass in the piece matrix and it will get rotated
    int temp[SQUARESIZE];

    // Copy the original matrix to a temporary matrix
    for (int i = 0; i < SQUARESIZE; i++) {
        temp[i] = matrix[i];
        matrix[i] = 0;
    }

    // rotate matrix cw
    for (int i = 0; i < SQUARESIZE; i++){
        for (int j = 0; j < SQUARESIZE; j++){
            matrix[j] |= ((temp[i] >> (SQUARESIZE - j - 1)) & 1) << i;
        }
    }
}

void rotate_ccw(int matrix[SQUARESIZE]){    // pass in the piece matrix and it will get rotated
    int temp[SQUARESIZE];

    // Copy the original matrix to a temporary matrix
    for (int i = 0; i < SQUARESIZE; i++) {
        temp[i] = matrix[i];
        matrix[i] = 0;
    }

    // Rotate matrix ccw
    for (int i = 0; i < SQUARESIZE; i++){
        for (int j = 0; j < SQUARESIZE; j++){
            matrix[SQUARESIZE-j-1] |= ((temp[i] >> j) & 1) << i;
        }
    }
}

