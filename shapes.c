#include "shapes.h"
#include "matrix.h"

void apply_mask(int piece[SQUARESIZE]){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece[i-piece_row]; // mask row equal current piece row
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
    }
}

void reset_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece_mask[i] >> 12;
    }
}

int pieces[TETRIS][SQUARESIZE]=
{
    {
        0b0010,
        0b0010,
        0b0010,
        0b0010,
    },
    {
        0b0000,
        0b0100,
        0b0111,
        0b0000
    },
    {
        0b0000,
        0b0010,
        0b1110,
        0b0000,
    },
    {
        0b0000,
        0b0110,
        0b0110,
        0b0000,
    },
    {
        0b0000,
        0b0110,
        0b1100,
        0b0000,
    },
    {
        0b0000,
        0b0110,
        0b0011,
        0b0000,
    },
    {
        0b0000,
        0b0100,
        0b1110,
        0b0000,
    }

};

int play_area[HEIGHT] =
{
    0b111111111111,
    0b111111111111,
    0b111111111111,
    0b111111111111,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b100000000001,
    0b111111111111,
    0b111111111111,
};

int piece_row = 0;
int piece_col = 0;

int piece_mask[HEIGHT] =
{
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
    0b000000000000,
};
