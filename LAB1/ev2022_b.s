			.data
apellid:	.asciiz "ruIz"            
            .text
            .globl main
main:		 	
			la a0, apellid			# Direccion del primer caracter en memoria
            jal apellido			# Llamo subrutina
            j fin					# Termino programa
apellido:	
			addi sp, sp, -8			# Reservo memoria en stack
            sw ra, 0(sp)			# Guardo valor de retorno
            sw s0, 4(sp)			# Guardo registro
            
            li a1, 'a'				# Limite inferior
            li a2, 'z'				# Limite Superior
            li a3, 32				# Cantidad a sumar o restar
            
            mv s0, a0				# Copia de la direccion de memoria
lazo:            
            jal cambiar            
            beqz a0, end			# if (char == 0) -> fin
            beq a0, a3, end			# if (char ==' ') -> fin
            addi s0, s0, 1			# Muevo el puntero al siguiente caracter
            mv a0, s0				# Recupero puntero
            j lazo					# Repito lazo
end:            
            lw ra, 0(sp)			# Recupero valor de retorno
            lw s0, 4(sp)			# Recupero registro
            addi sp, sp, 8			# Recupero espacio en stack
            ret						# Retorno al programa principal
#---------------------------------------------------------------------------------------#            
cambiar:
			lbu t0, 0(a0)			# Cargo caracter de memoria
            bge t0, a1, mayor_a    	# if (char >= a) -> mayor_a
            mv a0, t0				# Retorno una copia del caracter despues de la conversion
            ret						# else
mayor_a:	            
            ble t0, a2, menor_z		# if (char >= a y char <= z) -> convierto
            mv a0, t0				# Retorno una copia del caracter despues de la conversion
            ret						# else
menor_z:        
			li t1, 65
            beq a1, t1, may			# if (limite inferior == A) -> es mayuscula
            sub t0, t0, a3			# Minuscula -> Mayuscula resto 32
            sb t0, 0(a0)			# Guardo resultado en memoria
            mv a0, t0				# Retorno una copia del caracter despues de la conversion
            ret
may:
			add t0, t0, a3			# Mayuscula -> Minuscula sumo 32
            sb t0, 0(a0)			# Guardo resultado en memoria
            mv a0, t0				# Retorno una copia del caracter despues de la conversion
            ret
#---------------------------------------------------------------------------------------#            
fin:		
			li a0, 10				# Seleccion de servicio terminar programa sin errores
			ecall					# Termina el programa y retorna al sistema operativo
         