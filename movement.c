#include "movement.h"
#include "shapes.h"
#include "matrix.h"
#include "physics.h"
#include "lib.h"

void mv_piece_l(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece_mask[i] << 1;
    }
	
	if (colision_check_wall()) {
		printint(1);
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
			piece_mask[i] = piece_mask[i] >> 1;
		}
	}
	else {
		piece_col -= 1;
	}
}
void mv_piece_r(){
	printint(1);
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece_mask[i] >> 1;
    }
	if (colision_check_wall()) {
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
			piece_mask[i] = piece_mask[i] << 1;
		}
	}
	else{
		piece_col += 1;		
	}
}
void mv_piece_d(){
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
        piece_mask[i] = piece_mask[i-1];
    }
    piece_row += 1;
}
void mv_piece_u(){
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece_mask[i+1];
    }
    piece_row -= 1;
}
void r_piece_cw(){
    piece_index = rotational_vector[piece_index];
    change_piece();
    reset_mask();
    apply_mask(current_piecem);
	if (colision_check_wall()) {
		piece_index = rotational_vector[piece_index];
		piece_index = rotational_vector[piece_index];
		piece_index = rotational_vector[piece_index];
		change_piece();
		reset_mask();
		apply_mask(current_piecem);
	}
	
	
}

int rotational_vector[TETRIS] =
{
    1,0,3,4,5,2,7,8,9,6,10,12,11,14,13,16,17,18,15,
};
