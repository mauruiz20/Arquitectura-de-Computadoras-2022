			.data
minimo: 	.byte 0,0
vector: 	.byte 54,5,23,65,2,84,16,78,37,97,56,26,48,13,103,18
			.text
			.globl main
            
comparar: 	add t0, a1, a2			# x[t0] = x[a1] + x[a2]						Incremento el punto del vector
            lbu t0, 0(t0)			# x[t0] = M[x[t0] + 0]						Cargo el siguiente elemento
            bgeu t0, a0, retorno	# Si x[t0] > x[a0] Entonces PC += retorno 	Si el siguiente elemento es mayor a minimo, vuelvo
            mv a0, t0				# x[a0] = x[t0]								Si no actualizo minimo
            
retorno: 	jr ra					# PC = x[ra] 								Salto a x[ra]

main: 		la a2, vector 			# x[a2] = &vector							Carga de la direccion de inicio del vector
            lbu a0, 0(a2)			# x[a0] = M[x[a2] + 0]						Carga de el primer elemento
            li a1, 1				# x[a1] = 1									indice = 1
            
lazo: 		sltiu t0, a1, 16		# Si x[a1] < 16 Entonces x[t0] = 1			Si indice = 16 termino
									# Si x[a1] >= 16 Entonces x[t0] = 0
            beq t0, zero, final		# Si x[t0] = 0 Entonces Salto a "final"		
            jal comparar			# x[x1] = PC + 4 ; PC += comparar 			Salto a "comparar"
			addi a1, a1, 1			# x[a1] += 1								Incremento indice += 1
			j lazo					# PC += lazo								Salto a "lazo"
            
final: 		la t0, minimo			# x[t0] = &minimo							Carga de la direccion de minimo
            sb a0, 0(t0)			# M[x[t0] + 0] = x[a0]						Guardo minimo en memoria
            mv a1, a0				# x[a1] = x[a0]								-
            li a0,1					# x[a0] = 1									-
            ecall					
            li a0,10				# x[a0] = 10								-
            ecall