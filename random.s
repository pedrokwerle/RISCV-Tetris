# Function to generate a random number between 1-7 for utilization in tetris piece generation
# v1.0 by Pedro Kreutz Werle, created 16/02/2023, last updated 17/02/2023 
# licensed under Creative Commons Attribution International license 4.0

	.data
	
seed:	.word 0xfeca15e7	# initial seed for generator

	.text
	# void random(int seed) - generates a random number from 1 to 
   	#
   	# input: a0 = seed
   	# the seed should only be set once at the start of the program
   	# otherwise you can accidentally always get the same number
	.global initseed

initseed:
	la t0, seed		# load address of seed to t0
	li t5, 0x1234		# write-enable signal value
	sw t5, 0(t0)		# enable writing to seed location
	sw a0, 0(t0)		# load input seed to memory	
	jr ra
	
	.global random
	
random:
	la t0, seed		# load address of seed to t0
	lw t1, 0(t0)		# load seed to t1
	mv t1, sp		
	
roll:
	slli t2, t1, 1		# shift seed to the left and store in t2
	xor t1, t2, t1		# xor bits in t1 and t2 for a pseudo random number
	andi a0, t1, 0x700	# extract 3 bit random number from t1 using mask 0000011100000000
	srli a0, a0, 8		# shift bits in t4 to the right so they are the least significant digits
	beqz a0, roll		# reroll if equal to 0 
	sw t1, 0(t0)		# set new seed with value of t1
	jr ra 			# return

	
	
