#include "physics.h"
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

// checks for colision between the falling piece and the blocks in the playing area
int colision_check(){
    int ret_val;
    mv_piece_d(); // move piece down to check for future colisions
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
    }
    mv_piece_u(); // move piece up to its original position
    return ret_val;
}

int colision_check_wall(){
    int ret_val;
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
    }
    return ret_val;
}

int consolidate_rows(){
    // add each of the 4 rows where the piece is to the play area
    bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
}




int clear_rows(){
    int points = 0;
    for (int i = piece_row; i < HEIGHT-1; i++){ // check each of the 4 rows where the piece is
        if (play_area[i] == 4095){ // 4095 = column of all 1s
			if (!points){points = 1;}
            points = points*2;
            // this will break when the piece is off screen @@@@@@@@@@@@@
            for (int j = i; j > 4; j--){
                play_area[j] = play_area[j-1];
            }
            play_area[4] = 0b100000000001;
        }
    }
    return points;
}
void tetris_god_senpai(){
    piece_row = 4;
    piece_col = 5;
    piece_index = (piece_index + 7)%18;
    change_piece();
    reset_mask();
    apply_mask();
}						 

int result[SQUARESIZE] =
{
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
};
