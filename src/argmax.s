.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:

    # Prologue
    beq a1, x0, exception
    # store some values
    addi sp, sp, -20
    sw t0, 0(sp)
    sw t1, 4(sp)
    # load value from array
    sw s0, 8(sp)
    # element address
    sw s1, 12(sp)
    # max value
    sw s2, 16(sp)
    # array address
    mv t0, a0
    # array index, start from 0
    mv t1, x0
    mv s2, x0
    


loop_start:
    bge t1, a1, loop_end
    slli s1, t1, 2
    add s1, a0, s1
    lw s0, 0(s1)
    addi t1, t1, 1
    bge s2, s0, loop_start

loop_continue:
    mv s2, s0
    j loop_start


loop_end:
    mv a0, s2
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw s0, 8(sp)
    lw s1, 12(sp)
    lw s2, 16(sp)
    addi sp, sp, 20
    # Epilogue


    ret

exception:
    li a1, 77
    j exit2