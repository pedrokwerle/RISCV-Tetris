# Function to generate a random number between 0-31 for utilization in tetris piece generation
# v1.0 by Pedro Kreutz Werle, created 16/02/2023, last updated 19/02/2023 
# licensed under Creative Commons Attribution International license 4.0

	.text
	# void random() - generates a random number from 0 to 31
   	#
   	# uses two registers t0 and t1, shifts t1 to the left 1 bit xors them together to get a pseudo
   	# random numeber, then shifts that number to the 5 least significant digits so that the highest it 
   	# can be is 31
   	# the seed is loaded to t0
   	# FAT L SEED 12938476
	
	.global random
	
random:
	bnez t0, skip
	li t0, 851 	# seed, change for a different sequence
skip:
	slli  t1, t0, 1		
	xor t1, t1, t0
	mv t0, t1
	mv a0, t1
	ret			# Return
