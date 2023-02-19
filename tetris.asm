
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
  400048:	360000ef          	jal	ra,4003a8 <initialize>
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
  400068:	448000ef          	jal	ra,4004b0 <paint_row>
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
        consolidate_rows();
        points = clear_rows();
		printint(points);
		println();

        for (int j = 0; j < HEIGHT-1; j++){
  400094:	01800a13          	li	s4,24
  400098:	0600006f          	j	4000f8 <main+0xdc>
            else if(pollRightFlag()){
  40009c:	119000ef          	jal	ra,4009b4 <pollRightFlag>
  4000a0:	06050463          	beqz	a0,400108 <main+0xec>
            mv_piece_r();
  4000a4:	524000ef          	jal	ra,4005c8 <mv_piece_r>
            lowerFlags();
  4000a8:	125000ef          	jal	ra,4009cc <lowerFlags>
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
  4000d4:	3dc000ef          	jal	ra,4004b0 <paint_row>
            for (int j = piece_row-1; j < piece_row + SQUARESIZE; j++){
  4000d8:	00140413          	addi	s0,s0,1
  4000dc:	00490913          	addi	s2,s2,4
  4000e0:	00448493          	addi	s1,s1,4
  4000e4:	0ec9a783          	lw	a5,236(s3)
  4000e8:	00378793          	addi	a5,a5,3
  4000ec:	fc87dce3          	bge	a5,s0,4000c4 <main+0xa8>
            colision = colision_check();
  4000f0:	69c000ef          	jal	ra,40078c <colision_check>
        while (colision < 1){
  4000f4:	02a04663          	bgtz	a0,400120 <main+0x104>
            if(pollLeftFlag()){
  4000f8:	0b1000ef          	jal	ra,4009a8 <pollLeftFlag>
  4000fc:	fa0500e3          	beqz	a0,40009c <main+0x80>
            mv_piece_l();
  400100:	42c000ef          	jal	ra,40052c <mv_piece_l>
  400104:	fa5ff06f          	j	4000a8 <main+0x8c>
            else if(pollRotFlag()){
  400108:	0b9000ef          	jal	ra,4009c0 <pollRotFlag>
  40010c:	00050663          	beqz	a0,400118 <main+0xfc>
            r_piece_cw();
  400110:	5dc000ef          	jal	ra,4006ec <r_piece_cw>
  400114:	f95ff06f          	j	4000a8 <main+0x8c>
            mv_piece_d();
  400118:	554000ef          	jal	ra,40066c <mv_piece_d>
  40011c:	f8dff06f          	j	4000a8 <main+0x8c>
        consolidate_rows();
  400120:	760000ef          	jal	ra,400880 <consolidate_rows>
        points = clear_rows();
  400124:	7a0000ef          	jal	ra,4008c4 <clear_rows>
		printint(points);
  400128:	07c000ef          	jal	ra,4001a4 <printint>
		println();
  40012c:	048000ef          	jal	ra,400174 <println>
  400130:	000c0493          	mv	s1,s8
        for (int j = 0; j < HEIGHT-1; j++){
  400134:	00000413          	li	s0,0
            paint_row(play_area[j], j);
  400138:	00040593          	mv	a1,s0
  40013c:	0004a503          	lw	a0,0(s1)
  400140:	370000ef          	jal	ra,4004b0 <paint_row>
        for (int j = 0; j < HEIGHT-1; j++){
  400144:	00140413          	addi	s0,s0,1
  400148:	00448493          	addi	s1,s1,4
  40014c:	ff4416e3          	bne	s0,s4,400138 <main+0x11c>
        }
        tetris_god_senpai();
  400150:	009000ef          	jal	ra,400958 <tetris_god_senpai>
    while(1){
  400154:	fa5ff06f          	j	4000f8 <main+0xdc>

00400158 <abs>:
 */

#include "lib.h"

// returns absolute value of its integer argument - a replacement of the standard library function abs() 
inline int abs(int n) { return (n < 0) ? (-n) : n; }
  400158:	41f55793          	srai	a5,a0,0x1f
  40015c:	00a7c533          	xor	a0,a5,a0
  400160:	40f50533          	sub	a0,a0,a5
  400164:	00008067          	ret

00400168 <printchar>:

// prints single character to console - a substitute for the standard library funciton putch(int chr)
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400168:	ffff07b7          	lui	a5,0xffff0
  40016c:	00a7a623          	sw	a0,12(a5) # ffff000c <__stack_init+0xeffe0010>
  400170:	00008067          	ret

00400174 <println>:
  400174:	ffff07b7          	lui	a5,0xffff0
  400178:	00a00713          	li	a4,10
  40017c:	00e7a623          	sw	a4,12(a5) # ffff000c <__stack_init+0xeffe0010>

// prints newline character to console
void println() { printchar('\n'); }
  400180:	00008067          	ret

00400184 <printstr>:

// prints given string of characters to console - a substitute for the standard library function puts(char *s)
void printstr(char *str)
{
    while (*str != '\0') 
  400184:	00054783          	lbu	a5,0(a0)
  400188:	00078c63          	beqz	a5,4001a0 <printstr+0x1c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  40018c:	ffff0737          	lui	a4,0xffff0
  400190:	00f72623          	sw	a5,12(a4) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(*str);
        str += 1;
  400194:	00150513          	addi	a0,a0,1
    while (*str != '\0') 
  400198:	00054783          	lbu	a5,0(a0)
  40019c:	fe079ae3          	bnez	a5,400190 <printstr+0xc>
    }
}
  4001a0:	00008067          	ret

004001a4 <printint>:

// prints given integer as a signed decimal number
void printint(int n)
{
  4001a4:	ff010113          	addi	sp,sp,-16
    {
        sign = '-';
    }
    else
    {
        sign = '\0';
  4001a8:	41f55813          	srai	a6,a0,0x1f
  4001ac:	02d87813          	andi	a6,a6,45
  4001b0:	00410713          	addi	a4,sp,4
  4001b4:	00900613          	li	a2,9
    
    // produce decimal digits of the number going from right to left, keep them in num[] array.
    do 
    {
        i = i - 1;
        num[i] = abs(n % 10) + '0';
  4001b8:	00a00593          	li	a1,10
        i = i - 1;
  4001bc:	fff60613          	addi	a2,a2,-1
        num[i] = abs(n % 10) + '0';
  4001c0:	02b567b3          	rem	a5,a0,a1
  4001c4:	41f7d693          	srai	a3,a5,0x1f
  4001c8:	00f6c7b3          	xor	a5,a3,a5
  4001cc:	40d787b3          	sub	a5,a5,a3
  4001d0:	03078793          	addi	a5,a5,48
  4001d4:	00f70423          	sb	a5,8(a4)
        n = n / 10;
  4001d8:	02b54533          	div	a0,a0,a1
    } while (n != 0);
  4001dc:	fff70713          	addi	a4,a4,-1
  4001e0:	fc051ee3          	bnez	a0,4001bc <printint+0x18>
    
    //now print the sign of the number and its digits left-to-right.
    if (sign) 
  4001e4:	00080663          	beqz	a6,4001f0 <printint+0x4c>
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  4001e8:	ffff07b7          	lui	a5,0xffff0
  4001ec:	0107a623          	sw	a6,12(a5) # ffff000c <__stack_init+0xeffe0010>
    {
        printchar(sign);
    }
    
    while(i < MAX_INT_DIGITS)
  4001f0:	00900793          	li	a5,9
  4001f4:	02c7c263          	blt	a5,a2,400218 <printint+0x74>
  4001f8:	00410793          	addi	a5,sp,4
  4001fc:	00c787b3          	add	a5,a5,a2
  400200:	00e10693          	addi	a3,sp,14
inline void printchar(char chr) { *((volatile int *)0xffff000c) = chr; }  // write into TDR (don't forget to specify "volatile" !)
  400204:	ffff0637          	lui	a2,0xffff0
  400208:	0007c703          	lbu	a4,0(a5)
  40020c:	00e62623          	sw	a4,12(a2) # ffff000c <__stack_init+0xeffe0010>
    while(i < MAX_INT_DIGITS)
  400210:	00178793          	addi	a5,a5,1
  400214:	fed79ae3          	bne	a5,a3,400208 <printint+0x64>
    {
        printchar(num[i]);
        i=i+1;
    }
}
  400218:	01010113          	addi	sp,sp,16
  40021c:	00008067          	ret

00400220 <pollkbd>:


// check if keyboard buffer has some data
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400220:	ffff07b7          	lui	a5,0xffff0
  400224:	0007a503          	lw	a0,0(a5) # ffff0000 <__stack_init+0xeffe0004>
  400228:	00008067          	ret

0040022c <readchar>:

// read next character from keyboard buffer
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  40022c:	ffff07b7          	lui	a5,0xffff0
  400230:	0047a503          	lw	a0,4(a5) # ffff0004 <__stack_init+0xeffe0008>
  400234:	00008067          	ret

00400238 <readstr>:

// read characters into provided buffer until either user presses enter or the buffer size is reached.
int readstr(char *buf, int size)
{
  400238:	00050693          	mv	a3,a0
    int count;
    
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  40023c:	00100793          	li	a5,1
  400240:	04b7d263          	bge	a5,a1,400284 <readstr+0x4c>
  400244:	fff58613          	addi	a2,a1,-1
    
    count = 0;
  400248:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  40024c:	ffff0737          	lui	a4,0xffff0
       
       // read next character into the current element of the buffer
       *buf = (char)readchar();
       
       // if the user pressed Enter, stop reading
       if (*buf == '\n') 
  400250:	00a00593          	li	a1,10
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400254:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  400258:	fe078ee3          	beqz	a5,400254 <readstr+0x1c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  40025c:	00472783          	lw	a5,4(a4)
       *buf = (char)readchar();
  400260:	0ff7f793          	andi	a5,a5,255
  400264:	00f68023          	sb	a5,0(a3)
       if (*buf == '\n') 
  400268:	00b78a63          	beq	a5,a1,40027c <readstr+0x44>
       {
           break;
       }
       
       // move pointer to the next element of the buffer
       buf += 1;
  40026c:	00168693          	addi	a3,a3,1
       
       // increase the number of characters in the buffer
       count += 1;
  400270:	00150513          	addi	a0,a0,1
       
       // decrease the remaining space in the buffer
       size -= 1;
       
    } while(size > 1);  // keep going until one empty char remains (to hold the final '\0' character
  400274:	fec510e3          	bne	a0,a2,400254 <readstr+0x1c>
       count += 1;
  400278:	00060513          	mv	a0,a2
    
    *buf = '\0';  // add the end-of-string marker '\0'
  40027c:	00068023          	sb	zero,0(a3)
    
    return count; // return the number of characters in the read string
  400280:	00008067          	ret
    if (size < 2) return -1; // needs at least 2 bytes in the buffer to read at least 1 character 
  400284:	fff00513          	li	a0,-1
}
  400288:	00008067          	ret

0040028c <readint>:

//read signed integer
int readint()
{
    int res = 0;
    int sign = 1;
  40028c:	00100593          	li	a1,1
    int res = 0;
  400290:	00000513          	li	a0,0
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  400294:	ffff0737          	lui	a4,0xffff0
           sign = -1;
       }
       else
       {
           // otherwise, if a non-digit is read, it signifies the end of the number
           if (chr < '0' || chr > '9') 
  400298:	00900613          	li	a2,9
       if (res == 0 && sign == 1 && chr == '-') 
  40029c:	00100813          	li	a6,1
  4002a0:	02d00893          	li	a7,45
           sign = -1;
  4002a4:	fff00313          	li	t1,-1
  4002a8:	0200006f          	j	4002c8 <readint+0x3c>
           if (chr < '0' || chr > '9') 
  4002ac:	fd068793          	addi	a5,a3,-48
  4002b0:	02f66c63          	bltu	a2,a5,4002e8 <readint+0x5c>
           {
               break;
           }
           // incorporate the read digit into the number (N.B. chr - '0' gived the digit value).
           res = res * 10 + (chr - '0');
  4002b4:	00251793          	slli	a5,a0,0x2
  4002b8:	00a787b3          	add	a5,a5,a0
  4002bc:	00179793          	slli	a5,a5,0x1
  4002c0:	fd068693          	addi	a3,a3,-48
  4002c4:	00f68533          	add	a0,a3,a5
inline int pollkbd() { return *((volatile int *)0xffff0000); } // returns value of RCR  (don't forget to specify "volatile"!) 
  4002c8:	00072783          	lw	a5,0(a4) # ffff0000 <__stack_init+0xeffe0004>
       while (pollkbd() == 0) 
  4002cc:	fe078ee3          	beqz	a5,4002c8 <readint+0x3c>
inline int readchar() { return *((volatile int *)0xffff0004); } // returns value of RDR  (don't forget to specify "volatile"!) 
  4002d0:	00472683          	lw	a3,4(a4)
       if (res == 0 && sign == 1 && chr == '-') 
  4002d4:	fc051ce3          	bnez	a0,4002ac <readint+0x20>
  4002d8:	fd059ae3          	bne	a1,a6,4002ac <readint+0x20>
  4002dc:	fd1698e3          	bne	a3,a7,4002ac <readint+0x20>
           sign = -1;
  4002e0:	00030593          	mv	a1,t1
  4002e4:	fe5ff06f          	j	4002c8 <readint+0x3c>
       }
    }
    
    // return the absolute value of the number (constructed from entered digits) multiplied by the sign.
    return sign * res;
}
  4002e8:	02b50533          	mul	a0,a0,a1
  4002ec:	00008067          	ret

004002f0 <showpic>:
    # as long as this function is not calling other functions.
    
    .globl showpic
    
showpic:
    li t0,0xffff8000    # starting address of the graphics display
  4002f0:	ffff82b7          	lui	t0,0xffff8
    li t1,32            # number of lines on the display (each word encodes one line) 
  4002f4:	02000313          	li	t1,32

004002f8 <loop>:
loop:
    lw t2,0(a0)         # load next line (word) of the picture data
  4002f8:	00052383          	lw	t2,0(a0)
    sw t2,0(t0)         # write it to the corresponding line of the graphics display
  4002fc:	0072a023          	sw	t2,0(t0) # ffff8000 <__stack_init+0xeffe8004>
    addi t0,t0,4        # move to the next line of the graphics display
  400300:	00428293          	addi	t0,t0,4
    addi a0,a0,4        # move to the next line of the picture data
  400304:	00450513          	addi	a0,a0,4
    addi t1,t1,-1       # reduce the number of remaining lines
  400308:	fff30313          	addi	t1,t1,-1
    bnez t1,loop        # keep going until all lines on the display are filled with data
  40030c:	fe0316e3          	bnez	t1,4002f8 <loop>
    jr ra               # return 
  400310:	00008067          	ret

00400314 <random>:
   	# otherwise you can accidentally always get the same number
	
	.global random
	
random:
	li a7, 42		# Load the system call number for the getrandom function into a7
  400314:	02a00893          	li	a7,42
	li a1, 18		# Load the upper bound of the integer into a1
  400318:	01200593          	li	a1,18
	ecall			# Invoke syscall RandIntRange
  40031c:	00000073          	ecall
	jr ra			# Return
  400320:	00008067          	ret

00400324 <apply_mask>:

// copy the contents of the current_piecem to the position in the mask indicated by piece_row and piece_col
void apply_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
        piece_mask[i] = current_piecem[i-piece_row]; // mask row equal current piece row
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400324:	100007b7          	lui	a5,0x10000
  400328:	0e87a783          	lw	a5,232(a5) # 100000e8 <piece_col>
  40032c:	00800593          	li	a1,8
  400330:	40f585b3          	sub	a1,a1,a5
  400334:	100007b7          	lui	a5,0x10000
  400338:	00078793          	mv	a5,a5
  40033c:	01078613          	addi	a2,a5,16 # 10000010 <piece_mask>
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400340:	10000737          	lui	a4,0x10000
  400344:	0ec72703          	lw	a4,236(a4) # 100000ec <piece_row>
  400348:	00271713          	slli	a4,a4,0x2
  40034c:	00e60733          	add	a4,a2,a4
        piece_mask[i] = (piece_mask[i] << (12 - SQUARESIZE - piece_col)); // shift the mask back to its original position
  400350:	0007a683          	lw	a3,0(a5)
  400354:	00b696b3          	sll	a3,a3,a1
  400358:	00d72023          	sw	a3,0(a4)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40035c:	00478793          	addi	a5,a5,4
  400360:	00470713          	addi	a4,a4,4
  400364:	fec796e3          	bne	a5,a2,400350 <apply_mask+0x2c>
    }
}
  400368:	00008067          	ret

0040036c <reset_mask>:

void reset_mask(){
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40036c:	100007b7          	lui	a5,0x10000
  400370:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  400374:	00269693          	slli	a3,a3,0x2
  400378:	10000737          	lui	a4,0x10000
  40037c:	00070713          	mv	a4,a4
  400380:	01070793          	addi	a5,a4,16 # 10000010 <piece_mask>
  400384:	00d787b3          	add	a5,a5,a3
  400388:	02070713          	addi	a4,a4,32
  40038c:	00d706b3          	add	a3,a4,a3
        piece_mask[i] = piece_mask[i] >> 12;
  400390:	0007a703          	lw	a4,0(a5)
  400394:	40c75713          	srai	a4,a4,0xc
  400398:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40039c:	00478793          	addi	a5,a5,4
  4003a0:	fed798e3          	bne	a5,a3,400390 <reset_mask+0x24>
    }
}
  4003a4:	00008067          	ret

004003a8 <initialize>:

void initialize(){
  4003a8:	ff010113          	addi	sp,sp,-16
  4003ac:	00112623          	sw	ra,12(sp)
    piece_index = 0;
  4003b0:	100007b7          	lui	a5,0x10000
  4003b4:	0e07a823          	sw	zero,240(a5) # 100000f0 <piece_index>
    piece_row = 16;
  4003b8:	100007b7          	lui	a5,0x10000
  4003bc:	01000713          	li	a4,16
  4003c0:	0ee7a623          	sw	a4,236(a5) # 100000ec <piece_row>
    piece_col = 6;
  4003c4:	100007b7          	lui	a5,0x10000
  4003c8:	00600713          	li	a4,6
  4003cc:	0ee7a423          	sw	a4,232(a5) # 100000e8 <piece_col>
    // set the play area to its initial state
    play_area[0] = 0b111111111111;
  4003d0:	10000737          	lui	a4,0x10000
  4003d4:	00070713          	mv	a4,a4
  4003d8:	000017b7          	lui	a5,0x1
  4003dc:	fff78793          	addi	a5,a5,-1 # fff <_start-0x3ff001>
  4003e0:	06f72a23          	sw	a5,116(a4) # 10000074 <play_area>
    play_area[1] = 0b111111111111;
  4003e4:	06f72c23          	sw	a5,120(a4)
    play_area[2] = 0b111111111111;
  4003e8:	06f72e23          	sw	a5,124(a4)
    play_area[3] = 0b111111111111;
  4003ec:	08f72023          	sw	a5,128(a4)
    for (int i = 4; i < HEIGHT-1; i++){
  4003f0:	08470793          	addi	a5,a4,132
  4003f4:	0d470713          	addi	a4,a4,212
        play_area[i] = 0b100000000001;
  4003f8:	000016b7          	lui	a3,0x1
  4003fc:	80168693          	addi	a3,a3,-2047 # 801 <_start-0x3ff7ff>
  400400:	00d7a023          	sw	a3,0(a5)
    for (int i = 4; i < HEIGHT-1; i++){
  400404:	00478793          	addi	a5,a5,4
  400408:	fee79ce3          	bne	a5,a4,400400 <initialize+0x58>
    }
    play_area[HEIGHT-4] = 0b111111100111;
  40040c:	100007b7          	lui	a5,0x10000
  400410:	00078793          	mv	a5,a5
  400414:	00001737          	lui	a4,0x1
  400418:	fe770693          	addi	a3,a4,-25 # fe7 <_start-0x3ff019>
  40041c:	0cd7a423          	sw	a3,200(a5) # 100000c8 <play_area+0x54>
    play_area[HEIGHT-3] = 0b111111110111;
  400420:	ff770613          	addi	a2,a4,-9
  400424:	0cc7a623          	sw	a2,204(a5)
    play_area[HEIGHT-2] = 0b111111100111;
  400428:	0cd7a823          	sw	a3,208(a5)
    play_area[HEIGHT-1] = 0b111111111111;
  40042c:	fff70713          	addi	a4,a4,-1
  400430:	0ce7aa23          	sw	a4,212(a5)
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
  400434:	00401737          	lui	a4,0x401
  400438:	9dc70713          	addi	a4,a4,-1572 # 4009dc <pieces>
  40043c:	00072683          	lw	a3,0(a4)
  400440:	00d7a023          	sw	a3,0(a5)
  400444:	00472683          	lw	a3,4(a4)
  400448:	00d7a223          	sw	a3,4(a5)
  40044c:	00872683          	lw	a3,8(a4)
  400450:	00d7a423          	sw	a3,8(a5)
  400454:	00c72703          	lw	a4,12(a4)
  400458:	00e7a623          	sw	a4,12(a5)
    }
    apply_mask();
  40045c:	ec9ff0ef          	jal	ra,400324 <apply_mask>
}
  400460:	00c12083          	lw	ra,12(sp)
  400464:	01010113          	addi	sp,sp,16
  400468:	00008067          	ret

0040046c <change_piece>:

void change_piece(){
    for (int j = 0; j < SQUARESIZE; j++){
        current_piecem[j] = pieces[piece_index][j];
  40046c:	100007b7          	lui	a5,0x10000
  400470:	0f07a783          	lw	a5,240(a5) # 100000f0 <piece_index>
  400474:	10000737          	lui	a4,0x10000
  400478:	00070713          	mv	a4,a4
  40047c:	00479693          	slli	a3,a5,0x4
  400480:	004017b7          	lui	a5,0x401
  400484:	9dc78793          	addi	a5,a5,-1572 # 4009dc <pieces>
  400488:	00d787b3          	add	a5,a5,a3
  40048c:	0007a683          	lw	a3,0(a5)
  400490:	00d72023          	sw	a3,0(a4) # 10000000 <current_piecem>
  400494:	0047a683          	lw	a3,4(a5)
  400498:	00d72223          	sw	a3,4(a4)
  40049c:	0087a683          	lw	a3,8(a5)
  4004a0:	00d72423          	sw	a3,8(a4)
  4004a4:	00c7a783          	lw	a5,12(a5)
  4004a8:	00f72623          	sw	a5,12(a4)
    }
}
  4004ac:	00008067          	ret

004004b0 <paint_row>:
#include "display.h"
#include "shapes.h"

void paint_row(int row, int row_num){
        *((volatile int *)(0xffff8000 + row_num*4)) = row;
  4004b0:	00259593          	slli	a1,a1,0x2
  4004b4:	ffff87b7          	lui	a5,0xffff8
  4004b8:	00f585b3          	add	a1,a1,a5
  4004bc:	00a5a023          	sw	a0,0(a1)
}
  4004c0:	00008067          	ret

004004c4 <bit_or_matrix>:
#include "matrix.h"
#include "lib.h"
#include "shapes.h"

void bit_or_matrix(int size, int matrix1[size], int matrix2[size], int result[size]){
    for (int i = 0; i < size; i++) {
  4004c4:	02a05863          	blez	a0,4004f4 <bit_or_matrix+0x30>
  4004c8:	00058793          	mv	a5,a1
  4004cc:	00251513          	slli	a0,a0,0x2
  4004d0:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] | matrix2[i];
  4004d4:	0007a703          	lw	a4,0(a5) # ffff8000 <__stack_init+0xeffe8004>
  4004d8:	00062583          	lw	a1,0(a2)
  4004dc:	00b76733          	or	a4,a4,a1
  4004e0:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  4004e4:	00478793          	addi	a5,a5,4
  4004e8:	00460613          	addi	a2,a2,4
  4004ec:	00468693          	addi	a3,a3,4
  4004f0:	fea792e3          	bne	a5,a0,4004d4 <bit_or_matrix+0x10>
    }
}
  4004f4:	00008067          	ret

004004f8 <bit_and_matrix>:

void bit_and_matrix(int size, int matrix1[size], int matrix2[size], int result[size]){
    for (int i = 0; i < size; i++) {
  4004f8:	02a05863          	blez	a0,400528 <bit_and_matrix+0x30>
  4004fc:	00058793          	mv	a5,a1
  400500:	00251513          	slli	a0,a0,0x2
  400504:	00a58533          	add	a0,a1,a0
        result[i] = matrix1[i] & matrix2[i];
  400508:	0007a703          	lw	a4,0(a5)
  40050c:	00062583          	lw	a1,0(a2)
  400510:	00b77733          	and	a4,a4,a1
  400514:	00e6a023          	sw	a4,0(a3)
    for (int i = 0; i < size; i++) {
  400518:	00478793          	addi	a5,a5,4
  40051c:	00460613          	addi	a2,a2,4
  400520:	00468693          	addi	a3,a3,4
  400524:	fea792e3          	bne	a5,a0,400508 <bit_and_matrix+0x10>
    }
}
  400528:	00008067          	ret

0040052c <mv_piece_l>:
#include "shapes.h"
#include "matrix.h"
#include "physics.h"
#include "lib.h"

void mv_piece_l(){
  40052c:	ff010113          	addi	sp,sp,-16
  400530:	00112623          	sw	ra,12(sp)
  400534:	00812423          	sw	s0,8(sp)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400538:	100007b7          	lui	a5,0x10000
  40053c:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  400540:	00269693          	slli	a3,a3,0x2
  400544:	10000737          	lui	a4,0x10000
  400548:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  40054c:	00e687b3          	add	a5,a3,a4
  400550:	01070413          	addi	s0,a4,16
  400554:	008686b3          	add	a3,a3,s0
        piece_mask[i] = piece_mask[i] << 1;
  400558:	0007a703          	lw	a4,0(a5)
  40055c:	00171713          	slli	a4,a4,0x1
  400560:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400564:	00478793          	addi	a5,a5,4
  400568:	fed798e3          	bne	a5,a3,400558 <mv_piece_l+0x2c>
    }
	
	if (colision_check_wall()) {
  40056c:	2a4000ef          	jal	ra,400810 <colision_check_wall>
  400570:	02050c63          	beqz	a0,4005a8 <mv_piece_l+0x7c>
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400574:	100007b7          	lui	a5,0x10000
  400578:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  40057c:	00269693          	slli	a3,a3,0x2
  400580:	100007b7          	lui	a5,0x10000
  400584:	01078793          	addi	a5,a5,16 # 10000010 <piece_mask>
  400588:	00f687b3          	add	a5,a3,a5
  40058c:	008686b3          	add	a3,a3,s0
			piece_mask[i] = piece_mask[i] >> 1;
  400590:	0007a703          	lw	a4,0(a5)
  400594:	40175713          	srai	a4,a4,0x1
  400598:	00e7a023          	sw	a4,0(a5)
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  40059c:	00478793          	addi	a5,a5,4
  4005a0:	fed798e3          	bne	a5,a3,400590 <mv_piece_l+0x64>
  4005a4:	0140006f          	j	4005b8 <mv_piece_l+0x8c>
		}
	}
	else {
		piece_col -= 1;
  4005a8:	10000737          	lui	a4,0x10000
  4005ac:	0e872783          	lw	a5,232(a4) # 100000e8 <piece_col>
  4005b0:	fff78793          	addi	a5,a5,-1
  4005b4:	0ef72423          	sw	a5,232(a4)
	}
}
  4005b8:	00c12083          	lw	ra,12(sp)
  4005bc:	00812403          	lw	s0,8(sp)
  4005c0:	01010113          	addi	sp,sp,16
  4005c4:	00008067          	ret

004005c8 <mv_piece_r>:
void mv_piece_r(){
  4005c8:	ff010113          	addi	sp,sp,-16
  4005cc:	00112623          	sw	ra,12(sp)
  4005d0:	00812423          	sw	s0,8(sp)
	printint(1);
  4005d4:	00100513          	li	a0,1
  4005d8:	bcdff0ef          	jal	ra,4001a4 <printint>
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  4005dc:	100007b7          	lui	a5,0x10000
  4005e0:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  4005e4:	00269693          	slli	a3,a3,0x2
  4005e8:	10000737          	lui	a4,0x10000
  4005ec:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  4005f0:	00e687b3          	add	a5,a3,a4
  4005f4:	01070413          	addi	s0,a4,16
  4005f8:	008686b3          	add	a3,a3,s0
        piece_mask[i] = piece_mask[i] >> 1;
  4005fc:	0007a703          	lw	a4,0(a5)
  400600:	40175713          	srai	a4,a4,0x1
  400604:	00e7a023          	sw	a4,0(a5)
    for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400608:	00478793          	addi	a5,a5,4
  40060c:	fed798e3          	bne	a5,a3,4005fc <mv_piece_r+0x34>
    }
	if (colision_check_wall()) {
  400610:	200000ef          	jal	ra,400810 <colision_check_wall>
  400614:	02050c63          	beqz	a0,40064c <mv_piece_r+0x84>
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400618:	100007b7          	lui	a5,0x10000
  40061c:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  400620:	00269693          	slli	a3,a3,0x2
  400624:	100007b7          	lui	a5,0x10000
  400628:	01078793          	addi	a5,a5,16 # 10000010 <piece_mask>
  40062c:	00f687b3          	add	a5,a3,a5
  400630:	008686b3          	add	a3,a3,s0
			piece_mask[i] = piece_mask[i] << 1;
  400634:	0007a703          	lw	a4,0(a5)
  400638:	00171713          	slli	a4,a4,0x1
  40063c:	00e7a023          	sw	a4,0(a5)
		for (int i = piece_row; i < piece_row + SQUARESIZE; i++){
  400640:	00478793          	addi	a5,a5,4
  400644:	fed798e3          	bne	a5,a3,400634 <mv_piece_r+0x6c>
  400648:	0140006f          	j	40065c <mv_piece_r+0x94>
		}
	}
	else{
		piece_col += 1;		
  40064c:	10000737          	lui	a4,0x10000
  400650:	0e872783          	lw	a5,232(a4) # 100000e8 <piece_col>
  400654:	00178793          	addi	a5,a5,1
  400658:	0ef72423          	sw	a5,232(a4)
	}
}
  40065c:	00c12083          	lw	ra,12(sp)
  400660:	00812403          	lw	s0,8(sp)
  400664:	01010113          	addi	sp,sp,16
  400668:	00008067          	ret

0040066c <mv_piece_d>:
void mv_piece_d(){
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  40066c:	100007b7          	lui	a5,0x10000
  400670:	0ec7a603          	lw	a2,236(a5) # 100000ec <piece_row>
  400674:	00261693          	slli	a3,a2,0x2
  400678:	10000737          	lui	a4,0x10000
  40067c:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  400680:	00e687b3          	add	a5,a3,a4
  400684:	fec70713          	addi	a4,a4,-20
  400688:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i-1];
  40068c:	00c7a683          	lw	a3,12(a5)
  400690:	00d7a823          	sw	a3,16(a5)
    for (int i = piece_row + SQUARESIZE; i > piece_row - 1; i--){
  400694:	ffc78793          	addi	a5,a5,-4
  400698:	fee79ae3          	bne	a5,a4,40068c <mv_piece_d+0x20>
    }
    piece_row += 1;
  40069c:	00160613          	addi	a2,a2,1
  4006a0:	100007b7          	lui	a5,0x10000
  4006a4:	0ec7a623          	sw	a2,236(a5) # 100000ec <piece_row>
}
  4006a8:	00008067          	ret

004006ac <mv_piece_u>:
void mv_piece_u(){
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  4006ac:	100007b7          	lui	a5,0x10000
  4006b0:	0ec7a703          	lw	a4,236(a5) # 100000ec <piece_row>
  4006b4:	fff70613          	addi	a2,a4,-1
  4006b8:	00271693          	slli	a3,a4,0x2
  4006bc:	10000737          	lui	a4,0x10000
  4006c0:	01070713          	addi	a4,a4,16 # 10000010 <piece_mask>
  4006c4:	00e687b3          	add	a5,a3,a4
  4006c8:	01470713          	addi	a4,a4,20
  4006cc:	00d70733          	add	a4,a4,a3
        piece_mask[i] = piece_mask[i+1];
  4006d0:	0007a683          	lw	a3,0(a5)
  4006d4:	fed7ae23          	sw	a3,-4(a5)
    for (int i = piece_row - 1; i < piece_row + SQUARESIZE; i++){
  4006d8:	00478793          	addi	a5,a5,4
  4006dc:	fee79ae3          	bne	a5,a4,4006d0 <mv_piece_u+0x24>
    }
    piece_row -= 1;
  4006e0:	100007b7          	lui	a5,0x10000
  4006e4:	0ec7a623          	sw	a2,236(a5) # 100000ec <piece_row>
}
  4006e8:	00008067          	ret

004006ec <r_piece_cw>:
void r_piece_cw(){
  4006ec:	ff010113          	addi	sp,sp,-16
  4006f0:	00112623          	sw	ra,12(sp)
    piece_index = rotational_vector[piece_index];
  4006f4:	100006b7          	lui	a3,0x10000
  4006f8:	0f06a783          	lw	a5,240(a3) # 100000f0 <piece_index>
  4006fc:	00279713          	slli	a4,a5,0x2
  400700:	004017b7          	lui	a5,0x401
  400704:	b0c78793          	addi	a5,a5,-1268 # 400b0c <rotational_vector>
  400708:	00e787b3          	add	a5,a5,a4
  40070c:	0007a783          	lw	a5,0(a5)
  400710:	0ef6a823          	sw	a5,240(a3)
    change_piece();
  400714:	d59ff0ef          	jal	ra,40046c <change_piece>
    reset_mask();
  400718:	c55ff0ef          	jal	ra,40036c <reset_mask>
    apply_mask(current_piecem);
  40071c:	10000537          	lui	a0,0x10000
  400720:	00050513          	mv	a0,a0
  400724:	c01ff0ef          	jal	ra,400324 <apply_mask>
	if (colision_check_wall()) {
  400728:	0e8000ef          	jal	ra,400810 <colision_check_wall>
  40072c:	00051863          	bnez	a0,40073c <r_piece_cw+0x50>
		reset_mask();
		apply_mask(current_piecem);
	}
	
	
}
  400730:	00c12083          	lw	ra,12(sp)
  400734:	01010113          	addi	sp,sp,16
  400738:	00008067          	ret
		piece_index = rotational_vector[piece_index];
  40073c:	100006b7          	lui	a3,0x10000
  400740:	004017b7          	lui	a5,0x401
  400744:	b0c78793          	addi	a5,a5,-1268 # 400b0c <rotational_vector>
		piece_index = rotational_vector[piece_index];
  400748:	0f06a703          	lw	a4,240(a3) # 100000f0 <piece_index>
  40074c:	00271713          	slli	a4,a4,0x2
  400750:	00e78733          	add	a4,a5,a4
		piece_index = rotational_vector[piece_index];
  400754:	00072703          	lw	a4,0(a4)
  400758:	00271713          	slli	a4,a4,0x2
  40075c:	00e78733          	add	a4,a5,a4
		piece_index = rotational_vector[piece_index];
  400760:	00072703          	lw	a4,0(a4)
  400764:	00271713          	slli	a4,a4,0x2
  400768:	00e787b3          	add	a5,a5,a4
  40076c:	0007a783          	lw	a5,0(a5)
  400770:	0ef6a823          	sw	a5,240(a3)
		change_piece();
  400774:	cf9ff0ef          	jal	ra,40046c <change_piece>
		reset_mask();
  400778:	bf5ff0ef          	jal	ra,40036c <reset_mask>
		apply_mask(current_piecem);
  40077c:	10000537          	lui	a0,0x10000
  400780:	00050513          	mv	a0,a0
  400784:	ba1ff0ef          	jal	ra,400324 <apply_mask>
}
  400788:	fa9ff06f          	j	400730 <r_piece_cw+0x44>

0040078c <colision_check>:
#include "movement.h"
#include "shapes.h"
#include "matrix.h"

// checks for colision between the falling piece and the blocks in the playing area
int colision_check(){
  40078c:	ff010113          	addi	sp,sp,-16
  400790:	00112623          	sw	ra,12(sp)
  400794:	00812423          	sw	s0,8(sp)
  400798:	00912223          	sw	s1,4(sp)
    int ret_val;
    mv_piece_d(); // move piece down to check for future colisions
  40079c:	ed1ff0ef          	jal	ra,40066c <mv_piece_d>
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  4007a0:	100007b7          	lui	a5,0x10000
  4007a4:	0ec7a783          	lw	a5,236(a5) # 100000ec <piece_row>
  4007a8:	00279793          	slli	a5,a5,0x2
  4007ac:	100006b7          	lui	a3,0x10000
  4007b0:	0d868493          	addi	s1,a3,216 # 100000d8 <result>
  4007b4:	0d868693          	addi	a3,a3,216
  4007b8:	10000637          	lui	a2,0x10000
  4007bc:	07460613          	addi	a2,a2,116 # 10000074 <play_area>
  4007c0:	00f60633          	add	a2,a2,a5
  4007c4:	100005b7          	lui	a1,0x10000
  4007c8:	01058593          	addi	a1,a1,16 # 10000010 <piece_mask>
  4007cc:	00f585b3          	add	a1,a1,a5
  4007d0:	00400513          	li	a0,4
  4007d4:	d25ff0ef          	jal	ra,4004f8 <bit_and_matrix>
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
  4007d8:	0004a403          	lw	s0,0(s1)
  4007dc:	0044a783          	lw	a5,4(s1)
  4007e0:	00f46433          	or	s0,s0,a5
  4007e4:	0084a783          	lw	a5,8(s1)
  4007e8:	00f46433          	or	s0,s0,a5
  4007ec:	00c4a783          	lw	a5,12(s1)
  4007f0:	00f46433          	or	s0,s0,a5
    }
    mv_piece_u(); // move piece up to its original position
  4007f4:	eb9ff0ef          	jal	ra,4006ac <mv_piece_u>
    return ret_val;
}
  4007f8:	00040513          	mv	a0,s0
  4007fc:	00c12083          	lw	ra,12(sp)
  400800:	00812403          	lw	s0,8(sp)
  400804:	00412483          	lw	s1,4(sp)
  400808:	01010113          	addi	sp,sp,16
  40080c:	00008067          	ret

00400810 <colision_check_wall>:

int colision_check_wall(){
  400810:	ff010113          	addi	sp,sp,-16
  400814:	00112623          	sw	ra,12(sp)
  400818:	00812423          	sw	s0,8(sp)
    int ret_val;
    // ANDs the four rows where the piece is currently at
    bit_and_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], result);
  40081c:	100007b7          	lui	a5,0x10000
  400820:	0ec7a783          	lw	a5,236(a5) # 100000ec <piece_row>
  400824:	00279793          	slli	a5,a5,0x2
  400828:	100006b7          	lui	a3,0x10000
  40082c:	0d868413          	addi	s0,a3,216 # 100000d8 <result>
  400830:	0d868693          	addi	a3,a3,216
  400834:	10000637          	lui	a2,0x10000
  400838:	07460613          	addi	a2,a2,116 # 10000074 <play_area>
  40083c:	00f60633          	add	a2,a2,a5
  400840:	100005b7          	lui	a1,0x10000
  400844:	01058593          	addi	a1,a1,16 # 10000010 <piece_mask>
  400848:	00f585b3          	add	a1,a1,a5
  40084c:	00400513          	li	a0,4
  400850:	ca9ff0ef          	jal	ra,4004f8 <bit_and_matrix>
    // checks if any of the four rows contains a 1
    for (int i = 0; i < SQUARESIZE; i++){
        ret_val |= result[i];
  400854:	00042783          	lw	a5,0(s0)
  400858:	00442503          	lw	a0,4(s0)
  40085c:	00a7e7b3          	or	a5,a5,a0
  400860:	00842503          	lw	a0,8(s0)
  400864:	00a7e7b3          	or	a5,a5,a0
  400868:	00c42503          	lw	a0,12(s0)
    }
    return ret_val;
}
  40086c:	00a7e533          	or	a0,a5,a0
  400870:	00c12083          	lw	ra,12(sp)
  400874:	00812403          	lw	s0,8(sp)
  400878:	01010113          	addi	sp,sp,16
  40087c:	00008067          	ret

00400880 <consolidate_rows>:

int consolidate_rows(){
  400880:	ff010113          	addi	sp,sp,-16
  400884:	00112623          	sw	ra,12(sp)
    // add each of the 4 rows where the piece is to the play area
    bit_or_matrix(SQUARESIZE, &piece_mask[piece_row], &play_area[piece_row], &play_area[piece_row]);
  400888:	100007b7          	lui	a5,0x10000
  40088c:	0ec7a783          	lw	a5,236(a5) # 100000ec <piece_row>
  400890:	00279793          	slli	a5,a5,0x2
  400894:	10000637          	lui	a2,0x10000
  400898:	07460613          	addi	a2,a2,116 # 10000074 <play_area>
  40089c:	00c78633          	add	a2,a5,a2
  4008a0:	00060693          	mv	a3,a2
  4008a4:	100005b7          	lui	a1,0x10000
  4008a8:	01058593          	addi	a1,a1,16 # 10000010 <piece_mask>
  4008ac:	00f585b3          	add	a1,a1,a5
  4008b0:	00400513          	li	a0,4
  4008b4:	c11ff0ef          	jal	ra,4004c4 <bit_or_matrix>
}
  4008b8:	00c12083          	lw	ra,12(sp)
  4008bc:	01010113          	addi	sp,sp,16
  4008c0:	00008067          	ret

004008c4 <clear_rows>:



int clear_rows(){
    int points = 0;
    for (int i = piece_row; i < HEIGHT-1; i++){ // check each of the 4 rows where the piece is
  4008c4:	100007b7          	lui	a5,0x10000
  4008c8:	0ec7a683          	lw	a3,236(a5) # 100000ec <piece_row>
  4008cc:	01700793          	li	a5,23
  4008d0:	08d7c063          	blt	a5,a3,400950 <clear_rows+0x8c>
  4008d4:	00269713          	slli	a4,a3,0x2
  4008d8:	100007b7          	lui	a5,0x10000
  4008dc:	07478793          	addi	a5,a5,116 # 10000074 <play_area>
  4008e0:	00f70733          	add	a4,a4,a5
    int points = 0;
  4008e4:	00000513          	li	a0,0
        if (play_area[i] == 4095){ // 4095 = column of all 1s
  4008e8:	000017b7          	lui	a5,0x1
  4008ec:	fff78893          	addi	a7,a5,-1 # fff <_start-0x3ff001>
			if (!points){points = 1;}
            points = points*2;
            // this will break when the piece is off screen @@@@@@@@@@@@@
            for (int j = i; j > 4; j--){
  4008f0:	00400e93          	li	t4,4
                play_area[j] = play_area[j-1];
            }
            play_area[4] = 0b100000000001;
  4008f4:	10000337          	lui	t1,0x10000
  4008f8:	07430313          	addi	t1,t1,116 # 10000074 <play_area>
  4008fc:	80178e13          	addi	t3,a5,-2047
  400900:	01030593          	addi	a1,t1,16
    for (int i = piece_row; i < HEIGHT-1; i++){ // check each of the 4 rows where the piece is
  400904:	01800813          	li	a6,24
  400908:	0300006f          	j	400938 <clear_rows+0x74>
            points = points*2;
  40090c:	00151513          	slli	a0,a0,0x1
            for (int j = i; j > 4; j--){
  400910:	00dedc63          	bge	t4,a3,400928 <clear_rows+0x64>
  400914:	00070793          	mv	a5,a4
                play_area[j] = play_area[j-1];
  400918:	ffc7a603          	lw	a2,-4(a5)
  40091c:	00c7a023          	sw	a2,0(a5)
            for (int j = i; j > 4; j--){
  400920:	ffc78793          	addi	a5,a5,-4
  400924:	feb79ae3          	bne	a5,a1,400918 <clear_rows+0x54>
            play_area[4] = 0b100000000001;
  400928:	01c32823          	sw	t3,16(t1)
    for (int i = piece_row; i < HEIGHT-1; i++){ // check each of the 4 rows where the piece is
  40092c:	00168693          	addi	a3,a3,1
  400930:	00470713          	addi	a4,a4,4
  400934:	01068c63          	beq	a3,a6,40094c <clear_rows+0x88>
        if (play_area[i] == 4095){ // 4095 = column of all 1s
  400938:	00072783          	lw	a5,0(a4)
  40093c:	ff1798e3          	bne	a5,a7,40092c <clear_rows+0x68>
			if (!points){points = 1;}
  400940:	fc0516e3          	bnez	a0,40090c <clear_rows+0x48>
  400944:	00100513          	li	a0,1
  400948:	fc5ff06f          	j	40090c <clear_rows+0x48>
  40094c:	00008067          	ret
    int points = 0;
  400950:	00000513          	li	a0,0
        }
    }
    return points;
}
  400954:	00008067          	ret

00400958 <tetris_god_senpai>:
void tetris_god_senpai(){
  400958:	ff010113          	addi	sp,sp,-16
  40095c:	00112623          	sw	ra,12(sp)
    piece_row = 4;
  400960:	100007b7          	lui	a5,0x10000
  400964:	00400713          	li	a4,4
  400968:	0ee7a623          	sw	a4,236(a5) # 100000ec <piece_row>
    piece_col = 5;
  40096c:	100007b7          	lui	a5,0x10000
  400970:	00500713          	li	a4,5
  400974:	0ee7a423          	sw	a4,232(a5) # 100000e8 <piece_col>
    piece_index = (piece_index + 7)%18;
  400978:	10000737          	lui	a4,0x10000
  40097c:	0f072783          	lw	a5,240(a4) # 100000f0 <piece_index>
  400980:	00778793          	addi	a5,a5,7
  400984:	01200693          	li	a3,18
  400988:	02d7e7b3          	rem	a5,a5,a3
  40098c:	0ef72823          	sw	a5,240(a4)
    change_piece();
  400990:	addff0ef          	jal	ra,40046c <change_piece>
    reset_mask();
  400994:	9d9ff0ef          	jal	ra,40036c <reset_mask>
    apply_mask();
  400998:	98dff0ef          	jal	ra,400324 <apply_mask>
}						 
  40099c:	00c12083          	lw	ra,12(sp)
  4009a0:	01010113          	addi	sp,sp,16
  4009a4:	00008067          	ret

004009a8 <pollLeftFlag>:
#include "buttons.h"

inline int pollLeftFlag() { return *((volatile int *)0xffff0044); }
  4009a8:	ffff07b7          	lui	a5,0xffff0
  4009ac:	0447a503          	lw	a0,68(a5) # ffff0044 <__stack_init+0xeffe0048>
  4009b0:	00008067          	ret

004009b4 <pollRightFlag>:
inline int pollRightFlag() { return *((volatile int *)0xffff0048); }
  4009b4:	ffff07b7          	lui	a5,0xffff0
  4009b8:	0487a503          	lw	a0,72(a5) # ffff0048 <__stack_init+0xeffe004c>
  4009bc:	00008067          	ret

004009c0 <pollRotFlag>:
inline int pollRotFlag() { return *((volatile int *)0xffff004c); }
  4009c0:	ffff07b7          	lui	a5,0xffff0
  4009c4:	04c7a503          	lw	a0,76(a5) # ffff004c <__stack_init+0xeffe0050>
  4009c8:	00008067          	ret

004009cc <lowerFlags>:
inline void lowerFlags() { *((volatile int *)0xffff0050) = 1; }
  4009cc:	ffff07b7          	lui	a5,0xffff0
  4009d0:	00100713          	li	a4,1
  4009d4:	04e7a823          	sw	a4,80(a5) # ffff0050 <__stack_init+0xeffe0054>
  4009d8:	00008067          	ret
