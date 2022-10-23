			.data
vocales:	.asciiz "aeiou"
caracter:	.asciiz "a"
cad:		.asciiz "Ruiz, Francisco Mauricio"
salto:		.asciiz "\n"
            .text
            .globl main
            
main:		
			li a0, 4				# Selección del servicio mostrar un string
            la a1, cad				# Muestro cadena original
            ecall   
            la a1, salto			# Muestro un salto de linea
            ecall
            la s0, cad				# Puntero al inicio de la cadena
lazo_v:            
            lb a0, 0(s0)			# Cargo una letra
            beqz a0, fin_v			# Si la letra es 0 -> termino
			jal vocal				# Verifico si es vocal
            beqz a0, normal			# Si no es vocal -> imprimo el caracter normalmente
            addi s0, s0, 1      	# Muevo el puntero a la siguiente letra
            mv a1, a0				# Cargo en a1 el numero de la vocal
            li a0, 1				# Selección del servicio mostrar un entero
            ecall  					# Muestro por pantalla el entero
            j lazo_v				# Repito lazo
normal:		            
			li t0, 32				# Cte = 32 para comparar si la letra es un espacio
			li a0, 11				# Selección del servicio mostrar un caracter
            lb a1, 0(s0)			# Cargo la letra en su codigo ascii
            beq a1, t0, numeral		# Si la letra es un espacio -> transformo a numeral
            ecall					# Muestro por pantalla la letra
            addi s0, s0, 1			# Muevo puntero a la siguiente letra
            j lazo_v         		# Repito lazo   
numeral:	
			li a1, 35				# Cargo el valor del numeral en ascii
			ecall					# Muestro por pantalla el numeral
            addi s0, s0, 1			# Muevo puntero a la siguiente letra
            j lazo_v				# Repito lazo
fin_v:            
            j fin					# Fin del programa
vocal:
			li t0, 1 				# En principio supongo que es la vocal a
			la t1, vocales 			# Apunto al inicio de la cadena de vocales
			lb t2, 0(t1) 			# Cargo el caracter de la cadena de vocales
lazo:
            beq a0, t2, final 		# Si el caracter esta entre las vocales termino
            addi t0, t0, 1 			# Incremento en uno el posible indice de la vocal
            addi t1, t1, 1 			# Muevo el puntero en la cadena de vocales
            lb t2, 0(t1) 			# Cargo el caracter de la cadena de vocales
            bnez t2, lazo 			# Si no es el terminador de la cadena repito
            li t0, 0 				# Si llegue al final de la cadena no es una vocal
final:
            mv a0, t0 				# Cargo el resultado en el registro de argumentos
            ret 					# Retorno al programa principal
fin:		
			li a0, 10				# Selección del servicio terminar el programa sin error
            ecall					# Termina el programa y retorna al sistema operativo