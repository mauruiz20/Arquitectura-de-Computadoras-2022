			.data
vector:		.byte 1 2 3 4 5 6 7 11 0 8 9 10
cad1:		.asciiz "Numeros pares: "
cad2:		.asciiz	"\nNumeros impares: "
			.text
            .globl main
            
main:		la a0, vector
			jal ra, subrutina
            j fin
			
subrutina:	mv t0, a0								
            li s0, 1					
            li a1, 0					# Cantidad de numeros pares
            li a2, 0					# Cantidad de numeros impares
            
lazo:		lb t1, 0(t0)				# Cargo un elemento
			beqz t1, fin_lazo			# Si el elemento es 0 -> termino
			addi t0, t0, 1				# Incremento puntero
            and t1, t1, s0				
            beqz t1, par				# Si el primer bit es 0 -> par
            j impar						# Si el primer bit es 1 -> impar
            
par:		addi a1, a1, 1				# Incremento pares
			j lazo
impar:		addi a2, a2, 1				# Incremento impares
			j lazo
            
fin_lazo:	jr ra

fin:		mv t0, a1

			li a0, 4
			la a1, cad1
			ecall
            li a0, 1
            mv a1, t0
            ecall
            
            li a0, 4
			la a1, cad2
			ecall
            li a0, 1
            mv a1, a2
            ecall

			li a0, 10
			ecall