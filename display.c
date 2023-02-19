#include "display.h"
#include "shapes.h"

void paint_row(int row, int row_num){
        *((volatile int *)(0xffff8000 + row_num*4)) = row;
}
