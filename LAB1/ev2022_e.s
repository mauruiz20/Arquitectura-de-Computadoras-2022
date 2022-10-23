			.data
cad:		.asciiz "nOmBrE ApElLiDo"  
salto:		.asciiz "\n"
            .text
            .globl main
main:		 	
			la a0, cad				# Direccion de memoria de la cadena
            jal mostrar				# Muestro cadena
            	
            la a0, salto			# Direccion de memoria de salto de linea
            jal mostrar				# Muestro salto de linea
            
            la a0, cad				# Direccion de memoria de la cadena
            jal convertir			# Llamo subrutina para convertir la cadena
     
            la a0, cad				# Direccion de memoria de la cadena
            jal mostrar				# Muestro cadena
            
            j fin					# Termino programa
#---------------------------------------------------------------------------------------#     
convertir:
			addi sp, sp, -4			# Reservo memoria en stack
            sw ra, 0(sp)			# Guardo valor de retorno
            
            jal nombre				# Convierto el nombre
            jal apellido			# Convierto el apellido
            
            lw ra, 0(sp)			# Recupero valor de retorno
            addi sp, sp, 4			# Recupero espacio en stack
            ret						# Retorno al programa principal
#---------------------------------------------------------------------------------------#               
nombre:	
			addi sp, sp, -8			# Reservo memoria en stack
            sw ra, 0(sp)			# Guardo valor de retorno
            sw s0, 4(sp)			# Guardo registro

            li a1, 'a'				# Limite inferior
            li a2, 'z'				# Limite Superior
            li a3, 32				# Cantidad a sumar o restar
            
            mv s0, a0				# Copia de la direccion de memoria
            
            jal cambiar				# Convierto el primer a caracter a Mayusculas
            addi s0, s0, 1			# Muevo el puntero al siguiente caracter
            mv a0, s0              	# Recupero el puntero
            li a1, 'A'				# Limite inferior
            li a2, 'Z'				# Limite Superior
lazo_n:            
            jal cambiar            
            beqz a0, end_n			# if (char == 0) -> fin
            beq a0, a3, end_n		# if (char ==' ') -> fin
            						# else
            addi s0, s0, 1			# Muevo el puntero al siguiente caracter
            mv a0, s0				# Recupero el puntero
            j lazo_n				# Repito lazo
end_n:                	
            addi s0, s0, 1			# Muevo el puntero al siguiente caracter
            mv a0, s0				# Retorno el puntero al siguiente caracter (Continuar con la conversion)
            
            lw ra, 0(sp)			# Recupero valor de retorno
            lw s0, 4(sp)			# Recupero registro
            addi sp, sp, 8			# Recupero espacio en stack
            
            ret						# Retorno al programa principal
#---------------------------------------------------------------------------------------#   
apellido:	
			addi sp, sp, -8			# Reservo memoria en stack
            sw ra, 0(sp)			# Guardo valor de retorno
            sw s0, 4(sp)			# Guardo registro
            
            li a1, 'a'				# Limite inferior
            li a2, 'z'				# Limite Superior
            li a3, 32				# Cantidad a sumar o restar
            
            mv s0, a0				# Copia de la direccion de memoria
lazo_a:            
            jal cambiar            
            beqz a0, end_a			# if (char == 0) -> fin
            beq a0, a3, end_a		# if (char ==' ') -> fin
            addi s0, s0, 1			# Muevo el puntero al siguiente caracter
            mv a0, s0
            j lazo_a				# Repito lazo
end_a:            
            lw ra, 0(sp)			# Recupero valor de retorno
            lw s0, 4(sp)			# Recupero registro
            addi sp, sp, 8			# Recupero espacio en stack
            ret            			# Retorno al programa principal
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
mostrar:
			mv a1, a0				# Muevo la direccion a a1
            li a0, 4				# Seleccion de servicio mostrar string
            ecall					# Muestro por pantalla la cadena de caracteres
            ret						# Retorno al programa principal
#---------------------------------------------------------------------------------------#              
fin:		
			li a0, 10				# Seleccion de servicio terminar programa sin errores
			ecall					# Termina el programa y retorna al sistema operativo
         