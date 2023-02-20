#pragma once

#define TETRIS (28)
#define SQUARESIZE (4)
#define HEIGHT (25)

extern int pieces[TETRIS][SQUARESIZE];
extern int piece_mask[HEIGHT];
extern int play_area[HEIGHT];
extern int play_area_redacted[HEIGHT];
extern int piece_row;
extern int piece_col;
extern int current_piecem[SQUARESIZE];
extern volatile int piece_index;
void change_piece();
void apply_mask();
void reset_mask();
void initialize();
void reset_position();
