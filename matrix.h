#pragma once
#define SQUARESIZE (4)

void bit_or_matrix(int size, int matrix1[size], int matrix2[size], int* result);
void bit_and_matrix(int size, int matrix1[size], int matrix2[size], int* result);
void rotate_cw(int matrix[SQUARESIZE]);
void rotate_ccw(int matrix[SQUARESIZE]);

