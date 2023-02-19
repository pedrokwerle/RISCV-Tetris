#include "shapes.h"
#include "matrix.h"

// copy the contents of the piece matrix to the position in the mask indicated by piece_row and piece_col
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

void initialize(){
    piece_index = 15;
    piece_row = 16;
    piece_col = 6;
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
    }
    apply_mask(current_piecem);
}

void change_piece(){
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
    }
}

int piece_index = 0;
int piece_row = 0;
int piece_col = 0;
int current_piecem[SQUARESIZE];

int pieces[TETRIS][SQUARESIZE]=
{
    // line variations 0-1
    {
        0b0010,
        0b0010,
        0b0010,
        0b0010,
    },
    {
        0b0000,
        0b1111,
        0b0000,
        0b0000,
    },

    // L variations 2-5
    {
        0b0000,
        0b0100,
        0b0111,
        0b0000
    },
    {
        0b0110,
        0b0100,
        0b0100,
        0b0000
    },
    {
        0b0000,
        0b1110,
        0b0010,
        0b0000
    },
    {
        0b0010,
        0b0010,
        0b0110,
        0b0000
    },
    // reverse L variations 6-9
    {
        0b0000,
        0b0010,
        0b1110,
        0b0000,
    },
    {
        0b0100,
        0b0100,
        0b0110,
        0b0000,
    },
    {
        0b0000,
        0b0111,
        0b0100,
        0b0000,
    },
    {
        0b0110,
        0b0010,
        0b0010,
        0b0000,
    },
    // square variations 10
    {
        0b0000,
        0b0110,
        0b0110,
        0b0000,
    },

    // S variations 11-12
    {
        0b0000,
        0b0110,
        0b1100,
        0b0000,
    },
    {
        0b0100,
        0b0110,
        0b0010,
        0b0000,
    },
    // Z variations 13-14

    {
        0b0000,
        0b0110,
        0b0011,
        0b0000,
    },
    {
        0b0010,
        0b0110,
        0b0100,
        0b0000,
    },

    // cross variations 15-18
    {
        0b0000,
        0b0100,
        0b1110,
        0b0000,
    },
    {
        0b0100,
        0b0110,
        0b0100,
        0b0000,
    },
    {
        0b0000,
        0b1110,
        0b0100,
        0b0000,
    },
    {
        0b0100,
        0b1100,
        0b0100,
        0b0000,
    },

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
    0b000000000000,
};
