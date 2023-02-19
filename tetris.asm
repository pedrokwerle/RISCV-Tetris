
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
#include "shapes.h"
#include "physics.h"
#include "random.h"
#include "matrix.h"

int main(){
  40001c:	fd010113          	addi	sp,sp,-48
  400020:	02112623          	sw	ra,44(sp)
  400024:	02812423          	sw	s0,40(sp)
  400028:	02912223          	sw	s1,36(sp)
  40002c:	03212023          	sw	s2,32(sp)
  400030:	01312e23          	sw	s3,28(sp)
  400034:	01412c23          	sw	s4,24(sp)
  400038:	01512a23          	sw	s5,20(sp)
  40003c:	01612823          	sw	s6,16(sp)
  400040:	01712623          	sw	s7,12(sp)
  400044:	01812423          	sw	s8,8(sp)
    initialize();
  400048:	35c000ef          	jal	ra,4003a4 <initialize>
    int points = 0;
    for (int j = 0; j < HEIGHT; j++){
  40004c:	100004b7          	lui	s1,0x10000
  400050:	07448c13          	addi	s8,s1,116 # 10000074 <play_area>
    initialize();
  400054:	07448493          	addi	s1,s1,116
    for (int j = 0; j < HEIGHT; j++){
  400058:	00000413          	li	s0,0
  40005c:	01900913          	li	s2,25
        paint_row(play_area[j], j);
  400060:	00040593          	mv	a1,s0
  400064:	0004a503          	lw	a0,0(s1)
  400068:	444000ef          	jal	ra,4004ac <paint_row>
    for (int j = 0; j < HEIGHT; j++){
  40006c:	00140413          	addi	s0,s0,1
  400070:	00448493          	addi	s1,s1,4
  400074:	ff2416e3          	bne	s0,s2,400060 <main+0x44>
    }
    while(1){
        int colision = 0;
        while (colision < 1){
            mv_piece_d();
            for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  400078:	100009b7          	lui	s3,0x10000
  40007c:	40000bb7          	lui	s7,0x40000
  400080:	fffb8b93          	addi	s7,s7,-1 # 3fffffff <__stack_init+0x2fff0003>
  400084:	10000b37          	lui	s6,0x10000
  400088:	010b0b13          	addi	s6,s6,16 # 10000010 <piece_mask>
  40008c:	10000ab7          	lui	s5,0x10000
  400090:	074a8a93          	addi	s5,s5,116 # 10000074 <play_area>
            colision = colision_check();
        }
        consolidate_rows();
        points = clear_rows();

        for (int j = 0; j < HEIGHT-1; j++){
  400094:	01800a13          	li	s4,24
  400098:	0300006f          	j	4000c8 <main+0xac>
        consolidate_rows();
  40009c:	660000ef          	jal	ra,4006fc <consolidate_rows>
        points = clear_rows();
  4000a0:	6a0000ef          	jal	ra,400740 <clear_rows>
  4000a4:	000c0493          	mv	s1,s8
        for (int j = 0; j < HEIGHT-1; j++){
  4000a8:	00000413          	li	s0,0
            paint_row(play_area[j], j);
  4000ac:	00040593          	mv	a1,s0
  4000b0:	0004a503          	lw	a0,0(s1)
  4000b4:	3f8000ef          	jal	ra,4004ac <paint_row>
        for (int j = 0; j < HEIGHT-1; j++){
  4000b8:	00140413          	addi	s0,s0,1
  4000bc:	00448493          	addi	s1,s1,4
  4000c0:	ff4416e3          	bne	s0,s4,4000ac <main+0x90>
        }
        tetris_god_senpai();
  4000c4:	6e8000ef          	jal	ra,4007ac <tetris_god_senpai>
            mv_piece_d();
  4000c8:	4f0000ef          	jal	ra,4005b8 <mv_piece_d>
            for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  4000cc:	0ec9a483          	lw	s1,236(s3) # 100000ec <piece_row>
  4000d0:	fff48413          	addi	s0,s1,-1
  4000d4:	017484b3          	add	s1,s1,s7
  4000d8:	00249493          	slli	s1,s1,0x2
  4000dc:	01648933          	add	s2,s1,s6
  4000e0:	015484b3          	add	s1,s1,s5
                paint_row(piece_mask[j] | play_area[j], j);
  4000e4:	00092503          	lw	a0,0(s2)
  4000e8:	0004a783          	lw	a5,0(s1)
  4000ec:	00040593          	mv	a1,s0
  4000f0:	00f56533          	or	a0,a0,a5
  4000f4:	3b8000ef          	jal	ra,4004ac <paint_row>
            for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  4000f8:	00140413          	addi	s0,s0,1
  4000fc:	00490913          	addi	s2,s2,4
  400100:	00448493          	addi	s1,s1,4
  400104:	0ec9a783          	lw	a5,236(s3)
  400108:	00378793          	addi	a5,a5,3
  40010c:	fc87dce3          	bge	a5,s0,4000e4 <main+0xc8>
            colision = colision_check();
  400110:	568000ef          	jal	ra,400678 <colision_check>
        while (colision < 1){
  400114:	faa05ae3          	blez	a0,4000c8 <main+0xac>
  400118:	f85ff06f          	j	40009c <main+0x80>

0040011c <abs>:
 */

#include "lib.h"

// returns absolute value of its integer argument - a replacement of the standard library function abs() 
inline int abs(int n) { return (n < 0) ? (-n) : n; }
  40011c:	41f55793          	srai	a5,a0,0x1f
  400120:	00a7c533          	xor	a0,a5,a0
  400124:	40f50533          	sub	a0,a0,a5
  400128:	00008067          	ret

0040012c <printchar>:

// prints single character to console - a substitute for the standard library funciton putch(int chr)
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  40012c:	ffff07b7          	lui	a5,0xffff0
  400130:	00a7a623          	sw	a0,12(a5) # ffff000c <__stack_init+0xeffe0010>
  400134:	00008067          	ret

00400138 <println>:
  400138:	ffff07b7          	lui	a5,0xffff0
  40013c:	00a00713          	li	a4,10
  400140:	00e7a623          	sw	a4,12(a5) # ffff000c <__stack_init+0xeffe0010>

// prints newline character to console
void println() { printchar('\n'); }
  400144:	00008067          	ret

00400148 <printstr>:

// prints given string of characters to console - a substitute for the standard library function puts(char *s)
void printstr(char *str)
{
    while (*str != '\0') 
  400148:	00054783          	lbu	a5,0(a0)
  40014c:	00078c63          	beqz	a5,400164 <printstr+0x1c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400150:	ffff0737          	lui	a4,0xffff0
  400154:	00f72623          	sw	a5,12(a4) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(*str);
        str += 1;
  400158:	00150513          	addi	a0,a0,1
    while (*str != '\0') 
  40015c:	00054783          	lbu	a5,0(a0)
  400160:	fe079ae3          	bnez	a5,400154 <printstr+0xc>
    }
}
  400164:	00008067          	ret

00400168 <printint>:

// prints given integer as a signed decimal number
void printint(int n)
{
  400168:	ff010113          	addi	sp,sp,-16
    {
        sign = '-';
    }
    else
    {
        sign = '\0';
  40016c:	41f55813          	srai	a6,a0,0x1f
  400170:	02d87813          	andi	a6,a6,45
  400174:	00410713          	addi	a4,sp,4
  400178:	00900613          	li	a2,9
    
    // produce decimal digits of the number going from right to left, keep them in num[] array.
    do 
    {
        i = i - 1;
        num[i] = abs(n % 10) + '0';
  40017c:	00a00593          	li	a1,10
        i = i - 1;
  400180:	fff60613          	addi	a2,a2,-1
        num[i] = abs(n % 10) + '0';
  400184:	02b567b3          	rem	a5,a0,a1
  400188:	41f7d693          	srai	a3,a5,0x1f
  40018c:	00f6c7b3          	xor	a5,a3,a5
  400190:	40d787b3          	sub	a5,a5,a3
  400194:	03078793          	addi	a5,a5,48
  400198:	00f70423          	sb	a5,8(a4)
        n = n / 10;
  40019c:	02b54533          	div	a0,a0,a1
    } while (n != 0);
  4001a0:	fff70713          	addi	a4,a4,-1
  4001a4:	fc051ee3          	bnez	a0,400180 <printint+0x18>
    
    //now print the sign of the number and its digits left-to-right.
    if (sign) 
  4001a8:	00080663          	beqz	a6,4001b4 <printint+0x4c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  4001ac:	ffff07b7          	lui	a5,0xffff0
  4001b0:	0107a623          	sw	a6,12(a5) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(sign);
    }
    
    while(i < MAX_INT_DIGITS)
  4001b4:	00900793          	li	a5,9
  4001b8:	02c7c263          	blt	a5,a2,4001dc <printint+0x74>
  4001bc:	00410793          	addi	a5,sp,4
  4001c0:	00c787b3          	add	a5,a5,a2
  4001c4:	00e10693          	addi	a3,sp,14
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  4001c8:	ffff0637          	lui	a2,0xffff0
  4001cc:	0007c703          	lbu	a4,0(a5)
  4001d0:	00e62623          	sw	a4,12(a2) # ffff000c <__stack_init+0xeffe0010>
    while(i < MAX_INT_DIGITS)
  4001d4:	00178793          	addi	a5,a5,1
  4001d8:	fed79ae3          	bne	a5,a3,4001cc <printint+0x64>
    {
        printchar(num[i]);
        i=i+1;
    }
}
  4001dc:	01010113          	addi	sp,sp,16
  4001e0:	00008067          	ret

004001e4 <pollkbd>:


// check if keyboard buffer has some data
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  4001e4:	ffff07b7          	lui	a5,0xffff0
  4001e8:	0007a503          	lw	a0,0(a5) # ffff0000 <__stack_init+0xeffe0004>
  4001ec:	00008067          	ret

004001f0 <readchar>:

// read next character from keyboard buffer
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  4001f0:	ffff07b7          	lui	a5,0xffff0
  4001f4:	0047a503          	lw	a0,4(a5) # ffff0004 <__stack_init+0xeffe0008>
  4001f8:	00008067          	ret

004001fc <readstr>:

// read characters into provided buffer until either user presses enter or the buffer size is reached.
int readstr(char *buf, int size)
{
  4001fc:	00050693          	mv	a3,a0
    int count;
    
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  400200:	00100793          	li	a5,1
  400204:	04b7d263          	bge	a5,a1,400248 <readstr+0x4c>
  400208:	fff58613          	addi	a2,a1,-1
    
    count = 0;
  40020c:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400210:	ffff0737          	lui	a4,0xffff0
       
       // read next character into the current element of the buffer
       *buf = (char)readchar();
       
       // if the user pressed Enter, stop reading
       if (*buf == '\n') 
  400214:	00a00593          	li	a1,10
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400218:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  40021c:	fe078ee3          	beqz	a5,400218 <readstr+0x1c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  400220:	00472783          	lw	a5,4(a4)
       *buf = (char)readchar();
  400224:	0ff7f793          	andi	a5,a5,255
  400228:	00f68023          	sb	a5,0(a3)
       if (*buf == '\n') 
  40022c:	00b78a63          	beq	a5,a1,400240 <readstr+0x44>
       {
           break;
       }
       
       // move pointer to the next element of the buffer
       buf += 1;
  400230:	00168693          	addi	a3,a3,1
       
       // increase the number of characters in the buffer
       count += 1;
  400234:	00150513          	addi	a0,a0,1
       
       // decrease the remaining space in the buffer
       size -= 1;
       
    } while(size > 1);  // keep going until one empty char remains (to hold the final '\0' character
  400238:	fec510e3          	bne	a0,a2,400218 <readstr+0x1c>
       count += 1;
  40023c:	00060513          	mv	a0,a2
    
    *buf = '\0';  // add the end-of-string marker '\0'
  400240:	00068023          	sb	zero,0(a3)
    
    return count; // return the number of characters in the read string
  400244:	00008067          	ret
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  400248:	fff00513          	li	a0,-1
}
  40024c:	00008067          	ret

00400250 <readint>:

//read signed integer
int readint()
{
    int res = 0;
    int sign = 1;
  400250:	00100593          	li	a1,1
    int res = 0;
  400254:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400258:	ffff0737          	lui	a4,0xffff0
           sign = -1;
       }
       else
       {
           // otherwise, if a non-digit is read, it signifies the end of the number
           if (chr < '0' || chr > '9') 
  40025c:	00900613          	li	a2,9
       if (res == 0 && sign == 1 && chr == '-') 
  400260:	00100813          	li	a6,1
  400264:	02d00893          	li	a7,45
           sign = -1;
  400268:	fff00313          	li	t1,-1
  40026c:	0200006f          	j	40028c <readint+0x3c>
           if (chr < '0' || chr > '9') 
  400270:	fd068793          	addi	a5,a3,-48
  400274:	02f66c63          	bltu	a2,a5,4002ac <readint+0x5c>
           {
               break;
           }
           // incorporate the read digit into the number (N.B. chr - '0' gived the digit value).
           res = res * 10 + (chr - '0');
  400278:	00251793          	slli	a5,a0,0x2
  40027c:	00a787b3          	add	a5,a5,a0
  400280:	00179793          	slli	a5,a5,0x1
  400284:	fd068693          	addi	a3,a3,-48
  400288:	00f68533          	add	a0,a3,a5
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  40028c:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  400290:	fe078ee3          	beqz	a5,40028c <readint+0x3c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  400294:	00472683          	lw	a3,4(a4)
       if (res == 0 && sign == 1 && chr == '-') 
  400298:	fc051ce3          	bnez	a0,400270 <readint+0x20>
  40029c:	fd059ae3          	bne	a1,a6,400270 <readint+0x20>
  4002a0:	fd1698e3          	bne	a3,a7,400270 <readint+0x20>
           sign = -1;
  4002a4:	00030593          	mv	a1,t1
  4002a8:	fe5ff06f          	j	40028c <readint+0x3c>
       }
    }
    
    // return the absolute value of the number (constructed from entered digits) multiplied by the sign.
    return sign * res;
}
  4002ac:	02b50533          	mul	a0,a0,a1
  4002b0:	00008067          	ret

004002b4 <showpic>:
    # as long as this function is not calling other functions.
    
    .globl showpic
    
showpic:
    li t0,0xffff8000    # starting address of the graphics display
  4002b4:	ffff82b7          	lui	t0,0xffff8
    li t1,32            # number of lines on the display (each word encodes one line) 
  4002b8:	02000313          	li	t1,32

004002bc <loop>:
loop:
    lw t2,0(a0)         # load next line (word) of the picture data
  4002bc:	00052383          	lw	t2,0(a0)
    sw t2,0(t0)         # write it to the corresponding line of the graphics display
  4002c0:	0072a023          	sw	t2,0(t0) # ffff8000 <__stack_init+0xeffe8004>
    addi t0,t0,4        # move to the next line of the graphics display
  4002c4:	00428293          	addi	t0,t0,4
    addi a0,a0,4        # move to the next line of the picture data
  4002c8:	00450513          	addi	a0,a0,4
    addi t1,t1,-1       # reduce the number of remaining lines
  4002cc:	fff30313          	addi	t1,t1,-1
    bnez t1,loop        # keep going until all lines on the display are filled with data
  4002d0:	fe0316e3          	bnez	t1,4002bc <loop>
    jr ra               # return 
  4002d4:	00008067          	ret

004002d8 <initseed>:
   	# the seed should only be set once at the start of the program
   	# otherwise you can accidentally always get the same number
	.global initseed

initseed:
	la t0, seed		# load address of seed to t0
  4002d8:	00000297          	auipc	t0,0x0
  4002dc:	52428293          	addi	t0,t0,1316 # 4007fc <seed>
	li t5, 0x1234		# write-enable signal value
  4002e0:	00001f37          	lui	t5,0x1
  4002e4:	234f0f13          	addi	t5,t5,564 # 1234 <_start-0x3fedcc>
	sw t5, 0(t0)		# enable writing to seed location
  4002e8:	01e2a023          	sw	t5,0(t0)
	sw a0, 0(t0)		# load input seed to memory	
  4002ec:	00a2a023          	sw	a0,0(t0)
	jr ra
  4002f0:	00008067          	ret

004002f4 <random>:
	
	.global random
	
random:
	la t0, seed		# load address of seed to t0
  4002f4:	00000297          	auipc	t0,0x0
  4002f8:	50828293          	addi	t0,t0,1288 # 4007fc <seed>
	lw t1, 0(t0)		# load seed to t1
  4002fc:	0002a303          	lw	t1,0(t0)
	mv t1, sp		
  400300:	00010313          	mv	t1,sp

00400304 <roll>:
	
roll:
	slli t2, t1, 1		# shift seed to the left and store in t2
  400304:	00131393          	slli	t2,t1,0x1
	xor t1, t2, t1		# xor bits in t1 and t2 for a pseudo random number
  400308:	0063c333          	xor	t1,t2,t1
	andi a0, t1, 0x700	# extract 3 bit random number from t1 using mask 0000011100000000
  40030c:	70037513          	andi	a0,t1,1792
	srli a0, a0, 8		# shift bits in t4 to the right so they are the least significant digits
  400310:	00855513          	srli	a0,a0,0x8
	beqz a0, roll		# reroll if equal to 0 
  400314:	fe0508e3          	beqz	a0,400304 <roll>
	sw t1, 0(t0)		# set new seed with value of t1
  400318:	0062a023          	sw	t1,0(t0)
	jr ra 			# return
  40031c:	00008067          	ret

00400320 <apply_mask>:

// copy the contents of the current_piecem to the position in the mask indicated by piece_row and piece_col
void apply_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = current_piecem[i-piece_row]; // mask row equal current piece row
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400320:	100007b7          	lui	a5,0x10000
  400324:	0e87a783          	lw	a5,232(a5) # 100000e8 <piece_col>
  400328:	00800593          	li	a1,8
  40032c:	40f585b3          	sub	a1,a1,a5
  400330:	100007b7          	lui	a5,0x10000
  400334:	00078793          	mv	a5,a5
  400338:	01078613          	addi	a2,a5,16 # 10000010 <piece_mask>
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40033c:	10000737          	lui	a4,0x10000
  400340:	0ec72703          	lw	a4,236(a4) # 100000ec <piece_row>
  400344:	00271713          	slli	a4,a4,0x2
  400348:	00e60733          	add	a4,a2,a4
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  40034c:	0007a683          	lw	a3,0(a5)
  400350:	00b696b3          	sll	a3,a3,a1
  400354:	00d72023          	sw	a3,0(a4)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400358:	00478793          	addi	a5,a5,4
  40035c:	00470713          	addi	a4,a4,4
  400360:	fec796e3          	bne	a5,a2,40034c <apply_mask+0x2c>
    }
}
  400364:	00008067          	ret

00400368 <reset_mask>:

void reset_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400368:	100007b7          	lui	a5,0x10000
  40036c:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  400370:	00269693          	slli	a3,a3,0x2
  400374:	10000737          	lui	a4,0x10000
  400378:	00070713          	mv	a4,a4
  40037c:	01070793          	addi	a5,a4,16 # 10000010 <piece_mask>
  400380:	00d787b3          	add	a5,a5,a3
  400384:	02070713          	addi	a4,a4,32
  400388:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 12;
  40038c:	0007a703          	lw	a4,0(a5)
  400390:	40c75713          	srai	a4,a4,0xc
  400394:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400398:	00478793          	addi	a5,a5,4
  40039c:	fed798e3          	bne	a5,a3,40038c <reset_mask+0x24>
    }
}
  4003a0:	00008067          	ret

004003a4 <initialize>:

void initialize(){
  4003a4:	ff010113          	addi	sp,sp,-16
  4003a8:	00112623          	sw	ra,12(sp)
    piece_index = 0;
  4003ac:	100007b7          	lui	a5,0x10000
  4003b0:	0e07a823          	sw	zero,240(a5) # 100000f0 <piece_index>
    piece_row = 16;
  4003b4:	100007b7          	lui	a5,0x10000
  4003b8:	01000713          	li	a4,16
  4003bc:	0ee7a623          	sw	a4,236(a5) # 100000ec <piece_row>
    piece_col = 6;
  4003c0:	100007b7          	lui	a5,0x10000
  4003c4:	00600713          	li	a4,6
  4003c8:	0ee7a423          	sw	a4,232(a5) # 100000e8 <piece_col>
    // set the play area to its initial state
    play_area[0] = 0b111111111111;
  4003cc:	10000737          	lui	a4,0x10000
  4003d0:	00070713          	mv	a4,a4
  4003d4:	000017b7          	lui	a5,0x1
  4003d8:	fff78793          	addi	a5,a5,-1 # fff <_start-0x3ff001>
  4003dc:	06f72a23          	sw	a5,116(a4) # 10000074 <play_area>
    play_area[1] = 0b111111111111;
  4003e0:	06f72c23          	sw	a5,120(a4)
    play_area[2] = 0b111111111111;
  4003e4:	06f72e23          	sw	a5,124(a4)
    play_area[3] = 0b111111111111;
  4003e8:	08f72023          	sw	a5,128(a4)
    for (int i = 4; i < HEIGHT-1; i++){
  4003ec:	08470793          	addi	a5,a4,132
  4003f0:	0d470713          	addi	a4,a4,212
        play_area[i] = 0b100000000001;
  4003f4:	000016b7          	lui	a3,0x1
  4003f8:	80168693          	addi	a3,a3,-2047 # 801 <_start-0x3ff7ff>
  4003fc:	00d7a023          	sw	a3,0(a5)
    for (int i = 4; i < HEIGHT-1; i++){
  400400:	00478793          	addi	a5,a5,4
  400404:	fee79ce3          	bne	a5,a4,4003fc <initialize+0x58>
    }
    play_area[HEIGHT-4] = 0b111111100111;
  400408:	100007b7          	lui	a5,0x10000
  40040c:	00078793          	mv	a5,a5
  400410:	00001737          	lui	a4,0x1
  400414:	fe770693          	addi	a3,a4,-25 # fe7 <_start-0x3ff019>
  400418:	0cd7a423          	sw	a3,200(a5) # 100000c8 <play_area+0x54>
    play_area[HEIGHT-3] = 0b111111110111;
  40041c:	ff770613          	addi	a2,a4,-9
  400420:	0cc7a623          	sw	a2,204(a5)
    play_area[HEIGHT-2] = 0b111111100111;
  400424:	0cd7a823          	sw	a3,208(a5)
    play_area[HEIGHT-1] = 0b111111111111;
  400428:	fff70713          	addi	a4,a4,-1
  40042c:	0ce7aa23          	sw	a4,212(a5)
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
  400430:	00401737          	lui	a4,0x401
  400434:	80070713          	addi	a4,a4,-2048 # 400800 <pieces>
  400438:	00072683          	lw	a3,0(a4)
  40043c:	00d7a023          	sw	a3,0(a5)
  400440:	00472683          	lw	a3,4(a4)
  400444:	00d7a223          	sw	a3,4(a5)
  400448:	00872683          	lw	a3,8(a4)
  40044c:	00d7a423          	sw	a3,8(a5)
  400450:	00c72703          	lw	a4,12(a4)
  400454:	00e7a623          	sw	a4,12(a5)
    }
    apply_mask();
  400458:	ec9ff0ef          	jal	ra,400320 <apply_mask>
}
  40045c:	00c12083          	lw	ra,12(sp)
  400460:	01010113          	addi	sp,sp,16
  400464:	00008067          	ret

00400468 <change_piece>:

void change_piece(){
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
  400468:	100007b7          	lui	a5,0x10000
  40046c:	0f07a783          	lw	a5,240(a5) # 100000f0 <piece_index>
  400470:	10000737          	lui	a4,0x10000
  400474:	00070713          	mv	a4,a4
  400478:	00479693          	slli	a3,a5,0x4
  40047c:	004017b7          	lui	a5,0x401
  400480:	80078793          	addi	a5,a5,-2048 # 400800 <pieces>
  400484:	00d787b3          	add	a5,a5,a3
  400488:	0007a683          	lw	a3,0(a5)
  40048c:	00d72023          	sw	a3,0(a4) # 10000000 <current_piecem>
  400490:	0047a683          	lw	a3,4(a5)
  400494:	00d72223          	sw	a3,4(a4)
  400498:	0087a683          	lw	a3,8(a5)
  40049c:	00d72423          	sw	a3,8(a4)
  4004a0:	00c7a783          	lw	a5,12(a5)
  4004a4:	00f72623          	sw	a5,12(a4)
    }
}
  4004a8:	00008067          	ret

004004ac <paint_row>:
#include "display.h"
#include "shapes.h"

void paint_row(int row, int row_num){
        *((volatile int *)(0xffff8000 + row_num*4)) = row;
  4004ac:	00259593          	slli	a1,a1,0x2
  4004b0:	ffff87b7          	lui	a5,0xffff8
  4004b4:	00f585b3          	add	a1,a1,a5
  4004b8:	00a5a023          	sw	a0,0(a1)
}
  4004bc:	00008067          	ret

004004c0 <bit_or_matrix>:
#include "matrix.h"
#include "lib.h"
#include "shapes.h"

void bit_or_matrix(int size, int matrix1[size], int matrix2[size], int result[size]){
    for (int i = 0; i < size; i++) {
  4004c0:	02a05863          	blez	a0,4004f0 <bit_or_matrix+0x30>
  4004c4:	00058793          	mv	a5,a1
  4004c8:	00251513          	slli	a0,a0,0x2
  4004cc:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] | matrix2[i];
  4004d0:	0007a703          	lw	a4,0(a5) # ffff8000 <__stack_init+0xeffe8004>
  4004d4:	00062583          	lw	a1,0(a2)
  4004d8:	00b76733          	or	a4,a4,a1
  4004dc:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  4004e0:	00478793          	addi	a5,a5,4
  4004e4:	00460613          	addi	a2,a2,4
  4004e8:	00468693          	addi	a3,a3,4
  4004ec:	fea792e3          	bne	a5,a0,4004d0 <bit_or_matrix+0x10>
    }
}
  4004f0:	00008067          	ret

004004f4 <bit_and_matrix>:

void bit_and_matrix(int size, int matrix1[size], int matrix2[size], int result[size]){
    for (int i = 0; i < size; i++) {
  4004f4:	02a05863          	blez	a0,400524 <bit_and_matrix+0x30>
  4004f8:	00058793          	mv	a5,a1
  4004fc:	00251513          	slli	a0,a0,0x2
  400500:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] & matrix2[i];
  400504:	0007a703          	lw	a4,0(a5)
  400508:	00062583          	lw	a1,0(a2)
  40050c:	00b77733          	and	a4,a4,a1
  400510:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  400514:	00478793          	addi	a5,a5,4
  400518:	00460613          	addi	a2,a2,4
  40051c:	00468693          	addi	a3,a3,4
  400520:	fea792e3          	bne	a5,a0,400504 <bit_and_matrix+0x10>
    }
}
  400524:	00008067          	ret

00400528 <mv_piece_l>:
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

void mv_piece_l(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400528:	100007b7          	lui	a5,0x10000
  40052c:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  400530:	00269693          	slli	a3,a3,0x2
  400534:	10000737          	lui	a4,0x10000
  400538:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  40053c:	00e687b3          	add	a5,a3,a4
  400540:	01070713          	addi	a4,a4,16
  400544:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] << 1;
  400548:	0007a703          	lw	a4,0(a5)
  40054c:	00171713          	slli	a4,a4,0x1
  400550:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400554:	00478793          	addi	a5,a5,4
  400558:	fed798e3          	bne	a5,a3,400548 <mv_piece_l+0x20>
    }
    piece_col -= 1;
  40055c:	10000737          	lui	a4,0x10000
  400560:	0e872783          	lw	a5,232(a4) # 100000e8 <piece_col>
  400564:	fff78793          	addi	a5,a5,-1
  400568:	0ef72423          	sw	a5,232(a4)
}
  40056c:	00008067          	ret

00400570 <mv_piece_r>:
void mv_piece_r(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400570:	100007b7          	lui	a5,0x10000
  400574:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  400578:	00269693          	slli	a3,a3,0x2
  40057c:	10000737          	lui	a4,0x10000
  400580:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  400584:	00e687b3          	add	a5,a3,a4
  400588:	01070713          	addi	a4,a4,16
  40058c:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 1;
  400590:	0007a703          	lw	a4,0(a5)
  400594:	40175713          	srai	a4,a4,0x1
  400598:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40059c:	00478793          	addi	a5,a5,4
  4005a0:	fed798e3          	bne	a5,a3,400590 <mv_piece_r+0x20>
    }
    piece_col += 1;
  4005a4:	10000737          	lui	a4,0x10000
  4005a8:	0e872783          	lw	a5,232(a4) # 100000e8 <piece_col>
  4005ac:	00178793          	addi	a5,a5,1
  4005b0:	0ef72423          	sw	a5,232(a4)
}
  4005b4:	00008067          	ret

004005b8 <mv_piece_d>:
void mv_piece_d(){
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  4005b8:	100007b7          	lui	a5,0x10000
  4005bc:	0ec7a603          	lw	a2,236(a5) # 100000ec <piece_row>
  4005c0:	00261693          	slli	a3,a2,0x2
  4005c4:	10000737          	lui	a4,0x10000
  4005c8:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  4005cc:	00e687b3          	add	a5,a3,a4
  4005d0:	fec70713          	addi	a4,a4,-20
  4005d4:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i-1];
  4005d8:	00c7a683          	lw	a3,12(a5)
  4005dc:	00d7a823          	sw	a3,16(a5)
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  4005e0:	ffc78793          	addi	a5,a5,-4
  4005e4:	fee79ae3          	bne	a5,a4,4005d8 <mv_piece_d+0x20>
    }
    piece_row += 1;
  4005e8:	00160613          	addi	a2,a2,1
  4005ec:	100007b7          	lui	a5,0x10000
  4005f0:	0ec7a623          	sw	a2,236(a5) # 100000ec <piece_row>
}
  4005f4:	00008067          	ret

004005f8 <mv_piece_u>:
void mv_piece_u(){
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  4005f8:	100007b7          	lui	a5,0x10000
  4005fc:	0ec7a703          	lw	a4,236(a5) # 100000ec <piece_row>
  400600:	fff70613          	addi	a2,a4,-1
  400604:	00271693          	slli	a3,a4,0x2
  400608:	10000737          	lui	a4,0x10000
  40060c:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  400610:	00e687b3          	add	a5,a3,a4
  400614:	01470713          	addi	a4,a4,20
  400618:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i+1];
  40061c:	0007a683          	lw	a3,0(a5)
  400620:	fed7ae23          	sw	a3,-4(a5)
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  400624:	00478793          	addi	a5,a5,4
  400628:	fee79ae3          	bne	a5,a4,40061c <mv_piece_u+0x24>
    }
    piece_row -= 1;
  40062c:	100007b7          	lui	a5,0x10000
  400630:	0ec7a623          	sw	a2,236(a5) # 100000ec <piece_row>
}
  400634:	00008067          	ret

00400638 <r_piece_cw>:
void r_piece_cw(){
  400638:	ff010113          	addi	sp,sp,-16
  40063c:	00112623          	sw	ra,12(sp)
    piece_index = rotational_vector[piece_index];
  400640:	100006b7          	lui	a3,0x10000
  400644:	0f06a783          	lw	a5,240(a3) # 100000f0 <piece_index>
  400648:	00279713          	slli	a4,a5,0x2
  40064c:	004017b7          	lui	a5,0x401
  400650:	93078793          	addi	a5,a5,-1744 # 400930 <rotational_vector>
  400654:	00e787b3          	add	a5,a5,a4
  400658:	0007a783          	lw	a5,0(a5)
  40065c:	0ef6a823          	sw	a5,240(a3)
    change_piece();
  400660:	e09ff0ef          	jal	ra,400468 <change_piece>
    reset_mask();
  400664:	d05ff0ef          	jal	ra,400368 <reset_mask>
    apply_mask();
  400668:	cb9ff0ef          	jal	ra,400320 <apply_mask>
}
  40066c:	00c12083          	lw	ra,12(sp)
  400670:	01010113          	addi	sp,sp,16
  400674:	00008067          	ret

00400678 <colision_check>:
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

// checks for colision between the falling piece and the blocks in the playing area
int colision_check(){
  400678:	ff010113          	addi	sp,sp,-16
  40067c:	00112623          	sw	ra,12(sp)
  400680:	00812423          	sw	s0,8(sp)
  400684:	00912223          	sw	s1,4(sp)
    int ret_val;
    mv_piece_d(); // move piece down to check for future colisions
  400688:	f31ff0ef          	jal	ra,4005b8 <mv_piece_d>
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  40068c:	100007b7          	lui	a5,0x10000
  400690:	0ec7a783          	lw	a5,236(a5) # 100000ec <piece_row>
  400694:	00279793          	slli	a5,a5,0x2
  400698:	100006b7          	lui	a3,0x10000
  40069c:	0d868493          	addi	s1,a3,216 # 100000d8 <result>
  4006a0:	0d868693          	addi	a3,a3,216
  4006a4:	10000637          	lui	a2,0x10000
  4006a8:	07460613          	addi	a2,a2,116 # 10000074 <play_area>
  4006ac:	00f60633          	add	a2,a2,a5
  4006b0:	100005b7          	lui	a1,0x10000
  4006b4:	01058593          	addi	a1,a1,16 # 10000010 <piece_mask>
  4006b8:	00f585b3          	add	a1,a1,a5
  4006bc:	00400513          	li	a0,4
  4006c0:	e35ff0ef          	jal	ra,4004f4 <bit_and_matrix>
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
  4006c4:	0004a403          	lw	s0,0(s1)
  4006c8:	0044a783          	lw	a5,4(s1)
  4006cc:	00f46433          	or	s0,s0,a5
  4006d0:	0084a783          	lw	a5,8(s1)
  4006d4:	00f46433          	or	s0,s0,a5
  4006d8:	00c4a783          	lw	a5,12(s1)
  4006dc:	00f46433          	or	s0,s0,a5
    }
    mv_piece_u(); // move piece up to its original position
  4006e0:	f19ff0ef          	jal	ra,4005f8 <mv_piece_u>
    return ret_val;
}
  4006e4:	00040513          	mv	a0,s0
  4006e8:	00c12083          	lw	ra,12(sp)
  4006ec:	00812403          	lw	s0,8(sp)
  4006f0:	00412483          	lw	s1,4(sp)
  4006f4:	01010113          	addi	sp,sp,16
  4006f8:	00008067          	ret

004006fc <consolidate_rows>:


int consolidate_rows(){
  4006fc:	ff010113          	addi	sp,sp,-16
  400700:	00112623          	sw	ra,12(sp)
    // add each of the 4 rows where the piece is to the play area
    bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
  400704:	100007b7          	lui	a5,0x10000
  400708:	0ec7a783          	lw	a5,236(a5) # 100000ec <piece_row>
  40070c:	00279793          	slli	a5,a5,0x2
  400710:	10000637          	lui	a2,0x10000
  400714:	07460613          	addi	a2,a2,116 # 10000074 <play_area>
  400718:	00c78633          	add	a2,a5,a2
  40071c:	00060693          	mv	a3,a2
  400720:	100005b7          	lui	a1,0x10000
  400724:	01058593          	addi	a1,a1,16 # 10000010 <piece_mask>
  400728:	00f585b3          	add	a1,a1,a5
  40072c:	00400513          	li	a0,4
  400730:	d91ff0ef          	jal	ra,4004c0 <bit_or_matrix>
}
  400734:	00c12083          	lw	ra,12(sp)
  400738:	01010113          	addi	sp,sp,16
  40073c:	00008067          	ret

00400740 <clear_rows>:



int clear_rows(){
    int points = 0;
    for (int i = HEIGHT-2; i > 4; i--){ // check each of the 4 rows where the piece is
  400740:	10000737          	lui	a4,0x10000
  400744:	0d070713          	addi	a4,a4,208 # 100000d0 <play_area+0x5c>
  400748:	01700693          	li	a3,23
    int points = 0;
  40074c:	00000513          	li	a0,0
        if (play_area[i] == 4095){ // 4095 = column of all 1s
  400750:	00001e37          	lui	t3,0x1
  400754:	fffe0893          	addi	a7,t3,-1 # fff <_start-0x3ff001>
            points++;
            // this will break when the piece is off screen @@@@@@@@@@@@@
            for (int j = i; j > 4; j--){
  400758:	00400813          	li	a6,4
                play_area[j] = play_area[j-1];
            }
            play_area[4] = 0b100000000001;
  40075c:	10000337          	lui	t1,0x10000
  400760:	07430313          	addi	t1,t1,116 # 10000074 <play_area>
  400764:	801e0e13          	addi	t3,t3,-2047
  400768:	01030593          	addi	a1,t1,16
  40076c:	0140006f          	j	400780 <clear_rows+0x40>
  400770:	01c32823          	sw	t3,16(t1)
    for (int i = HEIGHT-2; i > 4; i--){ // check each of the 4 rows where the piece is
  400774:	fff68693          	addi	a3,a3,-1
  400778:	ffc70713          	addi	a4,a4,-4
  40077c:	03068663          	beq	a3,a6,4007a8 <clear_rows+0x68>
        if (play_area[i] == 4095){ // 4095 = column of all 1s
  400780:	00072783          	lw	a5,0(a4)
  400784:	ff1798e3          	bne	a5,a7,400774 <clear_rows+0x34>
            points++;
  400788:	00150513          	addi	a0,a0,1
            for (int j = i; j > 4; j--){
  40078c:	fed852e3          	bge	a6,a3,400770 <clear_rows+0x30>
  400790:	00070793          	mv	a5,a4
                play_area[j] = play_area[j-1];
  400794:	ffc7a603          	lw	a2,-4(a5)
  400798:	00c7a023          	sw	a2,0(a5)
            for (int j = i; j > 4; j--){
  40079c:	ffc78793          	addi	a5,a5,-4
  4007a0:	feb79ae3          	bne	a5,a1,400794 <clear_rows+0x54>
  4007a4:	fcdff06f          	j	400770 <clear_rows+0x30>
        }
    }
    return points;
}
  4007a8:	00008067          	ret

004007ac <tetris_god_senpai>:

void tetris_god_senpai(){
  4007ac:	ff010113          	addi	sp,sp,-16
  4007b0:	00112623          	sw	ra,12(sp)
    piece_row = 4;
  4007b4:	100007b7          	lui	a5,0x10000
  4007b8:	00400713          	li	a4,4
  4007bc:	0ee7a623          	sw	a4,236(a5) # 100000ec <piece_row>
    piece_col = 5;
  4007c0:	100007b7          	lui	a5,0x10000
  4007c4:	00500713          	li	a4,5
  4007c8:	0ee7a423          	sw	a4,232(a5) # 100000e8 <piece_col>
    piece_index = (piece_index + 7)%18;
  4007cc:	10000737          	lui	a4,0x10000
  4007d0:	0f072783          	lw	a5,240(a4) # 100000f0 <piece_index>
  4007d4:	00778793          	addi	a5,a5,7
  4007d8:	01200693          	li	a3,18
  4007dc:	02d7e7b3          	rem	a5,a5,a3
  4007e0:	0ef72823          	sw	a5,240(a4)
    change_piece();
  4007e4:	c85ff0ef          	jal	ra,400468 <change_piece>
    reset_mask();
  4007e8:	b81ff0ef          	jal	ra,400368 <reset_mask>
    apply_mask();
  4007ec:	b35ff0ef          	jal	ra,400320 <apply_mask>
}
  4007f0:	00c12083          	lw	ra,12(sp)
  4007f4:	01010113          	addi	sp,sp,16
  4007f8:	00008067          	ret
