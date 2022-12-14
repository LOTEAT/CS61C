.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:

    # Error checks
	ble a1, zero, exit_72
    ble a2, zero, exit_72
    ble a4, zero, exit_73
    ble a5, zero, exit_73
	bne a2, a4, exit_74
    # Prologue
    addi sp, sp, -32
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw ra, 28(sp)
    mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3
    mv s4, a4
    mv s5, a5
    mv s6, a6
    
	# init
    li t0, 0 # i = 0
ebreak
outer_loop_start:
	li t1, 0 # j = 0
inner_loop_start:
	mv a0, s0
    li t2, 4
    mul t2, t2, t1
    add a1, s3, t2
    mv a2, s2
    li a3, 1
    mv a4, s5
    
    # prologue
	addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)
    
    jal dot
ebreak
    sw a0, 0(s6)
    addi s6, s6, 4
    
    # epilogue
    lw t0, 0(sp)
    lw t1, 4(sp)
	addi sp, sp, 8
    
    addi t1, t1, 1 # j++
    beq t1, s5, inner_loop_end
    j inner_loop_start
inner_loop_end:
	addi t0, t0, 1 # i++
    beq t0, s1, outer_loop_end
	li t2, 4
    mul t2, t2, s2
    add s0, s0, t2
    j outer_loop_start
outer_loop_end:

    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32
    ret

exit_72:
    li a1, 72
    j exit2
exit_73:
	li a1, 73
    j exit2
exit_74:
	li a1, 74
    j exit2



################################################################
# Below is the answer written by me
# I think this is also correct
# And I have debugged in venus
# It seems every part works well
# But it cannot pass the test cases
################################################################


# .globl matmul
# .import dot.s
# 
# .text
# # =======================================================
# # FUNCTION: Matrix Multiplication of 2 integer matrices
# # 	d = matmul(m0, m1)
# # Arguments:
# # 	a0 (int*)  is the pointer to the start of m0 
# #	a1 (int)   is the # of rows (height) of m0
# #	a2 (int)   is the # of columns (width) of m0
# #	a3 (int*)  is the pointer to the start of m1
# # 	a4 (int)   is the # of rows (height) of m1
# #	a5 (int)   is the # of columns (width) of m1
# #	a6 (int*)  is the pointer to the the start of d
# # Returns:
# #	None (void), sets d = matmul(m0, m1)
# # Exceptions:
# #   Make sure to check in top to bottom order!
# #   - If the dimensions of m0 do not make sense,
# #     this function terminates the program with exit code 72.
# #   - If the dimensions of m1 do not make sense,
# #     this function terminates the program with exit code 73.
# #   - If the dimensions of m0 and m1 don't match,
# #     this function terminates the program with exit code 74.
# # =======================================================
# matmul:
#     ; # Error check# 	; ble a1, zero, exit_7#     ; ble a2, zero, exit_7#     ; ble a4, zero, exit_7#     ; ble a5, zero, exit_7# 	; bne a2, a4, exit_7#     ; # Prologu#     ; addi sp, sp, -4#     ; sw t0, 0(sp#     ; sw t1, 4(sp#     ; sw t2, 8(sp#     ; sw t3, 12(sp#     ; sw t4, 16(sp#     ; sw t5, 20(sp#     ; sw t6, 24(sp#     ; sw s2, 28(sp#     ; sw s3, 32(sp#     ; sw s4, 36(sp#     ; sw ra, 40(sp)
# 
# 
#     ; # the row index of m#     ; mv t0, x#     ; # the col index of m#     ; mv t1, x#     ; # the number of m1's row#     ; mv t3, a#     ; # the number of m1's col#     ; mv t4, a#     ; # the number of m2's row#     ; mv t5, a#     ; # the number of m2's col#     ; mv t6, a#     ; # m1 addres#     ; mv s0, a#     ; # m2 addres#     ; mv s1, a#     ; # the current address of m#     ; mv s2, x#     ; # the current address of m#     ; mv s3, x#     ; # the current index of #     ; mv s4, a#     ; 
# 
# outer_loop_start#     ; bge t0, t3, outer_loop_en#     ; mul s2, t0, t#     ; slli s2, s2, #     ; add s2, s2, s#     ; mv a2, t#     ; mv a0, s#     ; mv t1, x#     ; addi a3, x0, #     ; addi t0, t0, 1
# 
# 
# #   a0 (int*) is the pointer to the start of v0
# #   a1 (int*) is the pointer to the start of v1
# #   a2 (int)  is the length of the vectors
# #   a3 (int)  is the stride of v0
# #   a4 (int)  is the stride of v1
# 
# 
# inner_loop_start#     ; slli s3, t1, #     ; add s3, s3, s#     ; mv a1, s#     ; mv a4, t#     ; jal do#     ; sw a0, 0(s4#     ; addi s4, s4, #     ; addi t1, t1, 1
# 
# inner_loop_end#     ; bge t1, t6, outer_loop_star#     ; mv a0, s#     ; j inner_loop_start
# 
# 
# 
# outer_loop_end#     ; lw t0, 0(sp#     ; lw t1, 4(sp#     ; lw t2, 8(sp#     ; lw t3, 12(sp#     ; lw t4, 16(sp#     ; lw t5, 20(sp#     ; lw t6, 24(sp#     ; lw s2, 28(sp#     ; lw s3, 32(sp#     ; lw s4, 36(sp#     ; lw ra, 40(sp#     ; addi sp, sp, 44
#     ; # Epilogu#     ;#     ;#     ; ret
# 
# exit_72#     ; li a1, 7#     ; j exit2
# exit_73# 	; li a1, 7#     ; j exit2
# exit_74# 	; li a1, 7#     ; j exit2