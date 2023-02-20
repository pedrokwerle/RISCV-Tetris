#pragma once

#define SQUARESIZE (4)

extern int result[SQUARESIZE];
extern int end_game;

int colision_check();
int colision_check_wall();
int consolidate_rows();
int clear_rows();
void tetris_god_senpai();
