#pragma once

#define TETRIS (7)
#define SQUARESIZE (4)
#define HEIGHT (25)

extern int pieces[TETRIS][SQUARESIZE];
extern int play_area[HEIGHT];
extern int piece_row;
extern int piece_col;
extern int piece_mask[HEIGHT];
extern int current_piece[SQUARESIZE];
void apply_mask(int piece[SQUARESIZE]);
void reset_mask();
void initialize();
void reset_position();
