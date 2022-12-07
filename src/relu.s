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
    addi sp, sp, -16
    sw t0, 0(sp)
    sw t1, 4(sp)
    # load value from array
    sw s0, 8(sp)
    # element address
    sw s1, 12(sp)
    # array address
    mv t0, a0
    # array index, start from 0
    mv t1, x0

loop_start:
    bge t1, a1, loop_end
    slli s1, t1, 2
    add s1, a0, s1
    lw s0, 0(s1)
    addi t1, t1, 1
    bge s0, x0, loop_start

loop_continue:
    mv s0, x0
    sw s0, 0(s1)
    j loop_start

loop_end:
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw s0, 8(sp)
    lw s1, 12(sp)
    addi sp, sp, 16


    # Epilogue

    
	ret
