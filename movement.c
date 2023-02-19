#include "movement.h"
#include "shapes.h"
#include "matrix.h"

void mv_piece_l(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece_mask[i] << 1;
    }
    piece_col -= 1;
}
void mv_piece_r(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece_mask[i] >> 1;
    }
    piece_col += 1;
}
void mv_piece_d(){
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
        piece_mask[i] = piece_mask[i-1];
    }
    piece_row += 1;
}
void mv_piece_u(){
    for (int i = piece_row - 1; i > piece_row + SQUARESIZE - 1; i--){
        piece_mask[i] = piece_mask[i+1];
    }
    piece_row -= 1;
}
void r_piece_cw(int piece[SQUARESIZE]){
    rotate_cw(piece);
    reset_mask();
    apply_mask(piece);
}
void r_piece_ccw(int piece[SQUARESIZE]){
    rotate_ccw(piece);
    reset_mask();
    apply_mask(piece);
}
