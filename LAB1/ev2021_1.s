#	Su sobrino, entusiasta de las las matématicas, está aprendiendo a dividir números enteros por
#	lo que cada vez que toma un nuevo número le pregunta si encontró todos los divisores que
#	existen para ese nuevo número. Ud. para ayudarlo decide escribir un programa que cuente la
#	cantidad de divisores de un número para ello deberá:
#	a) Escribir una subrutina esdivisor en lenguaje ensamblador RV32IM del RISC-V que dados
#	dos números enteros A y B determine si B es divisor de A.
#	b) Escribir un programa principal que determine la cantidad de divisores que tiene un cierto
#	número X. Muestre por pantalla el número X, sus divisores y el total de divisores.
#	Por ejemplo: Los divisores de 6 son los siguientes: 1, 2, 3, 6. En total son: 4

		.data
cad1:	.asciiz "Divisores de "
cad2:	.asciiz " son los siguientes: "
cad3:	.asciiz	"\nEn total son: "
        .text
        .globl main
        
main:	li a0, 4
		la a1, cad1
		ecall
        
        li a0, 1
		li a1, 12				# Numero A
        ecall
        
        li a0, 4
		la a1, cad2
		ecall
        
        li a0, 12				# Numero A
        jal ra, divisores
        
        li a0, 4
        la a1, cad3
        ecall
        
        li a0, 1
        mv a1, s2
        ecall
        
        j fin

divisores:
		mv s0, a0				# Copio A
		mv s1, a0			
		mv s2, zero				# Cantidad de divisores
        addi sp, sp, -4
        sw ra, 0(sp)
        
lazo:	beqz s1, fin_lazo		# Si A es cero entonces no hay mas divisores
		mv a0, s0				# Copio A
		mv a1, s1				# Actualizo divisor
		jal ra, esdivisor		
        addi s1, s1, -1			# Busco otro divisor
        beqz a0, incremento		# Si es divisor incremento el contador
        j lazo					# Repito lazo
incremento:
		addi s2, s2, 1			# Incremento contador
        li a0, 1
        addi a1, s1, 1
        ecall
        
        li a0, 11
        li a1, 32
        ecall
        
        j lazo
fin_lazo:
        lw ra, 0(sp)
        addi sp, sp, 4
        jr ra

esdivisor:					# D = d * C + R -> R = D - d * C		D = A ; d = B
		div t0, a0, a1		# C = A / B
        mul t0, a1, t0		# d * C
        sub t0, a0, t0		# R = D - d * C
        beqz t0, divisor	# if (R == 0) -> si es divisor
        li a0, 1			# Si no -> no es divisor
        jr ra			
        
divisor:li a0, 0			# Retorno a0 = 0 si es divisor y si no a0 = 1
		jr ra

fin:	li a0, 10
		ecall
		