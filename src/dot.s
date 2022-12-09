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

    # Prologue
    addi sp, sp, -20
    # v0 address
    sw t0, 0(sp)
    # v1 address
    sw t1, 4(sp)
    # v0 index
    sw s0, 8(sp)
    # v1 index
    sw s1, 12(sp)
    # current value
    sw s2, 16(sp)
    # array address
    mv t0, a0
    mv t1, a1
    mv s0, x0
    mv s1, x0
    mv s2, x0

loop_start:
    bge s0, a2, loop_end
    bge s1, a2, loop_end

    slli s1, s0, 2
    add s1, a0, s1
    lw s0, 0(s1)
    addi t1, t1, 1
    bge s2, s0, loop_start



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
