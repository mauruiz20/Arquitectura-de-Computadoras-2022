			.data
vector:		.byte 9 4 8 6 2 1 0 5 7 12 3			# Promedio = 5
            .text
            .globl main
            
main:		la a0, vector
			li t0, 0					# t0: Acumulador
            li t1, 0					# t1: Indice
            
lazo:
			lb t2, 0(a0)				# Carga de un elemento del vector
            beqz t2, fin				# Si es 0 -> termino
            add t0, t0, t2				# Acumulo
            addi t1, t1, 1				# Incremento indice
            addi a0, a0, 1				# Incremento el puntero del vector
            j lazo						# Repito hasta encontrar un 0

fin:		beqz t0, cero				# Si el primer elemento es 0 no calculo
			div a1, t0, t1				# Calculo promedio = Acumulador/Indice
            j stop

cero:		li a1, 0					# Si el primer elemento es 0 lo muestro
stop:		li a0, 1					# Muestro resultado por pantalla
            ecall
            
			li a0, 10
			ecall