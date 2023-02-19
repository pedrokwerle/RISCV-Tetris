/*
 * Example software running in Logisim RISC-V Computer System model by Pavel Gladyshev
 * licensed under Creative Commons Attribution International license 4.0
 *
 * This example shows how graphics display can be used to dsisplay pictures.
 * 
 * the showpic() function that fills graphics display with the given picture is 
 * written in assembly language (it is in the file showpic.s). 
 * It is declared at the end of lib.h
 *
 * The picture data for two pictures is defined in pictures.c file,
 * the pictures[] array is declared in pictures.h header file.
 */

#include "lib.h"
#include "display.h"
#include "movement.h"
#include "shapes.h"
#include "physics.h"
#include "random.h"

int main(){
    initialize();
    for (int j = 0; j < HEIGHT; j++){
        paint_row(play_area[j], j);
    }
    int colision = 0;
    while (colision < 1){
        for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
            paint_row(piece_mask[j] | play_area[j], j);
        }
        mv_piece_d();
        colision = colision_check();
    }
    /*
    mv_piece_u();
    consolidate_rows();
    clear_rows();

    for (int j = 0; j < HEIGHT; j++){
        paint_row(play_area[j], j);
    }
    */
}
