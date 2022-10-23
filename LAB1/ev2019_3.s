			.data
cad:		.asciiz "\nLongitud: "
cadena:		.asciiz "Hola Mundo"
            .text
            .globl main
            
main:		la a0, cadena
			mv s0, a0					# Puntero a la cadena
            li s1, 0					# Longitud = 0
            li a0, 11					# Muestro caracteres
            
lazo:       lb a1, 0(s0)				# Cargo un caracter
            beq a1, zero, fin			# Si es cero finalizo
            ecall						# Sino muestro caracter
            addi s0, s0, 1				# Incremento puntero al siguiente caracter
            addi s1, s1, 1				# Longitud++
            j lazo						# Repito lazo
            
fin:        li a0, 4					# Muestro cadena
			la a1, cad
            ecall
            li a0, 1					# Muestro longitud (entero)
            mv a1, s1
            ecall
            li a0, 10					# Finalizo programa
            ecall