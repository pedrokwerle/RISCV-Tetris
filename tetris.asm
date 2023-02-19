
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
  400048:	390000ef          	jal	ra,4003d8 <initialize>
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
  400068:	478000ef          	jal	ra,4004e0 <paint_row>
    for (int j = 0; j < HEIGHT; j++){
  40006c:	00140413          	addi	s0,s0,1
  400070:	00448493          	addi	s1,s1,4
  400074:	ff2416e3          	bne	s0,s2,400060 <main+0x44>
            }
            else{
            mv_piece_d();
            }
            lowerFlags();
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
  400098:	0600006f          	j	4000f8 <main+0xdc>
            else if(pollRightFlag()){
  40009c:	129000ef          	jal	ra,4009c4 <pollRightFlag>
  4000a0:	06050463          	beqz	a0,400108 <main+0xec>
            mv_piece_r();
  4000a4:	55c000ef          	jal	ra,400600 <mv_piece_r>
            lowerFlags();
  4000a8:	135000ef          	jal	ra,4009dc <lowerFlags>
            for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  4000ac:	0ec9a483          	lw	s1,236(s3) # 100000ec <piece_row>
  4000b0:	fff48413          	addi	s0,s1,-1
  4000b4:	017484b3          	add	s1,s1,s7
  4000b8:	00249493          	slli	s1,s1,0x2
  4000bc:	01648933          	add	s2,s1,s6
  4000c0:	015484b3          	add	s1,s1,s5
                paint_row(piece_mask[j] | play_area[j], j);
  4000c4:	00092503          	lw	a0,0(s2)
  4000c8:	0004a783          	lw	a5,0(s1)
  4000cc:	00040593          	mv	a1,s0
  4000d0:	00f56533          	or	a0,a0,a5
  4000d4:	40c000ef          	jal	ra,4004e0 <paint_row>
            for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  4000d8:	00140413          	addi	s0,s0,1
  4000dc:	00490913          	addi	s2,s2,4
  4000e0:	00448493          	addi	s1,s1,4
  4000e4:	0ec9a783          	lw	a5,236(s3)
  4000e8:	00378793          	addi	a5,a5,3
  4000ec:	fc87dce3          	bge	a5,s0,4000c4 <main+0xa8>
            colision = colision_check();
  4000f0:	6d4000ef          	jal	ra,4007c4 <colision_check>
        while (colision < 1){
  4000f4:	02a04663          	bgtz	a0,400120 <main+0x104>
            if(pollLeftFlag()){
  4000f8:	0c1000ef          	jal	ra,4009b8 <pollLeftFlag>
  4000fc:	fa0500e3          	beqz	a0,40009c <main+0x80>
            mv_piece_l();
  400100:	45c000ef          	jal	ra,40055c <mv_piece_l>
  400104:	fa5ff06f          	j	4000a8 <main+0x8c>
            else if(pollRotFlag()){
  400108:	0c9000ef          	jal	ra,4009d0 <pollRotFlag>
  40010c:	00050663          	beqz	a0,400118 <main+0xfc>
            r_piece_cw();
  400110:	614000ef          	jal	ra,400724 <r_piece_cw>
  400114:	f95ff06f          	j	4000a8 <main+0x8c>
            mv_piece_d();
  400118:	58c000ef          	jal	ra,4006a4 <mv_piece_d>
  40011c:	f8dff06f          	j	4000a8 <main+0x8c>
        consolidate_rows();
  400120:	798000ef          	jal	ra,4008b8 <consolidate_rows>
        points = clear_rows();
  400124:	7d8000ef          	jal	ra,4008fc <clear_rows>
  400128:	000c0493          	mv	s1,s8
        for (int j = 0; j < HEIGHT-1; j++){
  40012c:	00000413          	li	s0,0
            paint_row(play_area[j], j);
  400130:	00040593          	mv	a1,s0
  400134:	0004a503          	lw	a0,0(s1)
  400138:	3a8000ef          	jal	ra,4004e0 <paint_row>
        for (int j = 0; j < HEIGHT-1; j++){
  40013c:	00140413          	addi	s0,s0,1
  400140:	00448493          	addi	s1,s1,4
  400144:	ff4416e3          	bne	s0,s4,400130 <main+0x114>
        }
        tetris_god_senpai();
  400148:	021000ef          	jal	ra,400968 <tetris_god_senpai>
    while(1){
  40014c:	fadff06f          	j	4000f8 <main+0xdc>

00400150 <abs>:
 */

#include "lib.h"

// returns absolute value of its integer argument - a replacement of the standard library function abs() 
inline int abs(int n) { return (n < 0) ? (-n) : n; }
  400150:	41f55793          	srai	a5,a0,0x1f
  400154:	00a7c533          	xor	a0,a5,a0
  400158:	40f50533          	sub	a0,a0,a5
  40015c:	00008067          	ret

00400160 <printchar>:

// prints single character to console - a substitute for the standard library funciton putch(int chr)
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400160:	ffff07b7          	lui	a5,0xffff0
  400164:	00a7a623          	sw	a0,12(a5) # ffff000c <__stack_init+0xeffe0010>
  400168:	00008067          	ret

0040016c <println>:
  40016c:	ffff07b7          	lui	a5,0xffff0
  400170:	00a00713          	li	a4,10
  400174:	00e7a623          	sw	a4,12(a5) # ffff000c <__stack_init+0xeffe0010>

// prints newline character to console
void println() { printchar('\n'); }
  400178:	00008067          	ret

0040017c <printstr>:

// prints given string of characters to console - a substitute for the standard library function puts(char *s)
void printstr(char *str)
{
    while (*str != '\0') 
  40017c:	00054783          	lbu	a5,0(a0)
  400180:	00078c63          	beqz	a5,400198 <printstr+0x1c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400184:	ffff0737          	lui	a4,0xffff0
  400188:	00f72623          	sw	a5,12(a4) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(*str);
        str += 1;
  40018c:	00150513          	addi	a0,a0,1
    while (*str != '\0') 
  400190:	00054783          	lbu	a5,0(a0)
  400194:	fe079ae3          	bnez	a5,400188 <printstr+0xc>
    }
}
  400198:	00008067          	ret

0040019c <printint>:

// prints given integer as a signed decimal number
void printint(int n)
{
  40019c:	ff010113          	addi	sp,sp,-16
    {
        sign = '-';
    }
    else
    {
        sign = '\0';
  4001a0:	41f55813          	srai	a6,a0,0x1f
  4001a4:	02d87813          	andi	a6,a6,45
  4001a8:	00410713          	addi	a4,sp,4
  4001ac:	00900613          	li	a2,9
    
    // produce decimal digits of the number going from right to left, keep them in num[] array.
    do 
    {
        i = i - 1;
        num[i] = abs(n % 10) + '0';
  4001b0:	00a00593          	li	a1,10
        i = i - 1;
  4001b4:	fff60613          	addi	a2,a2,-1
        num[i] = abs(n % 10) + '0';
  4001b8:	02b567b3          	rem	a5,a0,a1
  4001bc:	41f7d693          	srai	a3,a5,0x1f
  4001c0:	00f6c7b3          	xor	a5,a3,a5
  4001c4:	40d787b3          	sub	a5,a5,a3
  4001c8:	03078793          	addi	a5,a5,48
  4001cc:	00f70423          	sb	a5,8(a4)
        n = n / 10;
  4001d0:	02b54533          	div	a0,a0,a1
    } while (n != 0);
  4001d4:	fff70713          	addi	a4,a4,-1
  4001d8:	fc051ee3          	bnez	a0,4001b4 <printint+0x18>
    
    //now print the sign of the number and its digits left-to-right.
    if (sign) 
  4001dc:	00080663          	beqz	a6,4001e8 <printint+0x4c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  4001e0:	ffff07b7          	lui	a5,0xffff0
  4001e4:	0107a623          	sw	a6,12(a5) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(sign);
    }
    
    while(i < MAX_INT_DIGITS)
  4001e8:	00900793          	li	a5,9
  4001ec:	02c7c263          	blt	a5,a2,400210 <printint+0x74>
  4001f0:	00410793          	addi	a5,sp,4
  4001f4:	00c787b3          	add	a5,a5,a2
  4001f8:	00e10693          	addi	a3,sp,14
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  4001fc:	ffff0637          	lui	a2,0xffff0
  400200:	0007c703          	lbu	a4,0(a5)
  400204:	00e62623          	sw	a4,12(a2) # ffff000c <__stack_init+0xeffe0010>
    while(i < MAX_INT_DIGITS)
  400208:	00178793          	addi	a5,a5,1
  40020c:	fed79ae3          	bne	a5,a3,400200 <printint+0x64>
    {
        printchar(num[i]);
        i=i+1;
    }
}
  400210:	01010113          	addi	sp,sp,16
  400214:	00008067          	ret

00400218 <pollkbd>:


// check if keyboard buffer has some data
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400218:	ffff07b7          	lui	a5,0xffff0
  40021c:	0007a503          	lw	a0,0(a5) # ffff0000 <__stack_init+0xeffe0004>
  400220:	00008067          	ret

00400224 <readchar>:

// read next character from keyboard buffer
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  400224:	ffff07b7          	lui	a5,0xffff0
  400228:	0047a503          	lw	a0,4(a5) # ffff0004 <__stack_init+0xeffe0008>
  40022c:	00008067          	ret

00400230 <readstr>:

// read characters into provided buffer until either user presses enter or the buffer size is reached.
int readstr(char *buf, int size)
{
  400230:	00050693          	mv	a3,a0
    int count;
    
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  400234:	00100793          	li	a5,1
  400238:	04b7d263          	bge	a5,a1,40027c <readstr+0x4c>
  40023c:	fff58613          	addi	a2,a1,-1
    
    count = 0;
  400240:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400244:	ffff0737          	lui	a4,0xffff0
       
       // read next character into the current element of the buffer
       *buf = (char)readchar();
       
       // if the user pressed Enter, stop reading
       if (*buf == '\n') 
  400248:	00a00593          	li	a1,10
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  40024c:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  400250:	fe078ee3          	beqz	a5,40024c <readstr+0x1c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  400254:	00472783          	lw	a5,4(a4)
       *buf = (char)readchar();
  400258:	0ff7f793          	andi	a5,a5,255
  40025c:	00f68023          	sb	a5,0(a3)
       if (*buf == '\n') 
  400260:	00b78a63          	beq	a5,a1,400274 <readstr+0x44>
       {
           break;
       }
       
       // move pointer to the next element of the buffer
       buf += 1;
  400264:	00168693          	addi	a3,a3,1
       
       // increase the number of characters in the buffer
       count += 1;
  400268:	00150513          	addi	a0,a0,1
       
       // decrease the remaining space in the buffer
       size -= 1;
       
    } while(size > 1);  // keep going until one empty char remains (to hold the final '\0' character
  40026c:	fec510e3          	bne	a0,a2,40024c <readstr+0x1c>
       count += 1;
  400270:	00060513          	mv	a0,a2
    
    *buf = '\0';  // add the end-of-string marker '\0'
  400274:	00068023          	sb	zero,0(a3)
    
    return count; // return the number of characters in the read string
  400278:	00008067          	ret
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  40027c:	fff00513          	li	a0,-1
}
  400280:	00008067          	ret

00400284 <readint>:

//read signed integer
int readint()
{
    int res = 0;
    int sign = 1;
  400284:	00100593          	li	a1,1
    int res = 0;
  400288:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  40028c:	ffff0737          	lui	a4,0xffff0
           sign = -1;
       }
       else
       {
           // otherwise, if a non-digit is read, it signifies the end of the number
           if (chr < '0' || chr > '9') 
  400290:	00900613          	li	a2,9
       if (res == 0 && sign == 1 && chr == '-') 
  400294:	00100813          	li	a6,1
  400298:	02d00893          	li	a7,45
           sign = -1;
  40029c:	fff00313          	li	t1,-1
  4002a0:	0200006f          	j	4002c0 <readint+0x3c>
           if (chr < '0' || chr > '9') 
  4002a4:	fd068793          	addi	a5,a3,-48
  4002a8:	02f66c63          	bltu	a2,a5,4002e0 <readint+0x5c>
           {
               break;
           }
           // incorporate the read digit into the number (N.B. chr - '0' gived the digit value).
           res = res * 10 + (chr - '0');
  4002ac:	00251793          	slli	a5,a0,0x2
  4002b0:	00a787b3          	add	a5,a5,a0
  4002b4:	00179793          	slli	a5,a5,0x1
  4002b8:	fd068693          	addi	a3,a3,-48
  4002bc:	00f68533          	add	a0,a3,a5
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  4002c0:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  4002c4:	fe078ee3          	beqz	a5,4002c0 <readint+0x3c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  4002c8:	00472683          	lw	a3,4(a4)
       if (res == 0 && sign == 1 && chr == '-') 
  4002cc:	fc051ce3          	bnez	a0,4002a4 <readint+0x20>
  4002d0:	fd059ae3          	bne	a1,a6,4002a4 <readint+0x20>
  4002d4:	fd1698e3          	bne	a3,a7,4002a4 <readint+0x20>
           sign = -1;
  4002d8:	00030593          	mv	a1,t1
  4002dc:	fe5ff06f          	j	4002c0 <readint+0x3c>
       }
    }
    
    // return the absolute value of the number (constructed from entered digits) multiplied by the sign.
    return sign * res;
}
  4002e0:	02b50533          	mul	a0,a0,a1
  4002e4:	00008067          	ret

004002e8 <showpic>:
    # as long as this function is not calling other functions.
    
    .globl showpic
    
showpic:
    li t0,0xffff8000    # starting address of the graphics display
  4002e8:	ffff82b7          	lui	t0,0xffff8
    li t1,32            # number of lines on the display (each word encodes one line) 
  4002ec:	02000313          	li	t1,32

004002f0 <loop>:
loop:
    lw t2,0(a0)         # load next line (word) of the picture data
  4002f0:	00052383          	lw	t2,0(a0)
    sw t2,0(t0)         # write it to the corresponding line of the graphics display
  4002f4:	0072a023          	sw	t2,0(t0) # ffff8000 <__stack_init+0xeffe8004>
    addi t0,t0,4        # move to the next line of the graphics display
  4002f8:	00428293          	addi	t0,t0,4
    addi a0,a0,4        # move to the next line of the picture data
  4002fc:	00450513          	addi	a0,a0,4
    addi t1,t1,-1       # reduce the number of remaining lines
  400300:	fff30313          	addi	t1,t1,-1
    bnez t1,loop        # keep going until all lines on the display are filled with data
  400304:	fe0316e3          	bnez	t1,4002f0 <loop>
    jr ra               # return 
  400308:	00008067          	ret

0040030c <initseed>:
   	# the seed should only be set once at the start of the program
   	# otherwise you can accidentally always get the same number
	.global initseed

initseed:
	la t0, seed		# load address of seed to t0
  40030c:	00000297          	auipc	t0,0x0
  400310:	6e028293          	addi	t0,t0,1760 # 4009ec <seed>
	li t5, 0x1234		# write-enable signal value
  400314:	00001f37          	lui	t5,0x1
  400318:	234f0f13          	addi	t5,t5,564 # 1234 <_start-0x3fedcc>
	sw t5, 0(t0)		# enable writing to seed location
  40031c:	01e2a023          	sw	t5,0(t0)
	sw a0, 0(t0)		# load input seed to memory	
  400320:	00a2a023          	sw	a0,0(t0)
	jr ra
  400324:	00008067          	ret

00400328 <random>:
	
	.global random
	
random:
	la t0, seed		# load address of seed to t0
  400328:	00000297          	auipc	t0,0x0
  40032c:	6c428293          	addi	t0,t0,1732 # 4009ec <seed>
	lw t1, 0(t0)		# load seed to t1
  400330:	0002a303          	lw	t1,0(t0)
	mv t1, sp		
  400334:	00010313          	mv	t1,sp

00400338 <roll>:
	
roll:
	slli t2, t1, 1		# shift seed to the left and store in t2
  400338:	00131393          	slli	t2,t1,0x1
	xor t1, t2, t1		# xor bits in t1 and t2 for a pseudo random number
  40033c:	0063c333          	xor	t1,t2,t1
	andi a0, t1, 0x700	# extract 3 bit random number from t1 using mask 0000011100000000
  400340:	70037513          	andi	a0,t1,1792
	srli a0, a0, 8		# shift bits in t4 to the right so they are the least significant digits
  400344:	00855513          	srli	a0,a0,0x8
	beqz a0, roll		# reroll if equal to 0 
  400348:	fe0508e3          	beqz	a0,400338 <roll>
	sw t1, 0(t0)		# set new seed with value of t1
  40034c:	0062a023          	sw	t1,0(t0)
	jr ra 			# return
  400350:	00008067          	ret

00400354 <apply_mask>:

// copy the contents of the current_piecem to the position in the mask indicated by piece_row and piece_col
void apply_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = current_piecem[i-piece_row]; // mask row equal current piece row
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400354:	100007b7          	lui	a5,0x10000
  400358:	0e87a783          	lw	a5,232(a5) # 100000e8 <piece_col>
  40035c:	00800593          	li	a1,8
  400360:	40f585b3          	sub	a1,a1,a5
  400364:	100007b7          	lui	a5,0x10000
  400368:	00078793          	mv	a5,a5
  40036c:	01078613          	addi	a2,a5,16 # 10000010 <piece_mask>
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400370:	10000737          	lui	a4,0x10000
  400374:	0ec72703          	lw	a4,236(a4) # 100000ec <piece_row>
  400378:	00271713          	slli	a4,a4,0x2
  40037c:	00e60733          	add	a4,a2,a4
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400380:	0007a683          	lw	a3,0(a5)
  400384:	00b696b3          	sll	a3,a3,a1
  400388:	00d72023          	sw	a3,0(a4)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40038c:	00478793          	addi	a5,a5,4
  400390:	00470713          	addi	a4,a4,4
  400394:	fec796e3          	bne	a5,a2,400380 <apply_mask+0x2c>
    }
}
  400398:	00008067          	ret

0040039c <reset_mask>:

void reset_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40039c:	100007b7          	lui	a5,0x10000
  4003a0:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  4003a4:	00269693          	slli	a3,a3,0x2
  4003a8:	10000737          	lui	a4,0x10000
  4003ac:	00070713          	mv	a4,a4
  4003b0:	01070793          	addi	a5,a4,16 # 10000010 <piece_mask>
  4003b4:	00d787b3          	add	a5,a5,a3
  4003b8:	02070713          	addi	a4,a4,32
  4003bc:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 12;
  4003c0:	0007a703          	lw	a4,0(a5)
  4003c4:	40c75713          	srai	a4,a4,0xc
  4003c8:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4003cc:	00478793          	addi	a5,a5,4
  4003d0:	fed798e3          	bne	a5,a3,4003c0 <reset_mask+0x24>
    }
}
  4003d4:	00008067          	ret

004003d8 <initialize>:

void initialize(){
  4003d8:	ff010113          	addi	sp,sp,-16
  4003dc:	00112623          	sw	ra,12(sp)
    piece_index = 0;
  4003e0:	100007b7          	lui	a5,0x10000
  4003e4:	0e07a823          	sw	zero,240(a5) # 100000f0 <piece_index>
    piece_row = 16;
  4003e8:	100007b7          	lui	a5,0x10000
  4003ec:	01000713          	li	a4,16
  4003f0:	0ee7a623          	sw	a4,236(a5) # 100000ec <piece_row>
    piece_col = 6;
  4003f4:	100007b7          	lui	a5,0x10000
  4003f8:	00600713          	li	a4,6
  4003fc:	0ee7a423          	sw	a4,232(a5) # 100000e8 <piece_col>
    // set the play area to its initial state
    play_area[0] = 0b111111111111;
  400400:	10000737          	lui	a4,0x10000
  400404:	00070713          	mv	a4,a4
  400408:	000017b7          	lui	a5,0x1
  40040c:	fff78793          	addi	a5,a5,-1 # fff <_start-0x3ff001>
  400410:	06f72a23          	sw	a5,116(a4) # 10000074 <play_area>
    play_area[1] = 0b111111111111;
  400414:	06f72c23          	sw	a5,120(a4)
    play_area[2] = 0b111111111111;
  400418:	06f72e23          	sw	a5,124(a4)
    play_area[3] = 0b111111111111;
  40041c:	08f72023          	sw	a5,128(a4)
    for (int i = 4; i < HEIGHT-1; i++){
  400420:	08470793          	addi	a5,a4,132
  400424:	0d470713          	addi	a4,a4,212
        play_area[i] = 0b100000000001;
  400428:	000016b7          	lui	a3,0x1
  40042c:	80168693          	addi	a3,a3,-2047 # 801 <_start-0x3ff7ff>
  400430:	00d7a023          	sw	a3,0(a5)
    for (int i = 4; i < HEIGHT-1; i++){
  400434:	00478793          	addi	a5,a5,4
  400438:	fee79ce3          	bne	a5,a4,400430 <initialize+0x58>
    }
    play_area[HEIGHT-4] = 0b111111100111;
  40043c:	100007b7          	lui	a5,0x10000
  400440:	00078793          	mv	a5,a5
  400444:	00001737          	lui	a4,0x1
  400448:	fe770693          	addi	a3,a4,-25 # fe7 <_start-0x3ff019>
  40044c:	0cd7a423          	sw	a3,200(a5) # 100000c8 <play_area+0x54>
    play_area[HEIGHT-3] = 0b111111110111;
  400450:	ff770613          	addi	a2,a4,-9
  400454:	0cc7a623          	sw	a2,204(a5)
    play_area[HEIGHT-2] = 0b111111100111;
  400458:	0cd7a823          	sw	a3,208(a5)
    play_area[HEIGHT-1] = 0b111111111111;
  40045c:	fff70713          	addi	a4,a4,-1
  400460:	0ce7aa23          	sw	a4,212(a5)
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
  400464:	00401737          	lui	a4,0x401
  400468:	9f070713          	addi	a4,a4,-1552 # 4009f0 <pieces>
  40046c:	00072683          	lw	a3,0(a4)
  400470:	00d7a023          	sw	a3,0(a5)
  400474:	00472683          	lw	a3,4(a4)
  400478:	00d7a223          	sw	a3,4(a5)
  40047c:	00872683          	lw	a3,8(a4)
  400480:	00d7a423          	sw	a3,8(a5)
  400484:	00c72703          	lw	a4,12(a4)
  400488:	00e7a623          	sw	a4,12(a5)
    }
    apply_mask();
  40048c:	ec9ff0ef          	jal	ra,400354 <apply_mask>
}
  400490:	00c12083          	lw	ra,12(sp)
  400494:	01010113          	addi	sp,sp,16
  400498:	00008067          	ret

0040049c <change_piece>:

void change_piece(){
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
  40049c:	100007b7          	lui	a5,0x10000
  4004a0:	0f07a783          	lw	a5,240(a5) # 100000f0 <piece_index>
  4004a4:	10000737          	lui	a4,0x10000
  4004a8:	00070713          	mv	a4,a4
  4004ac:	00479693          	slli	a3,a5,0x4
  4004b0:	004017b7          	lui	a5,0x401
  4004b4:	9f078793          	addi	a5,a5,-1552 # 4009f0 <pieces>
  4004b8:	00d787b3          	add	a5,a5,a3
  4004bc:	0007a683          	lw	a3,0(a5)
  4004c0:	00d72023          	sw	a3,0(a4) # 10000000 <current_piecem>
  4004c4:	0047a683          	lw	a3,4(a5)
  4004c8:	00d72223          	sw	a3,4(a4)
  4004cc:	0087a683          	lw	a3,8(a5)
  4004d0:	00d72423          	sw	a3,8(a4)
  4004d4:	00c7a783          	lw	a5,12(a5)
  4004d8:	00f72623          	sw	a5,12(a4)
    }
}
  4004dc:	00008067          	ret

004004e0 <paint_row>:
#include "display.h"
#include "shapes.h"

void paint_row(int row, int row_num){
        *((volatile int *)(0xffff8000 + row_num*4)) = row;
  4004e0:	00259593          	slli	a1,a1,0x2
  4004e4:	ffff87b7          	lui	a5,0xffff8
  4004e8:	00f585b3          	add	a1,a1,a5
  4004ec:	00a5a023          	sw	a0,0(a1)
}
  4004f0:	00008067          	ret

004004f4 <bit_or_matrix>:
#include "matrix.h"
#include "lib.h"
#include "shapes.h"

void bit_or_matrix(int size, int matrix1[size], int matrix2[size], int result[size]){
    for (int i = 0; i < size; i++) {
  4004f4:	02a05863          	blez	a0,400524 <bit_or_matrix+0x30>
  4004f8:	00058793          	mv	a5,a1
  4004fc:	00251513          	slli	a0,a0,0x2
  400500:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] | matrix2[i];
  400504:	0007a703          	lw	a4,0(a5) # ffff8000 <__stack_init+0xeffe8004>
  400508:	00062583          	lw	a1,0(a2)
  40050c:	00b76733          	or	a4,a4,a1
  400510:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  400514:	00478793          	addi	a5,a5,4
  400518:	00460613          	addi	a2,a2,4
  40051c:	00468693          	addi	a3,a3,4
  400520:	fea792e3          	bne	a5,a0,400504 <bit_or_matrix+0x10>
    }
}
  400524:	00008067          	ret

00400528 <bit_and_matrix>:

void bit_and_matrix(int size, int matrix1[size], int matrix2[size], int result[size]){
    for (int i = 0; i < size; i++) {
  400528:	02a05863          	blez	a0,400558 <bit_and_matrix+0x30>
  40052c:	00058793          	mv	a5,a1
  400530:	00251513          	slli	a0,a0,0x2
  400534:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] & matrix2[i];
  400538:	0007a703          	lw	a4,0(a5)
  40053c:	00062583          	lw	a1,0(a2)
  400540:	00b77733          	and	a4,a4,a1
  400544:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  400548:	00478793          	addi	a5,a5,4
  40054c:	00460613          	addi	a2,a2,4
  400550:	00468693          	addi	a3,a3,4
  400554:	fea792e3          	bne	a5,a0,400538 <bit_and_matrix+0x10>
    }
}
  400558:	00008067          	ret

0040055c <mv_piece_l>:
#include "shapes.h"
#include "matrix.h"
#include "physics.h"
#include "lib.h"

void mv_piece_l(){
  40055c:	ff010113          	addi	sp,sp,-16
  400560:	00112623          	sw	ra,12(sp)
  400564:	00812423          	sw	s0,8(sp)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400568:	100007b7          	lui	a5,0x10000
  40056c:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  400570:	00269693          	slli	a3,a3,0x2
  400574:	10000737          	lui	a4,0x10000
  400578:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  40057c:	00e687b3          	add	a5,a3,a4
  400580:	01070413          	addi	s0,a4,16
  400584:	008686b3          	add	a3,a3,s0
        piece_mask[i] = piece_mask[i] << 1;
  400588:	0007a703          	lw	a4,0(a5)
  40058c:	00171713          	slli	a4,a4,0x1
  400590:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400594:	00478793          	addi	a5,a5,4
  400598:	fed798e3          	bne	a5,a3,400588 <mv_piece_l+0x2c>
    }
	
	if (colision_check_wall()) {
  40059c:	2ac000ef          	jal	ra,400848 <colision_check_wall>
  4005a0:	02051263          	bnez	a0,4005c4 <mv_piece_l+0x68>
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
			piece_mask[i] = piece_mask[i] >> 1;
		}
	}
	else {
		piece_col -= 1;
  4005a4:	10000737          	lui	a4,0x10000
  4005a8:	0e872783          	lw	a5,232(a4) # 100000e8 <piece_col>
  4005ac:	fff78793          	addi	a5,a5,-1
  4005b0:	0ef72423          	sw	a5,232(a4)
	}
}
  4005b4:	00c12083          	lw	ra,12(sp)
  4005b8:	00812403          	lw	s0,8(sp)
  4005bc:	01010113          	addi	sp,sp,16
  4005c0:	00008067          	ret
		printint(1);
  4005c4:	00100513          	li	a0,1
  4005c8:	bd5ff0ef          	jal	ra,40019c <printint>
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4005cc:	100007b7          	lui	a5,0x10000
  4005d0:	0ec7a703          	lw	a4,236(a5) # 100000ec <piece_row>
  4005d4:	00271713          	slli	a4,a4,0x2
  4005d8:	100007b7          	lui	a5,0x10000
  4005dc:	01078793          	addi	a5,a5,16 # 10000010 <piece_mask>
  4005e0:	00f707b3          	add	a5,a4,a5
  4005e4:	00870433          	add	s0,a4,s0
			piece_mask[i] = piece_mask[i] >> 1;
  4005e8:	0007a703          	lw	a4,0(a5)
  4005ec:	40175713          	srai	a4,a4,0x1
  4005f0:	00e7a023          	sw	a4,0(a5)
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4005f4:	00478793          	addi	a5,a5,4
  4005f8:	fe8798e3          	bne	a5,s0,4005e8 <mv_piece_l+0x8c>
  4005fc:	fb9ff06f          	j	4005b4 <mv_piece_l+0x58>

00400600 <mv_piece_r>:
void mv_piece_r(){
  400600:	ff010113          	addi	sp,sp,-16
  400604:	00112623          	sw	ra,12(sp)
  400608:	00812423          	sw	s0,8(sp)
	printint(1);
  40060c:	00100513          	li	a0,1
  400610:	b8dff0ef          	jal	ra,40019c <printint>
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400614:	100007b7          	lui	a5,0x10000
  400618:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  40061c:	00269693          	slli	a3,a3,0x2
  400620:	10000737          	lui	a4,0x10000
  400624:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  400628:	00e687b3          	add	a5,a3,a4
  40062c:	01070413          	addi	s0,a4,16
  400630:	008686b3          	add	a3,a3,s0
        piece_mask[i] = piece_mask[i] >> 1;
  400634:	0007a703          	lw	a4,0(a5)
  400638:	40175713          	srai	a4,a4,0x1
  40063c:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400640:	00478793          	addi	a5,a5,4
  400644:	fed798e3          	bne	a5,a3,400634 <mv_piece_r+0x34>
    }
	if (colision_check_wall()) {
  400648:	200000ef          	jal	ra,400848 <colision_check_wall>
  40064c:	02050c63          	beqz	a0,400684 <mv_piece_r+0x84>
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400650:	100007b7          	lui	a5,0x10000
  400654:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  400658:	00269693          	slli	a3,a3,0x2
  40065c:	100007b7          	lui	a5,0x10000
  400660:	01078793          	addi	a5,a5,16 # 10000010 <piece_mask>
  400664:	00f687b3          	add	a5,a3,a5
  400668:	008686b3          	add	a3,a3,s0
			piece_mask[i] = piece_mask[i] << 1;
  40066c:	0007a703          	lw	a4,0(a5)
  400670:	00171713          	slli	a4,a4,0x1
  400674:	00e7a023          	sw	a4,0(a5)
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400678:	00478793          	addi	a5,a5,4
  40067c:	fed798e3          	bne	a5,a3,40066c <mv_piece_r+0x6c>
  400680:	0140006f          	j	400694 <mv_piece_r+0x94>
		}
	}
	else{
		piece_col += 1;		
  400684:	10000737          	lui	a4,0x10000
  400688:	0e872783          	lw	a5,232(a4) # 100000e8 <piece_col>
  40068c:	00178793          	addi	a5,a5,1
  400690:	0ef72423          	sw	a5,232(a4)
	}
}
  400694:	00c12083          	lw	ra,12(sp)
  400698:	00812403          	lw	s0,8(sp)
  40069c:	01010113          	addi	sp,sp,16
  4006a0:	00008067          	ret

004006a4 <mv_piece_d>:
void mv_piece_d(){
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  4006a4:	100007b7          	lui	a5,0x10000
  4006a8:	0ec7a603          	lw	a2,236(a5) # 100000ec <piece_row>
  4006ac:	00261693          	slli	a3,a2,0x2
  4006b0:	10000737          	lui	a4,0x10000
  4006b4:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  4006b8:	00e687b3          	add	a5,a3,a4
  4006bc:	fec70713          	addi	a4,a4,-20
  4006c0:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i-1];
  4006c4:	00c7a683          	lw	a3,12(a5)
  4006c8:	00d7a823          	sw	a3,16(a5)
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  4006cc:	ffc78793          	addi	a5,a5,-4
  4006d0:	fee79ae3          	bne	a5,a4,4006c4 <mv_piece_d+0x20>
    }
    piece_row += 1;
  4006d4:	00160613          	addi	a2,a2,1
  4006d8:	100007b7          	lui	a5,0x10000
  4006dc:	0ec7a623          	sw	a2,236(a5) # 100000ec <piece_row>
}
  4006e0:	00008067          	ret

004006e4 <mv_piece_u>:
void mv_piece_u(){
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  4006e4:	100007b7          	lui	a5,0x10000
  4006e8:	0ec7a703          	lw	a4,236(a5) # 100000ec <piece_row>
  4006ec:	fff70613          	addi	a2,a4,-1
  4006f0:	00271693          	slli	a3,a4,0x2
  4006f4:	10000737          	lui	a4,0x10000
  4006f8:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  4006fc:	00e687b3          	add	a5,a3,a4
  400700:	01470713          	addi	a4,a4,20
  400704:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i+1];
  400708:	0007a683          	lw	a3,0(a5)
  40070c:	fed7ae23          	sw	a3,-4(a5)
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  400710:	00478793          	addi	a5,a5,4
  400714:	fee79ae3          	bne	a5,a4,400708 <mv_piece_u+0x24>
    }
    piece_row -= 1;
  400718:	100007b7          	lui	a5,0x10000
  40071c:	0ec7a623          	sw	a2,236(a5) # 100000ec <piece_row>
}
  400720:	00008067          	ret

00400724 <r_piece_cw>:
void r_piece_cw(){
  400724:	ff010113          	addi	sp,sp,-16
  400728:	00112623          	sw	ra,12(sp)
    piece_index = rotational_vector[piece_index];
  40072c:	100006b7          	lui	a3,0x10000
  400730:	0f06a783          	lw	a5,240(a3) # 100000f0 <piece_index>
  400734:	00279713          	slli	a4,a5,0x2
  400738:	004017b7          	lui	a5,0x401
  40073c:	b2078793          	addi	a5,a5,-1248 # 400b20 <rotational_vector>
  400740:	00e787b3          	add	a5,a5,a4
  400744:	0007a783          	lw	a5,0(a5)
  400748:	0ef6a823          	sw	a5,240(a3)
    change_piece();
  40074c:	d51ff0ef          	jal	ra,40049c <change_piece>
    reset_mask();
  400750:	c4dff0ef          	jal	ra,40039c <reset_mask>
    apply_mask(current_piecem);
  400754:	10000537          	lui	a0,0x10000
  400758:	00050513          	mv	a0,a0
  40075c:	bf9ff0ef          	jal	ra,400354 <apply_mask>
	if (colision_check_wall()) {
  400760:	0e8000ef          	jal	ra,400848 <colision_check_wall>
  400764:	00051863          	bnez	a0,400774 <r_piece_cw+0x50>
		reset_mask();
		apply_mask(current_piecem);
	}
	
	
}
  400768:	00c12083          	lw	ra,12(sp)
  40076c:	01010113          	addi	sp,sp,16
  400770:	00008067          	ret
		piece_index = rotational_vector[piece_index];
  400774:	100006b7          	lui	a3,0x10000
  400778:	004017b7          	lui	a5,0x401
  40077c:	b2078793          	addi	a5,a5,-1248 # 400b20 <rotational_vector>
		piece_index = rotational_vector[piece_index];
  400780:	0f06a703          	lw	a4,240(a3) # 100000f0 <piece_index>
  400784:	00271713          	slli	a4,a4,0x2
  400788:	00e78733          	add	a4,a5,a4
		piece_index = rotational_vector[piece_index];
  40078c:	00072703          	lw	a4,0(a4)
  400790:	00271713          	slli	a4,a4,0x2
  400794:	00e78733          	add	a4,a5,a4
		piece_index = rotational_vector[piece_index];
  400798:	00072703          	lw	a4,0(a4)
  40079c:	00271713          	slli	a4,a4,0x2
  4007a0:	00e787b3          	add	a5,a5,a4
  4007a4:	0007a783          	lw	a5,0(a5)
  4007a8:	0ef6a823          	sw	a5,240(a3)
		change_piece();
  4007ac:	cf1ff0ef          	jal	ra,40049c <change_piece>
		reset_mask();
  4007b0:	bedff0ef          	jal	ra,40039c <reset_mask>
		apply_mask(current_piecem);
  4007b4:	10000537          	lui	a0,0x10000
  4007b8:	00050513          	mv	a0,a0
  4007bc:	b99ff0ef          	jal	ra,400354 <apply_mask>
}
  4007c0:	fa9ff06f          	j	400768 <r_piece_cw+0x44>

004007c4 <colision_check>:
#include "shapes.h"
#include "matrix.h"
#include "buttons.h"

// checks for colision between the falling piece and the blocks in the playing area
int colision_check(){
  4007c4:	ff010113          	addi	sp,sp,-16
  4007c8:	00112623          	sw	ra,12(sp)
  4007cc:	00812423          	sw	s0,8(sp)
  4007d0:	00912223          	sw	s1,4(sp)
    int ret_val;
    mv_piece_d(); // move piece down to check for future colisions
  4007d4:	ed1ff0ef          	jal	ra,4006a4 <mv_piece_d>
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  4007d8:	100007b7          	lui	a5,0x10000
  4007dc:	0ec7a783          	lw	a5,236(a5) # 100000ec <piece_row>
  4007e0:	00279793          	slli	a5,a5,0x2
  4007e4:	100006b7          	lui	a3,0x10000
  4007e8:	0d868493          	addi	s1,a3,216 # 100000d8 <result>
  4007ec:	0d868693          	addi	a3,a3,216
  4007f0:	10000637          	lui	a2,0x10000
  4007f4:	07460613          	addi	a2,a2,116 # 10000074 <play_area>
  4007f8:	00f60633          	add	a2,a2,a5
  4007fc:	100005b7          	lui	a1,0x10000
  400800:	01058593          	addi	a1,a1,16 # 10000010 <piece_mask>
  400804:	00f585b3          	add	a1,a1,a5
  400808:	00400513          	li	a0,4
  40080c:	d1dff0ef          	jal	ra,400528 <bit_and_matrix>
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
  400810:	0004a403          	lw	s0,0(s1)
  400814:	0044a783          	lw	a5,4(s1)
  400818:	00f46433          	or	s0,s0,a5
  40081c:	0084a783          	lw	a5,8(s1)
  400820:	00f46433          	or	s0,s0,a5
  400824:	00c4a783          	lw	a5,12(s1)
  400828:	00f46433          	or	s0,s0,a5
    }
    mv_piece_u(); // move piece up to its original position
  40082c:	eb9ff0ef          	jal	ra,4006e4 <mv_piece_u>
    return ret_val;
}
  400830:	00040513          	mv	a0,s0
  400834:	00c12083          	lw	ra,12(sp)
  400838:	00812403          	lw	s0,8(sp)
  40083c:	00412483          	lw	s1,4(sp)
  400840:	01010113          	addi	sp,sp,16
  400844:	00008067          	ret

00400848 <colision_check_wall>:

int colision_check_wall(){
  400848:	ff010113          	addi	sp,sp,-16
  40084c:	00112623          	sw	ra,12(sp)
  400850:	00812423          	sw	s0,8(sp)
    int ret_val;
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  400854:	100007b7          	lui	a5,0x10000
  400858:	0ec7a783          	lw	a5,236(a5) # 100000ec <piece_row>
  40085c:	00279793          	slli	a5,a5,0x2
  400860:	100006b7          	lui	a3,0x10000
  400864:	0d868413          	addi	s0,a3,216 # 100000d8 <result>
  400868:	0d868693          	addi	a3,a3,216
  40086c:	10000637          	lui	a2,0x10000
  400870:	07460613          	addi	a2,a2,116 # 10000074 <play_area>
  400874:	00f60633          	add	a2,a2,a5
  400878:	100005b7          	lui	a1,0x10000
  40087c:	01058593          	addi	a1,a1,16 # 10000010 <piece_mask>
  400880:	00f585b3          	add	a1,a1,a5
  400884:	00400513          	li	a0,4
  400888:	ca1ff0ef          	jal	ra,400528 <bit_and_matrix>
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
  40088c:	00042783          	lw	a5,0(s0)
  400890:	00442503          	lw	a0,4(s0)
  400894:	00a7e7b3          	or	a5,a5,a0
  400898:	00842503          	lw	a0,8(s0)
  40089c:	00a7e7b3          	or	a5,a5,a0
  4008a0:	00c42503          	lw	a0,12(s0)
    }
    return ret_val;
}
  4008a4:	00a7e533          	or	a0,a5,a0
  4008a8:	00c12083          	lw	ra,12(sp)
  4008ac:	00812403          	lw	s0,8(sp)
  4008b0:	01010113          	addi	sp,sp,16
  4008b4:	00008067          	ret

004008b8 <consolidate_rows>:

int consolidate_rows(){
  4008b8:	ff010113          	addi	sp,sp,-16
  4008bc:	00112623          	sw	ra,12(sp)
    // add each of the 4 rows where the piece is to the play area
    bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
  4008c0:	100007b7          	lui	a5,0x10000
  4008c4:	0ec7a783          	lw	a5,236(a5) # 100000ec <piece_row>
  4008c8:	00279793          	slli	a5,a5,0x2
  4008cc:	10000637          	lui	a2,0x10000
  4008d0:	07460613          	addi	a2,a2,116 # 10000074 <play_area>
  4008d4:	00c78633          	add	a2,a5,a2
  4008d8:	00060693          	mv	a3,a2
  4008dc:	100005b7          	lui	a1,0x10000
  4008e0:	01058593          	addi	a1,a1,16 # 10000010 <piece_mask>
  4008e4:	00f585b3          	add	a1,a1,a5
  4008e8:	00400513          	li	a0,4
  4008ec:	c09ff0ef          	jal	ra,4004f4 <bit_or_matrix>
}
  4008f0:	00c12083          	lw	ra,12(sp)
  4008f4:	01010113          	addi	sp,sp,16
  4008f8:	00008067          	ret

004008fc <clear_rows>:



int clear_rows(){
    int points = 0;
    for (int i = HEIGHT-2; i > 4; i--){ // check each of the 4 rows where the piece is
  4008fc:	10000737          	lui	a4,0x10000
  400900:	0d070713          	addi	a4,a4,208 # 100000d0 <play_area+0x5c>
  400904:	01700693          	li	a3,23
    int points = 0;
  400908:	00000513          	li	a0,0
        if (play_area[i] == 4095){ // 4095 = column of all 1s
  40090c:	00001e37          	lui	t3,0x1
  400910:	fffe0893          	addi	a7,t3,-1 # fff <_start-0x3ff001>
            points++;
            // this will break when the piece is off screen @@@@@@@@@@@@@
            for (int j = i; j > 4; j--){
  400914:	00400813          	li	a6,4
                play_area[j] = play_area[j-1];
            }
            play_area[4] = 0b100000000001;
  400918:	10000337          	lui	t1,0x10000
  40091c:	07430313          	addi	t1,t1,116 # 10000074 <play_area>
  400920:	801e0e13          	addi	t3,t3,-2047
  400924:	01030593          	addi	a1,t1,16
  400928:	0140006f          	j	40093c <clear_rows+0x40>
  40092c:	01c32823          	sw	t3,16(t1)
    for (int i = HEIGHT-2; i > 4; i--){ // check each of the 4 rows where the piece is
  400930:	fff68693          	addi	a3,a3,-1
  400934:	ffc70713          	addi	a4,a4,-4
  400938:	03068663          	beq	a3,a6,400964 <clear_rows+0x68>
        if (play_area[i] == 4095){ // 4095 = column of all 1s
  40093c:	00072783          	lw	a5,0(a4)
  400940:	ff1798e3          	bne	a5,a7,400930 <clear_rows+0x34>
            points++;
  400944:	00150513          	addi	a0,a0,1 # 10000001 <current_piecem+0x1>
            for (int j = i; j > 4; j--){
  400948:	fed852e3          	bge	a6,a3,40092c <clear_rows+0x30>
  40094c:	00070793          	mv	a5,a4
                play_area[j] = play_area[j-1];
  400950:	ffc7a603          	lw	a2,-4(a5)
  400954:	00c7a023          	sw	a2,0(a5)
            for (int j = i; j > 4; j--){
  400958:	ffc78793          	addi	a5,a5,-4
  40095c:	feb79ae3          	bne	a5,a1,400950 <clear_rows+0x54>
  400960:	fcdff06f          	j	40092c <clear_rows+0x30>
        }
    }
    return points;
}
  400964:	00008067          	ret

00400968 <tetris_god_senpai>:
void tetris_god_senpai(){
  400968:	ff010113          	addi	sp,sp,-16
  40096c:	00112623          	sw	ra,12(sp)
    piece_row = 4;
  400970:	100007b7          	lui	a5,0x10000
  400974:	00400713          	li	a4,4
  400978:	0ee7a623          	sw	a4,236(a5) # 100000ec <piece_row>
    piece_col = 5;
  40097c:	100007b7          	lui	a5,0x10000
  400980:	00500713          	li	a4,5
  400984:	0ee7a423          	sw	a4,232(a5) # 100000e8 <piece_col>
    piece_index = (piece_index + 7)%18;
  400988:	10000737          	lui	a4,0x10000
  40098c:	0f072783          	lw	a5,240(a4) # 100000f0 <piece_index>
  400990:	00778793          	addi	a5,a5,7
  400994:	01200693          	li	a3,18
  400998:	02d7e7b3          	rem	a5,a5,a3
  40099c:	0ef72823          	sw	a5,240(a4)
    change_piece();
  4009a0:	afdff0ef          	jal	ra,40049c <change_piece>
    reset_mask();
  4009a4:	9f9ff0ef          	jal	ra,40039c <reset_mask>
    apply_mask();
  4009a8:	9adff0ef          	jal	ra,400354 <apply_mask>
}						 
  4009ac:	00c12083          	lw	ra,12(sp)
  4009b0:	01010113          	addi	sp,sp,16
  4009b4:	00008067          	ret

004009b8 <pollLeftFlag>:
#include "buttons.h"

inline int pollLeftFlag() { return *((volatile int *)0xffff0044); }
  4009b8:	ffff07b7          	lui	a5,0xffff0
  4009bc:	0447a503          	lw	a0,68(a5) # ffff0044 <__stack_init+0xeffe0048>
  4009c0:	00008067          	ret

004009c4 <pollRightFlag>:
inline int pollRightFlag() { return *((volatile int *)0xffff0048); }
  4009c4:	ffff07b7          	lui	a5,0xffff0
  4009c8:	0487a503          	lw	a0,72(a5) # ffff0048 <__stack_init+0xeffe004c>
  4009cc:	00008067          	ret

004009d0 <pollRotFlag>:
inline int pollRotFlag() { return *((volatile int *)0xffff004c); }
  4009d0:	ffff07b7          	lui	a5,0xffff0
  4009d4:	04c7a503          	lw	a0,76(a5) # ffff004c <__stack_init+0xeffe0050>
  4009d8:	00008067          	ret

004009dc <lowerFlags>:
inline void lowerFlags() { *((volatile int *)0xffff0050) = 1; }
  4009dc:	ffff07b7          	lui	a5,0xffff0
  4009e0:	00100713          	li	a4,1
  4009e4:	04e7a823          	sw	a4,80(a5) # ffff0050 <__stack_init+0xeffe0054>
  4009e8:	00008067          	ret
