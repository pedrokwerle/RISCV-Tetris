
tetris:     file format elf32-littleriscv


Disassembly of section .init:

00400000 <_start>:

    .extern __stack_init      # address of the initial top of C call stack (calculated externally by linker)

	.globl _start
_start:                       # this is where CPU starts executing instructions after reset / power-on
	la sp,__stack_init        # initialise stack pointer (with the value that points to the last word of RAM)
  400000:	0fc10117          	auipc	sp,0xfc10
  400004:	ffc10113          	addi	sp,sp,-4 # 1000fffc <__stack_init>
	li a0,0                   # populate optional main() parameters with dummy values (just in case)
  400008:	00000513          	li	a0,0
	li a1,0
  40000c:	00000593          	li	a1,0
	li a2,0
  400010:	00000613          	li	a2,0
	jal main                  # call C main() function
  400014:	008000ef          	jal	ra,40001c <main>

00400018 <exit>:
exit:
	j exit                    # keep looping forever after main() returns
  400018:	0000006f          	j	400018 <exit>

Disassembly of section .text:

0040001c <main>:
#include "physics.h"
#include "random.h"
#include "matrix.h"
#include "buttons.h"

int main(){
  40001c:	fc010113          	addi	sp,sp,-64
  400020:	02112e23          	sw	ra,60(sp)
  400024:	02812c23          	sw	s0,56(sp)
  400028:	02912a23          	sw	s1,52(sp)
  40002c:	03212823          	sw	s2,48(sp)
  400030:	03312623          	sw	s3,44(sp)
  400034:	03412423          	sw	s4,40(sp)
  400038:	03512223          	sw	s5,36(sp)
  40003c:	03612023          	sw	s6,32(sp)
  400040:	01712e23          	sw	s7,28(sp)
  400044:	01812c23          	sw	s8,24(sp)
  400048:	01912a23          	sw	s9,20(sp)
  40004c:	01a12823          	sw	s10,16(sp)
  400050:	01b12623          	sw	s11,12(sp)
    initialize();
  400054:	3dc000ef          	jal	ra,400430 <initialize>
    int points = 0;
    for (int j = 0; j < HEIGHT; j++){
  400058:	100004b7          	lui	s1,0x10000
  40005c:	07448d93          	addi	s11,s1,116 # 10000074 <play_area>
    initialize();
  400060:	07448493          	addi	s1,s1,116
    for (int j = 0; j < HEIGHT; j++){
  400064:	00000413          	li	s0,0
  400068:	01900913          	li	s2,25
        paint_row(play_area[j], j);
  40006c:	00040593          	mv	a1,s0
  400070:	0004a503          	lw	a0,0(s1)
  400074:	4e0000ef          	jal	ra,400554 <paint_row>
    for (int j = 0; j < HEIGHT; j++){
  400078:	00140413          	addi	s0,s0,1
  40007c:	00448493          	addi	s1,s1,4
  400080:	ff2416e3          	bne	s0,s2,40006c <main+0x50>
    }
    while(!end_game){
  400084:	100007b7          	lui	a5,0x10000
  400088:	0f47ac83          	lw	s9,244(a5) # 100000f4 <end_game>
    int points = 0;
  40008c:	000c8c13          	mv	s8,s9
    while(!end_game){
  400090:	020c9663          	bnez	s9,4000bc <main+0xa0>
            }
            else{
            mv_piece_d();
            }
            lowerFlags();
            for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  400094:	100009b7          	lui	s3,0x10000
  400098:	40000bb7          	lui	s7,0x40000
  40009c:	fffb8b93          	addi	s7,s7,-1 # 3fffffff <__stack_init+0x2fff0003>
  4000a0:	10000b37          	lui	s6,0x10000
  4000a4:	010b0b13          	addi	s6,s6,16 # 10000010 <piece_mask>
  4000a8:	10000ab7          	lui	s5,0x10000
  4000ac:	074a8a93          	addi	s5,s5,116 # 10000074 <play_area>
            colision = colision_check();
        }
        consolidate_rows();
        points += clear_rows();

        for (int j = 0; j < HEIGHT-1; j++){
  4000b0:	01800a13          	li	s4,24
    while(!end_game){
  4000b4:	00078d13          	mv	s10,a5
  4000b8:	0680006f          	j	400120 <main+0x104>
    int points = 0;
  4000bc:	00000c13          	li	s8,0
  4000c0:	0c00006f          	j	400180 <main+0x164>
            else if(pollRightFlag()){
  4000c4:	1b1000ef          	jal	ra,400a74 <pollRightFlag>
  4000c8:	06050463          	beqz	a0,400130 <main+0x114>
            mv_piece_r();
  4000cc:	5a0000ef          	jal	ra,40066c <mv_piece_r>
            lowerFlags();
  4000d0:	1bd000ef          	jal	ra,400a8c <lowerFlags>
            for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  4000d4:	0ec9a483          	lw	s1,236(s3) # 100000ec <piece_row>
  4000d8:	fff48413          	addi	s0,s1,-1
  4000dc:	017484b3          	add	s1,s1,s7
  4000e0:	00249493          	slli	s1,s1,0x2
  4000e4:	01648933          	add	s2,s1,s6
  4000e8:	015484b3          	add	s1,s1,s5
                paint_row(piece_mask[j] | play_area[j], j);
  4000ec:	00092503          	lw	a0,0(s2)
  4000f0:	0004a783          	lw	a5,0(s1)
  4000f4:	00040593          	mv	a1,s0
  4000f8:	00f56533          	or	a0,a0,a5
  4000fc:	458000ef          	jal	ra,400554 <paint_row>
            for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  400100:	00140413          	addi	s0,s0,1
  400104:	00490913          	addi	s2,s2,4
  400108:	00448493          	addi	s1,s1,4
  40010c:	0ec9a783          	lw	a5,236(s3)
  400110:	00378793          	addi	a5,a5,3
  400114:	fc87dce3          	bge	a5,s0,4000ec <main+0xd0>
            colision = colision_check();
  400118:	720000ef          	jal	ra,400838 <colision_check>
        while (colision < 1){
  40011c:	02a04663          	bgtz	a0,400148 <main+0x12c>
            if(pollLeftFlag()){
  400120:	149000ef          	jal	ra,400a68 <pollLeftFlag>
  400124:	fa0500e3          	beqz	a0,4000c4 <main+0xa8>
            mv_piece_l();
  400128:	4a8000ef          	jal	ra,4005d0 <mv_piece_l>
  40012c:	fa5ff06f          	j	4000d0 <main+0xb4>
            else if(pollRotFlag()){
  400130:	151000ef          	jal	ra,400a80 <pollRotFlag>
  400134:	00050663          	beqz	a0,400140 <main+0x124>
            r_piece_cw();
  400138:	650000ef          	jal	ra,400788 <r_piece_cw>
  40013c:	f95ff06f          	j	4000d0 <main+0xb4>
            mv_piece_d();
  400140:	5c8000ef          	jal	ra,400708 <mv_piece_d>
  400144:	f8dff06f          	j	4000d0 <main+0xb4>
        consolidate_rows();
  400148:	7e4000ef          	jal	ra,40092c <consolidate_rows>
        points += clear_rows();
  40014c:	025000ef          	jal	ra,400970 <clear_rows>
  400150:	00ac0c33          	add	s8,s8,a0
  400154:	000d8493          	mv	s1,s11
        for (int j = 0; j < HEIGHT-1; j++){
  400158:	000c8413          	mv	s0,s9
            paint_row(play_area[j], j);
  40015c:	00040593          	mv	a1,s0
  400160:	0004a503          	lw	a0,0(s1)
  400164:	3f0000ef          	jal	ra,400554 <paint_row>
        for (int j = 0; j < HEIGHT-1; j++){
  400168:	00140413          	addi	s0,s0,1
  40016c:	00448493          	addi	s1,s1,4
  400170:	ff4416e3          	bne	s0,s4,40015c <main+0x140>
        }
        tetris_god_senpai();
  400174:	091000ef          	jal	ra,400a04 <tetris_god_senpai>
    while(!end_game){
  400178:	0f4d2783          	lw	a5,244(s10)
  40017c:	fa0782e3          	beqz	a5,400120 <main+0x104>
    }
    printstr("Your score is: ");
  400180:	00401537          	lui	a0,0x401
  400184:	a9c50513          	addi	a0,a0,-1380 # 400a9c <lowerFlags+0x10>
  400188:	078000ef          	jal	ra,400200 <printstr>
    printint(points);
  40018c:	000c0513          	mv	a0,s8
  400190:	090000ef          	jal	ra,400220 <printint>
}
  400194:	00000513          	li	a0,0
  400198:	03c12083          	lw	ra,60(sp)
  40019c:	03812403          	lw	s0,56(sp)
  4001a0:	03412483          	lw	s1,52(sp)
  4001a4:	03012903          	lw	s2,48(sp)
  4001a8:	02c12983          	lw	s3,44(sp)
  4001ac:	02812a03          	lw	s4,40(sp)
  4001b0:	02412a83          	lw	s5,36(sp)
  4001b4:	02012b03          	lw	s6,32(sp)
  4001b8:	01c12b83          	lw	s7,28(sp)
  4001bc:	01812c03          	lw	s8,24(sp)
  4001c0:	01412c83          	lw	s9,20(sp)
  4001c4:	01012d03          	lw	s10,16(sp)
  4001c8:	00c12d83          	lw	s11,12(sp)
  4001cc:	04010113          	addi	sp,sp,64
  4001d0:	00008067          	ret

004001d4 <abs>:
 */

#include "lib.h"

// returns absolute value of its integer argument - a replacement of the standard library function abs() 
inline int abs(int n) { return (n < 0) ? (-n) : n; }
  4001d4:	41f55793          	srai	a5,a0,0x1f
  4001d8:	00a7c533          	xor	a0,a5,a0
  4001dc:	40f50533          	sub	a0,a0,a5
  4001e0:	00008067          	ret

004001e4 <printchar>:

// prints single character to console - a substitute for the standard library funciton putch(int chr)
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  4001e4:	ffff07b7          	lui	a5,0xffff0
  4001e8:	00a7a623          	sw	a0,12(a5) # ffff000c <__stack_init+0xeffe0010>
  4001ec:	00008067          	ret

004001f0 <println>:
  4001f0:	ffff07b7          	lui	a5,0xffff0
  4001f4:	00a00713          	li	a4,10
  4001f8:	00e7a623          	sw	a4,12(a5) # ffff000c <__stack_init+0xeffe0010>

// prints newline character to console
void println() { printchar('\n'); }
  4001fc:	00008067          	ret

00400200 <printstr>:

// prints given string of characters to console - a substitute for the standard library function puts(char *s)
void printstr(char *str)
{
    while (*str != '\0') 
  400200:	00054783          	lbu	a5,0(a0)
  400204:	00078c63          	beqz	a5,40021c <printstr+0x1c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400208:	ffff0737          	lui	a4,0xffff0
  40020c:	00f72623          	sw	a5,12(a4) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(*str);
        str += 1;
  400210:	00150513          	addi	a0,a0,1
    while (*str != '\0') 
  400214:	00054783          	lbu	a5,0(a0)
  400218:	fe079ae3          	bnez	a5,40020c <printstr+0xc>
    }
}
  40021c:	00008067          	ret

00400220 <printint>:

// prints given integer as a signed decimal number
void printint(int n)
{
  400220:	ff010113          	addi	sp,sp,-16
    {
        sign = '-';
    }
    else
    {
        sign = '\0';
  400224:	41f55813          	srai	a6,a0,0x1f
  400228:	02d87813          	andi	a6,a6,45
  40022c:	00410713          	addi	a4,sp,4
  400230:	00900613          	li	a2,9
    
    // produce decimal digits of the number going from right to left, keep them in num[] array.
    do 
    {
        i = i - 1;
        num[i] = abs(n % 10) + '0';
  400234:	00a00593          	li	a1,10
        i = i - 1;
  400238:	fff60613          	addi	a2,a2,-1
        num[i] = abs(n % 10) + '0';
  40023c:	02b567b3          	rem	a5,a0,a1
  400240:	41f7d693          	srai	a3,a5,0x1f
  400244:	00f6c7b3          	xor	a5,a3,a5
  400248:	40d787b3          	sub	a5,a5,a3
  40024c:	03078793          	addi	a5,a5,48
  400250:	00f70423          	sb	a5,8(a4)
        n = n / 10;
  400254:	02b54533          	div	a0,a0,a1
    } while (n != 0);
  400258:	fff70713          	addi	a4,a4,-1
  40025c:	fc051ee3          	bnez	a0,400238 <printint+0x18>
    
    //now print the sign of the number and its digits left-to-right.
    if (sign) 
  400260:	00080663          	beqz	a6,40026c <printint+0x4c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400264:	ffff07b7          	lui	a5,0xffff0
  400268:	0107a623          	sw	a6,12(a5) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(sign);
    }
    
    while(i < MAX_INT_DIGITS)
  40026c:	00900793          	li	a5,9
  400270:	02c7c263          	blt	a5,a2,400294 <printint+0x74>
  400274:	00410793          	addi	a5,sp,4
  400278:	00c787b3          	add	a5,a5,a2
  40027c:	00e10693          	addi	a3,sp,14
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400280:	ffff0637          	lui	a2,0xffff0
  400284:	0007c703          	lbu	a4,0(a5)
  400288:	00e62623          	sw	a4,12(a2) # ffff000c <__stack_init+0xeffe0010>
    while(i < MAX_INT_DIGITS)
  40028c:	00178793          	addi	a5,a5,1
  400290:	fed79ae3          	bne	a5,a3,400284 <printint+0x64>
    {
        printchar(num[i]);
        i=i+1;
    }
}
  400294:	01010113          	addi	sp,sp,16
  400298:	00008067          	ret

0040029c <pollkbd>:


// check if keyboard buffer has some data
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  40029c:	ffff07b7          	lui	a5,0xffff0
  4002a0:	0007a503          	lw	a0,0(a5) # ffff0000 <__stack_init+0xeffe0004>
  4002a4:	00008067          	ret

004002a8 <readchar>:

// read next character from keyboard buffer
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  4002a8:	ffff07b7          	lui	a5,0xffff0
  4002ac:	0047a503          	lw	a0,4(a5) # ffff0004 <__stack_init+0xeffe0008>
  4002b0:	00008067          	ret

004002b4 <readstr>:

// read characters into provided buffer until either user presses enter or the buffer size is reached.
int readstr(char *buf, int size)
{
  4002b4:	00050693          	mv	a3,a0
    int count;
    
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  4002b8:	00100793          	li	a5,1
  4002bc:	04b7d263          	bge	a5,a1,400300 <readstr+0x4c>
  4002c0:	fff58613          	addi	a2,a1,-1
    
    count = 0;
  4002c4:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  4002c8:	ffff0737          	lui	a4,0xffff0
       
       // read next character into the current element of the buffer
       *buf = (char)readchar();
       
       // if the user pressed Enter, stop reading
       if (*buf == '\n') 
  4002cc:	00a00593          	li	a1,10
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  4002d0:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  4002d4:	fe078ee3          	beqz	a5,4002d0 <readstr+0x1c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  4002d8:	00472783          	lw	a5,4(a4)
       *buf = (char)readchar();
  4002dc:	0ff7f793          	andi	a5,a5,255
  4002e0:	00f68023          	sb	a5,0(a3)
       if (*buf == '\n') 
  4002e4:	00b78a63          	beq	a5,a1,4002f8 <readstr+0x44>
       {
           break;
       }
       
       // move pointer to the next element of the buffer
       buf += 1;
  4002e8:	00168693          	addi	a3,a3,1
       
       // increase the number of characters in the buffer
       count += 1;
  4002ec:	00150513          	addi	a0,a0,1
       
       // decrease the remaining space in the buffer
       size -= 1;
       
    } while(size > 1);  // keep going until one empty char remains (to hold the final '\0' character
  4002f0:	fec510e3          	bne	a0,a2,4002d0 <readstr+0x1c>
       count += 1;
  4002f4:	00060513          	mv	a0,a2
    
    *buf = '\0';  // add the end-of-string marker '\0'
  4002f8:	00068023          	sb	zero,0(a3)
    
    return count; // return the number of characters in the read string
  4002fc:	00008067          	ret
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  400300:	fff00513          	li	a0,-1
}
  400304:	00008067          	ret

00400308 <readint>:

//read signed integer
int readint()
{
    int res = 0;
    int sign = 1;
  400308:	00100593          	li	a1,1
    int res = 0;
  40030c:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400310:	ffff0737          	lui	a4,0xffff0
           sign = -1;
       }
       else
       {
           // otherwise, if a non-digit is read, it signifies the end of the number
           if (chr < '0' || chr > '9') 
  400314:	00900613          	li	a2,9
       if (res == 0 && sign == 1 && chr == '-') 
  400318:	00100813          	li	a6,1
  40031c:	02d00893          	li	a7,45
           sign = -1;
  400320:	fff00313          	li	t1,-1
  400324:	0200006f          	j	400344 <readint+0x3c>
           if (chr < '0' || chr > '9') 
  400328:	fd068793          	addi	a5,a3,-48
  40032c:	02f66c63          	bltu	a2,a5,400364 <readint+0x5c>
           {
               break;
           }
           // incorporate the read digit into the number (N.B. chr - '0' gived the digit value).
           res = res * 10 + (chr - '0');
  400330:	00251793          	slli	a5,a0,0x2
  400334:	00a787b3          	add	a5,a5,a0
  400338:	00179793          	slli	a5,a5,0x1
  40033c:	fd068693          	addi	a3,a3,-48
  400340:	00f68533          	add	a0,a3,a5
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400344:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  400348:	fe078ee3          	beqz	a5,400344 <readint+0x3c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  40034c:	00472683          	lw	a3,4(a4)
       if (res == 0 && sign == 1 && chr == '-') 
  400350:	fc051ce3          	bnez	a0,400328 <readint+0x20>
  400354:	fd059ae3          	bne	a1,a6,400328 <readint+0x20>
  400358:	fd1698e3          	bne	a3,a7,400328 <readint+0x20>
           sign = -1;
  40035c:	00030593          	mv	a1,t1
  400360:	fe5ff06f          	j	400344 <readint+0x3c>
       }
    }
    
    // return the absolute value of the number (constructed from entered digits) multiplied by the sign.
    return sign * res;
}
  400364:	02b50533          	mul	a0,a0,a1
  400368:	00008067          	ret

0040036c <showpic>:
    # as long as this function is not calling other functions.
    
    .globl showpic
    
showpic:
    li t0,0xffff8000    # starting address of the graphics display
  40036c:	ffff82b7          	lui	t0,0xffff8
    li t1,32            # number of lines on the display (each word encodes one line) 
  400370:	02000313          	li	t1,32

00400374 <loop>:
loop:
    lw t2,0(a0)         # load next line (word) of the picture data
  400374:	00052383          	lw	t2,0(a0)
    sw t2,0(t0)         # write it to the corresponding line of the graphics display
  400378:	0072a023          	sw	t2,0(t0) # ffff8000 <__stack_init+0xeffe8004>
    addi t0,t0,4        # move to the next line of the graphics display
  40037c:	00428293          	addi	t0,t0,4
    addi a0,a0,4        # move to the next line of the picture data
  400380:	00450513          	addi	a0,a0,4
    addi t1,t1,-1       # reduce the number of remaining lines
  400384:	fff30313          	addi	t1,t1,-1
    bnez t1,loop        # keep going until all lines on the display are filled with data
  400388:	fe0316e3          	bnez	t1,400374 <loop>
    jr ra               # return 
  40038c:	00008067          	ret

00400390 <random>:
   	# FAT L SEED 12938476
	
	.global random
	
random:
	bnez t0, skip
  400390:	00029463          	bnez	t0,400398 <skip>
	li t0, 851 	# seed, change for a different sequence
  400394:	35300293          	li	t0,851

00400398 <skip>:
skip:
	slli  t1, t0, 1		
  400398:	00129313          	slli	t1,t0,0x1
	xor t1, t1, t0
  40039c:	00534333          	xor	t1,t1,t0
	mv t0, t1
  4003a0:	00030293          	mv	t0,t1
	mv a0, t1
  4003a4:	00030513          	mv	a0,t1
	ret			# Return
  4003a8:	00008067          	ret

004003ac <apply_mask>:

// copy the contents of the current_piecem to the position in the mask indicated by piece_row and piece_col
void apply_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = current_piecem[i-piece_row]; // mask row equal current piece row
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  4003ac:	100007b7          	lui	a5,0x10000
  4003b0:	0e87a783          	lw	a5,232(a5) # 100000e8 <piece_col>
  4003b4:	00800593          	li	a1,8
  4003b8:	40f585b3          	sub	a1,a1,a5
  4003bc:	100007b7          	lui	a5,0x10000
  4003c0:	00078793          	mv	a5,a5
  4003c4:	01078613          	addi	a2,a5,16 # 10000010 <piece_mask>
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4003c8:	10000737          	lui	a4,0x10000
  4003cc:	0ec72703          	lw	a4,236(a4) # 100000ec <piece_row>
  4003d0:	00271713          	slli	a4,a4,0x2
  4003d4:	00e60733          	add	a4,a2,a4
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  4003d8:	0007a683          	lw	a3,0(a5)
  4003dc:	00b696b3          	sll	a3,a3,a1
  4003e0:	00d72023          	sw	a3,0(a4)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4003e4:	00478793          	addi	a5,a5,4
  4003e8:	00470713          	addi	a4,a4,4
  4003ec:	fec796e3          	bne	a5,a2,4003d8 <apply_mask+0x2c>
    }
}
  4003f0:	00008067          	ret

004003f4 <reset_mask>:

void reset_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4003f4:	100007b7          	lui	a5,0x10000
  4003f8:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  4003fc:	00269693          	slli	a3,a3,0x2
  400400:	10000737          	lui	a4,0x10000
  400404:	00070713          	mv	a4,a4
  400408:	01070793          	addi	a5,a4,16 # 10000010 <piece_mask>
  40040c:	00d787b3          	add	a5,a5,a3
  400410:	02070713          	addi	a4,a4,32
  400414:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 12;
  400418:	0007a703          	lw	a4,0(a5)
  40041c:	40c75713          	srai	a4,a4,0xc
  400420:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400424:	00478793          	addi	a5,a5,4
  400428:	fed798e3          	bne	a5,a3,400418 <reset_mask+0x24>
    }
}
  40042c:	00008067          	ret

00400430 <initialize>:

void initialize(){
  400430:	ff010113          	addi	sp,sp,-16
  400434:	00112623          	sw	ra,12(sp)
    piece_index = (random())%TETRIS-1; // modulo TETRIS-1 so that the number is never bigger than the last piece index
  400438:	f59ff0ef          	jal	ra,400390 <random>
  40043c:	01c00793          	li	a5,28
  400440:	02f567b3          	rem	a5,a0,a5
  400444:	fff78793          	addi	a5,a5,-1
  400448:	10000737          	lui	a4,0x10000
  40044c:	0ef72823          	sw	a5,240(a4) # 100000f0 <piece_index>
    (piece_index);
  400450:	0f072783          	lw	a5,240(a4)
    piece_row = 4;
  400454:	100007b7          	lui	a5,0x10000
  400458:	00400713          	li	a4,4
  40045c:	0ee7a623          	sw	a4,236(a5) # 100000ec <piece_row>
    piece_col = 5;
  400460:	100007b7          	lui	a5,0x10000
  400464:	00500713          	li	a4,5
  400468:	0ee7a423          	sw	a4,232(a5) # 100000e8 <piece_col>
    // set the play area to its initial state
    play_area[0] = 0b111111111111;
  40046c:	10000737          	lui	a4,0x10000
  400470:	00070713          	mv	a4,a4
  400474:	000017b7          	lui	a5,0x1
  400478:	fff78793          	addi	a5,a5,-1 # fff <_start-0x3ff001>
  40047c:	06f72a23          	sw	a5,116(a4) # 10000074 <play_area>
    play_area[1] = 0b111111111111;
  400480:	06f72c23          	sw	a5,120(a4)
    play_area[2] = 0b111111111111;
  400484:	06f72e23          	sw	a5,124(a4)
    play_area[3] = 0b111111111111;
  400488:	08f72023          	sw	a5,128(a4)
    for (int i = 4; i < HEIGHT-1; i++){
  40048c:	08470793          	addi	a5,a4,132
  400490:	0d470713          	addi	a4,a4,212
        play_area[i] = 0b100000000001;
  400494:	000016b7          	lui	a3,0x1
  400498:	80168693          	addi	a3,a3,-2047 # 801 <_start-0x3ff7ff>
  40049c:	00d7a023          	sw	a3,0(a5)
    for (int i = 4; i < HEIGHT-1; i++){
  4004a0:	00478793          	addi	a5,a5,4
  4004a4:	fee79ce3          	bne	a5,a4,40049c <initialize+0x6c>
    }
    play_area[HEIGHT-1] = 0b111111111111;
  4004a8:	100006b7          	lui	a3,0x10000
  4004ac:	00068713          	mv	a4,a3
  4004b0:	000017b7          	lui	a5,0x1
  4004b4:	fff78793          	addi	a5,a5,-1 # fff <_start-0x3ff001>
  4004b8:	0cf72a23          	sw	a5,212(a4)
    for (int j = 0; j < SQUARESIZE; j++){
  4004bc:	00068693          	mv	a3,a3
  4004c0:	00000713          	li	a4,0
        current_piecem[j] = pieces[piece_index][j];
  4004c4:	10000537          	lui	a0,0x10000
  4004c8:	00401637          	lui	a2,0x401
  4004cc:	aac60613          	addi	a2,a2,-1364 # 400aac <pieces>
    for (int j = 0; j < SQUARESIZE; j++){
  4004d0:	00400593          	li	a1,4
        current_piecem[j] = pieces[piece_index][j];
  4004d4:	0f052783          	lw	a5,240(a0) # 100000f0 <piece_index>
  4004d8:	00279793          	slli	a5,a5,0x2
  4004dc:	00e787b3          	add	a5,a5,a4
  4004e0:	00279793          	slli	a5,a5,0x2
  4004e4:	00f607b3          	add	a5,a2,a5
  4004e8:	0007a783          	lw	a5,0(a5)
  4004ec:	00f6a023          	sw	a5,0(a3) # 10000000 <current_piecem>
    for (int j = 0; j < SQUARESIZE; j++){
  4004f0:	00170713          	addi	a4,a4,1
  4004f4:	00468693          	addi	a3,a3,4
  4004f8:	fcb71ee3          	bne	a4,a1,4004d4 <initialize+0xa4>
    }
    apply_mask();
  4004fc:	eb1ff0ef          	jal	ra,4003ac <apply_mask>
}
  400500:	00c12083          	lw	ra,12(sp)
  400504:	01010113          	addi	sp,sp,16
  400508:	00008067          	ret

0040050c <change_piece>:

void change_piece(){
    for (int j = 0; j < SQUARESIZE; j++){
  40050c:	100006b7          	lui	a3,0x10000
  400510:	00068693          	mv	a3,a3
  400514:	00000713          	li	a4,0
        current_piecem[j] = pieces[piece_index][j];
  400518:	10000537          	lui	a0,0x10000
  40051c:	00401637          	lui	a2,0x401
  400520:	aac60613          	addi	a2,a2,-1364 # 400aac <pieces>
    for (int j = 0; j < SQUARESIZE; j++){
  400524:	00400593          	li	a1,4
        current_piecem[j] = pieces[piece_index][j];
  400528:	0f052783          	lw	a5,240(a0) # 100000f0 <piece_index>
  40052c:	00279793          	slli	a5,a5,0x2
  400530:	00e787b3          	add	a5,a5,a4
  400534:	00279793          	slli	a5,a5,0x2
  400538:	00f607b3          	add	a5,a2,a5
  40053c:	0007a783          	lw	a5,0(a5)
  400540:	00f6a023          	sw	a5,0(a3) # 10000000 <current_piecem>
    for (int j = 0; j < SQUARESIZE; j++){
  400544:	00170713          	addi	a4,a4,1
  400548:	00468693          	addi	a3,a3,4
  40054c:	fcb71ee3          	bne	a4,a1,400528 <change_piece+0x1c>
    }
}
  400550:	00008067          	ret

00400554 <paint_row>:
#include "display.h"
#include "shapes.h"

void paint_row(int row, int row_num){
        *((volatile int *)(0xffff8000 + row_num*4)) = row;
  400554:	00259593          	slli	a1,a1,0x2
  400558:	ffff87b7          	lui	a5,0xffff8
  40055c:	00f585b3          	add	a1,a1,a5
  400560:	00a5a023          	sw	a0,0(a1)
}
  400564:	00008067          	ret

00400568 <bit_or_matrix>:
#include "matrix.h"
#include "lib.h"
#include "shapes.h"

void bit_or_matrix(int size, int matrix1[size], int matrix2[size], int result[size]){
    for (int i = 0; i < size; i++) {
  400568:	02a05863          	blez	a0,400598 <bit_or_matrix+0x30>
  40056c:	00058793          	mv	a5,a1
  400570:	00251513          	slli	a0,a0,0x2
  400574:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] | matrix2[i];
  400578:	0007a703          	lw	a4,0(a5) # ffff8000 <__stack_init+0xeffe8004>
  40057c:	00062583          	lw	a1,0(a2)
  400580:	00b76733          	or	a4,a4,a1
  400584:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  400588:	00478793          	addi	a5,a5,4
  40058c:	00460613          	addi	a2,a2,4
  400590:	00468693          	addi	a3,a3,4
  400594:	fea792e3          	bne	a5,a0,400578 <bit_or_matrix+0x10>
    }
}
  400598:	00008067          	ret

0040059c <bit_and_matrix>:

void bit_and_matrix(int size, int matrix1[size], int matrix2[size], int result[size]){
    for (int i = 0; i < size; i++) {
  40059c:	02a05863          	blez	a0,4005cc <bit_and_matrix+0x30>
  4005a0:	00058793          	mv	a5,a1
  4005a4:	00251513          	slli	a0,a0,0x2
  4005a8:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] & matrix2[i];
  4005ac:	0007a703          	lw	a4,0(a5)
  4005b0:	00062583          	lw	a1,0(a2)
  4005b4:	00b77733          	and	a4,a4,a1
  4005b8:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  4005bc:	00478793          	addi	a5,a5,4
  4005c0:	00460613          	addi	a2,a2,4
  4005c4:	00468693          	addi	a3,a3,4
  4005c8:	fea792e3          	bne	a5,a0,4005ac <bit_and_matrix+0x10>
    }
}
  4005cc:	00008067          	ret

004005d0 <mv_piece_l>:
#include "shapes.h"
#include "matrix.h"
#include "physics.h"
#include "lib.h"

void mv_piece_l(){
  4005d0:	ff010113          	addi	sp,sp,-16
  4005d4:	00112623          	sw	ra,12(sp)
  4005d8:	00812423          	sw	s0,8(sp)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4005dc:	100007b7          	lui	a5,0x10000
  4005e0:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  4005e4:	00269693          	slli	a3,a3,0x2
  4005e8:	10000737          	lui	a4,0x10000
  4005ec:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  4005f0:	00e687b3          	add	a5,a3,a4
  4005f4:	01070413          	addi	s0,a4,16
  4005f8:	008686b3          	add	a3,a3,s0
        piece_mask[i] = piece_mask[i] << 1;
  4005fc:	0007a703          	lw	a4,0(a5)
  400600:	00171713          	slli	a4,a4,0x1
  400604:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400608:	00478793          	addi	a5,a5,4
  40060c:	fed798e3          	bne	a5,a3,4005fc <mv_piece_l+0x2c>
    }
	
	if (colision_check_wall()) {
  400610:	2ac000ef          	jal	ra,4008bc <colision_check_wall>
  400614:	02050c63          	beqz	a0,40064c <mv_piece_l+0x7c>
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400618:	100007b7          	lui	a5,0x10000
  40061c:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  400620:	00269693          	slli	a3,a3,0x2
  400624:	100007b7          	lui	a5,0x10000
  400628:	01078793          	addi	a5,a5,16 # 10000010 <piece_mask>
  40062c:	00f687b3          	add	a5,a3,a5
  400630:	008686b3          	add	a3,a3,s0
			piece_mask[i] = piece_mask[i] >> 1;
  400634:	0007a703          	lw	a4,0(a5)
  400638:	40175713          	srai	a4,a4,0x1
  40063c:	00e7a023          	sw	a4,0(a5)
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400640:	00478793          	addi	a5,a5,4
  400644:	fed798e3          	bne	a5,a3,400634 <mv_piece_l+0x64>
  400648:	0140006f          	j	40065c <mv_piece_l+0x8c>
		}
	}
	else {
		piece_col -= 1;
  40064c:	10000737          	lui	a4,0x10000
  400650:	0e872783          	lw	a5,232(a4) # 100000e8 <piece_col>
  400654:	fff78793          	addi	a5,a5,-1
  400658:	0ef72423          	sw	a5,232(a4)
	}
}
  40065c:	00c12083          	lw	ra,12(sp)
  400660:	00812403          	lw	s0,8(sp)
  400664:	01010113          	addi	sp,sp,16
  400668:	00008067          	ret

0040066c <mv_piece_r>:
void mv_piece_r(){
  40066c:	ff010113          	addi	sp,sp,-16
  400670:	00112623          	sw	ra,12(sp)
  400674:	00812423          	sw	s0,8(sp)
	(1);
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400678:	100007b7          	lui	a5,0x10000
  40067c:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  400680:	00269693          	slli	a3,a3,0x2
  400684:	10000737          	lui	a4,0x10000
  400688:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  40068c:	00e687b3          	add	a5,a3,a4
  400690:	01070413          	addi	s0,a4,16
  400694:	008686b3          	add	a3,a3,s0
        piece_mask[i] = piece_mask[i] >> 1;
  400698:	0007a703          	lw	a4,0(a5)
  40069c:	40175713          	srai	a4,a4,0x1
  4006a0:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4006a4:	00478793          	addi	a5,a5,4
  4006a8:	fed798e3          	bne	a5,a3,400698 <mv_piece_r+0x2c>
    }
	if (colision_check_wall()) {
  4006ac:	210000ef          	jal	ra,4008bc <colision_check_wall>
  4006b0:	02050c63          	beqz	a0,4006e8 <mv_piece_r+0x7c>
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4006b4:	100007b7          	lui	a5,0x10000
  4006b8:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  4006bc:	00269693          	slli	a3,a3,0x2
  4006c0:	100007b7          	lui	a5,0x10000
  4006c4:	01078793          	addi	a5,a5,16 # 10000010 <piece_mask>
  4006c8:	00f687b3          	add	a5,a3,a5
  4006cc:	008686b3          	add	a3,a3,s0
			piece_mask[i] = piece_mask[i] << 1;
  4006d0:	0007a703          	lw	a4,0(a5)
  4006d4:	00171713          	slli	a4,a4,0x1
  4006d8:	00e7a023          	sw	a4,0(a5)
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4006dc:	00478793          	addi	a5,a5,4
  4006e0:	fed798e3          	bne	a5,a3,4006d0 <mv_piece_r+0x64>
  4006e4:	0140006f          	j	4006f8 <mv_piece_r+0x8c>
		}
	}
	else{
		piece_col += 1;		
  4006e8:	10000737          	lui	a4,0x10000
  4006ec:	0e872783          	lw	a5,232(a4) # 100000e8 <piece_col>
  4006f0:	00178793          	addi	a5,a5,1
  4006f4:	0ef72423          	sw	a5,232(a4)
	}
}
  4006f8:	00c12083          	lw	ra,12(sp)
  4006fc:	00812403          	lw	s0,8(sp)
  400700:	01010113          	addi	sp,sp,16
  400704:	00008067          	ret

00400708 <mv_piece_d>:
void mv_piece_d(){
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  400708:	100007b7          	lui	a5,0x10000
  40070c:	0ec7a603          	lw	a2,236(a5) # 100000ec <piece_row>
  400710:	00261693          	slli	a3,a2,0x2
  400714:	10000737          	lui	a4,0x10000
  400718:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  40071c:	00e687b3          	add	a5,a3,a4
  400720:	fec70713          	addi	a4,a4,-20
  400724:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i-1];
  400728:	00c7a683          	lw	a3,12(a5)
  40072c:	00d7a823          	sw	a3,16(a5)
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  400730:	ffc78793          	addi	a5,a5,-4
  400734:	fee79ae3          	bne	a5,a4,400728 <mv_piece_d+0x20>
    }
    piece_row += 1;
  400738:	00160613          	addi	a2,a2,1
  40073c:	100007b7          	lui	a5,0x10000
  400740:	0ec7a623          	sw	a2,236(a5) # 100000ec <piece_row>
}
  400744:	00008067          	ret

00400748 <mv_piece_u>:
void mv_piece_u(){
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  400748:	100007b7          	lui	a5,0x10000
  40074c:	0ec7a703          	lw	a4,236(a5) # 100000ec <piece_row>
  400750:	fff70613          	addi	a2,a4,-1
  400754:	00271693          	slli	a3,a4,0x2
  400758:	10000737          	lui	a4,0x10000
  40075c:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  400760:	00e687b3          	add	a5,a3,a4
  400764:	01470713          	addi	a4,a4,20
  400768:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i+1];
  40076c:	0007a683          	lw	a3,0(a5)
  400770:	fed7ae23          	sw	a3,-4(a5)
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  400774:	00478793          	addi	a5,a5,4
  400778:	fee79ae3          	bne	a5,a4,40076c <mv_piece_u+0x24>
    }
    piece_row -= 1;
  40077c:	100007b7          	lui	a5,0x10000
  400780:	0ec7a623          	sw	a2,236(a5) # 100000ec <piece_row>
}
  400784:	00008067          	ret

00400788 <r_piece_cw>:
void r_piece_cw(){
  400788:	ff010113          	addi	sp,sp,-16
  40078c:	00112623          	sw	ra,12(sp)
    piece_index = rotational_vector[piece_index];
  400790:	100006b7          	lui	a3,0x10000
  400794:	0f06a783          	lw	a5,240(a3) # 100000f0 <piece_index>
  400798:	00279713          	slli	a4,a5,0x2
  40079c:	004017b7          	lui	a5,0x401
  4007a0:	c6c78793          	addi	a5,a5,-916 # 400c6c <rotational_vector>
  4007a4:	00e787b3          	add	a5,a5,a4
  4007a8:	0007a783          	lw	a5,0(a5)
  4007ac:	0ef6a823          	sw	a5,240(a3)
    change_piece();
  4007b0:	d5dff0ef          	jal	ra,40050c <change_piece>
    reset_mask();
  4007b4:	c41ff0ef          	jal	ra,4003f4 <reset_mask>
    apply_mask(current_piecem);
  4007b8:	10000537          	lui	a0,0x10000
  4007bc:	00050513          	mv	a0,a0
  4007c0:	bedff0ef          	jal	ra,4003ac <apply_mask>
	if (colision_check_wall()) {
  4007c4:	0f8000ef          	jal	ra,4008bc <colision_check_wall>
  4007c8:	00051863          	bnez	a0,4007d8 <r_piece_cw+0x50>
		reset_mask();
		apply_mask(current_piecem);
	}
	
	
}
  4007cc:	00c12083          	lw	ra,12(sp)
  4007d0:	01010113          	addi	sp,sp,16
  4007d4:	00008067          	ret
		piece_index = rotational_vector[piece_index];
  4007d8:	10000737          	lui	a4,0x10000
  4007dc:	0f072683          	lw	a3,240(a4) # 100000f0 <piece_index>
  4007e0:	004017b7          	lui	a5,0x401
  4007e4:	c6c78793          	addi	a5,a5,-916 # 400c6c <rotational_vector>
  4007e8:	00269693          	slli	a3,a3,0x2
  4007ec:	00d786b3          	add	a3,a5,a3
  4007f0:	0006a683          	lw	a3,0(a3)
  4007f4:	0ed72823          	sw	a3,240(a4)
		piece_index = rotational_vector[piece_index];
  4007f8:	0f072683          	lw	a3,240(a4)
  4007fc:	00269693          	slli	a3,a3,0x2
  400800:	00d786b3          	add	a3,a5,a3
  400804:	0006a683          	lw	a3,0(a3)
  400808:	0ed72823          	sw	a3,240(a4)
		piece_index = rotational_vector[piece_index];
  40080c:	0f072683          	lw	a3,240(a4)
  400810:	00269693          	slli	a3,a3,0x2
  400814:	00d787b3          	add	a5,a5,a3
  400818:	0007a783          	lw	a5,0(a5)
  40081c:	0ef72823          	sw	a5,240(a4)
		change_piece();
  400820:	cedff0ef          	jal	ra,40050c <change_piece>
		reset_mask();
  400824:	bd1ff0ef          	jal	ra,4003f4 <reset_mask>
		apply_mask(current_piecem);
  400828:	10000537          	lui	a0,0x10000
  40082c:	00050513          	mv	a0,a0
  400830:	b7dff0ef          	jal	ra,4003ac <apply_mask>
}
  400834:	f99ff06f          	j	4007cc <r_piece_cw+0x44>

00400838 <colision_check>:
#include "matrix.h"
#include "random.h"
#include "lib.h"

// checks for colision between the falling piece and the blocks in the playing area
int colision_check(){
  400838:	ff010113          	addi	sp,sp,-16
  40083c:	00112623          	sw	ra,12(sp)
  400840:	00812423          	sw	s0,8(sp)
  400844:	00912223          	sw	s1,4(sp)
    int ret_val;
    mv_piece_d(); // move piece down to check for future colisions
  400848:	ec1ff0ef          	jal	ra,400708 <mv_piece_d>
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  40084c:	100007b7          	lui	a5,0x10000
  400850:	0ec7a783          	lw	a5,236(a5) # 100000ec <piece_row>
  400854:	00279793          	slli	a5,a5,0x2
  400858:	100006b7          	lui	a3,0x10000
  40085c:	0d868493          	addi	s1,a3,216 # 100000d8 <result>
  400860:	0d868693          	addi	a3,a3,216
  400864:	10000637          	lui	a2,0x10000
  400868:	07460613          	addi	a2,a2,116 # 10000074 <play_area>
  40086c:	00f60633          	add	a2,a2,a5
  400870:	100005b7          	lui	a1,0x10000
  400874:	01058593          	addi	a1,a1,16 # 10000010 <piece_mask>
  400878:	00f585b3          	add	a1,a1,a5
  40087c:	00400513          	li	a0,4
  400880:	d1dff0ef          	jal	ra,40059c <bit_and_matrix>
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
  400884:	0004a403          	lw	s0,0(s1)
  400888:	0044a783          	lw	a5,4(s1)
  40088c:	00f46433          	or	s0,s0,a5
  400890:	0084a783          	lw	a5,8(s1)
  400894:	00f46433          	or	s0,s0,a5
  400898:	00c4a783          	lw	a5,12(s1)
  40089c:	00f46433          	or	s0,s0,a5
    }
    mv_piece_u(); // move piece up to its original position
  4008a0:	ea9ff0ef          	jal	ra,400748 <mv_piece_u>
    return ret_val;
}
  4008a4:	00040513          	mv	a0,s0
  4008a8:	00c12083          	lw	ra,12(sp)
  4008ac:	00812403          	lw	s0,8(sp)
  4008b0:	00412483          	lw	s1,4(sp)
  4008b4:	01010113          	addi	sp,sp,16
  4008b8:	00008067          	ret

004008bc <colision_check_wall>:

int colision_check_wall(){
  4008bc:	ff010113          	addi	sp,sp,-16
  4008c0:	00112623          	sw	ra,12(sp)
  4008c4:	00812423          	sw	s0,8(sp)
    int ret_val;
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  4008c8:	100007b7          	lui	a5,0x10000
  4008cc:	0ec7a783          	lw	a5,236(a5) # 100000ec <piece_row>
  4008d0:	00279793          	slli	a5,a5,0x2
  4008d4:	100006b7          	lui	a3,0x10000
  4008d8:	0d868413          	addi	s0,a3,216 # 100000d8 <result>
  4008dc:	0d868693          	addi	a3,a3,216
  4008e0:	10000637          	lui	a2,0x10000
  4008e4:	07460613          	addi	a2,a2,116 # 10000074 <play_area>
  4008e8:	00f60633          	add	a2,a2,a5
  4008ec:	100005b7          	lui	a1,0x10000
  4008f0:	01058593          	addi	a1,a1,16 # 10000010 <piece_mask>
  4008f4:	00f585b3          	add	a1,a1,a5
  4008f8:	00400513          	li	a0,4
  4008fc:	ca1ff0ef          	jal	ra,40059c <bit_and_matrix>
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
  400900:	00042783          	lw	a5,0(s0)
  400904:	00442503          	lw	a0,4(s0)
  400908:	00a7e7b3          	or	a5,a5,a0
  40090c:	00842503          	lw	a0,8(s0)
  400910:	00a7e7b3          	or	a5,a5,a0
  400914:	00c42503          	lw	a0,12(s0)
    }
    return ret_val;
}
  400918:	00a7e533          	or	a0,a5,a0
  40091c:	00c12083          	lw	ra,12(sp)
  400920:	00812403          	lw	s0,8(sp)
  400924:	01010113          	addi	sp,sp,16
  400928:	00008067          	ret

0040092c <consolidate_rows>:

int consolidate_rows(){
  40092c:	ff010113          	addi	sp,sp,-16
  400930:	00112623          	sw	ra,12(sp)
    // add each of the 4 rows where the piece is to the play area
    bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
  400934:	100007b7          	lui	a5,0x10000
  400938:	0ec7a783          	lw	a5,236(a5) # 100000ec <piece_row>
  40093c:	00279793          	slli	a5,a5,0x2
  400940:	10000637          	lui	a2,0x10000
  400944:	07460613          	addi	a2,a2,116 # 10000074 <play_area>
  400948:	00c78633          	add	a2,a5,a2
  40094c:	00060693          	mv	a3,a2
  400950:	100005b7          	lui	a1,0x10000
  400954:	01058593          	addi	a1,a1,16 # 10000010 <piece_mask>
  400958:	00f585b3          	add	a1,a1,a5
  40095c:	00400513          	li	a0,4
  400960:	c09ff0ef          	jal	ra,400568 <bit_or_matrix>
}
  400964:	00c12083          	lw	ra,12(sp)
  400968:	01010113          	addi	sp,sp,16
  40096c:	00008067          	ret

00400970 <clear_rows>:



int clear_rows(){
    int points = 0;
    for (int i = piece_row; i < HEIGHT-1; i++){ // check each of the 4 rows where the piece is
  400970:	100007b7          	lui	a5,0x10000
  400974:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  400978:	01700793          	li	a5,23
  40097c:	08d7c063          	blt	a5,a3,4009fc <clear_rows+0x8c>
  400980:	00269713          	slli	a4,a3,0x2
  400984:	100007b7          	lui	a5,0x10000
  400988:	07478793          	addi	a5,a5,116 # 10000074 <play_area>
  40098c:	00f70733          	add	a4,a4,a5
    int points = 0;
  400990:	00000513          	li	a0,0
        if (play_area[i] == 4095){ // 4095 = column of all 1s
  400994:	000017b7          	lui	a5,0x1
  400998:	fff78893          	addi	a7,a5,-1 # fff <_start-0x3ff001>
			if (!points){points = 1;}
            points = points*2;
            // this will break when the piece is off screen @@@@@@@@@@@@@
            for (int j = i; j > 4; j--){
  40099c:	00400e93          	li	t4,4
                play_area[j] = play_area[j-1];
            }
            play_area[4] = 0b100000000001;
  4009a0:	10000337          	lui	t1,0x10000
  4009a4:	07430313          	addi	t1,t1,116 # 10000074 <play_area>
  4009a8:	80178e13          	addi	t3,a5,-2047
  4009ac:	01030593          	addi	a1,t1,16
    for (int i = piece_row; i < HEIGHT-1; i++){ // check each of the 4 rows where the piece is
  4009b0:	01800813          	li	a6,24
  4009b4:	0300006f          	j	4009e4 <clear_rows+0x74>
            points = points*2;
  4009b8:	00151513          	slli	a0,a0,0x1
            for (int j = i; j > 4; j--){
  4009bc:	00dedc63          	bge	t4,a3,4009d4 <clear_rows+0x64>
  4009c0:	00070793          	mv	a5,a4
                play_area[j] = play_area[j-1];
  4009c4:	ffc7a603          	lw	a2,-4(a5)
  4009c8:	00c7a023          	sw	a2,0(a5)
            for (int j = i; j > 4; j--){
  4009cc:	ffc78793          	addi	a5,a5,-4
  4009d0:	feb79ae3          	bne	a5,a1,4009c4 <clear_rows+0x54>
            play_area[4] = 0b100000000001;
  4009d4:	01c32823          	sw	t3,16(t1)
    for (int i = piece_row; i < HEIGHT-1; i++){ // check each of the 4 rows where the piece is
  4009d8:	00168693          	addi	a3,a3,1
  4009dc:	00470713          	addi	a4,a4,4
  4009e0:	01068c63          	beq	a3,a6,4009f8 <clear_rows+0x88>
        if (play_area[i] == 4095){ // 4095 = column of all 1s
  4009e4:	00072783          	lw	a5,0(a4)
  4009e8:	ff1798e3          	bne	a5,a7,4009d8 <clear_rows+0x68>
			if (!points){points = 1;}
  4009ec:	fc0516e3          	bnez	a0,4009b8 <clear_rows+0x48>
  4009f0:	00100513          	li	a0,1
  4009f4:	fc5ff06f          	j	4009b8 <clear_rows+0x48>
  4009f8:	00008067          	ret
    int points = 0;
  4009fc:	00000513          	li	a0,0
        }
    }
    return points;
}
  400a00:	00008067          	ret

00400a04 <tetris_god_senpai>:
void tetris_god_senpai(){
  400a04:	ff010113          	addi	sp,sp,-16
  400a08:	00112623          	sw	ra,12(sp)
    piece_row = 4;
  400a0c:	100007b7          	lui	a5,0x10000
  400a10:	00400713          	li	a4,4
  400a14:	0ee7a623          	sw	a4,236(a5) # 100000ec <piece_row>
    piece_col = 5;
  400a18:	100007b7          	lui	a5,0x10000
  400a1c:	00500713          	li	a4,5
  400a20:	0ee7a423          	sw	a4,232(a5) # 100000e8 <piece_col>
    piece_index = (random())%TETRIS-1;
  400a24:	96dff0ef          	jal	ra,400390 <random>
  400a28:	01c00793          	li	a5,28
  400a2c:	02f56533          	rem	a0,a0,a5
  400a30:	fff50513          	addi	a0,a0,-1 # fffffff <rotational_vector+0xfbff393>
  400a34:	100007b7          	lui	a5,0x10000
  400a38:	0ea7a823          	sw	a0,240(a5) # 100000f0 <piece_index>
    change_piece();
  400a3c:	ad1ff0ef          	jal	ra,40050c <change_piece>
    reset_mask();
  400a40:	9b5ff0ef          	jal	ra,4003f4 <reset_mask>
    apply_mask();
  400a44:	969ff0ef          	jal	ra,4003ac <apply_mask>
    if(colision_check_wall()){
  400a48:	e75ff0ef          	jal	ra,4008bc <colision_check_wall>
  400a4c:	00050863          	beqz	a0,400a5c <tetris_god_senpai+0x58>
        end_game = 1;
  400a50:	100007b7          	lui	a5,0x10000
  400a54:	00100713          	li	a4,1
  400a58:	0ee7aa23          	sw	a4,244(a5) # 100000f4 <end_game>
    }
}
  400a5c:	00c12083          	lw	ra,12(sp)
  400a60:	01010113          	addi	sp,sp,16
  400a64:	00008067          	ret

00400a68 <pollLeftFlag>:
#include "buttons.h"

inline int pollLeftFlag() { return *((volatile int *)0xffff0044); }
  400a68:	ffff07b7          	lui	a5,0xffff0
  400a6c:	0447a503          	lw	a0,68(a5) # ffff0044 <__stack_init+0xeffe0048>
  400a70:	00008067          	ret

00400a74 <pollRightFlag>:
inline int pollRightFlag() { return *((volatile int *)0xffff0048); }
  400a74:	ffff07b7          	lui	a5,0xffff0
  400a78:	0487a503          	lw	a0,72(a5) # ffff0048 <__stack_init+0xeffe004c>
  400a7c:	00008067          	ret

00400a80 <pollRotFlag>:
inline int pollRotFlag() { return *((volatile int *)0xffff004c); }
  400a80:	ffff07b7          	lui	a5,0xffff0
  400a84:	04c7a503          	lw	a0,76(a5) # ffff004c <__stack_init+0xeffe0050>
  400a88:	00008067          	ret

00400a8c <lowerFlags>:
inline void lowerFlags() { *((volatile int *)0xffff0050) = 1; }
  400a8c:	ffff07b7          	lui	a5,0xffff0
  400a90:	00100713          	li	a4,1
  400a94:	04e7a823          	sw	a4,80(a5) # ffff0050 <__stack_init+0xeffe0054>
  400a98:	00008067          	ret
