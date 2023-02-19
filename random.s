# Function to generate a random number between 1-7 for utilization in tetris piece generation
# v1.0 by Pedro Kreutz Werle, created 16/02/2023, last updated 19/02/2023 
# licensed under Creative Commons Attribution International license 4.0

	.text
	# void random(int seed) - generates a random number from 1 to 
   	#
   	# input: a0 = seed
   	# the seed should only be set once at the start of the program
   	# otherwise you can accidentally always get the same number
	
	.global random
	
random:
	li a7, 42		# Load the system call number for the getrandom function into a7
	li a1, 18		# Load the upper bound of the integer into a1
	ecall			# Invoke syscall RandIntRange
	jr ra			# Return
	
	
	
