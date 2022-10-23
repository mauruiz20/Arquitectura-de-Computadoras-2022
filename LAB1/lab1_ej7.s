			.data
A:			.byte 1 2 3 4
			.byte 5 6 7 8
            .byte 9 1 2 3
            .byte 4 5 6 7
            
B:			.byte 6 5 4 1
			.byte 1 1 1 1
            .byte 2 1 5 4
            .byte 3 6 0 7
            
C:			.byte 0 0 0 0					# Resultado: 26 34 21 43
			.byte 0 0 0 0					#			 74 86 61 95	
            .byte 0 0 0 0					#			 68 66 47 39	
            .byte 0 0 0 0					#     		 62 73 51 82
            
           	.text
            .globl main
            
main:		la a0, C			# puntero C
			la a1, A			# puntero A
            la a2, B			# puntero B
            
            jal ra, gemm		# subrutina gemm
            j fin
            
gemm:		li t0, 0			# i
			li t1, 0			# j
            li t2, 0			# k
            li t3, 4			# Tamaño de las matrices
            li s0, 4			# Multiplicador de filas
            
for_i:		bge t0, t3, end_i			# if (i >= 4) -> end_i
			li t1, 0					# j = 0
            
	for_j:		bge t1, t3, end_j			# if (j >= 4) -> end_j
    			li t2, 0					# k = 0
    
		for_k:		bge t2, t3, end_k			# if (k >= 4) -> end_k
        
        			mul t4, t0, s0				# aux = i*4
                    add t4, t4, t1				# aux = i*4 + j
                    add s1, a0, t4				# puntero C += i*4 + j
                    lb s2, 0(s1)				# s2 = C[i][j]
                    
                    mul t4, t0, s0				# aux = i*4
                    add t4, t4, t2				# aux = i*4 + k
                    add s3, a1, t4				# puntero A += i*4 + k
                    lb s3, 0(s3)				# s3 = A[i][k]
                    
                    mul t4, t2, s0				# aux = k*4
                    add t4, t4, t1				# aux = k*4 + j
                    add s4, a2, t4				# puntero B += k*4 + j
                    lb s4, 0(s4)				# s4 = B[k][j]
                    
                    mul t4, s3, s4				# aux = A[i][k] * B[k][j]
                    add t4, t4, s2				# aux = A[i][k] * B[k][j] + C[i][j]
                    sb t4, 0(s1)				# C[i][j] = A[i][k] * B[k][j] + C[i][j]
                    
                    addi t2, t2, 1				# k++
                    j for_k						# Repito for_k
                    
		end_k:		addi t1, t1, 1				# j++
        			j for_j						# Repito for_j
                    
	end_j:		addi t0, t0, 1				# i++
    			j for_i						# Repito for_i
    
end_i:		jr ra			# Vuelvo al programa principal				

fin:		li a0, 10		# Selección del servicio terminar el programa sin error
			ecall			# Termina el programa y retorna al sistema operativo