			.data
TABLA:		.byte 0x3F 0x06 0x5B 0x4F 0x66 0x6D 0x7D 0x07 0x7F 0x6F
				#	0	1	 2	  3	   4	5	  6	   7	8	9				
cad1:		.asciiz "BCD: "
cad2:		.asciiz "\n7Segmentos: "
            .text
            .globl main
            
main:		la a1, cad1				# Cargo cadena1
			li a0, 4				# Seleccion de servicio mostrar string
			ecall					# Muestro cad1 por pantalla
            
			li a1, 3				# Numero en BCD
			li a0, 1				# Seleccion de servicio mostrar entero
            ecall					# Muestro por pantalla el numero en decimal
            
            la a1, cad2				# Cargo cadena2
			li a0, 4				# Seleccion de servicio mostrar string
			ecall					# Muestro cad2 por pantalla
            
            li a0, 3				# Numero en BCD a convertir
			la a1, TABLA			# Direccion de la tabla
            jal ra, conversion		# Convierto BCD -> 7Segmentos
            
			mv a1, a0				# Numero en 7Segmentos
            li a0, 34				# Seleccion de servicio mostrar numero en hexadecimal
            ecall					# Muestro por pantalla el resultado
            
            j fin
            
conversion:	add a1, a1, a0			# Mapeo la direccion del 5 respecto del primero
			lb a0, 0(a1)			# Cargo el 5 en hexa
            jr ra					# Retorno valor

fin:		li a0, 10				# Seleccion de servicio terminar programa sin errores
			ecall					# Termina programa y retorna al sistema operativo
			