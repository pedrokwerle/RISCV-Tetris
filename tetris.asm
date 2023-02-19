
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
#include "movement.h"
#include "physics.h"
#include "random.h"

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
    int current_piece[SQUARESIZE];
    for (int j = 0; j < SQUARESIZE; j++){
        current_piece[j] = pieces[3][j];
  400044:	004017b7          	lui	a5,0x401
  400048:	87478793          	addi	a5,a5,-1932 # 400874 <pieces>
  40004c:	0307a703          	lw	a4,48(a5)
  400050:	00e12023          	sw	a4,0(sp)
  400054:	0347a703          	lw	a4,52(a5)
  400058:	00e12223          	sw	a4,4(sp)
  40005c:	0387a703          	lw	a4,56(a5)
  400060:	00e12423          	sw	a4,8(sp)
  400064:	03c7a783          	lw	a5,60(a5)
  400068:	00f12623          	sw	a5,12(sp)
    }
    piece_row = 14;
  40006c:	100007b7          	lui	a5,0x10000
  400070:	00e00713          	li	a4,14
  400074:	06e7ac23          	sw	a4,120(a5) # 10000078 <piece_row>
    piece_col = 4;
  400078:	100007b7          	lui	a5,0x10000
  40007c:	00400713          	li	a4,4
  400080:	06e7aa23          	sw	a4,116(a5) # 10000074 <piece_col>
    for (int j = 0; j < HEIGHT; j++){
  400084:	00401437          	lui	s0,0x401
  400088:	81040913          	addi	s2,s0,-2032 # 400810 <play_area>
    piece_col = 4;
  40008c:	81040413          	addi	s0,s0,-2032
    for (int j = 0; j < HEIGHT; j++){
  400090:	00000493          	li	s1,0
  400094:	01900993          	li	s3,25
        paint_row(play_area[j], j);
  400098:	00048593          	mv	a1,s1
  40009c:	00042503          	lw	a0,0(s0)
  4000a0:	368000ef          	jal	ra,400408 <paint_row>
    for (int j = 0; j < HEIGHT; j++){
  4000a4:	00148493          	addi	s1,s1,1
  4000a8:	00440413          	addi	s0,s0,4
  4000ac:	ff3496e3          	bne	s1,s3,400098 <main+0x7c>
    }
    apply_mask(current_piece);
  4000b0:	00010513          	mv	a0,sp
  4000b4:	2d0000ef          	jal	ra,400384 <apply_mask>
    int colision = 0;
    while (colision < 1){
        for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  4000b8:	100009b7          	lui	s3,0x10000
  4000bc:	40000b37          	lui	s6,0x40000
  4000c0:	fffb0b13          	addi	s6,s6,-1 # 3fffffff <__stack_init+0x2fff0003>
  4000c4:	10000ab7          	lui	s5,0x10000
  4000c8:	000a8a93          	mv	s5,s5
  4000cc:	00401a37          	lui	s4,0x401
  4000d0:	810a0a13          	addi	s4,s4,-2032 # 400810 <play_area>
  4000d4:	0789a483          	lw	s1,120(s3) # 10000078 <piece_row>
  4000d8:	fff48413          	addi	s0,s1,-1
  4000dc:	016484b3          	add	s1,s1,s6
  4000e0:	00249493          	slli	s1,s1,0x2
  4000e4:	01548bb3          	add	s7,s1,s5
  4000e8:	014484b3          	add	s1,s1,s4
            paint_row(piece_mask[j] | play_area[j], j);
  4000ec:	000ba503          	lw	a0,0(s7)
  4000f0:	0004a783          	lw	a5,0(s1)
  4000f4:	00040593          	mv	a1,s0
  4000f8:	00f56533          	or	a0,a0,a5
  4000fc:	30c000ef          	jal	ra,400408 <paint_row>
        for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  400100:	00140413          	addi	s0,s0,1
  400104:	004b8b93          	addi	s7,s7,4
  400108:	00448493          	addi	s1,s1,4
  40010c:	0789a783          	lw	a5,120(s3)
  400110:	00378793          	addi	a5,a5,3
  400114:	fc87dce3          	bge	a5,s0,4000ec <main+0xd0>
        }
        mv_piece_d();
  400118:	500000ef          	jal	ra,400618 <mv_piece_d>
        colision = colision_check();
  40011c:	5b0000ef          	jal	ra,4006cc <colision_check>
    while (colision < 1){
  400120:	faa05ae3          	blez	a0,4000d4 <main+0xb8>
    }
    mv_piece_u();
  400124:	534000ef          	jal	ra,400658 <mv_piece_u>
    consolidate_rows();
  400128:	614000ef          	jal	ra,40073c <consolidate_rows>
    clear_rows();
  40012c:	654000ef          	jal	ra,400780 <clear_rows>

    for (int j = 0; j < HEIGHT; j++){
  400130:	00000413          	li	s0,0
  400134:	01900493          	li	s1,25
        paint_row(play_area[j], j);
  400138:	00040593          	mv	a1,s0
  40013c:	00092503          	lw	a0,0(s2)
  400140:	2c8000ef          	jal	ra,400408 <paint_row>
    for (int j = 0; j < HEIGHT; j++){
  400144:	00140413          	addi	s0,s0,1
  400148:	00490913          	addi	s2,s2,4
  40014c:	fe9416e3          	bne	s0,s1,400138 <main+0x11c>
    }
}
  400150:	00000513          	li	a0,0
  400154:	03c12083          	lw	ra,60(sp)
  400158:	03812403          	lw	s0,56(sp)
  40015c:	03412483          	lw	s1,52(sp)
  400160:	03012903          	lw	s2,48(sp)
  400164:	02c12983          	lw	s3,44(sp)
  400168:	02812a03          	lw	s4,40(sp)
  40016c:	02412a83          	lw	s5,36(sp)
  400170:	02012b03          	lw	s6,32(sp)
  400174:	01c12b83          	lw	s7,28(sp)
  400178:	04010113          	addi	sp,sp,64
  40017c:	00008067          	ret

00400180 <abs>:
 */

#include "lib.h"

// returns absolute value of its integer argument - a replacement of the standard library function abs() 
inline int abs(int n) { return (n < 0) ? (-n) : n; }
  400180:	41f55793          	srai	a5,a0,0x1f
  400184:	00a7c533          	xor	a0,a5,a0
  400188:	40f50533          	sub	a0,a0,a5
  40018c:	00008067          	ret

00400190 <printchar>:

// prints single character to console - a substitute for the standard library funciton putch(int chr)
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400190:	ffff07b7          	lui	a5,0xffff0
  400194:	00a7a623          	sw	a0,12(a5) # ffff000c <__stack_init+0xeffe0010>
  400198:	00008067          	ret

0040019c <println>:
  40019c:	ffff07b7          	lui	a5,0xffff0
  4001a0:	00a00713          	li	a4,10
  4001a4:	00e7a623          	sw	a4,12(a5) # ffff000c <__stack_init+0xeffe0010>

// prints newline character to console
void println() { printchar('\n'); }
  4001a8:	00008067          	ret

004001ac <printstr>:

// prints given string of characters to console - a substitute for the standard library function puts(char *s)
void printstr(char *str)
{
    while (*str != '\0') 
  4001ac:	00054783          	lbu	a5,0(a0)
  4001b0:	00078c63          	beqz	a5,4001c8 <printstr+0x1c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  4001b4:	ffff0737          	lui	a4,0xffff0
  4001b8:	00f72623          	sw	a5,12(a4) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(*str);
        str += 1;
  4001bc:	00150513          	addi	a0,a0,1
    while (*str != '\0') 
  4001c0:	00054783          	lbu	a5,0(a0)
  4001c4:	fe079ae3          	bnez	a5,4001b8 <printstr+0xc>
    }
}
  4001c8:	00008067          	ret

004001cc <printint>:

// prints given integer as a signed decimal number
void printint(int n)
{
  4001cc:	ff010113          	addi	sp,sp,-16
    {
        sign = '-';
    }
    else
    {
        sign = '\0';
  4001d0:	41f55813          	srai	a6,a0,0x1f
  4001d4:	02d87813          	andi	a6,a6,45
  4001d8:	00410713          	addi	a4,sp,4
  4001dc:	00900613          	li	a2,9
    
    // produce decimal digits of the number going from right to left, keep them in num[] array.
    do 
    {
        i = i - 1;
        num[i] = abs(n % 10) + '0';
  4001e0:	00a00593          	li	a1,10
        i = i - 1;
  4001e4:	fff60613          	addi	a2,a2,-1
        num[i] = abs(n % 10) + '0';
  4001e8:	02b567b3          	rem	a5,a0,a1
  4001ec:	41f7d693          	srai	a3,a5,0x1f
  4001f0:	00f6c7b3          	xor	a5,a3,a5
  4001f4:	40d787b3          	sub	a5,a5,a3
  4001f8:	03078793          	addi	a5,a5,48
  4001fc:	00f70423          	sb	a5,8(a4)
        n = n / 10;
  400200:	02b54533          	div	a0,a0,a1
    } while (n != 0);
  400204:	fff70713          	addi	a4,a4,-1
  400208:	fc051ee3          	bnez	a0,4001e4 <printint+0x18>
    
    //now print the sign of the number and its digits left-to-right.
    if (sign) 
  40020c:	00080663          	beqz	a6,400218 <printint+0x4c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400210:	ffff07b7          	lui	a5,0xffff0
  400214:	0107a623          	sw	a6,12(a5) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(sign);
    }
    
    while(i < MAX_INT_DIGITS)
  400218:	00900793          	li	a5,9
  40021c:	02c7c263          	blt	a5,a2,400240 <printint+0x74>
  400220:	00410793          	addi	a5,sp,4
  400224:	00c787b3          	add	a5,a5,a2
  400228:	00e10693          	addi	a3,sp,14
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  40022c:	ffff0637          	lui	a2,0xffff0
  400230:	0007c703          	lbu	a4,0(a5)
  400234:	00e62623          	sw	a4,12(a2) # ffff000c <__stack_init+0xeffe0010>
    while(i < MAX_INT_DIGITS)
  400238:	00178793          	addi	a5,a5,1
  40023c:	fed79ae3          	bne	a5,a3,400230 <printint+0x64>
    {
        printchar(num[i]);
        i=i+1;
    }
}
  400240:	01010113          	addi	sp,sp,16
  400244:	00008067          	ret

00400248 <pollkbd>:


// check if keyboard buffer has some data
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400248:	ffff07b7          	lui	a5,0xffff0
  40024c:	0007a503          	lw	a0,0(a5) # ffff0000 <__stack_init+0xeffe0004>
  400250:	00008067          	ret

00400254 <readchar>:

// read next character from keyboard buffer
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  400254:	ffff07b7          	lui	a5,0xffff0
  400258:	0047a503          	lw	a0,4(a5) # ffff0004 <__stack_init+0xeffe0008>
  40025c:	00008067          	ret

00400260 <readstr>:

// read characters into provided buffer until either user presses enter or the buffer size is reached.
int readstr(char *buf, int size)
{
  400260:	00050693          	mv	a3,a0
    int count;
    
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  400264:	00100793          	li	a5,1
  400268:	04b7d263          	bge	a5,a1,4002ac <readstr+0x4c>
  40026c:	fff58613          	addi	a2,a1,-1
    
    count = 0;
  400270:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400274:	ffff0737          	lui	a4,0xffff0
       
       // read next character into the current element of the buffer
       *buf = (char)readchar();
       
       // if the user pressed Enter, stop reading
       if (*buf == '\n') 
  400278:	00a00593          	li	a1,10
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  40027c:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  400280:	fe078ee3          	beqz	a5,40027c <readstr+0x1c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  400284:	00472783          	lw	a5,4(a4)
       *buf = (char)readchar();
  400288:	0ff7f793          	andi	a5,a5,255
  40028c:	00f68023          	sb	a5,0(a3)
       if (*buf == '\n') 
  400290:	00b78a63          	beq	a5,a1,4002a4 <readstr+0x44>
       {
           break;
       }
       
       // move pointer to the next element of the buffer
       buf += 1;
  400294:	00168693          	addi	a3,a3,1
       
       // increase the number of characters in the buffer
       count += 1;
  400298:	00150513          	addi	a0,a0,1
       
       // decrease the remaining space in the buffer
       size -= 1;
       
    } while(size > 1);  // keep going until one empty char remains (to hold the final '\0' character
  40029c:	fec510e3          	bne	a0,a2,40027c <readstr+0x1c>
       count += 1;
  4002a0:	00060513          	mv	a0,a2
    
    *buf = '\0';  // add the end-of-string marker '\0'
  4002a4:	00068023          	sb	zero,0(a3)
    
    return count; // return the number of characters in the read string
  4002a8:	00008067          	ret
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  4002ac:	fff00513          	li	a0,-1
}
  4002b0:	00008067          	ret

004002b4 <readint>:

//read signed integer
int readint()
{
    int res = 0;
    int sign = 1;
  4002b4:	00100593          	li	a1,1
    int res = 0;
  4002b8:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  4002bc:	ffff0737          	lui	a4,0xffff0
           sign = -1;
       }
       else
       {
           // otherwise, if a non-digit is read, it signifies the end of the number
           if (chr < '0' || chr > '9') 
  4002c0:	00900613          	li	a2,9
       if (res == 0 && sign == 1 && chr == '-') 
  4002c4:	00100813          	li	a6,1
  4002c8:	02d00893          	li	a7,45
           sign = -1;
  4002cc:	fff00313          	li	t1,-1
  4002d0:	0200006f          	j	4002f0 <readint+0x3c>
           if (chr < '0' || chr > '9') 
  4002d4:	fd068793          	addi	a5,a3,-48
  4002d8:	02f66c63          	bltu	a2,a5,400310 <readint+0x5c>
           {
               break;
           }
           // incorporate the read digit into the number (N.B. chr - '0' gived the digit value).
           res = res * 10 + (chr - '0');
  4002dc:	00251793          	slli	a5,a0,0x2
  4002e0:	00a787b3          	add	a5,a5,a0
  4002e4:	00179793          	slli	a5,a5,0x1
  4002e8:	fd068693          	addi	a3,a3,-48
  4002ec:	00f68533          	add	a0,a3,a5
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  4002f0:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  4002f4:	fe078ee3          	beqz	a5,4002f0 <readint+0x3c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  4002f8:	00472683          	lw	a3,4(a4)
       if (res == 0 && sign == 1 && chr == '-') 
  4002fc:	fc051ce3          	bnez	a0,4002d4 <readint+0x20>
  400300:	fd059ae3          	bne	a1,a6,4002d4 <readint+0x20>
  400304:	fd1698e3          	bne	a3,a7,4002d4 <readint+0x20>
           sign = -1;
  400308:	00030593          	mv	a1,t1
  40030c:	fe5ff06f          	j	4002f0 <readint+0x3c>
       }
    }
    
    // return the absolute value of the number (constructed from entered digits) multiplied by the sign.
    return sign * res;
}
  400310:	02b50533          	mul	a0,a0,a1
  400314:	00008067          	ret

00400318 <showpic>:
    # as long as this function is not calling other functions.
    
    .globl showpic
    
showpic:
    li t0,0xffff8000    # starting address of the graphics display
  400318:	ffff82b7          	lui	t0,0xffff8
    li t1,32            # number of lines on the display (each word encodes one line) 
  40031c:	02000313          	li	t1,32

00400320 <loop>:
loop:
    lw t2,0(a0)         # load next line (word) of the picture data
  400320:	00052383          	lw	t2,0(a0)
    sw t2,0(t0)         # write it to the corresponding line of the graphics display
  400324:	0072a023          	sw	t2,0(t0) # ffff8000 <__stack_init+0xeffe8004>
    addi t0,t0,4        # move to the next line of the graphics display
  400328:	00428293          	addi	t0,t0,4
    addi a0,a0,4        # move to the next line of the picture data
  40032c:	00450513          	addi	a0,a0,4
    addi t1,t1,-1       # reduce the number of remaining lines
  400330:	fff30313          	addi	t1,t1,-1
    bnez t1,loop        # keep going until all lines on the display are filled with data
  400334:	fe0316e3          	bnez	t1,400320 <loop>
    jr ra               # return 
  400338:	00008067          	ret

0040033c <initseed>:
   	# the seed should only be set once at the start of the program
   	# otherwise you can accidentally always get the same number
	.global initseed

initseed:
	la t0, seed		# load address of seed to t0
  40033c:	00000297          	auipc	t0,0x0
  400340:	4d028293          	addi	t0,t0,1232 # 40080c <seed>
	li t5, 0x1234		# write-enable signal value
  400344:	00001f37          	lui	t5,0x1
  400348:	234f0f13          	addi	t5,t5,564 # 1234 <_start-0x3fedcc>
	sw t5, 0(t0)		# enable writing to seed location
  40034c:	01e2a023          	sw	t5,0(t0)
	sw a0, 0(t0)		# load input seed to memory	
  400350:	00a2a023          	sw	a0,0(t0)
	jr ra
  400354:	00008067          	ret

00400358 <random>:
	
	.global random
	
random:
	la t0, seed		# load address of seed to t0
  400358:	00000297          	auipc	t0,0x0
  40035c:	4b428293          	addi	t0,t0,1204 # 40080c <seed>
	lw t1, 0(t0)		# load seed to t1
  400360:	0002a303          	lw	t1,0(t0)
	mv t1, sp		
  400364:	00010313          	mv	t1,sp

00400368 <roll>:
	
roll:
	slli t2, t1, 1		# shift seed to the left and store in t2
  400368:	00131393          	slli	t2,t1,0x1
	xor t1, t2, t1		# xor bits in t1 and t2 for a pseudo random number
  40036c:	0063c333          	xor	t1,t2,t1
	andi a0, t1, 0x700	# extract 3 bit random number from t1 using mask 0000011100000000
  400370:	70037513          	andi	a0,t1,1792
	srli a0, a0, 8		# shift bits in t4 to the right so they are the least significant digits
  400374:	00855513          	srli	a0,a0,0x8
	beqz a0, roll		# reroll if equal to 0 
  400378:	fe0508e3          	beqz	a0,400368 <roll>
	sw t1, 0(t0)		# set new seed with value of t1
  40037c:	0062a023          	sw	t1,0(t0)
	jr ra 			# return
  400380:	00008067          	ret

00400384 <apply_mask>:
#include "matrix.h"

void apply_mask(int piece[SQUARESIZE]){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece[i-piece_row]; // mask row equal current piece row
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400384:	100007b7          	lui	a5,0x10000
  400388:	0747a783          	lw	a5,116(a5) # 10000074 <piece_col>
  40038c:	00800613          	li	a2,8
  400390:	40f60633          	sub	a2,a2,a5
  400394:	00050713          	mv	a4,a0
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400398:	100007b7          	lui	a5,0x10000
  40039c:	0787a783          	lw	a5,120(a5) # 10000078 <piece_row>
  4003a0:	00279693          	slli	a3,a5,0x2
  4003a4:	100007b7          	lui	a5,0x10000
  4003a8:	00078793          	mv	a5,a5
  4003ac:	00d787b3          	add	a5,a5,a3
  4003b0:	01050513          	addi	a0,a0,16
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  4003b4:	00072683          	lw	a3,0(a4)
  4003b8:	00c696b3          	sll	a3,a3,a2
  4003bc:	00d7a023          	sw	a3,0(a5) # 10000000 <piece_mask>
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4003c0:	00470713          	addi	a4,a4,4
  4003c4:	00478793          	addi	a5,a5,4
  4003c8:	fea716e3          	bne	a4,a0,4003b4 <apply_mask+0x30>
    }
}
  4003cc:	00008067          	ret

004003d0 <reset_mask>:

void reset_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4003d0:	100007b7          	lui	a5,0x10000
  4003d4:	0787a683          	lw	a3,120(a5) # 10000078 <piece_row>
  4003d8:	00269693          	slli	a3,a3,0x2
  4003dc:	10000737          	lui	a4,0x10000
  4003e0:	00070713          	mv	a4,a4
  4003e4:	00d707b3          	add	a5,a4,a3
  4003e8:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  4003ec:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 12;
  4003f0:	0007a703          	lw	a4,0(a5)
  4003f4:	40c75713          	srai	a4,a4,0xc
  4003f8:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4003fc:	00478793          	addi	a5,a5,4
  400400:	fed798e3          	bne	a5,a3,4003f0 <reset_mask+0x20>
    }
}
  400404:	00008067          	ret

00400408 <paint_row>:
#include "display.h"

void paint_row(int row, int row_num){
        *((volatile int *)(0xffff8000 + row_num*4)) = row;
  400408:	00259593          	slli	a1,a1,0x2
  40040c:	ffff87b7          	lui	a5,0xffff8
  400410:	00f585b3          	add	a1,a1,a5
  400414:	00a5a023          	sw	a0,0(a1)
}
  400418:	00008067          	ret

0040041c <bit_or_matrix>:
/* matrix operations for binary 2D arrays that are treated as matrices */
#include "matrix.h"

void bit_or_matrix(int size, int matrix1[size], int matrix2[size], int* result){
    for (int i = 0; i < size - 1; i++) {
  40041c:	00100793          	li	a5,1
  400420:	02a7da63          	bge	a5,a0,400454 <bit_or_matrix+0x38>
  400424:	00251513          	slli	a0,a0,0x2
  400428:	ffc50893          	addi	a7,a0,-4
  40042c:	00000793          	li	a5,0
        result[i] = matrix1[i] | matrix2[i];
  400430:	00f68533          	add	a0,a3,a5
  400434:	00f58733          	add	a4,a1,a5
  400438:	00f60833          	add	a6,a2,a5
  40043c:	00072703          	lw	a4,0(a4)
  400440:	00082803          	lw	a6,0(a6)
  400444:	01076733          	or	a4,a4,a6
  400448:	00e52023          	sw	a4,0(a0)
    for (int i = 0; i < size - 1; i++) {
  40044c:	00478793          	addi	a5,a5,4 # ffff8004 <__stack_init+0xeffe8008>
  400450:	ff1790e3          	bne	a5,a7,400430 <bit_or_matrix+0x14>
    }
}
  400454:	00008067          	ret

00400458 <bit_and_matrix>:

void bit_and_matrix(int size, int matrix1[size], int matrix2[size], int* result){
    for (int i = 0; i < size - 1; i++) {
  400458:	00100793          	li	a5,1
  40045c:	02a7da63          	bge	a5,a0,400490 <bit_and_matrix+0x38>
  400460:	00251513          	slli	a0,a0,0x2
  400464:	ffc50893          	addi	a7,a0,-4
  400468:	00000793          	li	a5,0
        result[i] = matrix1[i] & matrix2[i];
  40046c:	00f68533          	add	a0,a3,a5
  400470:	00f58733          	add	a4,a1,a5
  400474:	00f60833          	add	a6,a2,a5
  400478:	00072703          	lw	a4,0(a4)
  40047c:	00082803          	lw	a6,0(a6)
  400480:	01077733          	and	a4,a4,a6
  400484:	00e52023          	sw	a4,0(a0)
    for (int i = 0; i < size - 1; i++) {
  400488:	00478793          	addi	a5,a5,4
  40048c:	ff1790e3          	bne	a5,a7,40046c <bit_and_matrix+0x14>
    }
}
  400490:	00008067          	ret

00400494 <rotate_cw>:

void rotate_cw(int matrix[SQUARESIZE]){     // pass in the piece matrix and it will get rotated
  400494:	ff010113          	addi	sp,sp,-16
    int temp[SQUARESIZE];

    // Copy the original matrix to a temporary matrix
    for (int i = 0; i < SQUARESIZE; i++) {
  400498:	00010313          	mv	t1,sp
  40049c:	01050613          	addi	a2,a0,16
void rotate_cw(int matrix[SQUARESIZE]){     // pass in the piece matrix and it will get rotated
  4004a0:	00030713          	mv	a4,t1
  4004a4:	00050793          	mv	a5,a0
        temp[i] = matrix[i];
  4004a8:	0007a683          	lw	a3,0(a5)
  4004ac:	00d72023          	sw	a3,0(a4)
        matrix[i] = 0;
  4004b0:	0007a023          	sw	zero,0(a5)
    for (int i = 0; i < SQUARESIZE; i++) {
  4004b4:	00478793          	addi	a5,a5,4
  4004b8:	00470713          	addi	a4,a4,4
  4004bc:	fec796e3          	bne	a5,a2,4004a8 <rotate_cw+0x14>
    }

    // rotate matrix cw
    for (int i = 0; i < SQUARESIZE; i++){
  4004c0:	00000593          	li	a1,0
        for (int j = 0; j < SQUARESIZE; j++){
  4004c4:	fff00893          	li	a7,-1
    for (int i = 0; i < SQUARESIZE; i++){
  4004c8:	00400e13          	li	t3,4
            matrix[j] |= ((temp[i] >> (SQUARESIZE - j - 1)) & 1) << i;
  4004cc:	00032803          	lw	a6,0(t1)
  4004d0:	00050693          	mv	a3,a0
  4004d4:	00300713          	li	a4,3
  4004d8:	40e857b3          	sra	a5,a6,a4
  4004dc:	0017f793          	andi	a5,a5,1
  4004e0:	00b797b3          	sll	a5,a5,a1
  4004e4:	0006a603          	lw	a2,0(a3)
  4004e8:	00f667b3          	or	a5,a2,a5
  4004ec:	00f6a023          	sw	a5,0(a3)
        for (int j = 0; j < SQUARESIZE; j++){
  4004f0:	fff70713          	addi	a4,a4,-1
  4004f4:	00468693          	addi	a3,a3,4
  4004f8:	ff1710e3          	bne	a4,a7,4004d8 <rotate_cw+0x44>
    for (int i = 0; i < SQUARESIZE; i++){
  4004fc:	00158593          	addi	a1,a1,1
  400500:	00430313          	addi	t1,t1,4
  400504:	fdc594e3          	bne	a1,t3,4004cc <rotate_cw+0x38>
        }
    }
}
  400508:	01010113          	addi	sp,sp,16
  40050c:	00008067          	ret

00400510 <rotate_ccw>:

void rotate_ccw(int matrix[SQUARESIZE]){    // pass in the piece matrix and it will get rotated
  400510:	ff010113          	addi	sp,sp,-16
    int temp[SQUARESIZE];

    // Copy the original matrix to a temporary matrix
    for (int i = 0; i < SQUARESIZE; i++) {
  400514:	00050793          	mv	a5,a0
  400518:	00010313          	mv	t1,sp
  40051c:	01050613          	addi	a2,a0,16
void rotate_ccw(int matrix[SQUARESIZE]){    // pass in the piece matrix and it will get rotated
  400520:	00030713          	mv	a4,t1
        temp[i] = matrix[i];
  400524:	0007a683          	lw	a3,0(a5)
  400528:	00d72023          	sw	a3,0(a4)
        matrix[i] = 0;
  40052c:	0007a023          	sw	zero,0(a5)
    for (int i = 0; i < SQUARESIZE; i++) {
  400530:	00478793          	addi	a5,a5,4
  400534:	00470713          	addi	a4,a4,4
  400538:	fec796e3          	bne	a5,a2,400524 <rotate_ccw+0x14>
    }

    // Rotate matrix ccw
    for (int i = 0; i < SQUARESIZE; i++){
  40053c:	00000593          	li	a1,0
        for (int j = 0; j < SQUARESIZE; j++){
  400540:	00400813          	li	a6,4
            matrix[SQUARESIZE-j-1] |= ((temp[i] >> j) & 1) << i;
  400544:	00032883          	lw	a7,0(t1)
  400548:	00c50693          	addi	a3,a0,12
        for (int j = 0; j < SQUARESIZE; j++){
  40054c:	00000713          	li	a4,0
            matrix[SQUARESIZE-j-1] |= ((temp[i] >> j) & 1) << i;
  400550:	40e8d7b3          	sra	a5,a7,a4
  400554:	0017f793          	andi	a5,a5,1
  400558:	00b797b3          	sll	a5,a5,a1
  40055c:	0006a603          	lw	a2,0(a3)
  400560:	00f667b3          	or	a5,a2,a5
  400564:	00f6a023          	sw	a5,0(a3)
        for (int j = 0; j < SQUARESIZE; j++){
  400568:	00170713          	addi	a4,a4,1
  40056c:	ffc68693          	addi	a3,a3,-4
  400570:	ff0710e3          	bne	a4,a6,400550 <rotate_ccw+0x40>
    for (int i = 0; i < SQUARESIZE; i++){
  400574:	00158593          	addi	a1,a1,1
  400578:	00430313          	addi	t1,t1,4
  40057c:	fd0594e3          	bne	a1,a6,400544 <rotate_ccw+0x34>
        }
    }
}
  400580:	01010113          	addi	sp,sp,16
  400584:	00008067          	ret

00400588 <mv_piece_l>:
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

void mv_piece_l(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400588:	100007b7          	lui	a5,0x10000
  40058c:	0787a683          	lw	a3,120(a5) # 10000078 <piece_row>
  400590:	00269693          	slli	a3,a3,0x2
  400594:	10000737          	lui	a4,0x10000
  400598:	00070713          	mv	a4,a4
  40059c:	00e687b3          	add	a5,a3,a4
  4005a0:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  4005a4:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] << 1;
  4005a8:	0007a703          	lw	a4,0(a5)
  4005ac:	00171713          	slli	a4,a4,0x1
  4005b0:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4005b4:	00478793          	addi	a5,a5,4
  4005b8:	fed798e3          	bne	a5,a3,4005a8 <mv_piece_l+0x20>
    }
    piece_col -= 1;
  4005bc:	10000737          	lui	a4,0x10000
  4005c0:	07472783          	lw	a5,116(a4) # 10000074 <piece_col>
  4005c4:	fff78793          	addi	a5,a5,-1
  4005c8:	06f72a23          	sw	a5,116(a4)
}
  4005cc:	00008067          	ret

004005d0 <mv_piece_r>:
void mv_piece_r(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4005d0:	100007b7          	lui	a5,0x10000
  4005d4:	0787a683          	lw	a3,120(a5) # 10000078 <piece_row>
  4005d8:	00269693          	slli	a3,a3,0x2
  4005dc:	10000737          	lui	a4,0x10000
  4005e0:	00070713          	mv	a4,a4
  4005e4:	00e687b3          	add	a5,a3,a4
  4005e8:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  4005ec:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 1;
  4005f0:	0007a703          	lw	a4,0(a5)
  4005f4:	40175713          	srai	a4,a4,0x1
  4005f8:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4005fc:	00478793          	addi	a5,a5,4
  400600:	fed798e3          	bne	a5,a3,4005f0 <mv_piece_r+0x20>
    }
    piece_col += 1;
  400604:	10000737          	lui	a4,0x10000
  400608:	07472783          	lw	a5,116(a4) # 10000074 <piece_col>
  40060c:	00178793          	addi	a5,a5,1
  400610:	06f72a23          	sw	a5,116(a4)
}
  400614:	00008067          	ret

00400618 <mv_piece_d>:
void mv_piece_d(){
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  400618:	100007b7          	lui	a5,0x10000
  40061c:	0787a603          	lw	a2,120(a5) # 10000078 <piece_row>
  400620:	00261693          	slli	a3,a2,0x2
  400624:	10000737          	lui	a4,0x10000
  400628:	00070713          	mv	a4,a4
  40062c:	00e687b3          	add	a5,a3,a4
  400630:	fec70713          	addi	a4,a4,-20 # fffffec <pieces+0xfbff778>
  400634:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i-1];
  400638:	00c7a683          	lw	a3,12(a5)
  40063c:	00d7a823          	sw	a3,16(a5)
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  400640:	ffc78793          	addi	a5,a5,-4
  400644:	fee79ae3          	bne	a5,a4,400638 <mv_piece_d+0x20>
    }
    piece_row += 1;
  400648:	00160613          	addi	a2,a2,1
  40064c:	100007b7          	lui	a5,0x10000
  400650:	06c7ac23          	sw	a2,120(a5) # 10000078 <piece_row>
}
  400654:	00008067          	ret

00400658 <mv_piece_u>:
void mv_piece_u(){
    for (int i = piece_row - 1; i > piece_row + SQUARESIZE - 1; i--){
        piece_mask[i] = piece_mask[i+1];
    }
    piece_row -= 1;
  400658:	10000737          	lui	a4,0x10000
    for (int i = piece_row - 1; i > piece_row + SQUARESIZE - 1; i--){
  40065c:	07872783          	lw	a5,120(a4) # 10000078 <piece_row>
  400660:	fff78793          	addi	a5,a5,-1
    piece_row -= 1;
  400664:	06f72c23          	sw	a5,120(a4)
}
  400668:	00008067          	ret

0040066c <r_piece_cw>:
void r_piece_cw(int piece[SQUARESIZE]){
  40066c:	ff010113          	addi	sp,sp,-16
  400670:	00112623          	sw	ra,12(sp)
  400674:	00812423          	sw	s0,8(sp)
  400678:	00050413          	mv	s0,a0
    rotate_cw(piece);
  40067c:	e19ff0ef          	jal	ra,400494 <rotate_cw>
    reset_mask();
  400680:	d51ff0ef          	jal	ra,4003d0 <reset_mask>
    apply_mask(piece);
  400684:	00040513          	mv	a0,s0
  400688:	cfdff0ef          	jal	ra,400384 <apply_mask>
}
  40068c:	00c12083          	lw	ra,12(sp)
  400690:	00812403          	lw	s0,8(sp)
  400694:	01010113          	addi	sp,sp,16
  400698:	00008067          	ret

0040069c <r_piece_ccw>:
void r_piece_ccw(int piece[SQUARESIZE]){
  40069c:	ff010113          	addi	sp,sp,-16
  4006a0:	00112623          	sw	ra,12(sp)
  4006a4:	00812423          	sw	s0,8(sp)
  4006a8:	00050413          	mv	s0,a0
    rotate_ccw(piece);
  4006ac:	e65ff0ef          	jal	ra,400510 <rotate_ccw>
    reset_mask();
  4006b0:	d21ff0ef          	jal	ra,4003d0 <reset_mask>
    apply_mask(piece);
  4006b4:	00040513          	mv	a0,s0
  4006b8:	ccdff0ef          	jal	ra,400384 <apply_mask>
}
  4006bc:	00c12083          	lw	ra,12(sp)
  4006c0:	00812403          	lw	s0,8(sp)
  4006c4:	01010113          	addi	sp,sp,16
  4006c8:	00008067          	ret

004006cc <colision_check>:
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

// checks for colision between the falling piece and the blocks in the playing area
int colision_check(){
  4006cc:	ff010113          	addi	sp,sp,-16
  4006d0:	00112623          	sw	ra,12(sp)
  4006d4:	00812423          	sw	s0,8(sp)
    int ret_val;
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  4006d8:	100007b7          	lui	a5,0x10000
  4006dc:	0787a783          	lw	a5,120(a5) # 10000078 <piece_row>
  4006e0:	00279793          	slli	a5,a5,0x2
  4006e4:	100006b7          	lui	a3,0x10000
  4006e8:	06468413          	addi	s0,a3,100 # 10000064 <result>
  4006ec:	06468693          	addi	a3,a3,100
  4006f0:	00401637          	lui	a2,0x401
  4006f4:	81060613          	addi	a2,a2,-2032 # 400810 <play_area>
  4006f8:	00f60633          	add	a2,a2,a5
  4006fc:	100005b7          	lui	a1,0x10000
  400700:	00058593          	mv	a1,a1
  400704:	00f585b3          	add	a1,a1,a5
  400708:	00400513          	li	a0,4
  40070c:	d4dff0ef          	jal	ra,400458 <bit_and_matrix>
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
  400710:	00042783          	lw	a5,0(s0)
  400714:	00442503          	lw	a0,4(s0)
  400718:	00a7e7b3          	or	a5,a5,a0
  40071c:	00842503          	lw	a0,8(s0)
  400720:	00a7e7b3          	or	a5,a5,a0
  400724:	00c42503          	lw	a0,12(s0)
    }
    return ret_val;
}
  400728:	00a7e533          	or	a0,a5,a0
  40072c:	00c12083          	lw	ra,12(sp)
  400730:	00812403          	lw	s0,8(sp)
  400734:	01010113          	addi	sp,sp,16
  400738:	00008067          	ret

0040073c <consolidate_rows>:

// TODO: doesn't work
  40073c:	ff010113          	addi	sp,sp,-16
  400740:	00112623          	sw	ra,12(sp)
int consolidate_rows(){
    // add each of the 4 rows where the piece is to the play area
  400744:	100007b7          	lui	a5,0x10000
  400748:	0787a783          	lw	a5,120(a5) # 10000078 <piece_row>
  40074c:	00279793          	slli	a5,a5,0x2
  400750:	00401637          	lui	a2,0x401
  400754:	81060613          	addi	a2,a2,-2032 # 400810 <play_area>
  400758:	00c78633          	add	a2,a5,a2
  40075c:	00060693          	mv	a3,a2
  400760:	100005b7          	lui	a1,0x10000
  400764:	00058593          	mv	a1,a1
  400768:	00f585b3          	add	a1,a1,a5
  40076c:	00400513          	li	a0,4
  400770:	cadff0ef          	jal	ra,40041c <bit_or_matrix>
    bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
    /*for (int i = piece_row; i < SQUARESIZE; i++){
        bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
    }*/
  400774:	00c12083          	lw	ra,12(sp)
  400778:	01010113          	addi	sp,sp,16
  40077c:	00008067          	ret

00400780 <clear_rows>:
}

// TODO: doesn't work
int clear_rows(){
  400780:	100007b7          	lui	a5,0x10000
  400784:	0787a603          	lw	a2,120(a5) # 10000078 <piece_row>
  400788:	00200793          	li	a5,2
  40078c:	06c7cc63          	blt	a5,a2,400804 <clear_rows+0x84>
  400790:	00261593          	slli	a1,a2,0x2
  400794:	004017b7          	lui	a5,0x401
  400798:	81078793          	addi	a5,a5,-2032 # 400810 <play_area>
  40079c:	00f585b3          	add	a1,a1,a5
// TODO: doesn't work
  4007a0:	00000513          	li	a0,0
    int points = 0;
    for (int i = piece_row; i < SQUARESIZE - 1; i++){ // check each of the 4 rows where the piece is
        if (play_area[i] == 0b000000000000){
            points++;
  4007a4:	00400813          	li	a6,4
            // this wil break when the piece is off screen @@@@@@@@@@@@@
            for (int j = i; j > 4; j++){
                play_area[j] = play_area[j-1];
  4007a8:	00401e37          	lui	t3,0x401
  4007ac:	810e0e13          	addi	t3,t3,-2032 # 400810 <play_area>
  4007b0:	00001337          	lui	t1,0x1
  4007b4:	80130313          	addi	t1,t1,-2047 # 801 <_start-0x3ff7ff>
int clear_rows(){
  4007b8:	00300893          	li	a7,3
  4007bc:	0140006f          	j	4007d0 <clear_rows+0x50>
                play_area[j] = play_area[j-1];
  4007c0:	006e2823          	sw	t1,16(t3)
int clear_rows(){
  4007c4:	00160613          	addi	a2,a2,1
  4007c8:	00458593          	addi	a1,a1,4 # 10000004 <piece_mask+0x4>
  4007cc:	03160a63          	beq	a2,a7,400800 <clear_rows+0x80>
    int points = 0;
  4007d0:	0005a783          	lw	a5,0(a1)
  4007d4:	fe0798e3          	bnez	a5,4007c4 <clear_rows+0x44>
    for (int i = piece_row; i < SQUARESIZE - 1; i++){ // check each of the 4 rows where the piece is
  4007d8:	00150513          	addi	a0,a0,1
            points++;
  4007dc:	fec852e3          	bge	a6,a2,4007c0 <clear_rows+0x40>
  4007e0:	00058793          	mv	a5,a1
  4007e4:	00060713          	mv	a4,a2
            // this wil break when the piece is off screen @@@@@@@@@@@@@
  4007e8:	ffc7a683          	lw	a3,-4(a5)
  4007ec:	00d7a023          	sw	a3,0(a5)
            points++;
  4007f0:	00170713          	addi	a4,a4,1
  4007f4:	00478793          	addi	a5,a5,4
  4007f8:	fee848e3          	blt	a6,a4,4007e8 <clear_rows+0x68>
  4007fc:	fc5ff06f          	j	4007c0 <clear_rows+0x40>
  400800:	00008067          	ret
// TODO: doesn't work
  400804:	00000513          	li	a0,0
            }
            play_area[4] = 0b100000000001;
        }
    }
  400808:	00008067          	ret
