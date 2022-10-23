#	Escriba una subrutina que invierta una cadena de caracteres ASCII se encuentra
#	almacenada en memoria. Esta subrutina recibe el puntero al inicio de la cadena en R0
#	y un puntero al final en R1.
#	a) Diseñe una subrutina cambiar que invierta el primer y el último caracter de la cadena. Esta
#	subrutina recibe el puntero al primer elemento en R0 y al último en R1.
#	b) Diseñe ahora una subrutina recursiva invertir que utiliza la rutina anterior para intercambiar
#	los elementos del extremo de la cadena y a si misma para invertir el resto.

			.data
cad:		.asciiz "Hola Mundo"            
            .text
            .globl main
main:		
			la a0, cad					# Puntero al inicio de la cadena
            addi a1, a0, 9				# Puntero al fin de la cadena
            jal invertir				# Llamo subrutina invertir
            j fin						# Fin del programa
cambiar:	
			lb t0, 0(a0)				# Cargo el primer elemento
            lb t1, 0(a1)				# Cargo el ultimo elemento
            sb t1, 0(a0)				# Cargo el primero en la ultima posicion
            sb t0, 0(a1)				# Cargo el ultimo en la primera posicion
            ret							# Retorno al programa principal
invertir:	
			addi sp, sp, -4				# Reservo memoria en stack
            sw ra, 0(sp)				# Guardo el valor de retorno
lazo:		
			bgt a0, a1, lazo_fin		# Si el primer puntero se cruza con el ultimo entonces fin
            jal cambiar					# Llamo subrutina cambiar
            addi a0, a0, 1				# Muevo primer puntero 1 posicion a la derecha
            addi a1, a1, -1				# Muevo ultimo puntero 1 posicion a la izquierda
            j lazo						# Repito lazo
lazo_fin:
			lw ra, 0(sp)				# Recupero memoria en stack
            addi sp, sp, 4				# Recupero el valor de retorno
            ret							# Retorno al programa principal
fin:		
			li a0, 10					# Seleccion de servicio finalizar el programa sin errores
            ecall						# Termina el programa y retorna al sistema operativo