# Escriba un programa para encontrar el mayor elemento en un bloque de datos. El tamaño de
# dato es de 8 bits. El resultado debe guardarse en la dirección base, la longitud del bloque está
# en la dirección base+1 y el bloque comienza a partir de la dirección base+2.
			.data
base:		.byte 0xCC 0x03 0x3A 0xAA 0xF2 
			.text
            .globl main
main:		
			la a0, base
            jal rutina
            j fin
rutina:		
			mv t0, a0				# Copio puntero
            lb t1, 1(t0)			# Cargo el tamaño del bloque de datos
            addi t0, t0, 2			# Muevo el puntero al primer elemento
            lbu t2, 0(t0)			# Cargo el primer elemento y lo seteo como el mas grande
lazo:		
			beqz t1, fin_lazo		# Si el tamaño es cero -> termino
            addi t0, t0, 1			# Muevo el puntero al siguiente elemento
            lbu t3, 0(t0)			# Cargo elemento
            addi t1, t1, -1			# Decremento el tamaño del bloque
            bgt t3, t2, mayor		# Si el nuevo elemento > mayor -> nuevo mayor
            j lazo					# Repito lazo
mayor:		
			mv t2, t3				# Seteo nuevo mayor
            j lazo					# Repito lazo
fin_lazo:		
			sb t2, 0(a0)			# Guardo el resultado en la direccion base
            ret						# Retorno al programa principal
fin:		
			li a0, 10				# Seleccion del servicio terminar programa sin errores
            ecall					# Termina el programa y retorna al sistema operativo