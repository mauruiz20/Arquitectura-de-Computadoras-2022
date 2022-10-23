			.data
cad1:		.asciiz "Monedas de 1: "
cad2:		.asciiz "\nMonedas de 5: "
cad3:		.asciiz "\nMonedas de 10: "
            .text
            .globl main
main:		li a0, 77
			jal intercambio
            jal mostrar
            j fin
            
intercambio:li s0, 10				# Cte = 10
			li s1, 5				# Cte = 5
            li s2, 1				# Cte = 1
            mv a1, zero				# Contador de monedas de 1
            mv a2, zero				# Contador de monedas de 5
            mv a3, zero				# Contador de monedas de 10
            
lazo:	    beqz a0, fin_lazo		# Si el monto es 0 -> fin
			sub t0, a0, s0			# Primero resto 10
            bge t0, zero, diez		# Si >= 0 entonces uso una de 10
            sub t0, a0, s1			# Si no -> resto 5
            bge t0, zero, cinco		# Si >= 0 entonces uso una de 5
            sub a0, a0, s2			# Si no -> resto 1
            addi a1, a1, 1			# Incremento contador de monedas de 1
            j lazo
            
fin_lazo:	jr ra

diez:		addi a3, a3, 1			# Incremento contador de monedas de 10
			addi a0, a0, -10		# Resto 10 al monto
            j lazo

cinco:		addi a2, a2, 1			# Incremento contador de monedas de 5
			addi a0, a0, -5			# Resto 5 al monto
            j lazo
            
mostrar:	mv t0, a1
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
            
            li a0, 4
            la a1, cad3
            ecall
            li a0, 1
            mv a1, a3
            ecall
            
            jr ra
            
fin:		li a0, 10
			ecall