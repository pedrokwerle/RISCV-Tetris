
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
    initialize();
  400044:	380000ef          	jal	ra,4003c4 <initialize>
    for (int j = 0; j < HEIGHT; j++){
  400048:	00401437          	lui	s0,0x401
  40004c:	8c040913          	addi	s2,s0,-1856 # 4008c0 <play_area>
    initialize();
  400050:	8c040413          	addi	s0,s0,-1856
    for (int j = 0; j < HEIGHT; j++){
  400054:	00000493          	li	s1,0
  400058:	01900993          	li	s3,25
        paint_row(play_area[j], j);
  40005c:	00048593          	mv	a1,s1
  400060:	00042503          	lw	a0,0(s0)
  400064:	414000ef          	jal	ra,400478 <paint_row>
    for (int j = 0; j < HEIGHT; j++){
  400068:	00148493          	addi	s1,s1,1
  40006c:	00440413          	addi	s0,s0,4
  400070:	ff3496e3          	bne	s1,s3,40005c <main+0x40>
    }
    int colision = 0;
    while (colision < 1){
        for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  400074:	100009b7          	lui	s3,0x10000
  400078:	40000b37          	lui	s6,0x40000
  40007c:	fffb0b13          	addi	s6,s6,-1 # 3fffffff <__stack_init+0x2fff0003>
  400080:	10000ab7          	lui	s5,0x10000
  400084:	000a8a93          	mv	s5,s5
  400088:	00401a37          	lui	s4,0x401
  40008c:	8c0a0a13          	addi	s4,s4,-1856 # 4008c0 <play_area>
  400090:	0889a483          	lw	s1,136(s3) # 10000088 <piece_row>
  400094:	fff48413          	addi	s0,s1,-1
  400098:	016484b3          	add	s1,s1,s6
  40009c:	00249493          	slli	s1,s1,0x2
  4000a0:	01548bb3          	add	s7,s1,s5
  4000a4:	014484b3          	add	s1,s1,s4
            paint_row(piece_mask[j] | play_area[j], j);
  4000a8:	000ba503          	lw	a0,0(s7)
  4000ac:	0004a783          	lw	a5,0(s1)
  4000b0:	00040593          	mv	a1,s0
  4000b4:	00f56533          	or	a0,a0,a5
  4000b8:	3c0000ef          	jal	ra,400478 <paint_row>
        for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  4000bc:	00140413          	addi	s0,s0,1
  4000c0:	004b8b93          	addi	s7,s7,4
  4000c4:	00448493          	addi	s1,s1,4
  4000c8:	0889a783          	lw	a5,136(s3)
  4000cc:	00378793          	addi	a5,a5,3
  4000d0:	fc87dce3          	bge	a5,s0,4000a8 <main+0x8c>
        }
<<<<<<< HEAD
        mv_piece_d();
  4000cc:	52c000ef          	jal	ra,4005f8 <mv_piece_d>
=======
        mv_piece_u();
  4000d4:	4fc000ef          	jal	ra,4005d0 <mv_piece_u>
        r_piece_cw();
  4000d8:	538000ef          	jal	ra,400610 <r_piece_cw>
>>>>>>> 9695830 (fixed piece rotation)
        colision = colision_check();
  4000dc:	57c000ef          	jal	ra,400658 <colision_check>
    while (colision < 1){
  4000e0:	faa058e3          	blez	a0,400090 <main+0x74>
    }

    mv_piece_u();
  4000e4:	4ec000ef          	jal	ra,4005d0 <mv_piece_u>
    consolidate_rows();
  4000e8:	5e0000ef          	jal	ra,4006c8 <consolidate_rows>
    //clear_rows();

    for (int j = 0; j < HEIGHT; j++){
  4000ec:	00000413          	li	s0,0
  4000f0:	01900493          	li	s1,25
        paint_row(play_area[j], j);
  4000f4:	00040593          	mv	a1,s0
  4000f8:	00092503          	lw	a0,0(s2)
  4000fc:	37c000ef          	jal	ra,400478 <paint_row>
    for (int j = 0; j < HEIGHT; j++){
  400100:	00140413          	addi	s0,s0,1
  400104:	00490913          	addi	s2,s2,4
  400108:	fe9416e3          	bne	s0,s1,4000f4 <main+0xd8>
    }

}
  40010c:	00000513          	li	a0,0
  400110:	02c12083          	lw	ra,44(sp)
  400114:	02812403          	lw	s0,40(sp)
  400118:	02412483          	lw	s1,36(sp)
  40011c:	02012903          	lw	s2,32(sp)
  400120:	01c12983          	lw	s3,28(sp)
  400124:	01812a03          	lw	s4,24(sp)
  400128:	01412a83          	lw	s5,20(sp)
  40012c:	01012b03          	lw	s6,16(sp)
  400130:	00c12b83          	lw	s7,12(sp)
  400134:	03010113          	addi	sp,sp,48
  400138:	00008067          	ret

0040013c <abs>:
 */

#include "lib.h"

// returns absolute value of its integer argument - a replacement of the standard library function abs() 
inline int abs(int n) { return (n < 0) ? (-n) : n; }
  40013c:	41f55793          	srai	a5,a0,0x1f
  400140:	00a7c533          	xor	a0,a5,a0
  400144:	40f50533          	sub	a0,a0,a5
  400148:	00008067          	ret

0040014c <printchar>:

// prints single character to console - a substitute for the standard library funciton putch(int chr)
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  40014c:	ffff07b7          	lui	a5,0xffff0
  400150:	00a7a623          	sw	a0,12(a5) # ffff000c <__stack_init+0xeffe0010>
  400154:	00008067          	ret

00400158 <println>:
  400158:	ffff07b7          	lui	a5,0xffff0
  40015c:	00a00713          	li	a4,10
  400160:	00e7a623          	sw	a4,12(a5) # ffff000c <__stack_init+0xeffe0010>

// prints newline character to console
void println() { printchar('\n'); }
  400164:	00008067          	ret

00400168 <printstr>:

// prints given string of characters to console - a substitute for the standard library function puts(char *s)
void printstr(char *str)
{
    while (*str != '\0') 
  400168:	00054783          	lbu	a5,0(a0)
  40016c:	00078c63          	beqz	a5,400184 <printstr+0x1c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400170:	ffff0737          	lui	a4,0xffff0
  400174:	00f72623          	sw	a5,12(a4) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(*str);
        str += 1;
  400178:	00150513          	addi	a0,a0,1
    while (*str != '\0') 
  40017c:	00054783          	lbu	a5,0(a0)
  400180:	fe079ae3          	bnez	a5,400174 <printstr+0xc>
    }
}
  400184:	00008067          	ret

00400188 <printint>:

// prints given integer as a signed decimal number
void printint(int n)
{
  400188:	ff010113          	addi	sp,sp,-16
    {
        sign = '-';
    }
    else
    {
        sign = '\0';
  40018c:	41f55813          	srai	a6,a0,0x1f
  400190:	02d87813          	andi	a6,a6,45
  400194:	00410713          	addi	a4,sp,4
  400198:	00900613          	li	a2,9
    
    // produce decimal digits of the number going from right to left, keep them in num[] array.
    do 
    {
        i = i - 1;
        num[i] = abs(n % 10) + '0';
  40019c:	00a00593          	li	a1,10
        i = i - 1;
  4001a0:	fff60613          	addi	a2,a2,-1
        num[i] = abs(n % 10) + '0';
  4001a4:	02b567b3          	rem	a5,a0,a1
  4001a8:	41f7d693          	srai	a3,a5,0x1f
  4001ac:	00f6c7b3          	xor	a5,a3,a5
  4001b0:	40d787b3          	sub	a5,a5,a3
  4001b4:	03078793          	addi	a5,a5,48
  4001b8:	00f70423          	sb	a5,8(a4)
        n = n / 10;
  4001bc:	02b54533          	div	a0,a0,a1
    } while (n != 0);
  4001c0:	fff70713          	addi	a4,a4,-1
  4001c4:	fc051ee3          	bnez	a0,4001a0 <printint+0x18>
    
    //now print the sign of the number and its digits left-to-right.
    if (sign) 
  4001c8:	00080663          	beqz	a6,4001d4 <printint+0x4c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  4001cc:	ffff07b7          	lui	a5,0xffff0
  4001d0:	0107a623          	sw	a6,12(a5) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(sign);
    }
    
    while(i < MAX_INT_DIGITS)
  4001d4:	00900793          	li	a5,9
  4001d8:	02c7c263          	blt	a5,a2,4001fc <printint+0x74>
  4001dc:	00410793          	addi	a5,sp,4
  4001e0:	00c787b3          	add	a5,a5,a2
  4001e4:	00e10693          	addi	a3,sp,14
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  4001e8:	ffff0637          	lui	a2,0xffff0
  4001ec:	0007c703          	lbu	a4,0(a5)
  4001f0:	00e62623          	sw	a4,12(a2) # ffff000c <__stack_init+0xeffe0010>
    while(i < MAX_INT_DIGITS)
  4001f4:	00178793          	addi	a5,a5,1
  4001f8:	fed79ae3          	bne	a5,a3,4001ec <printint+0x64>
    {
        printchar(num[i]);
        i=i+1;
    }
}
  4001fc:	01010113          	addi	sp,sp,16
  400200:	00008067          	ret

00400204 <pollkbd>:


// check if keyboard buffer has some data
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400204:	ffff07b7          	lui	a5,0xffff0
  400208:	0007a503          	lw	a0,0(a5) # ffff0000 <__stack_init+0xeffe0004>
  40020c:	00008067          	ret

00400210 <readchar>:

// read next character from keyboard buffer
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  400210:	ffff07b7          	lui	a5,0xffff0
  400214:	0047a503          	lw	a0,4(a5) # ffff0004 <__stack_init+0xeffe0008>
  400218:	00008067          	ret

0040021c <readstr>:

// read characters into provided buffer until either user presses enter or the buffer size is reached.
int readstr(char *buf, int size)
{
  40021c:	00050693          	mv	a3,a0
    int count;
    
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  400220:	00100793          	li	a5,1
  400224:	04b7d263          	bge	a5,a1,400268 <readstr+0x4c>
  400228:	fff58613          	addi	a2,a1,-1
    
    count = 0;
  40022c:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400230:	ffff0737          	lui	a4,0xffff0
       
       // read next character into the current element of the buffer
       *buf = (char)readchar();
       
       // if the user pressed Enter, stop reading
       if (*buf == '\n') 
  400234:	00a00593          	li	a1,10
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400238:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  40023c:	fe078ee3          	beqz	a5,400238 <readstr+0x1c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  400240:	00472783          	lw	a5,4(a4)
       *buf = (char)readchar();
  400244:	0ff7f793          	andi	a5,a5,255
  400248:	00f68023          	sb	a5,0(a3)
       if (*buf == '\n') 
  40024c:	00b78a63          	beq	a5,a1,400260 <readstr+0x44>
       {
           break;
       }
       
       // move pointer to the next element of the buffer
       buf += 1;
  400250:	00168693          	addi	a3,a3,1
       
       // increase the number of characters in the buffer
       count += 1;
  400254:	00150513          	addi	a0,a0,1
       
       // decrease the remaining space in the buffer
       size -= 1;
       
    } while(size > 1);  // keep going until one empty char remains (to hold the final '\0' character
  400258:	fec510e3          	bne	a0,a2,400238 <readstr+0x1c>
       count += 1;
  40025c:	00060513          	mv	a0,a2
    
    *buf = '\0';  // add the end-of-string marker '\0'
  400260:	00068023          	sb	zero,0(a3)
    
    return count; // return the number of characters in the read string
  400264:	00008067          	ret
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  400268:	fff00513          	li	a0,-1
}
  40026c:	00008067          	ret

00400270 <readint>:

//read signed integer
int readint()
{
    int res = 0;
    int sign = 1;
  400270:	00100593          	li	a1,1
    int res = 0;
  400274:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400278:	ffff0737          	lui	a4,0xffff0
           sign = -1;
       }
       else
       {
           // otherwise, if a non-digit is read, it signifies the end of the number
           if (chr < '0' || chr > '9') 
  40027c:	00900613          	li	a2,9
       if (res == 0 && sign == 1 && chr == '-') 
  400280:	00100813          	li	a6,1
  400284:	02d00893          	li	a7,45
           sign = -1;
  400288:	fff00313          	li	t1,-1
  40028c:	0200006f          	j	4002ac <readint+0x3c>
           if (chr < '0' || chr > '9') 
  400290:	fd068793          	addi	a5,a3,-48
  400294:	02f66c63          	bltu	a2,a5,4002cc <readint+0x5c>
           {
               break;
           }
           // incorporate the read digit into the number (N.B. chr - '0' gived the digit value).
           res = res * 10 + (chr - '0');
  400298:	00251793          	slli	a5,a0,0x2
  40029c:	00a787b3          	add	a5,a5,a0
  4002a0:	00179793          	slli	a5,a5,0x1
  4002a4:	fd068693          	addi	a3,a3,-48
  4002a8:	00f68533          	add	a0,a3,a5
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  4002ac:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  4002b0:	fe078ee3          	beqz	a5,4002ac <readint+0x3c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  4002b4:	00472683          	lw	a3,4(a4)
       if (res == 0 && sign == 1 && chr == '-') 
  4002b8:	fc051ce3          	bnez	a0,400290 <readint+0x20>
  4002bc:	fd059ae3          	bne	a1,a6,400290 <readint+0x20>
  4002c0:	fd1698e3          	bne	a3,a7,400290 <readint+0x20>
           sign = -1;
  4002c4:	00030593          	mv	a1,t1
  4002c8:	fe5ff06f          	j	4002ac <readint+0x3c>
       }
    }
    
    // return the absolute value of the number (constructed from entered digits) multiplied by the sign.
    return sign * res;
}
  4002cc:	02b50533          	mul	a0,a0,a1
  4002d0:	00008067          	ret

004002d4 <showpic>:
    # as long as this function is not calling other functions.
    
    .globl showpic
    
showpic:
    li t0,0xffff8000    # starting address of the graphics display
  4002d4:	ffff82b7          	lui	t0,0xffff8
    li t1,32            # number of lines on the display (each word encodes one line) 
  4002d8:	02000313          	li	t1,32

004002dc <loop>:
loop:
    lw t2,0(a0)         # load next line (word) of the picture data
  4002dc:	00052383          	lw	t2,0(a0)
    sw t2,0(t0)         # write it to the corresponding line of the graphics display
  4002e0:	0072a023          	sw	t2,0(t0) # ffff8000 <__stack_init+0xeffe8004>
    addi t0,t0,4        # move to the next line of the graphics display
  4002e4:	00428293          	addi	t0,t0,4
    addi a0,a0,4        # move to the next line of the picture data
  4002e8:	00450513          	addi	a0,a0,4
    addi t1,t1,-1       # reduce the number of remaining lines
  4002ec:	fff30313          	addi	t1,t1,-1
    bnez t1,loop        # keep going until all lines on the display are filled with data
  4002f0:	fe0316e3          	bnez	t1,4002dc <loop>
    jr ra               # return 
  4002f4:	00008067          	ret

004002f8 <initseed>:
   	# the seed should only be set once at the start of the program
   	# otherwise you can accidentally always get the same number
	.global initseed

initseed:
	la t0, seed		# load address of seed to t0
  4002f8:	00000297          	auipc	t0,0x0
  4002fc:	49428293          	addi	t0,t0,1172 # 40078c <seed>
	li t5, 0x1234		# write-enable signal value
  400300:	00001f37          	lui	t5,0x1
  400304:	234f0f13          	addi	t5,t5,564 # 1234 <_start-0x3fedcc>
	sw t5, 0(t0)		# enable writing to seed location
  400308:	01e2a023          	sw	t5,0(t0)
	sw a0, 0(t0)		# load input seed to memory	
  40030c:	00a2a023          	sw	a0,0(t0)
	jr ra
  400310:	00008067          	ret

00400314 <random>:
	
	.global random
	
random:
	la t0, seed		# load address of seed to t0
  400314:	00000297          	auipc	t0,0x0
  400318:	47828293          	addi	t0,t0,1144 # 40078c <seed>
	lw t1, 0(t0)		# load seed to t1
  40031c:	0002a303          	lw	t1,0(t0)
	mv t1, sp		
  400320:	00010313          	mv	t1,sp

00400324 <roll>:
	
roll:
	slli t2, t1, 1		# shift seed to the left and store in t2
  400324:	00131393          	slli	t2,t1,0x1
	xor t1, t2, t1		# xor bits in t1 and t2 for a pseudo random number
  400328:	0063c333          	xor	t1,t2,t1
	andi a0, t1, 0x700	# extract 3 bit random number from t1 using mask 0000011100000000
  40032c:	70037513          	andi	a0,t1,1792
	srli a0, a0, 8		# shift bits in t4 to the right so they are the least significant digits
  400330:	00855513          	srli	a0,a0,0x8
	beqz a0, roll		# reroll if equal to 0 
  400334:	fe0508e3          	beqz	a0,400324 <roll>
	sw t1, 0(t0)		# set new seed with value of t1
  400338:	0062a023          	sw	t1,0(t0)
	jr ra 			# return
  40033c:	00008067          	ret

<<<<<<< HEAD
00400308 <apply_mask>:
  400308:	100007b7          	lui	a5,0x10000
  40030c:	0847a783          	lw	a5,132(a5) # 10000084 <piece_col>
  400310:	00800613          	li	a2,8
  400314:	40f60633          	sub	a2,a2,a5
  400318:	00050713          	mv	a4,a0
  40031c:	100007b7          	lui	a5,0x10000
  400320:	0887a783          	lw	a5,136(a5) # 10000088 <piece_row>
  400324:	00279693          	slli	a3,a5,0x2
  400328:	100007b7          	lui	a5,0x10000
  40032c:	00078793          	mv	a5,a5
  400330:	00d787b3          	add	a5,a5,a3
  400334:	01050513          	addi	a0,a0,16
  400338:	00072683          	lw	a3,0(a4)
  40033c:	00c696b3          	sll	a3,a3,a2
  400340:	00d7a023          	sw	a3,0(a5) # 10000000 <piece_mask>
  400344:	00470713          	addi	a4,a4,4
  400348:	00478793          	addi	a5,a5,4
  40034c:	fea716e3          	bne	a4,a0,400338 <apply_mask+0x30>
  400350:	00008067          	ret

00400354 <reset_mask>:
  400354:	100007b7          	lui	a5,0x10000
  400358:	0887a683          	lw	a3,136(a5) # 10000088 <piece_row>
  40035c:	00269693          	slli	a3,a3,0x2
  400360:	10000737          	lui	a4,0x10000
  400364:	00070713          	mv	a4,a4
  400368:	00d707b3          	add	a5,a4,a3
  40036c:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  400370:	00d706b3          	add	a3,a4,a3
  400374:	0007a703          	lw	a4,0(a5)
  400378:	40c75713          	srai	a4,a4,0xc
  40037c:	00e7a023          	sw	a4,0(a5)
  400380:	00478793          	addi	a5,a5,4
  400384:	fed798e3          	bne	a5,a3,400374 <reset_mask+0x20>
  400388:	00008067          	ret

0040038c <initialize>:
  40038c:	ff010113          	addi	sp,sp,-16
  400390:	00112623          	sw	ra,12(sp)
  400394:	100007b7          	lui	a5,0x10000
  400398:	01200713          	li	a4,18
  40039c:	08e7a423          	sw	a4,136(a5) # 10000088 <piece_row>
  4003a0:	100007b7          	lui	a5,0x10000
  4003a4:	0807a223          	sw	zero,132(a5) # 10000084 <piece_col>
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
  4003d8:	06450513          	addi	a0,a0,100
  4003dc:	f2dff0ef          	jal	ra,400308 <apply_mask>
  4003e0:	00c12083          	lw	ra,12(sp)
  4003e4:	01010113          	addi	sp,sp,16
  4003e8:	00008067          	ret
=======
00400340 <apply_mask>:

// copy the contents of the piece matrix to the position in the mask indicated by piece_row and piece_col
void apply_mask(int piece[SQUARESIZE]){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = piece[i-piece_row]; // mask row equal current piece row
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400340:	100007b7          	lui	a5,0x10000
  400344:	0847a783          	lw	a5,132(a5) # 10000084 <piece_col>
  400348:	00800613          	li	a2,8
  40034c:	40f60633          	sub	a2,a2,a5
  400350:	00050713          	mv	a4,a0
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400354:	100007b7          	lui	a5,0x10000
  400358:	0887a783          	lw	a5,136(a5) # 10000088 <piece_row>
  40035c:	00279693          	slli	a3,a5,0x2
  400360:	100007b7          	lui	a5,0x10000
  400364:	00078793          	mv	a5,a5
  400368:	00d787b3          	add	a5,a5,a3
  40036c:	01050513          	addi	a0,a0,16
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400370:	00072683          	lw	a3,0(a4)
  400374:	00c696b3          	sll	a3,a3,a2
  400378:	00d7a023          	sw	a3,0(a5) # 10000000 <piece_mask>
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40037c:	00470713          	addi	a4,a4,4
  400380:	00478793          	addi	a5,a5,4
  400384:	fea716e3          	bne	a4,a0,400370 <apply_mask+0x30>
    }
}
  400388:	00008067          	ret

0040038c <reset_mask>:

void reset_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40038c:	100007b7          	lui	a5,0x10000
  400390:	0887a683          	lw	a3,136(a5) # 10000088 <piece_row>
  400394:	00269693          	slli	a3,a3,0x2
  400398:	10000737          	lui	a4,0x10000
  40039c:	00070713          	mv	a4,a4
  4003a0:	00d707b3          	add	a5,a4,a3
  4003a4:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  4003a8:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 12;
  4003ac:	0007a703          	lw	a4,0(a5)
  4003b0:	40c75713          	srai	a4,a4,0xc
  4003b4:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4003b8:	00478793          	addi	a5,a5,4
  4003bc:	fed798e3          	bne	a5,a3,4003ac <reset_mask+0x20>
    }
}
  4003c0:	00008067          	ret

004003c4 <initialize>:

void initialize(){
  4003c4:	ff010113          	addi	sp,sp,-16
  4003c8:	00112623          	sw	ra,12(sp)
    piece_index = 15;
  4003cc:	100007b7          	lui	a5,0x10000
  4003d0:	00f00713          	li	a4,15
  4003d4:	08e7a623          	sw	a4,140(a5) # 1000008c <piece_index>
    piece_row = 16;
  4003d8:	100007b7          	lui	a5,0x10000
  4003dc:	01000713          	li	a4,16
  4003e0:	08e7a423          	sw	a4,136(a5) # 10000088 <piece_row>
    piece_col = 6;
  4003e4:	100007b7          	lui	a5,0x10000
  4003e8:	00600713          	li	a4,6
  4003ec:	08e7a223          	sw	a4,132(a5) # 10000084 <piece_col>
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
  4003f0:	10000537          	lui	a0,0x10000
  4003f4:	00050513          	mv	a0,a0
  4003f8:	004007b7          	lui	a5,0x400
  4003fc:	79078793          	addi	a5,a5,1936 # 400790 <pieces>
  400400:	0f07a703          	lw	a4,240(a5)
  400404:	06e52223          	sw	a4,100(a0) # 10000064 <current_piecem>
  400408:	0f47a703          	lw	a4,244(a5)
  40040c:	06e52423          	sw	a4,104(a0)
  400410:	0f87a703          	lw	a4,248(a5)
  400414:	06e52623          	sw	a4,108(a0)
  400418:	0fc7a783          	lw	a5,252(a5)
  40041c:	06f52823          	sw	a5,112(a0)
    }
    apply_mask(current_piecem);
  400420:	06450513          	addi	a0,a0,100
  400424:	f1dff0ef          	jal	ra,400340 <apply_mask>
}
  400428:	00c12083          	lw	ra,12(sp)
  40042c:	01010113          	addi	sp,sp,16
  400430:	00008067          	ret
>>>>>>> 9695830 (fixed piece rotation)

00400434 <change_piece>:

void change_piece(){
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
  400434:	100007b7          	lui	a5,0x10000
  400438:	08c7a783          	lw	a5,140(a5) # 1000008c <piece_index>
  40043c:	10000737          	lui	a4,0x10000
  400440:	00070713          	mv	a4,a4
  400444:	00479693          	slli	a3,a5,0x4
  400448:	004007b7          	lui	a5,0x400
  40044c:	79078793          	addi	a5,a5,1936 # 400790 <pieces>
  400450:	00d787b3          	add	a5,a5,a3
  400454:	0007a683          	lw	a3,0(a5)
  400458:	06d72223          	sw	a3,100(a4) # 10000064 <current_piecem>
  40045c:	0047a683          	lw	a3,4(a5)
  400460:	06d72423          	sw	a3,104(a4)
  400464:	0087a683          	lw	a3,8(a5)
  400468:	06d72623          	sw	a3,108(a4)
  40046c:	00c7a783          	lw	a5,12(a5)
  400470:	06f72823          	sw	a5,112(a4)
    }
}
  400474:	00008067          	ret

00400478 <paint_row>:
#include "display.h"

void paint_row(int row, int row_num){
        *((volatile int *)(0xffff8000 + row_num*4)) = row;
  400478:	00259593          	slli	a1,a1,0x2
  40047c:	ffff87b7          	lui	a5,0xffff8
  400480:	00f585b3          	add	a1,a1,a5
  400484:	00a5a023          	sw	a0,0(a1)
}
  400488:	00008067          	ret

0040048c <bit_or_matrix>:
/* matrix operations for binary 2D arrays that are treated as matrices */
#include "matrix.h"

void bit_or_matrix(int size, int matrix1[size], int matrix2[size], int* result){
    for (int i = 0; i < size; i++) {
  40048c:	02a05863          	blez	a0,4004bc <bit_or_matrix+0x30>
  400490:	00058793          	mv	a5,a1
  400494:	00251513          	slli	a0,a0,0x2
  400498:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] | matrix2[i];
  40049c:	0007a703          	lw	a4,0(a5) # ffff8000 <__stack_init+0xeffe8004>
  4004a0:	00062583          	lw	a1,0(a2)
  4004a4:	00b76733          	or	a4,a4,a1
  4004a8:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  4004ac:	00478793          	addi	a5,a5,4
  4004b0:	00460613          	addi	a2,a2,4
  4004b4:	00468693          	addi	a3,a3,4
  4004b8:	fea792e3          	bne	a5,a0,40049c <bit_or_matrix+0x10>
    }
}
  4004bc:	00008067          	ret

004004c0 <bit_and_matrix>:

void bit_and_matrix(int size, int matrix1[size], int matrix2[size], int* result){
    for (int i = 0; i < size; i++) {
  4004c0:	02a05863          	blez	a0,4004f0 <bit_and_matrix+0x30>
  4004c4:	00058793          	mv	a5,a1
  4004c8:	00251513          	slli	a0,a0,0x2
  4004cc:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] & matrix2[i];
  4004d0:	0007a703          	lw	a4,0(a5)
  4004d4:	00062583          	lw	a1,0(a2)
  4004d8:	00b77733          	and	a4,a4,a1
  4004dc:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  4004e0:	00478793          	addi	a5,a5,4
  4004e4:	00460613          	addi	a2,a2,4
  4004e8:	00468693          	addi	a3,a3,4
  4004ec:	fea792e3          	bne	a5,a0,4004d0 <bit_and_matrix+0x10>
    }
}
  4004f0:	00008067          	ret

004004f4 <mv_piece_l>:
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

void mv_piece_l(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4004f4:	100007b7          	lui	a5,0x10000
  4004f8:	0887a683          	lw	a3,136(a5) # 10000088 <piece_row>
  4004fc:	00269693          	slli	a3,a3,0x2
  400500:	10000737          	lui	a4,0x10000
  400504:	00070713          	mv	a4,a4
  400508:	00e687b3          	add	a5,a3,a4
  40050c:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  400510:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] << 1;
  400514:	0007a703          	lw	a4,0(a5)
  400518:	00171713          	slli	a4,a4,0x1
  40051c:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400520:	00478793          	addi	a5,a5,4
  400524:	fed798e3          	bne	a5,a3,400514 <mv_piece_l+0x20>
    }
    piece_col -= 1;
  400528:	10000737          	lui	a4,0x10000
  40052c:	08472783          	lw	a5,132(a4) # 10000084 <piece_col>
  400530:	fff78793          	addi	a5,a5,-1
  400534:	08f72223          	sw	a5,132(a4)
}
  400538:	00008067          	ret

0040053c <mv_piece_r>:
void mv_piece_r(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40053c:	100007b7          	lui	a5,0x10000
  400540:	0887a603          	lw	a2,136(a5) # 10000088 <piece_row>
  400544:	00261693          	slli	a3,a2,0x2
  400548:	10000737          	lui	a4,0x10000
  40054c:	00070713          	mv	a4,a4
  400550:	00e687b3          	add	a5,a3,a4
  400554:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask+0x10>
  400558:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 1;
  40055c:	0007a703          	lw	a4,0(a5)
  400560:	40175713          	srai	a4,a4,0x1
  400564:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400568:	00478793          	addi	a5,a5,4
  40056c:	fed798e3          	bne	a5,a3,40055c <mv_piece_r+0x20>
    }
    piece_col += 1;
  400570:	10000737          	lui	a4,0x10000
  400574:	08472783          	lw	a5,132(a4) # 10000084 <piece_col>
  400578:	00178793          	addi	a5,a5,1
  40057c:	08f72223          	sw	a5,132(a4)
    piece_row += 1;
  400580:	00160613          	addi	a2,a2,1
  400584:	100007b7          	lui	a5,0x10000
  400588:	08c7a423          	sw	a2,136(a5) # 10000088 <piece_row>
}
  40058c:	00008067          	ret

00400590 <mv_piece_d>:
void mv_piece_d(){
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  400590:	100007b7          	lui	a5,0x10000
  400594:	0887a603          	lw	a2,136(a5) # 10000088 <piece_row>
  400598:	00261693          	slli	a3,a2,0x2
  40059c:	10000737          	lui	a4,0x10000
  4005a0:	00070713          	mv	a4,a4
  4005a4:	00e687b3          	add	a5,a3,a4
  4005a8:	fec70713          	addi	a4,a4,-20 # fffffec <rotational_vector+0xfbff6c8>
  4005ac:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i-1];
  4005b0:	00c7a683          	lw	a3,12(a5)
  4005b4:	00d7a823          	sw	a3,16(a5)
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  4005b8:	ffc78793          	addi	a5,a5,-4
  4005bc:	fee79ae3          	bne	a5,a4,4005b0 <mv_piece_d+0x20>
    }
    piece_row += 1;
  4005c0:	00160613          	addi	a2,a2,1
  4005c4:	100007b7          	lui	a5,0x10000
  4005c8:	08c7a423          	sw	a2,136(a5) # 10000088 <piece_row>
}
  4005cc:	00008067          	ret

004005d0 <mv_piece_u>:
void mv_piece_u(){
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  4005d0:	100007b7          	lui	a5,0x10000
  4005d4:	0887a703          	lw	a4,136(a5) # 10000088 <piece_row>
  4005d8:	fff70613          	addi	a2,a4,-1
  4005dc:	00271693          	slli	a3,a4,0x2
  4005e0:	10000737          	lui	a4,0x10000
  4005e4:	00070713          	mv	a4,a4
  4005e8:	00e687b3          	add	a5,a3,a4
  4005ec:	01470713          	addi	a4,a4,20 # 10000014 <piece_mask+0x14>
  4005f0:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i+1];
  4005f4:	0007a683          	lw	a3,0(a5)
  4005f8:	fed7ae23          	sw	a3,-4(a5)
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  4005fc:	00478793          	addi	a5,a5,4
  400600:	fee79ae3          	bne	a5,a4,4005f4 <mv_piece_u+0x24>
    }
    piece_row -= 1;
  400604:	100007b7          	lui	a5,0x10000
  400608:	08c7a423          	sw	a2,136(a5) # 10000088 <piece_row>
}
  40060c:	00008067          	ret

00400610 <r_piece_cw>:
void r_piece_cw(){
  400610:	ff010113          	addi	sp,sp,-16
  400614:	00112623          	sw	ra,12(sp)
    piece_index = rotational_vector[piece_index];
  400618:	100006b7          	lui	a3,0x10000
  40061c:	08c6a783          	lw	a5,140(a3) # 1000008c <piece_index>
  400620:	00279713          	slli	a4,a5,0x2
  400624:	004017b7          	lui	a5,0x401
  400628:	92478793          	addi	a5,a5,-1756 # 400924 <rotational_vector>
  40062c:	00e787b3          	add	a5,a5,a4
  400630:	0007a783          	lw	a5,0(a5)
  400634:	08f6a623          	sw	a5,140(a3)
    change_piece();
  400638:	dfdff0ef          	jal	ra,400434 <change_piece>
    reset_mask();
  40063c:	d51ff0ef          	jal	ra,40038c <reset_mask>
    apply_mask(current_piecem);
  400640:	10000537          	lui	a0,0x10000
  400644:	06450513          	addi	a0,a0,100 # 10000064 <current_piecem>
  400648:	cf9ff0ef          	jal	ra,400340 <apply_mask>
}
  40064c:	00c12083          	lw	ra,12(sp)
  400650:	01010113          	addi	sp,sp,16
  400654:	00008067          	ret

00400658 <colision_check>:
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

// checks for colision between the falling piece and the blocks in the playing area
int colision_check(){
  400658:	ff010113          	addi	sp,sp,-16
  40065c:	00112623          	sw	ra,12(sp)
  400660:	00812423          	sw	s0,8(sp)
    int ret_val;
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  400664:	100007b7          	lui	a5,0x10000
  400668:	0887a783          	lw	a5,136(a5) # 10000088 <piece_row>
  40066c:	00279793          	slli	a5,a5,0x2
  400670:	100006b7          	lui	a3,0x10000
  400674:	07468413          	addi	s0,a3,116 # 10000074 <result>
  400678:	07468693          	addi	a3,a3,116
  40067c:	00401637          	lui	a2,0x401
  400680:	8c060613          	addi	a2,a2,-1856 # 4008c0 <play_area>
  400684:	00f60633          	add	a2,a2,a5
  400688:	100005b7          	lui	a1,0x10000
  40068c:	00058593          	mv	a1,a1
  400690:	00f585b3          	add	a1,a1,a5
  400694:	00400513          	li	a0,4
  400698:	e29ff0ef          	jal	ra,4004c0 <bit_and_matrix>
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
  40069c:	00042783          	lw	a5,0(s0)
  4006a0:	00442503          	lw	a0,4(s0)
  4006a4:	00a7e7b3          	or	a5,a5,a0
  4006a8:	00842503          	lw	a0,8(s0)
  4006ac:	00a7e7b3          	or	a5,a5,a0
  4006b0:	00c42503          	lw	a0,12(s0)
    }
    return ret_val;
}
  4006b4:	00a7e533          	or	a0,a5,a0
  4006b8:	00c12083          	lw	ra,12(sp)
  4006bc:	00812403          	lw	s0,8(sp)
  4006c0:	01010113          	addi	sp,sp,16
  4006c4:	00008067          	ret

004006c8 <consolidate_rows>:

// TODO: doesn't work
int consolidate_rows(){
  4006c8:	ff010113          	addi	sp,sp,-16
  4006cc:	00112623          	sw	ra,12(sp)
    // add each of the 4 rows where the piece is to the play area
    bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
  4006d0:	100007b7          	lui	a5,0x10000
  4006d4:	0887a783          	lw	a5,136(a5) # 10000088 <piece_row>
  4006d8:	00279793          	slli	a5,a5,0x2
  4006dc:	00401637          	lui	a2,0x401
  4006e0:	8c060613          	addi	a2,a2,-1856 # 4008c0 <play_area>
  4006e4:	00c78633          	add	a2,a5,a2
  4006e8:	00060693          	mv	a3,a2
  4006ec:	100005b7          	lui	a1,0x10000
  4006f0:	00058593          	mv	a1,a1
  4006f4:	00f585b3          	add	a1,a1,a5
  4006f8:	00400513          	li	a0,4
  4006fc:	d91ff0ef          	jal	ra,40048c <bit_or_matrix>
    /*for (int i = piece_row; i < SQUARESIZE; i++){
        bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
    }*/
}
  400700:	00c12083          	lw	ra,12(sp)
  400704:	01010113          	addi	sp,sp,16
  400708:	00008067          	ret

0040070c <clear_rows>:

// TODO: doesn't work
int clear_rows(){
    int points = 0;
    for (int i = piece_row; i < SQUARESIZE - 1; i++){ // check each of the 4 rows where the piece is
  40070c:	100007b7          	lui	a5,0x10000
  400710:	0887a703          	lw	a4,136(a5) # 10000088 <piece_row>
  400714:	00200793          	li	a5,2
  400718:	06e7c663          	blt	a5,a4,400784 <clear_rows+0x78>
  40071c:	00271793          	slli	a5,a4,0x2
  400720:	004016b7          	lui	a3,0x401
  400724:	8c068693          	addi	a3,a3,-1856 # 4008c0 <play_area>
  400728:	00d787b3          	add	a5,a5,a3
    int points = 0;
  40072c:	00000513          	li	a0,0
        if (play_area[i] == 0b111111111111){
  400730:	000016b7          	lui	a3,0x1
  400734:	fff68593          	addi	a1,a3,-1 # fff <_start-0x3ff001>
            points++;
            // this wil break when the piece is off screen @@@@@@@@@@@@@
            for (int j = i; j > 4; j--){
  400738:	00400e13          	li	t3,4
                play_area[j] = play_area[j-1];
            }
            play_area[4] = 0b100000000001;
  40073c:	00401337          	lui	t1,0x401
  400740:	8c030313          	addi	t1,t1,-1856 # 4008c0 <play_area>
  400744:	80168893          	addi	a7,a3,-2047
    for (int i = piece_row; i < SQUARESIZE - 1; i++){ // check each of the 4 rows where the piece is
  400748:	00300613          	li	a2,3
  40074c:	01c0006f          	j	400768 <clear_rows+0x5c>
                play_area[j] = play_area[j-1];
  400750:	ffc7a683          	lw	a3,-4(a5)
  400754:	00d7a023          	sw	a3,0(a5)
            for (int j = i; j > 4; j--){
  400758:	0200006f          	j	400778 <clear_rows+0x6c>
    for (int i = piece_row; i < SQUARESIZE - 1; i++){ // check each of the 4 rows where the piece is
  40075c:	00170713          	addi	a4,a4,1
  400760:	00478793          	addi	a5,a5,4
  400764:	00c70e63          	beq	a4,a2,400780 <clear_rows+0x74>
        if (play_area[i] == 0b111111111111){
  400768:	0007a683          	lw	a3,0(a5)
  40076c:	feb698e3          	bne	a3,a1,40075c <clear_rows+0x50>
            points++;
  400770:	00150513          	addi	a0,a0,1
            for (int j = i; j > 4; j--){
  400774:	fcee4ee3          	blt	t3,a4,400750 <clear_rows+0x44>
            play_area[4] = 0b100000000001;
  400778:	01132823          	sw	a7,16(t1)
  40077c:	fe1ff06f          	j	40075c <clear_rows+0x50>
  400780:	00008067          	ret
    int points = 0;
  400784:	00000513          	li	a0,0
        }
    }
    return points;
}
  400788:	00008067          	ret
