
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
#include "movement.h"
#include "shapes.h"
#include "physics.h"
#include "random.h"

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
  400040:	34c000ef          	jal	ra,40038c <initialize>
    for (int j = 0; j < HEIGHT; j++){
  400044:	004014b7          	lui	s1,0x401
  400048:	88c48493          	addi	s1,s1,-1908 # 40088c <play_area>
  40004c:	00000413          	li	s0,0
  400050:	01900913          	li	s2,25
        paint_row(play_area[j], j);
  400054:	00040593          	mv	a1,s0
  400058:	0004a503          	lw	a0,0(s1)
  40005c:	390000ef          	jal	ra,4003ec <paint_row>
    for (int j = 0; j < HEIGHT; j++){
  400060:	00140413          	addi	s0,s0,1
  400064:	00448493          	addi	s1,s1,4
  400068:	ff2416e3          	bne	s0,s2,400054 <main+0x38>
    }
    int colision = 0;
    while (colision < 1){
        for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  40006c:	100009b7          	lui	s3,0x10000
  400070:	40000b37          	lui	s6,0x40000
  400074:	fffb0b13          	addi	s6,s6,-1 # 3fffffff <__stack_init+0x2fff0003>
  400078:	10000ab7          	lui	s5,0x10000
  40007c:	000a8a93          	mv	s5,s5
  400080:	00401a37          	lui	s4,0x401
  400084:	88ca0a13          	addi	s4,s4,-1908 # 40088c <play_area>
  400088:	0889a483          	lw	s1,136(s3) # 10000088 <piece_row>
  40008c:	fff48413          	addi	s0,s1,-1
  400090:	016484b3          	add	s1,s1,s6
  400094:	00249493          	slli	s1,s1,0x2
  400098:	01548933          	add	s2,s1,s5
  40009c:	014484b3          	add	s1,s1,s4
            paint_row(piece_mask[j] | play_area[j], j);
  4000a0:	00092503          	lw	a0,0(s2)
  4000a4:	0004a783          	lw	a5,0(s1)
  4000a8:	00040593          	mv	a1,s0
  4000ac:	00f56533          	or	a0,a0,a5
  4000b0:	33c000ef          	jal	ra,4003ec <paint_row>
        for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  4000b4:	00140413          	addi	s0,s0,1
  4000b8:	00490913          	addi	s2,s2,4
  4000bc:	00448493          	addi	s1,s1,4
  4000c0:	0889a783          	lw	a5,136(s3)
  4000c4:	00378793          	addi	a5,a5,3
  4000c8:	fc87dce3          	bge	a5,s0,4000a0 <main+0x84>
        }
        mv_piece_u();
  4000cc:	56c000ef          	jal	ra,400638 <mv_piece_u>
        colision = colision_check();
  4000d0:	608000ef          	jal	ra,4006d8 <colision_check>
    while (colision < 1){
  4000d4:	faa05ae3          	blez	a0,400088 <main+0x6c>

    for (int j = 0; j < HEIGHT; j++){
        paint_row(play_area[j], j);
    }
    */
}
  4000d8:	00000513          	li	a0,0
  4000dc:	01c12083          	lw	ra,28(sp)
  4000e0:	01812403          	lw	s0,24(sp)
  4000e4:	01412483          	lw	s1,20(sp)
  4000e8:	01012903          	lw	s2,16(sp)
  4000ec:	00c12983          	lw	s3,12(sp)
  4000f0:	00812a03          	lw	s4,8(sp)
  4000f4:	00412a83          	lw	s5,4(sp)
  4000f8:	00012b03          	lw	s6,0(sp)
  4000fc:	02010113          	addi	sp,sp,32
  400100:	00008067          	ret

00400104 <abs>:
 */

#include "lib.h"

// returns absolute value of its integer argument - a replacement of the standard library function abs() 
inline int abs(int n) { return (n < 0) ? (-n) : n; }
  400104:	41f55793          	srai	a5,a0,0x1f
  400108:	00a7c533          	xor	a0,a5,a0
  40010c:	40f50533          	sub	a0,a0,a5
  400110:	00008067          	ret

00400114 <printchar>:

// prints single character to console - a substitute for the standard library funciton putch(int chr)
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400114:	ffff07b7          	lui	a5,0xffff0
  400118:	00a7a623          	sw	a0,12(a5) # ffff000c <__stack_init+0xeffe0010>
  40011c:	00008067          	ret

00400120 <println>:
  400120:	ffff07b7          	lui	a5,0xffff0
  400124:	00a00713          	li	a4,10
  400128:	00e7a623          	sw	a4,12(a5) # ffff000c <__stack_init+0xeffe0010>

// prints newline character to console
void println() { printchar('\n'); }
  40012c:	00008067          	ret

00400130 <printstr>:

// prints given string of characters to console - a substitute for the standard library function puts(char *s)
void printstr(char *str)
{
    while (*str != '\0') 
  400130:	00054783          	lbu	a5,0(a0)
  400134:	00078c63          	beqz	a5,40014c <printstr+0x1c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400138:	ffff0737          	lui	a4,0xffff0
  40013c:	00f72623          	sw	a5,12(a4) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(*str);
        str += 1;
  400140:	00150513          	addi	a0,a0,1
    while (*str != '\0') 
  400144:	00054783          	lbu	a5,0(a0)
  400148:	fe079ae3          	bnez	a5,40013c <printstr+0xc>
    }
}
  40014c:	00008067          	ret

00400150 <printint>:

// prints given integer as a signed decimal number
void printint(int n)
{
  400150:	ff010113          	addi	sp,sp,-16
    {
        sign = '-';
    }
    else
    {
        sign = '\0';
  400154:	41f55813          	srai	a6,a0,0x1f
  400158:	02d87813          	andi	a6,a6,45
  40015c:	00410713          	addi	a4,sp,4
  400160:	00900613          	li	a2,9
    
    // produce decimal digits of the number going from right to left, keep them in num[] array.
    do 
    {
        i = i - 1;
        num[i] = abs(n % 10) + '0';
  400164:	00a00593          	li	a1,10
        i = i - 1;
  400168:	fff60613          	addi	a2,a2,-1
        num[i] = abs(n % 10) + '0';
  40016c:	02b567b3          	rem	a5,a0,a1
  400170:	41f7d693          	srai	a3,a5,0x1f
  400174:	00f6c7b3          	xor	a5,a3,a5
  400178:	40d787b3          	sub	a5,a5,a3
  40017c:	03078793          	addi	a5,a5,48
  400180:	00f70423          	sb	a5,8(a4)
        n = n / 10;
  400184:	02b54533          	div	a0,a0,a1
    } while (n != 0);
  400188:	fff70713          	addi	a4,a4,-1
  40018c:	fc051ee3          	bnez	a0,400168 <printint+0x18>
    
    //now print the sign of the number and its digits left-to-right.
    if (sign) 
  400190:	00080663          	beqz	a6,40019c <printint+0x4c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400194:	ffff07b7          	lui	a5,0xffff0
  400198:	0107a623          	sw	a6,12(a5) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(sign);
    }
    
    while(i < MAX_INT_DIGITS)
  40019c:	00900793          	li	a5,9
  4001a0:	02c7c263          	blt	a5,a2,4001c4 <printint+0x74>
  4001a4:	00410793          	addi	a5,sp,4
  4001a8:	00c787b3          	add	a5,a5,a2
  4001ac:	00e10693          	addi	a3,sp,14
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  4001b0:	ffff0637          	lui	a2,0xffff0
  4001b4:	0007c703          	lbu	a4,0(a5)
  4001b8:	00e62623          	sw	a4,12(a2) # ffff000c <__stack_init+0xeffe0010>
    while(i < MAX_INT_DIGITS)
  4001bc:	00178793          	addi	a5,a5,1
  4001c0:	fed79ae3          	bne	a5,a3,4001b4 <printint+0x64>
    {
        printchar(num[i]);
        i=i+1;
    }
}
  4001c4:	01010113          	addi	sp,sp,16
  4001c8:	00008067          	ret

004001cc <pollkbd>:


// check if keyboard buffer has some data
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  4001cc:	ffff07b7          	lui	a5,0xffff0
  4001d0:	0007a503          	lw	a0,0(a5) # ffff0000 <__stack_init+0xeffe0004>
  4001d4:	00008067          	ret

004001d8 <readchar>:

// read next character from keyboard buffer
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  4001d8:	ffff07b7          	lui	a5,0xffff0
  4001dc:	0047a503          	lw	a0,4(a5) # ffff0004 <__stack_init+0xeffe0008>
  4001e0:	00008067          	ret

004001e4 <readstr>:

// read characters into provided buffer until either user presses enter or the buffer size is reached.
int readstr(char *buf, int size)
{
  4001e4:	00050693          	mv	a3,a0
    int count;
    
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  4001e8:	00100793          	li	a5,1
  4001ec:	04b7d263          	bge	a5,a1,400230 <readstr+0x4c>
  4001f0:	fff58613          	addi	a2,a1,-1
    
    count = 0;
  4001f4:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  4001f8:	ffff0737          	lui	a4,0xffff0
       
       // read next character into the current element of the buffer
       *buf = (char)readchar();
       
       // if the user pressed Enter, stop reading
       if (*buf == '\n') 
  4001fc:	00a00593          	li	a1,10
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400200:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  400204:	fe078ee3          	beqz	a5,400200 <readstr+0x1c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  400208:	00472783          	lw	a5,4(a4)
       *buf = (char)readchar();
  40020c:	0ff7f793          	andi	a5,a5,255
  400210:	00f68023          	sb	a5,0(a3)
       if (*buf == '\n') 
  400214:	00b78a63          	beq	a5,a1,400228 <readstr+0x44>
       {
           break;
       }
       
       // move pointer to the next element of the buffer
       buf += 1;
  400218:	00168693          	addi	a3,a3,1
       
       // increase the number of characters in the buffer
       count += 1;
  40021c:	00150513          	addi	a0,a0,1
       
       // decrease the remaining space in the buffer
       size -= 1;
       
    } while(size > 1);  // keep going until one empty char remains (to hold the final '\0' character
  400220:	fec510e3          	bne	a0,a2,400200 <readstr+0x1c>
       count += 1;
  400224:	00060513          	mv	a0,a2
    
    *buf = '\0';  // add the end-of-string marker '\0'
  400228:	00068023          	sb	zero,0(a3)
    
    return count; // return the number of characters in the read string
  40022c:	00008067          	ret
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  400230:	fff00513          	li	a0,-1
}
  400234:	00008067          	ret

00400238 <readint>:

//read signed integer
int readint()
{
    int res = 0;
    int sign = 1;
  400238:	00100593          	li	a1,1
    int res = 0;
  40023c:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400240:	ffff0737          	lui	a4,0xffff0
           sign = -1;
       }
       else
       {
           // otherwise, if a non-digit is read, it signifies the end of the number
           if (chr < '0' || chr > '9') 
  400244:	00900613          	li	a2,9
       if (res == 0 && sign == 1 && chr == '-') 
  400248:	00100813          	li	a6,1
  40024c:	02d00893          	li	a7,45
           sign = -1;
  400250:	fff00313          	li	t1,-1
  400254:	0200006f          	j	400274 <readint+0x3c>
           if (chr < '0' || chr > '9') 
  400258:	fd068793          	addi	a5,a3,-48
  40025c:	02f66c63          	bltu	a2,a5,400294 <readint+0x5c>
           {
               break;
           }
           // incorporate the read digit into the number (N.B. chr - '0' gived the digit value).
           res = res * 10 + (chr - '0');
  400260:	00251793          	slli	a5,a0,0x2
  400264:	00a787b3          	add	a5,a5,a0
  400268:	00179793          	slli	a5,a5,0x1
  40026c:	fd068693          	addi	a3,a3,-48
  400270:	00f68533          	add	a0,a3,a5
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400274:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  400278:	fe078ee3          	beqz	a5,400274 <readint+0x3c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  40027c:	00472683          	lw	a3,4(a4)
       if (res == 0 && sign == 1 && chr == '-') 
  400280:	fc051ce3          	bnez	a0,400258 <readint+0x20>
  400284:	fd059ae3          	bne	a1,a6,400258 <readint+0x20>
  400288:	fd1698e3          	bne	a3,a7,400258 <readint+0x20>
           sign = -1;
  40028c:	00030593          	mv	a1,t1
  400290:	fe5ff06f          	j	400274 <readint+0x3c>
       }
    }
    
    // return the absolute value of the number (constructed from entered digits) multiplied by the sign.
    return sign * res;
}
  400294:	02b50533          	mul	a0,a0,a1
  400298:	00008067          	ret

0040029c <showpic>:
    # as long as this function is not calling other functions.
    
    .globl showpic
    
showpic:
    li t0,0xffff8000    # starting address of the graphics display
  40029c:	ffff82b7          	lui	t0,0xffff8
    li t1,32            # number of lines on the display (each word encodes one line) 
  4002a0:	02000313          	li	t1,32

004002a4 <loop>:
loop:
    lw t2,0(a0)         # load next line (word) of the picture data
  4002a4:	00052383          	lw	t2,0(a0)
    sw t2,0(t0)         # write it to the corresponding line of the graphics display
  4002a8:	0072a023          	sw	t2,0(t0) # ffff8000 <__stack_init+0xeffe8004>
    addi t0,t0,4        # move to the next line of the graphics display
  4002ac:	00428293          	addi	t0,t0,4
    addi a0,a0,4        # move to the next line of the picture data
  4002b0:	00450513          	addi	a0,a0,4
    addi t1,t1,-1       # reduce the number of remaining lines
  4002b4:	fff30313          	addi	t1,t1,-1
    bnez t1,loop        # keep going until all lines on the display are filled with data
  4002b8:	fe0316e3          	bnez	t1,4002a4 <loop>
    jr ra               # return 
  4002bc:	00008067          	ret

004002c0 <initseed>:
   	# the seed should only be set once at the start of the program
   	# otherwise you can accidentally always get the same number
	.global initseed

initseed:
	la t0, seed		# load address of seed to t0
  4002c0:	00000297          	auipc	t0,0x0
  4002c4:	55828293          	addi	t0,t0,1368 # 400818 <seed>
	li t5, 0x1234		# write-enable signal value
  4002c8:	00001f37          	lui	t5,0x1
  4002cc:	234f0f13          	addi	t5,t5,564 # 1234 <_start-0x3fedcc>
	sw t5, 0(t0)		# enable writing to seed location
  4002d0:	01e2a023          	sw	t5,0(t0)
	sw a0, 0(t0)		# load input seed to memory	
  4002d4:	00a2a023          	sw	a0,0(t0)
	jr ra
  4002d8:	00008067          	ret

004002dc <random>:
	
	.global random
	
random:
	la t0, seed		# load address of seed to t0
  4002dc:	00000297          	auipc	t0,0x0
  4002e0:	53c28293          	addi	t0,t0,1340 # 400818 <seed>
	lw t1, 0(t0)		# load seed to t1
  4002e4:	0002a303          	lw	t1,0(t0)
	mv t1, sp		
  4002e8:	00010313          	mv	t1,sp

004002ec <roll>:
	
roll:
	slli t2, t1, 1		# shift seed to the left and store in t2
  4002ec:	00131393          	slli	t2,t1,0x1
	xor t1, t2, t1		# xor bits in t1 and t2 for a pseudo random number
  4002f0:	0063c333          	xor	t1,t2,t1
	andi a0, t1, 0x700	# extract 3 bit random number from t1 using mask 0000011100000000
  4002f4:	70037513          	andi	a0,t1,1792
	srli a0, a0, 8		# shift bits in t4 to the right so they are the least significant digits
  4002f8:	00855513          	srli	a0,a0,0x8
	beqz a0, roll		# reroll if equal to 0 
  4002fc:	fe0508e3          	beqz	a0,4002ec <roll>
	sw t1, 0(t0)		# set new seed with value of t1
  400300:	0062a023          	sw	t1,0(t0)
	jr ra 			# return
  400304:	00008067          	ret

00400308 <apply_mask>:
#include "matrix.h"

void apply_mask(int piece[SQUARESIZE]){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece[i-piece_row]; // mask row equal current piece row
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400308:	100007b7          	lui	a5,0x10000
  40030c:	0847a783          	lw	a5,132(a5) # 10000084 <piece_col>
  400310:	00800613          	li	a2,8
  400314:	40f60633          	sub	a2,a2,a5
  400318:	00050713          	mv	a4,a0
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40031c:	100007b7          	lui	a5,0x10000
  400320:	0887a783          	lw	a5,136(a5) # 10000088 <piece_row>
  400324:	00279693          	slli	a3,a5,0x2
  400328:	100007b7          	lui	a5,0x10000
  40032c:	00078793          	mv	a5,a5
  400330:	00d787b3          	add	a5,a5,a3
  400334:	01050513          	addi	a0,a0,16
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400338:	00072683          	lw	a3,0(a4)
  40033c:	00c696b3          	sll	a3,a3,a2
  400340:	00d7a023          	sw	a3,0(a5) # 10000000 <piece_mask>
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400344:	00470713          	addi	a4,a4,4
  400348:	00478793          	addi	a5,a5,4
  40034c:	fea716e3          	bne	a4,a0,400338 <apply_mask+0x30>
    }
}
  400350:	00008067          	ret

00400354 <reset_mask>:

void reset_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400354:	100007b7          	lui	a5,0x10000
  400358:	0887a683          	lw	a3,136(a5) # 10000088 <piece_row>
  40035c:	00269693          	slli	a3,a3,0x2
  400360:	10000737          	lui	a4,0x10000
  400364:	00070713          	mv	a4,a4
  400368:	00d707b3          	add	a5,a4,a3
  40036c:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  400370:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 12;
  400374:	0007a703          	lw	a4,0(a5)
  400378:	40c75713          	srai	a4,a4,0xc
  40037c:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400380:	00478793          	addi	a5,a5,4
  400384:	fed798e3          	bne	a5,a3,400374 <reset_mask+0x20>
    }
}
  400388:	00008067          	ret

0040038c <initialize>:

void initialize(){
  40038c:	ff010113          	addi	sp,sp,-16
  400390:	00112623          	sw	ra,12(sp)
    piece_row = 18;
  400394:	100007b7          	lui	a5,0x10000
  400398:	01200713          	li	a4,18
  40039c:	08e7a423          	sw	a4,136(a5) # 10000088 <piece_row>
    piece_col = 0;
  4003a0:	100007b7          	lui	a5,0x10000
  4003a4:	0807a223          	sw	zero,132(a5) # 10000084 <piece_col>
    for (int j = 0; j < SQUARESIZE; j++){
        current_piece[j] = pieces[3][j];
  4003a8:	10000537          	lui	a0,0x10000
  4003ac:	00050513          	mv	a0,a0
  4003b0:	004017b7          	lui	a5,0x401
  4003b4:	81c78793          	addi	a5,a5,-2020 # 40081c <pieces>
  4003b8:	0307a703          	lw	a4,48(a5)
  4003bc:	06e52223          	sw	a4,100(a0) # 10000064 <current_piece>
  4003c0:	0347a703          	lw	a4,52(a5)
  4003c4:	06e52423          	sw	a4,104(a0)
  4003c8:	0387a703          	lw	a4,56(a5)
  4003cc:	06e52623          	sw	a4,108(a0)
  4003d0:	03c7a783          	lw	a5,60(a5)
  4003d4:	06f52823          	sw	a5,112(a0)
    }
    apply_mask(current_piece);
  4003d8:	06450513          	addi	a0,a0,100
  4003dc:	f2dff0ef          	jal	ra,400308 <apply_mask>
}
  4003e0:	00c12083          	lw	ra,12(sp)
  4003e4:	01010113          	addi	sp,sp,16
  4003e8:	00008067          	ret

004003ec <paint_row>:
#include "display.h"

void paint_row(int row, int row_num){
        *((volatile int *)(0xffff8000 + row_num*4)) = row;
  4003ec:	00259593          	slli	a1,a1,0x2
  4003f0:	ffff87b7          	lui	a5,0xffff8
  4003f4:	00f585b3          	add	a1,a1,a5
  4003f8:	00a5a023          	sw	a0,0(a1)
}
  4003fc:	00008067          	ret

00400400 <bit_or_matrix>:
/* matrix operations for binary 2D arrays that are treated as matrices */
#include "matrix.h"

void bit_or_matrix(int size, int matrix1[size], int matrix2[size], int* result){
    for (int i = 0; i < size; i++) {
  400400:	02a05863          	blez	a0,400430 <bit_or_matrix+0x30>
  400404:	00058793          	mv	a5,a1
  400408:	00251513          	slli	a0,a0,0x2
  40040c:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] | matrix2[i];
  400410:	0007a703          	lw	a4,0(a5) # ffff8000 <__stack_init+0xeffe8004>
  400414:	00062583          	lw	a1,0(a2)
  400418:	00b76733          	or	a4,a4,a1
  40041c:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  400420:	00478793          	addi	a5,a5,4
  400424:	00460613          	addi	a2,a2,4
  400428:	00468693          	addi	a3,a3,4
  40042c:	fea792e3          	bne	a5,a0,400410 <bit_or_matrix+0x10>
    }
}
  400430:	00008067          	ret

00400434 <bit_and_matrix>:

void bit_and_matrix(int size, int matrix1[size], int matrix2[size], int* result){
    for (int i = 0; i < size; i++) {
  400434:	02a05863          	blez	a0,400464 <bit_and_matrix+0x30>
  400438:	00058793          	mv	a5,a1
  40043c:	00251513          	slli	a0,a0,0x2
  400440:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] & matrix2[i];
  400444:	0007a703          	lw	a4,0(a5)
  400448:	00062583          	lw	a1,0(a2)
  40044c:	00b77733          	and	a4,a4,a1
  400450:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  400454:	00478793          	addi	a5,a5,4
  400458:	00460613          	addi	a2,a2,4
  40045c:	00468693          	addi	a3,a3,4
  400460:	fea792e3          	bne	a5,a0,400444 <bit_and_matrix+0x10>
    }
}
  400464:	00008067          	ret

00400468 <rotate_cw>:

void rotate_cw(int matrix[SQUARESIZE]){     // pass in the piece matrix and it will get rotated
  400468:	ff010113          	addi	sp,sp,-16
    int temp[SQUARESIZE];

    // Copy the original matrix to a temporary matrix
    for (int i = 0; i < SQUARESIZE; i++) {
  40046c:	00010313          	mv	t1,sp
  400470:	01050613          	addi	a2,a0,16
void rotate_cw(int matrix[SQUARESIZE]){     // pass in the piece matrix and it will get rotated
  400474:	00030713          	mv	a4,t1
  400478:	00050793          	mv	a5,a0
        temp[i] = matrix[i];
  40047c:	0007a683          	lw	a3,0(a5)
  400480:	00d72023          	sw	a3,0(a4)
        matrix[i] = 0;
  400484:	0007a023          	sw	zero,0(a5)
    for (int i = 0; i < SQUARESIZE; i++) {
  400488:	00478793          	addi	a5,a5,4
  40048c:	00470713          	addi	a4,a4,4
  400490:	fec796e3          	bne	a5,a2,40047c <rotate_cw+0x14>
    }

    // rotate matrix cw
    for (int i = 0; i < SQUARESIZE; i++){
  400494:	00000593          	li	a1,0
        for (int j = 0; j < SQUARESIZE; j++){
  400498:	fff00893          	li	a7,-1
    for (int i = 0; i < SQUARESIZE; i++){
  40049c:	00400e13          	li	t3,4
            matrix[j] |= ((temp[i] >> (SQUARESIZE - j - 1)) & 1) << i;
  4004a0:	00032803          	lw	a6,0(t1)
  4004a4:	00050693          	mv	a3,a0
  4004a8:	00300713          	li	a4,3
  4004ac:	40e857b3          	sra	a5,a6,a4
  4004b0:	0017f793          	andi	a5,a5,1
  4004b4:	00b797b3          	sll	a5,a5,a1
  4004b8:	0006a603          	lw	a2,0(a3)
  4004bc:	00f667b3          	or	a5,a2,a5
  4004c0:	00f6a023          	sw	a5,0(a3)
        for (int j = 0; j < SQUARESIZE; j++){
  4004c4:	fff70713          	addi	a4,a4,-1
  4004c8:	00468693          	addi	a3,a3,4
  4004cc:	ff1710e3          	bne	a4,a7,4004ac <rotate_cw+0x44>
    for (int i = 0; i < SQUARESIZE; i++){
  4004d0:	00158593          	addi	a1,a1,1
  4004d4:	00430313          	addi	t1,t1,4
  4004d8:	fdc594e3          	bne	a1,t3,4004a0 <rotate_cw+0x38>
        }
    }
}
  4004dc:	01010113          	addi	sp,sp,16
  4004e0:	00008067          	ret

004004e4 <rotate_ccw>:

void rotate_ccw(int matrix[SQUARESIZE]){    // pass in the piece matrix and it will get rotated
  4004e4:	ff010113          	addi	sp,sp,-16
    int temp[SQUARESIZE];

    // Copy the original matrix to a temporary matrix
    for (int i = 0; i < SQUARESIZE; i++) {
  4004e8:	00050793          	mv	a5,a0
  4004ec:	00010313          	mv	t1,sp
  4004f0:	01050613          	addi	a2,a0,16
void rotate_ccw(int matrix[SQUARESIZE]){    // pass in the piece matrix and it will get rotated
  4004f4:	00030713          	mv	a4,t1
        temp[i] = matrix[i];
  4004f8:	0007a683          	lw	a3,0(a5)
  4004fc:	00d72023          	sw	a3,0(a4)
        matrix[i] = 0;
  400500:	0007a023          	sw	zero,0(a5)
    for (int i = 0; i < SQUARESIZE; i++) {
  400504:	00478793          	addi	a5,a5,4
  400508:	00470713          	addi	a4,a4,4
  40050c:	fec796e3          	bne	a5,a2,4004f8 <rotate_ccw+0x14>
    }

    // Rotate matrix ccw
    for (int i = 0; i < SQUARESIZE; i++){
  400510:	00000593          	li	a1,0
        for (int j = 0; j < SQUARESIZE; j++){
  400514:	00400813          	li	a6,4
            matrix[SQUARESIZE-j-1] |= ((temp[i] >> j) & 1) << i;
  400518:	00032883          	lw	a7,0(t1)
  40051c:	00c50693          	addi	a3,a0,12
        for (int j = 0; j < SQUARESIZE; j++){
  400520:	00000713          	li	a4,0
            matrix[SQUARESIZE-j-1] |= ((temp[i] >> j) & 1) << i;
  400524:	40e8d7b3          	sra	a5,a7,a4
  400528:	0017f793          	andi	a5,a5,1
  40052c:	00b797b3          	sll	a5,a5,a1
  400530:	0006a603          	lw	a2,0(a3)
  400534:	00f667b3          	or	a5,a2,a5
  400538:	00f6a023          	sw	a5,0(a3)
        for (int j = 0; j < SQUARESIZE; j++){
  40053c:	00170713          	addi	a4,a4,1
  400540:	ffc68693          	addi	a3,a3,-4
  400544:	ff0710e3          	bne	a4,a6,400524 <rotate_ccw+0x40>
    for (int i = 0; i < SQUARESIZE; i++){
  400548:	00158593          	addi	a1,a1,1
  40054c:	00430313          	addi	t1,t1,4
  400550:	fd0594e3          	bne	a1,a6,400518 <rotate_ccw+0x34>
        }
    }
}
  400554:	01010113          	addi	sp,sp,16
  400558:	00008067          	ret

0040055c <mv_piece_l>:
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

void mv_piece_l(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40055c:	100007b7          	lui	a5,0x10000
  400560:	0887a683          	lw	a3,136(a5) # 10000088 <piece_row>
  400564:	00269693          	slli	a3,a3,0x2
  400568:	10000737          	lui	a4,0x10000
  40056c:	00070713          	mv	a4,a4
  400570:	00e687b3          	add	a5,a3,a4
  400574:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  400578:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] << 1;
  40057c:	0007a703          	lw	a4,0(a5)
  400580:	00171713          	slli	a4,a4,0x1
  400584:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400588:	00478793          	addi	a5,a5,4
  40058c:	fed798e3          	bne	a5,a3,40057c <mv_piece_l+0x20>
    }
    piece_col -= 1;
  400590:	10000737          	lui	a4,0x10000
  400594:	08472783          	lw	a5,132(a4) # 10000084 <piece_col>
  400598:	fff78793          	addi	a5,a5,-1
  40059c:	08f72223          	sw	a5,132(a4)
}
  4005a0:	00008067          	ret

004005a4 <mv_piece_r>:
void mv_piece_r(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4005a4:	100007b7          	lui	a5,0x10000
  4005a8:	0887a603          	lw	a2,136(a5) # 10000088 <piece_row>
  4005ac:	00261693          	slli	a3,a2,0x2
  4005b0:	10000737          	lui	a4,0x10000
  4005b4:	00070713          	mv	a4,a4
  4005b8:	00e687b3          	add	a5,a3,a4
  4005bc:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  4005c0:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 1;
  4005c4:	0007a703          	lw	a4,0(a5)
  4005c8:	40175713          	srai	a4,a4,0x1
  4005cc:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4005d0:	00478793          	addi	a5,a5,4
  4005d4:	fed798e3          	bne	a5,a3,4005c4 <mv_piece_r+0x20>
    }
    piece_col += 1;
  4005d8:	10000737          	lui	a4,0x10000
  4005dc:	08472783          	lw	a5,132(a4) # 10000084 <piece_col>
  4005e0:	00178793          	addi	a5,a5,1
  4005e4:	08f72223          	sw	a5,132(a4)
    piece_row += 1;
  4005e8:	00160613          	addi	a2,a2,1
  4005ec:	100007b7          	lui	a5,0x10000
  4005f0:	08c7a423          	sw	a2,136(a5) # 10000088 <piece_row>
}
  4005f4:	00008067          	ret

004005f8 <mv_piece_d>:
void mv_piece_d(){
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  4005f8:	100007b7          	lui	a5,0x10000
  4005fc:	0887a603          	lw	a2,136(a5) # 10000088 <piece_row>
  400600:	00261693          	slli	a3,a2,0x2
  400604:	10000737          	lui	a4,0x10000
  400608:	00070713          	mv	a4,a4
  40060c:	00e687b3          	add	a5,a3,a4
  400610:	fec70713          	addi	a4,a4,-20 # fffffec <play_area+0xfbff760>
  400614:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i-1];
  400618:	00c7a683          	lw	a3,12(a5)
  40061c:	00d7a823          	sw	a3,16(a5)
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  400620:	ffc78793          	addi	a5,a5,-4
  400624:	fee79ae3          	bne	a5,a4,400618 <mv_piece_d+0x20>
    }
    piece_row += 1;
  400628:	00160613          	addi	a2,a2,1
  40062c:	100007b7          	lui	a5,0x10000
  400630:	08c7a423          	sw	a2,136(a5) # 10000088 <piece_row>
}
  400634:	00008067          	ret

00400638 <mv_piece_u>:
void mv_piece_u(){
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  400638:	100007b7          	lui	a5,0x10000
  40063c:	0887a703          	lw	a4,136(a5) # 10000088 <piece_row>
  400640:	fff70613          	addi	a2,a4,-1
  400644:	00271693          	slli	a3,a4,0x2
  400648:	10000737          	lui	a4,0x10000
  40064c:	00070713          	mv	a4,a4
  400650:	00e687b3          	add	a5,a3,a4
  400654:	01470713          	addi	a4,a4,20 # 10000014 <piece_mask+0x14>
  400658:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i+1];
  40065c:	0007a683          	lw	a3,0(a5)
  400660:	fed7ae23          	sw	a3,-4(a5)
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  400664:	00478793          	addi	a5,a5,4
  400668:	fee79ae3          	bne	a5,a4,40065c <mv_piece_u+0x24>
    }
    piece_row -= 1;
  40066c:	100007b7          	lui	a5,0x10000
  400670:	08c7a423          	sw	a2,136(a5) # 10000088 <piece_row>
}
  400674:	00008067          	ret

00400678 <r_piece_cw>:
void r_piece_cw(int piece[SQUARESIZE]){
  400678:	ff010113          	addi	sp,sp,-16
  40067c:	00112623          	sw	ra,12(sp)
  400680:	00812423          	sw	s0,8(sp)
  400684:	00050413          	mv	s0,a0
    rotate_cw(piece);
  400688:	de1ff0ef          	jal	ra,400468 <rotate_cw>
    reset_mask();
  40068c:	cc9ff0ef          	jal	ra,400354 <reset_mask>
    apply_mask(piece);
  400690:	00040513          	mv	a0,s0
  400694:	c75ff0ef          	jal	ra,400308 <apply_mask>
}
  400698:	00c12083          	lw	ra,12(sp)
  40069c:	00812403          	lw	s0,8(sp)
  4006a0:	01010113          	addi	sp,sp,16
  4006a4:	00008067          	ret

004006a8 <r_piece_ccw>:
void r_piece_ccw(int piece[SQUARESIZE]){
  4006a8:	ff010113          	addi	sp,sp,-16
  4006ac:	00112623          	sw	ra,12(sp)
  4006b0:	00812423          	sw	s0,8(sp)
  4006b4:	00050413          	mv	s0,a0
    rotate_ccw(piece);
  4006b8:	e2dff0ef          	jal	ra,4004e4 <rotate_ccw>
    reset_mask();
  4006bc:	c99ff0ef          	jal	ra,400354 <reset_mask>
    apply_mask(piece);
  4006c0:	00040513          	mv	a0,s0
  4006c4:	c45ff0ef          	jal	ra,400308 <apply_mask>
}
  4006c8:	00c12083          	lw	ra,12(sp)
  4006cc:	00812403          	lw	s0,8(sp)
  4006d0:	01010113          	addi	sp,sp,16
  4006d4:	00008067          	ret

004006d8 <colision_check>:
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

// checks for colision between the falling piece and the blocks in the playing area
int colision_check(){
  4006d8:	ff010113          	addi	sp,sp,-16
  4006dc:	00112623          	sw	ra,12(sp)
  4006e0:	00812423          	sw	s0,8(sp)
    int ret_val;
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  4006e4:	100007b7          	lui	a5,0x10000
  4006e8:	0887a783          	lw	a5,136(a5) # 10000088 <piece_row>
  4006ec:	00279793          	slli	a5,a5,0x2
  4006f0:	100006b7          	lui	a3,0x10000
  4006f4:	07468413          	addi	s0,a3,116 # 10000074 <result>
  4006f8:	07468693          	addi	a3,a3,116
  4006fc:	00401637          	lui	a2,0x401
  400700:	88c60613          	addi	a2,a2,-1908 # 40088c <play_area>
  400704:	00f60633          	add	a2,a2,a5
  400708:	100005b7          	lui	a1,0x10000
  40070c:	00058593          	mv	a1,a1
  400710:	00f585b3          	add	a1,a1,a5
  400714:	00400513          	li	a0,4
  400718:	d1dff0ef          	jal	ra,400434 <bit_and_matrix>
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
  40071c:	00042783          	lw	a5,0(s0)
  400720:	00442503          	lw	a0,4(s0)
  400724:	00a7e7b3          	or	a5,a5,a0
  400728:	00842503          	lw	a0,8(s0)
  40072c:	00a7e7b3          	or	a5,a5,a0
  400730:	00c42503          	lw	a0,12(s0)
    }
    return ret_val;
}
  400734:	00a7e533          	or	a0,a5,a0
  400738:	00c12083          	lw	ra,12(sp)
  40073c:	00812403          	lw	s0,8(sp)
  400740:	01010113          	addi	sp,sp,16
  400744:	00008067          	ret

00400748 <consolidate_rows>:

// TODO: doesn't work
int consolidate_rows(){
  400748:	ff010113          	addi	sp,sp,-16
  40074c:	00112623          	sw	ra,12(sp)
    // add each of the 4 rows where the piece is to the play area
    bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
  400750:	100007b7          	lui	a5,0x10000
  400754:	0887a783          	lw	a5,136(a5) # 10000088 <piece_row>
  400758:	00279793          	slli	a5,a5,0x2
  40075c:	00401637          	lui	a2,0x401
  400760:	88c60613          	addi	a2,a2,-1908 # 40088c <play_area>
  400764:	00c78633          	add	a2,a5,a2
  400768:	00060693          	mv	a3,a2
  40076c:	100005b7          	lui	a1,0x10000
  400770:	00058593          	mv	a1,a1
  400774:	00f585b3          	add	a1,a1,a5
  400778:	00400513          	li	a0,4
  40077c:	c85ff0ef          	jal	ra,400400 <bit_or_matrix>
    /*for (int i = piece_row; i < SQUARESIZE; i++){
        bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
    }*/
}
  400780:	00c12083          	lw	ra,12(sp)
  400784:	01010113          	addi	sp,sp,16
  400788:	00008067          	ret

0040078c <clear_rows>:

// TODO: doesn't work
int clear_rows(){
    int points = 0;
    for (int i = piece_row; i < SQUARESIZE - 1; i++){ // check each of the 4 rows where the piece is
  40078c:	100007b7          	lui	a5,0x10000
  400790:	0887a603          	lw	a2,136(a5) # 10000088 <piece_row>
  400794:	00200793          	li	a5,2
  400798:	06c7cc63          	blt	a5,a2,400810 <clear_rows+0x84>
  40079c:	00261593          	slli	a1,a2,0x2
  4007a0:	004017b7          	lui	a5,0x401
  4007a4:	88c78793          	addi	a5,a5,-1908 # 40088c <play_area>
  4007a8:	00f585b3          	add	a1,a1,a5
    int points = 0;
  4007ac:	00000513          	li	a0,0
        if (play_area[i] == 0b000000000000){
            points++;
            // this wil break when the piece is off screen @@@@@@@@@@@@@
            for (int j = i; j > 4; j++){
  4007b0:	00400813          	li	a6,4
                play_area[j] = play_area[j-1];
            }
            play_area[4] = 0b100000000001;
  4007b4:	00401e37          	lui	t3,0x401
  4007b8:	88ce0e13          	addi	t3,t3,-1908 # 40088c <play_area>
  4007bc:	00001337          	lui	t1,0x1
  4007c0:	80130313          	addi	t1,t1,-2047 # 801 <_start-0x3ff7ff>
    for (int i = piece_row; i < SQUARESIZE - 1; i++){ // check each of the 4 rows where the piece is
  4007c4:	00300893          	li	a7,3
  4007c8:	0140006f          	j	4007dc <clear_rows+0x50>
            play_area[4] = 0b100000000001;
  4007cc:	006e2823          	sw	t1,16(t3)
    for (int i = piece_row; i < SQUARESIZE - 1; i++){ // check each of the 4 rows where the piece is
  4007d0:	00160613          	addi	a2,a2,1
  4007d4:	00458593          	addi	a1,a1,4 # 10000004 <piece_mask+0x4>
  4007d8:	03160a63          	beq	a2,a7,40080c <clear_rows+0x80>
        if (play_area[i] == 0b000000000000){
  4007dc:	0005a783          	lw	a5,0(a1)
  4007e0:	fe0798e3          	bnez	a5,4007d0 <clear_rows+0x44>
            points++;
  4007e4:	00150513          	addi	a0,a0,1
            for (int j = i; j > 4; j++){
  4007e8:	fec852e3          	bge	a6,a2,4007cc <clear_rows+0x40>
  4007ec:	00058793          	mv	a5,a1
  4007f0:	00060713          	mv	a4,a2
                play_area[j] = play_area[j-1];
  4007f4:	ffc7a683          	lw	a3,-4(a5)
  4007f8:	00d7a023          	sw	a3,0(a5)
            for (int j = i; j > 4; j++){
  4007fc:	00170713          	addi	a4,a4,1
  400800:	00478793          	addi	a5,a5,4
  400804:	fee848e3          	blt	a6,a4,4007f4 <clear_rows+0x68>
  400808:	fc5ff06f          	j	4007cc <clear_rows+0x40>
  40080c:	00008067          	ret
    int points = 0;
  400810:	00000513          	li	a0,0
        }
    }
    return points;
}
  400814:	00008067          	ret
