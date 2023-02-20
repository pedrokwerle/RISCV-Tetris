#include "shapes.h"
#include "matrix.h"
#include "random.h"
#include "lib.h"

// copy the contents of the current_piecem to the position in the mask indicated by piece_row and piece_col
void apply_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = current_piecem[i-piece_row]; // mask row equal current piece row
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
    }
}

void reset_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece_mask[i] >> 12;
    }
}

void initialize(){
    piece_index = (random())%TETRIS-1; // modulo TETRIS-1 so that the number is never bigger than the last piece index
    (piece_index);
    piece_row = 4;
    piece_col = 5;
    // set the play area to its initial state
    play_area[0] = 0b111111111111;
    play_area[1] = 0b111111111111;
    play_area[2] = 0b111111111111;
    play_area[3] = 0b111111111111;
    for (int i = 4; i < HEIGHT-1; i++){
        play_area[i] = 0b100000000001;
    }
    play_area[HEIGHT-1] = 0b111111111111;
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
    }
    apply_mask();
}

void change_piece(){
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
    }
}

volatile int piece_index = 0;
int piece_row = 0;
int piece_col = 0;
int current_piecem[SQUARESIZE];

int pieces[TETRIS][SQUARESIZE]=
{
    // line variations
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

    // L variations
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
    // reverse L variations
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
    // square variations
    {
        0b0000,
        0b0110,
        0b0110,
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
        0b0110,
        0b0000,
    },
    {
        0b0000,
        0b0110,
        0b0110,
        0b0000,
    },

    // S variations
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
    // Z variations

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

    // cross variations
    {
        0b0100,
        0b1110,
        0b0000,
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
