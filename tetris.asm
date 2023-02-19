
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
  40001c:	fe010113          	addi	sp,sp,-32
  400020:	00112e23          	sw	ra,28(sp)
  400024:	00812c23          	sw	s0,24(sp)
  400028:	00912a23          	sw	s1,20(sp)
  40002c:	01212823          	sw	s2,16(sp)
  400030:	01312623          	sw	s3,12(sp)
  400034:	01412423          	sw	s4,8(sp)
  400038:	01512223          	sw	s5,4(sp)
  40003c:	01612023          	sw	s6,0(sp)
    initialize();
  400040:	3a8000ef          	jal	ra,4003e8 <initialize>
    for (int j = 0; j < HEIGHT; j++){
  400044:	004014b7          	lui	s1,0x401
  400048:	82848493          	addi	s1,s1,-2008 # 400828 <play_area>
  40004c:	00000413          	li	s0,0
  400050:	01900913          	li	s2,25
        paint_row(play_area[j], j);
  400054:	00040593          	mv	a1,s0
  400058:	0004a503          	lw	a0,0(s1)
  40005c:	440000ef          	jal	ra,40049c <paint_row>
    for (int j = 0; j < HEIGHT; j++){
  400060:	00140413          	addi	s0,s0,1
  400064:	00448493          	addi	s1,s1,4
  400068:	ff2416e3          	bne	s0,s2,400054 <main+0x38>
    }
    int colision = 0;
    while (colision < 1){
        mv_piece_d();
        for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  40006c:	100009b7          	lui	s3,0x10000
  400070:	40000b37          	lui	s6,0x40000
  400074:	fffb0b13          	addi	s6,s6,-1 # 3fffffff <__stack_init+0x2fff0003>
  400078:	10000ab7          	lui	s5,0x10000
  40007c:	000a8a93          	mv	s5,s5
  400080:	00401a37          	lui	s4,0x401
  400084:	828a0a13          	addi	s4,s4,-2008 # 400828 <play_area>
        mv_piece_d();
  400088:	520000ef          	jal	ra,4005a8 <mv_piece_d>
        for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  40008c:	0889a483          	lw	s1,136(s3) # 10000088 <piece_row>
  400090:	fff48413          	addi	s0,s1,-1
  400094:	016484b3          	add	s1,s1,s6
  400098:	00249493          	slli	s1,s1,0x2
  40009c:	01548933          	add	s2,s1,s5
  4000a0:	014484b3          	add	s1,s1,s4
            paint_row(piece_mask[j] | play_area[j], j);
  4000a4:	00092503          	lw	a0,0(s2)
  4000a8:	0004a783          	lw	a5,0(s1)
  4000ac:	00040593          	mv	a1,s0
  4000b0:	00f56533          	or	a0,a0,a5
  4000b4:	3e8000ef          	jal	ra,40049c <paint_row>
        for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  4000b8:	00140413          	addi	s0,s0,1
  4000bc:	00490913          	addi	s2,s2,4
  4000c0:	00448493          	addi	s1,s1,4
  4000c4:	0889a783          	lw	a5,136(s3)
  4000c8:	00378793          	addi	a5,a5,3
  4000cc:	fc87dce3          	bge	a5,s0,4000a4 <main+0x88>
        }
        colision = colision_check();
  4000d0:	5a0000ef          	jal	ra,400670 <colision_check>
    while (colision < 1){
  4000d4:	faa05ae3          	blez	a0,400088 <main+0x6c>
    }
    // consolidate rows:
    bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  4000d8:	10000937          	lui	s2,0x10000
  4000dc:	08892783          	lw	a5,136(s2) # 10000088 <piece_row>
  4000e0:	00279793          	slli	a5,a5,0x2
  4000e4:	00401737          	lui	a4,0x401
  4000e8:	82870493          	addi	s1,a4,-2008 # 400828 <play_area>
  4000ec:	10000437          	lui	s0,0x10000
  4000f0:	07440693          	addi	a3,s0,116 # 10000074 <result>
  4000f4:	00f48633          	add	a2,s1,a5
  4000f8:	100005b7          	lui	a1,0x10000
  4000fc:	00058593          	mv	a1,a1
  400100:	00f585b3          	add	a1,a1,a5
  400104:	00400513          	li	a0,4
  400108:	3a8000ef          	jal	ra,4004b0 <bit_or_matrix>
    for (int j = piece_row; j < piece_row + SQUARESIZE; j++){
  40010c:	07440793          	addi	a5,s0,116
  400110:	08892703          	lw	a4,136(s2)
  400114:	00271713          	slli	a4,a4,0x2
  400118:	00970733          	add	a4,a4,s1
  40011c:	01078613          	addi	a2,a5,16
        play_area[j] = result[j-piece_row];
  400120:	0007a683          	lw	a3,0(a5)
  400124:	00d72023          	sw	a3,0(a4)
    for (int j = piece_row; j < piece_row + SQUARESIZE; j++){
  400128:	00478793          	addi	a5,a5,4
  40012c:	00470713          	addi	a4,a4,4
  400130:	fec798e3          	bne	a5,a2,400120 <main+0x104>
    }
    // clear rows:

}
  400134:	00000513          	li	a0,0
  400138:	01c12083          	lw	ra,28(sp)
  40013c:	01812403          	lw	s0,24(sp)
  400140:	01412483          	lw	s1,20(sp)
  400144:	01012903          	lw	s2,16(sp)
  400148:	00c12983          	lw	s3,12(sp)
  40014c:	00812a03          	lw	s4,8(sp)
  400150:	00412a83          	lw	s5,4(sp)
  400154:	00012b03          	lw	s6,0(sp)
  400158:	02010113          	addi	sp,sp,32
  40015c:	00008067          	ret

00400160 <abs>:
 */

#include "lib.h"

// returns absolute value of its integer argument - a replacement of the standard library function abs() 
inline int abs(int n) { return (n < 0) ? (-n) : n; }
  400160:	41f55793          	srai	a5,a0,0x1f
  400164:	00a7c533          	xor	a0,a5,a0
  400168:	40f50533          	sub	a0,a0,a5
  40016c:	00008067          	ret

00400170 <printchar>:

// prints single character to console - a substitute for the standard library funciton putch(int chr)
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400170:	ffff07b7          	lui	a5,0xffff0
  400174:	00a7a623          	sw	a0,12(a5) # ffff000c <__stack_init+0xeffe0010>
  400178:	00008067          	ret

0040017c <println>:
  40017c:	ffff07b7          	lui	a5,0xffff0
  400180:	00a00713          	li	a4,10
  400184:	00e7a623          	sw	a4,12(a5) # ffff000c <__stack_init+0xeffe0010>

// prints newline character to console
void println() { printchar('\n'); }
  400188:	00008067          	ret

0040018c <printstr>:

// prints given string of characters to console - a substitute for the standard library function puts(char *s)
void printstr(char *str)
{
    while (*str != '\0') 
  40018c:	00054783          	lbu	a5,0(a0)
  400190:	00078c63          	beqz	a5,4001a8 <printstr+0x1c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400194:	ffff0737          	lui	a4,0xffff0
  400198:	00f72623          	sw	a5,12(a4) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(*str);
        str += 1;
  40019c:	00150513          	addi	a0,a0,1
    while (*str != '\0') 
  4001a0:	00054783          	lbu	a5,0(a0)
  4001a4:	fe079ae3          	bnez	a5,400198 <printstr+0xc>
    }
}
  4001a8:	00008067          	ret

004001ac <printint>:

// prints given integer as a signed decimal number
void printint(int n)
{
  4001ac:	ff010113          	addi	sp,sp,-16
    {
        sign = '-';
    }
    else
    {
        sign = '\0';
  4001b0:	41f55813          	srai	a6,a0,0x1f
  4001b4:	02d87813          	andi	a6,a6,45
  4001b8:	00410713          	addi	a4,sp,4
  4001bc:	00900613          	li	a2,9
    
    // produce decimal digits of the number going from right to left, keep them in num[] array.
    do 
    {
        i = i - 1;
        num[i] = abs(n % 10) + '0';
  4001c0:	00a00593          	li	a1,10
        i = i - 1;
  4001c4:	fff60613          	addi	a2,a2,-1
        num[i] = abs(n % 10) + '0';
  4001c8:	02b567b3          	rem	a5,a0,a1
  4001cc:	41f7d693          	srai	a3,a5,0x1f
  4001d0:	00f6c7b3          	xor	a5,a3,a5
  4001d4:	40d787b3          	sub	a5,a5,a3
  4001d8:	03078793          	addi	a5,a5,48
  4001dc:	00f70423          	sb	a5,8(a4)
        n = n / 10;
  4001e0:	02b54533          	div	a0,a0,a1
    } while (n != 0);
  4001e4:	fff70713          	addi	a4,a4,-1
  4001e8:	fc051ee3          	bnez	a0,4001c4 <printint+0x18>
    
    //now print the sign of the number and its digits left-to-right.
    if (sign) 
  4001ec:	00080663          	beqz	a6,4001f8 <printint+0x4c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  4001f0:	ffff07b7          	lui	a5,0xffff0
  4001f4:	0107a623          	sw	a6,12(a5) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(sign);
    }
    
    while(i < MAX_INT_DIGITS)
  4001f8:	00900793          	li	a5,9
  4001fc:	02c7c263          	blt	a5,a2,400220 <printint+0x74>
  400200:	00410793          	addi	a5,sp,4
  400204:	00c787b3          	add	a5,a5,a2
  400208:	00e10693          	addi	a3,sp,14
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  40020c:	ffff0637          	lui	a2,0xffff0
  400210:	0007c703          	lbu	a4,0(a5)
  400214:	00e62623          	sw	a4,12(a2) # ffff000c <__stack_init+0xeffe0010>
    while(i < MAX_INT_DIGITS)
  400218:	00178793          	addi	a5,a5,1
  40021c:	fed79ae3          	bne	a5,a3,400210 <printint+0x64>
    {
        printchar(num[i]);
        i=i+1;
    }
}
  400220:	01010113          	addi	sp,sp,16
  400224:	00008067          	ret

00400228 <pollkbd>:


// check if keyboard buffer has some data
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400228:	ffff07b7          	lui	a5,0xffff0
  40022c:	0007a503          	lw	a0,0(a5) # ffff0000 <__stack_init+0xeffe0004>
  400230:	00008067          	ret

00400234 <readchar>:

// read next character from keyboard buffer
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  400234:	ffff07b7          	lui	a5,0xffff0
  400238:	0047a503          	lw	a0,4(a5) # ffff0004 <__stack_init+0xeffe0008>
  40023c:	00008067          	ret

00400240 <readstr>:

// read characters into provided buffer until either user presses enter or the buffer size is reached.
int readstr(char *buf, int size)
{
  400240:	00050693          	mv	a3,a0
    int count;
    
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  400244:	00100793          	li	a5,1
  400248:	04b7d263          	bge	a5,a1,40028c <readstr+0x4c>
  40024c:	fff58613          	addi	a2,a1,-1 # fffffff <rotational_vector+0xfbff773>
    
    count = 0;
  400250:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400254:	ffff0737          	lui	a4,0xffff0
       
       // read next character into the current element of the buffer
       *buf = (char)readchar();
       
       // if the user pressed Enter, stop reading
       if (*buf == '\n') 
  400258:	00a00593          	li	a1,10
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  40025c:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  400260:	fe078ee3          	beqz	a5,40025c <readstr+0x1c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  400264:	00472783          	lw	a5,4(a4)
       *buf = (char)readchar();
  400268:	0ff7f793          	andi	a5,a5,255
  40026c:	00f68023          	sb	a5,0(a3)
       if (*buf == '\n') 
  400270:	00b78a63          	beq	a5,a1,400284 <readstr+0x44>
       {
           break;
       }
       
       // move pointer to the next element of the buffer
       buf += 1;
  400274:	00168693          	addi	a3,a3,1
       
       // increase the number of characters in the buffer
       count += 1;
  400278:	00150513          	addi	a0,a0,1
       
       // decrease the remaining space in the buffer
       size -= 1;
       
    } while(size > 1);  // keep going until one empty char remains (to hold the final '\0' character
  40027c:	fec510e3          	bne	a0,a2,40025c <readstr+0x1c>
       count += 1;
  400280:	00060513          	mv	a0,a2
    
    *buf = '\0';  // add the end-of-string marker '\0'
  400284:	00068023          	sb	zero,0(a3)
    
    return count; // return the number of characters in the read string
  400288:	00008067          	ret
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  40028c:	fff00513          	li	a0,-1
}
  400290:	00008067          	ret

00400294 <readint>:

//read signed integer
int readint()
{
    int res = 0;
    int sign = 1;
  400294:	00100593          	li	a1,1
    int res = 0;
  400298:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  40029c:	ffff0737          	lui	a4,0xffff0
           sign = -1;
       }
       else
       {
           // otherwise, if a non-digit is read, it signifies the end of the number
           if (chr < '0' || chr > '9') 
  4002a0:	00900613          	li	a2,9
       if (res == 0 && sign == 1 && chr == '-') 
  4002a4:	00100813          	li	a6,1
  4002a8:	02d00893          	li	a7,45
           sign = -1;
  4002ac:	fff00313          	li	t1,-1
  4002b0:	0200006f          	j	4002d0 <readint+0x3c>
           if (chr < '0' || chr > '9') 
  4002b4:	fd068793          	addi	a5,a3,-48
  4002b8:	02f66c63          	bltu	a2,a5,4002f0 <readint+0x5c>
           {
               break;
           }
           // incorporate the read digit into the number (N.B. chr - '0' gived the digit value).
           res = res * 10 + (chr - '0');
  4002bc:	00251793          	slli	a5,a0,0x2
  4002c0:	00a787b3          	add	a5,a5,a0
  4002c4:	00179793          	slli	a5,a5,0x1
  4002c8:	fd068693          	addi	a3,a3,-48
  4002cc:	00f68533          	add	a0,a3,a5
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  4002d0:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  4002d4:	fe078ee3          	beqz	a5,4002d0 <readint+0x3c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  4002d8:	00472683          	lw	a3,4(a4)
       if (res == 0 && sign == 1 && chr == '-') 
  4002dc:	fc051ce3          	bnez	a0,4002b4 <readint+0x20>
  4002e0:	fd059ae3          	bne	a1,a6,4002b4 <readint+0x20>
  4002e4:	fd1698e3          	bne	a3,a7,4002b4 <readint+0x20>
           sign = -1;
  4002e8:	00030593          	mv	a1,t1
  4002ec:	fe5ff06f          	j	4002d0 <readint+0x3c>
       }
    }
    
    // return the absolute value of the number (constructed from entered digits) multiplied by the sign.
    return sign * res;
}
  4002f0:	02b50533          	mul	a0,a0,a1
  4002f4:	00008067          	ret

004002f8 <showpic>:
    # as long as this function is not calling other functions.
    
    .globl showpic
    
showpic:
    li t0,0xffff8000    # starting address of the graphics display
  4002f8:	ffff82b7          	lui	t0,0xffff8
    li t1,32            # number of lines on the display (each word encodes one line) 
  4002fc:	02000313          	li	t1,32

00400300 <loop>:
loop:
    lw t2,0(a0)         # load next line (word) of the picture data
  400300:	00052383          	lw	t2,0(a0)
    sw t2,0(t0)         # write it to the corresponding line of the graphics display
  400304:	0072a023          	sw	t2,0(t0) # ffff8000 <__stack_init+0xeffe8004>
    addi t0,t0,4        # move to the next line of the graphics display
  400308:	00428293          	addi	t0,t0,4
    addi a0,a0,4        # move to the next line of the picture data
  40030c:	00450513          	addi	a0,a0,4
    addi t1,t1,-1       # reduce the number of remaining lines
  400310:	fff30313          	addi	t1,t1,-1
    bnez t1,loop        # keep going until all lines on the display are filled with data
  400314:	fe0316e3          	bnez	t1,400300 <loop>
    jr ra               # return 
  400318:	00008067          	ret

0040031c <initseed>:
   	# the seed should only be set once at the start of the program
   	# otherwise you can accidentally always get the same number
	.global initseed

initseed:
	la t0, seed		# load address of seed to t0
  40031c:	00000297          	auipc	t0,0x0
  400320:	3d828293          	addi	t0,t0,984 # 4006f4 <seed>
	li t5, 0x1234		# write-enable signal value
  400324:	00001f37          	lui	t5,0x1
  400328:	234f0f13          	addi	t5,t5,564 # 1234 <_start-0x3fedcc>
	sw t5, 0(t0)		# enable writing to seed location
  40032c:	01e2a023          	sw	t5,0(t0)
	sw a0, 0(t0)		# load input seed to memory	
  400330:	00a2a023          	sw	a0,0(t0)
	jr ra
  400334:	00008067          	ret

00400338 <random>:
	
	.global random
	
random:
	la t0, seed		# load address of seed to t0
  400338:	00000297          	auipc	t0,0x0
  40033c:	3bc28293          	addi	t0,t0,956 # 4006f4 <seed>
	lw t1, 0(t0)		# load seed to t1
  400340:	0002a303          	lw	t1,0(t0)
	mv t1, sp		
  400344:	00010313          	mv	t1,sp

00400348 <roll>:
	
roll:
	slli t2, t1, 1		# shift seed to the left and store in t2
  400348:	00131393          	slli	t2,t1,0x1
	xor t1, t2, t1		# xor bits in t1 and t2 for a pseudo random number
  40034c:	0063c333          	xor	t1,t2,t1
	andi a0, t1, 0x700	# extract 3 bit random number from t1 using mask 0000011100000000
  400350:	70037513          	andi	a0,t1,1792
	srli a0, a0, 8		# shift bits in t4 to the right so they are the least significant digits
  400354:	00855513          	srli	a0,a0,0x8
	beqz a0, roll		# reroll if equal to 0 
  400358:	fe0508e3          	beqz	a0,400348 <roll>
	sw t1, 0(t0)		# set new seed with value of t1
  40035c:	0062a023          	sw	t1,0(t0)
	jr ra 			# return
  400360:	00008067          	ret

00400364 <apply_mask>:

// copy the contents of the piece matrix to the position in the mask indicated by piece_row and piece_col
void apply_mask(int piece[SQUARESIZE]){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece[i-piece_row]; // mask row equal current piece row
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400364:	100007b7          	lui	a5,0x10000
  400368:	0847a783          	lw	a5,132(a5) # 10000084 <piece_col>
  40036c:	00800613          	li	a2,8
  400370:	40f60633          	sub	a2,a2,a5
  400374:	00050713          	mv	a4,a0
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400378:	100007b7          	lui	a5,0x10000
  40037c:	0887a783          	lw	a5,136(a5) # 10000088 <piece_row>
  400380:	00279693          	slli	a3,a5,0x2
  400384:	100007b7          	lui	a5,0x10000
  400388:	00078793          	mv	a5,a5
  40038c:	00d787b3          	add	a5,a5,a3
  400390:	01050513          	addi	a0,a0,16
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400394:	00072683          	lw	a3,0(a4)
  400398:	00c696b3          	sll	a3,a3,a2
  40039c:	00d7a023          	sw	a3,0(a5) # 10000000 <piece_mask>
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4003a0:	00470713          	addi	a4,a4,4
  4003a4:	00478793          	addi	a5,a5,4
  4003a8:	fea716e3          	bne	a4,a0,400394 <apply_mask+0x30>
    }
}
  4003ac:	00008067          	ret

004003b0 <reset_mask>:

void reset_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4003b0:	100007b7          	lui	a5,0x10000
  4003b4:	0887a683          	lw	a3,136(a5) # 10000088 <piece_row>
  4003b8:	00269693          	slli	a3,a3,0x2
  4003bc:	10000737          	lui	a4,0x10000
  4003c0:	00070713          	mv	a4,a4
  4003c4:	00d707b3          	add	a5,a4,a3
  4003c8:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  4003cc:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 12;
  4003d0:	0007a703          	lw	a4,0(a5)
  4003d4:	40c75713          	srai	a4,a4,0xc
  4003d8:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4003dc:	00478793          	addi	a5,a5,4
  4003e0:	fed798e3          	bne	a5,a3,4003d0 <reset_mask+0x20>
    }
}
  4003e4:	00008067          	ret

004003e8 <initialize>:

void initialize(){
  4003e8:	ff010113          	addi	sp,sp,-16
  4003ec:	00112623          	sw	ra,12(sp)
    piece_index = 15;
  4003f0:	100007b7          	lui	a5,0x10000
  4003f4:	00f00713          	li	a4,15
  4003f8:	08e7a623          	sw	a4,140(a5) # 1000008c <piece_index>
    piece_row = 19;
  4003fc:	100007b7          	lui	a5,0x10000
  400400:	01300713          	li	a4,19
  400404:	08e7a423          	sw	a4,136(a5) # 10000088 <piece_row>
    piece_col = 6;
  400408:	100007b7          	lui	a5,0x10000
  40040c:	00600713          	li	a4,6
  400410:	08e7a223          	sw	a4,132(a5) # 10000084 <piece_col>
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
  400414:	10000537          	lui	a0,0x10000
  400418:	00050513          	mv	a0,a0
  40041c:	004007b7          	lui	a5,0x400
  400420:	6f878793          	addi	a5,a5,1784 # 4006f8 <pieces>
  400424:	0f07a703          	lw	a4,240(a5)
  400428:	06e52223          	sw	a4,100(a0) # 10000064 <current_piecem>
  40042c:	0f47a703          	lw	a4,244(a5)
  400430:	06e52423          	sw	a4,104(a0)
  400434:	0f87a703          	lw	a4,248(a5)
  400438:	06e52623          	sw	a4,108(a0)
  40043c:	0fc7a783          	lw	a5,252(a5)
  400440:	06f52823          	sw	a5,112(a0)
    }
    apply_mask(current_piecem);
  400444:	06450513          	addi	a0,a0,100
  400448:	f1dff0ef          	jal	ra,400364 <apply_mask>
}
  40044c:	00c12083          	lw	ra,12(sp)
  400450:	01010113          	addi	sp,sp,16
  400454:	00008067          	ret

00400458 <change_piece>:

void change_piece(){
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
  400458:	100007b7          	lui	a5,0x10000
  40045c:	08c7a783          	lw	a5,140(a5) # 1000008c <piece_index>
  400460:	10000737          	lui	a4,0x10000
  400464:	00070713          	mv	a4,a4
  400468:	00479693          	slli	a3,a5,0x4
  40046c:	004007b7          	lui	a5,0x400
  400470:	6f878793          	addi	a5,a5,1784 # 4006f8 <pieces>
  400474:	00d787b3          	add	a5,a5,a3
  400478:	0007a683          	lw	a3,0(a5)
  40047c:	06d72223          	sw	a3,100(a4) # 10000064 <current_piecem>
  400480:	0047a683          	lw	a3,4(a5)
  400484:	06d72423          	sw	a3,104(a4)
  400488:	0087a683          	lw	a3,8(a5)
  40048c:	06d72623          	sw	a3,108(a4)
  400490:	00c7a783          	lw	a5,12(a5)
  400494:	06f72823          	sw	a5,112(a4)
    }
}
  400498:	00008067          	ret

0040049c <paint_row>:
#include "display.h"

void paint_row(int row, int row_num){
        *((volatile int *)(0xffff8000 + row_num*4)) = row;
  40049c:	00259593          	slli	a1,a1,0x2
  4004a0:	ffff87b7          	lui	a5,0xffff8
  4004a4:	00f585b3          	add	a1,a1,a5
  4004a8:	00a5a023          	sw	a0,0(a1)
}
  4004ac:	00008067          	ret

004004b0 <bit_or_matrix>:
#include "matrix.h"
#include "lib.h"
#include "shapes.h"

void bit_or_matrix(int size, int matrix1[size], int matrix2[size], int result[size]){
    for (int i = 0; i < size; i++) {
  4004b0:	02a05863          	blez	a0,4004e0 <bit_or_matrix+0x30>
  4004b4:	00058793          	mv	a5,a1
  4004b8:	00251513          	slli	a0,a0,0x2
  4004bc:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] | matrix2[i];
  4004c0:	0007a703          	lw	a4,0(a5) # ffff8000 <__stack_init+0xeffe8004>
  4004c4:	00062583          	lw	a1,0(a2)
  4004c8:	00b76733          	or	a4,a4,a1
  4004cc:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  4004d0:	00478793          	addi	a5,a5,4
  4004d4:	00460613          	addi	a2,a2,4
  4004d8:	00468693          	addi	a3,a3,4
  4004dc:	fea792e3          	bne	a5,a0,4004c0 <bit_or_matrix+0x10>
    }
}
  4004e0:	00008067          	ret

004004e4 <bit_and_matrix>:

void bit_and_matrix(int size, int matrix1[size], int matrix2[size], int result[size]){
    for (int i = 0; i < size; i++) {
  4004e4:	02a05863          	blez	a0,400514 <bit_and_matrix+0x30>
  4004e8:	00058793          	mv	a5,a1
  4004ec:	00251513          	slli	a0,a0,0x2
  4004f0:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] & matrix2[i];
  4004f4:	0007a703          	lw	a4,0(a5)
  4004f8:	00062583          	lw	a1,0(a2)
  4004fc:	00b77733          	and	a4,a4,a1
  400500:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  400504:	00478793          	addi	a5,a5,4
  400508:	00460613          	addi	a2,a2,4
  40050c:	00468693          	addi	a3,a3,4
  400510:	fea792e3          	bne	a5,a0,4004f4 <bit_and_matrix+0x10>
    }
}
  400514:	00008067          	ret

00400518 <mv_piece_l>:
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

void mv_piece_l(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400518:	100007b7          	lui	a5,0x10000
  40051c:	0887a683          	lw	a3,136(a5) # 10000088 <piece_row>
  400520:	00269693          	slli	a3,a3,0x2
  400524:	10000737          	lui	a4,0x10000
  400528:	00070713          	mv	a4,a4
  40052c:	00e687b3          	add	a5,a3,a4
  400530:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  400534:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] << 1;
  400538:	0007a703          	lw	a4,0(a5)
  40053c:	00171713          	slli	a4,a4,0x1
  400540:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400544:	00478793          	addi	a5,a5,4
  400548:	fed798e3          	bne	a5,a3,400538 <mv_piece_l+0x20>
    }
    piece_col -= 1;
  40054c:	10000737          	lui	a4,0x10000
  400550:	08472783          	lw	a5,132(a4) # 10000084 <piece_col>
  400554:	fff78793          	addi	a5,a5,-1
  400558:	08f72223          	sw	a5,132(a4)
}
  40055c:	00008067          	ret

00400560 <mv_piece_r>:
void mv_piece_r(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400560:	100007b7          	lui	a5,0x10000
  400564:	0887a683          	lw	a3,136(a5) # 10000088 <piece_row>
  400568:	00269693          	slli	a3,a3,0x2
  40056c:	10000737          	lui	a4,0x10000
  400570:	00070713          	mv	a4,a4
  400574:	00e687b3          	add	a5,a3,a4
  400578:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  40057c:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 1;
  400580:	0007a703          	lw	a4,0(a5)
  400584:	40175713          	srai	a4,a4,0x1
  400588:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40058c:	00478793          	addi	a5,a5,4
  400590:	fed798e3          	bne	a5,a3,400580 <mv_piece_r+0x20>
    }
    piece_col += 1;
  400594:	10000737          	lui	a4,0x10000
  400598:	08472783          	lw	a5,132(a4) # 10000084 <piece_col>
  40059c:	00178793          	addi	a5,a5,1
  4005a0:	08f72223          	sw	a5,132(a4)
}
  4005a4:	00008067          	ret

004005a8 <mv_piece_d>:
void mv_piece_d(){
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  4005a8:	100007b7          	lui	a5,0x10000
  4005ac:	0887a603          	lw	a2,136(a5) # 10000088 <piece_row>
  4005b0:	00261693          	slli	a3,a2,0x2
  4005b4:	10000737          	lui	a4,0x10000
  4005b8:	00070713          	mv	a4,a4
  4005bc:	00e687b3          	add	a5,a3,a4
  4005c0:	fec70713          	addi	a4,a4,-20 # fffffec <rotational_vector+0xfbff760>
  4005c4:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i-1];
  4005c8:	00c7a683          	lw	a3,12(a5)
  4005cc:	00d7a823          	sw	a3,16(a5)
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  4005d0:	ffc78793          	addi	a5,a5,-4
  4005d4:	fee79ae3          	bne	a5,a4,4005c8 <mv_piece_d+0x20>
    }
    piece_row += 1;
  4005d8:	00160613          	addi	a2,a2,1
  4005dc:	100007b7          	lui	a5,0x10000
  4005e0:	08c7a423          	sw	a2,136(a5) # 10000088 <piece_row>
}
  4005e4:	00008067          	ret

004005e8 <mv_piece_u>:
void mv_piece_u(){
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  4005e8:	100007b7          	lui	a5,0x10000
  4005ec:	0887a703          	lw	a4,136(a5) # 10000088 <piece_row>
  4005f0:	fff70613          	addi	a2,a4,-1
  4005f4:	00271693          	slli	a3,a4,0x2
  4005f8:	10000737          	lui	a4,0x10000
  4005fc:	00070713          	mv	a4,a4
  400600:	00e687b3          	add	a5,a3,a4
  400604:	01470713          	addi	a4,a4,20 # 10000014 <piece_mask+0x14>
  400608:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i+1];
  40060c:	0007a683          	lw	a3,0(a5)
  400610:	fed7ae23          	sw	a3,-4(a5)
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  400614:	00478793          	addi	a5,a5,4
  400618:	fee79ae3          	bne	a5,a4,40060c <mv_piece_u+0x24>
    }
    piece_row -= 1;
  40061c:	100007b7          	lui	a5,0x10000
  400620:	08c7a423          	sw	a2,136(a5) # 10000088 <piece_row>
}
  400624:	00008067          	ret

00400628 <r_piece_cw>:
void r_piece_cw(){
  400628:	ff010113          	addi	sp,sp,-16
  40062c:	00112623          	sw	ra,12(sp)
    piece_index = rotational_vector[piece_index];
  400630:	100006b7          	lui	a3,0x10000
  400634:	08c6a783          	lw	a5,140(a3) # 1000008c <piece_index>
  400638:	00279713          	slli	a4,a5,0x2
  40063c:	004017b7          	lui	a5,0x401
  400640:	88c78793          	addi	a5,a5,-1908 # 40088c <rotational_vector>
  400644:	00e787b3          	add	a5,a5,a4
  400648:	0007a783          	lw	a5,0(a5)
  40064c:	08f6a623          	sw	a5,140(a3)
    change_piece();
  400650:	e09ff0ef          	jal	ra,400458 <change_piece>
    reset_mask();
  400654:	d5dff0ef          	jal	ra,4003b0 <reset_mask>
    apply_mask(current_piecem);
  400658:	10000537          	lui	a0,0x10000
  40065c:	06450513          	addi	a0,a0,100 # 10000064 <current_piecem>
  400660:	d05ff0ef          	jal	ra,400364 <apply_mask>
}
  400664:	00c12083          	lw	ra,12(sp)
  400668:	01010113          	addi	sp,sp,16
  40066c:	00008067          	ret

00400670 <colision_check>:
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

// checks for colision between the falling piece and the blocks in the playing area
int colision_check(){
  400670:	ff010113          	addi	sp,sp,-16
  400674:	00112623          	sw	ra,12(sp)
  400678:	00812423          	sw	s0,8(sp)
  40067c:	00912223          	sw	s1,4(sp)
    int ret_val;
    mv_piece_d(); // move piece down to check for future colisions
  400680:	f29ff0ef          	jal	ra,4005a8 <mv_piece_d>
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  400684:	100007b7          	lui	a5,0x10000
  400688:	0887a783          	lw	a5,136(a5) # 10000088 <piece_row>
  40068c:	00279793          	slli	a5,a5,0x2
  400690:	100006b7          	lui	a3,0x10000
  400694:	07468493          	addi	s1,a3,116 # 10000074 <result>
  400698:	07468693          	addi	a3,a3,116
  40069c:	00401637          	lui	a2,0x401
  4006a0:	82860613          	addi	a2,a2,-2008 # 400828 <play_area>
  4006a4:	00f60633          	add	a2,a2,a5
  4006a8:	100005b7          	lui	a1,0x10000
  4006ac:	00058593          	mv	a1,a1
  4006b0:	00f585b3          	add	a1,a1,a5
  4006b4:	00400513          	li	a0,4
  4006b8:	e2dff0ef          	jal	ra,4004e4 <bit_and_matrix>
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
  4006bc:	0004a403          	lw	s0,0(s1)
  4006c0:	0044a783          	lw	a5,4(s1)
  4006c4:	00f46433          	or	s0,s0,a5
  4006c8:	0084a783          	lw	a5,8(s1)
  4006cc:	00f46433          	or	s0,s0,a5
  4006d0:	00c4a783          	lw	a5,12(s1)
  4006d4:	00f46433          	or	s0,s0,a5
    }
    mv_piece_u(); // move piece up to its original position
  4006d8:	f11ff0ef          	jal	ra,4005e8 <mv_piece_u>
    return ret_val;
}
  4006dc:	00040513          	mv	a0,s0
  4006e0:	00c12083          	lw	ra,12(sp)
  4006e4:	00812403          	lw	s0,8(sp)
  4006e8:	00412483          	lw	s1,4(sp)
  4006ec:	01010113          	addi	sp,sp,16
  4006f0:	00008067          	ret
