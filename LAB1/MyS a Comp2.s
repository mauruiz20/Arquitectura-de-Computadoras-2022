#		Se tiene un bloque de datos de 8 bits, guardados en codificación magnitud y signo. El primer
#	elemento está guardado en la dirección vector y el final del bloque está marcado con el valor
#	0x80.
#		Escriba un programa que modifique los elementos del bloque para quedar almacenados en
#	codificación complemento a 2. Los elementos deben quedar almacenados en las mismas
#	direcciones de memoria en que se encontraban originalmente.

			.data
vector:		.byte 0x06 0x85 0x78 0xF8 0xE0 0x80            
            .text
            .globl main
main:		
			la a0, vector				# Direccion del vector
            jal compados				# Llamo subrutina
            j fin						# Fin del programa
compados:	
			li s0, 0x80					# Valor de escape
lazo:
			lbu t0, 0(a0)				# Cargo un elemento del vector
            beq t0, s0, end				# if (elemento == 0x80) -> end
            
            andi t1, t0, 128			# Verifico si el MSB es = 0 o = 1
            beqz t1, noconv				# if (MSB == 0) -> no convierto (binario absoluto)
            							# else
            xori t0, t0, 127			# Cambio todos los bits 0 por 1 y los 1 por 0, menos el MSB
            addi t0, t0, 1				# Sumo 1 al resultado -> obtengo complemento2
            sb t0, 0(a0)				# Guardo el resultado en la posicion correspondiente
            
            addi a0, a0, 1				# Muevo puntero al siguiente elemento
			j lazo						# Repito lazo
noconv:		
			addi a0, a0, 1				# Muevo puntero al siguiente elemento
			j lazo						# Repito lazo
end:
			ret							# Retorno al programa principal
fin:		
			li a0, 10					# Seleccion de servicio terminar programa sin errores
			ecall						# Termina el programa y retorna al sistema operativo
			