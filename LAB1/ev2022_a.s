			.data
caracter:	.asciiz "C"            
            .text
            .globl main
main:		 
			la a0, caracter			# Direccion del caracter en memoria
            li a1, 'A'				# Limite inferior
            li a2, 'Z'				# Limite Superior
            li a3, 32				# Cantidad a sumar o restar
            jal cambiar				# Llamo subrutina
            j fin
cambiar:
			lbu t0, 0(a0)			# Cargo caracter de memoria
            bge t0, a1, mayor_a    	# if (char >= a) -> mayor_a
            mv a0, t0				# Retorno una copia del caracter
            ret						# else
mayor_a:	            
            ble t0, a2, menor_z		# if (char >= a y char <= z) -> convierto
            mv a0, t0				# Retorno una copia del caracter
            ret						# else
menor_z:        
			li t1, 65
            beq a1, t1, may			# if (limite inferior == A) -> es mayuscula
            						# else
            sub t0, t0, a3			# Minuscula -> Mayuscula resto 32
            sb t0, 0(a0)			# Guardo resultado en memoria
            mv a0, t0				# Retorno una copia del caracter despues de la conversion
            ret						# Retorno al programa principal
may:
			add t0, t0, a3			# Mayuscula -> Minuscula sumo 32
            sb t0, 0(a0)			# Guardo resultado en memoria
            mv a0, t0				# Retorno una copia del caracter despues de la conversion
            ret						# Retorno al programa principal
fin:		
			li a0, 10				# Seleccion de servicio terminar programa sin errores
			ecall					# Termina el programa y retorna al sistema operativo
         