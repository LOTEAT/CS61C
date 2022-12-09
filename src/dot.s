.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    ble a2, zero, exit_75
    ble a3, zero, exit_76
    ble a4, zero, exit_76
    # Prologue
    addi sp, sp, -24
    # v0 current element 
    sw t0, 0(sp)
    # v1 current element 
    sw t1, 4(sp)
    # v0 index
    sw s0, 8(sp)
    # v1 index
    sw s1, 12(sp)
    # current mul value
    sw s2, 16(sp)
    # current sum
    sw s3, 20(sp)
    # array address
    mv s0, x0
    mv s1, x0
    mv s3, x0

loop_start:
    bge s0, a2, loop_end

    slli t0, s0, 2
    add t0, t0, a0
    lw t0, 0(t0)

    slli t1, s1, 2
    add t1, t1, a1
    lw t1, 0(t1)   

    mul s2, t0, t1
    add s3, s3, s2
    add s0, s0, a3
    add s1, s1, a4
    j loop_start



loop_end:

    mv a0, s3
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw s0, 8(sp)
    lw s1, 12(sp)
    lw s2, 16(sp)
    lw s3, 20(sp)
    addi sp, sp, 24

    # Epilogue

    
    ret

exit_75:
	li a1, 75
    j exit2
   
exit_76:
    li a1, 76
    j exit2
    