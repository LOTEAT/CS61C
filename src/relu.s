.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    # Prologue
    # store some values
    addi sp, sp, -12
    sw t0, 0(sp)
    sw t1, 4(sp)
    # load value from array
    sw s0, 8(sp)
    # array address
    mv t0, a0
    # array index, start from 0
    mv t1, 0

loop_start:
    bne t1, loop_end
    lw 






loop_continue:



loop_end:


    # Epilogue

    
	ret
