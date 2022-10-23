#	Escriba un programa en lenguaje ensamblador RV32IM del RISC-V que reciba un número entero
#	en el registro a0 y devuelva por consola la raíz cuadrada aproximada del mismo. Para calcular
#	la misma utilice aproximaciones sucesivas calculando el producto de los números enteros
#	hasta obtener el más cercano inferior al número ingresado. Agregue las cadenas de texto
#	adecuadas para indicar qué significa el resultado.

			.data
cad1:		.asciiz "Raiz cuadrada aproximada de "  
cad2:		.asciiz " = "
            .text
            .globl main
            
main:		li a0, 4		# Muestro cadena
			la a1, cad1
            ecall
            
			li a0, 13		# Numero entero
            
            mv a1, a0		# Muestro numero
            li a0, 1
            ecall
            mv a0, a1
            
            mv a2, a0
            li a0, 4
            la a1, cad2
            ecall
            mv a0, a2
            
			jal ra, raiz	# Calculo raiz
            j fin
            
raiz:		li t0, 1

lazo_raiz:	mul t1, t0, t0	
			bgt t1, a0, fin_raiz
            addi t0, t0, 1
            j lazo_raiz
            
fin_raiz:	addi a1, t0, -1
			li a0, 1
            ecall
            jr ra
            
fin:		li a0, 10
			ecall