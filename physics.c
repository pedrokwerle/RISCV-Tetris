#include "physics.h"
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

// checks for colision between the falling piece and the blocks in the playing area
int colision_check(){
    int ret_val;
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
    }
    return ret_val;
}

// TODO: doesn't work
int consolidate_rows(){
    // add each of the 4 rows where the piece is to the play area
    bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
    /*for (int i = piece_row; i < SQUARESIZE; i++){
        bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
    }*/
}

// TODO: doesn't work
int clear_rows(){
    int points = 0;
    for (int i = piece_row; i < SQUARESIZE - 1; i++){ // check each of the 4 rows where the piece is
        if (play_area[i] == 0b000000000000){
            points++;
            // this wil break when the piece is off screen @@@@@@@@@@@@@
            for (int j = i; j > 4; j++){
                play_area[j] = play_area[j-1];
            }
            play_area[4] = 0b100000000001;
        }
    }
    return points;
}

int result[SQUARESIZE] =
{
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
};
