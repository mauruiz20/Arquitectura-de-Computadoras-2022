			.data
X:			.word 1 2 3 4 5
Y:			.word 5 4 3 2 1
Z:			.word 0 0 0 0 0
cad:		.asciiz "Vector resultado: "
            .text
            .globl main
            
main:		la a0, X			# Direccion base X
			la a1, Y			# Direccion base Y
            la a2, Z			# Direccion base Z
            li a3, 500			# Cte a
            li a4, 5			# Tamaño de los vectores
            jal ra, intvec
            
            la a0, Z			# Direccion base Z
            li a1, 5			# Tamaño del vector
            jal ra, mostrar		# Mostrar vector
            
            j fin
                      
intvec:		addi sp, sp, -4		# Reservo memoria en stack
			sw ra, 0(sp)		# Guardo ra
			
            mv t0, a0			# Direccion base X
            mv t1, a1			# Direccion base Y
            mv t2, a2			# Direccion base Z
            mv t3, a4			# Tamaño de los vectores
            
lazo:		beqz t3, fin_lazo	# Si el tamaño del vector es 0 termino
			lw a0, 0(t0)		# Cargo elemento Xi
			lw a1, 0(t1)		# Cargo elemento Yi
            mv a2, a3  			# Cte a
            
            jal ra, intlin		# Llamo subrutina intlin
            sw a0, 0(t2)		# Guardo resultado en Zi
            
            addi t0, t0, 4		# Incremento puntero X
            addi t1, t1, 4		# Incremento puntero Y
            addi t2, t2, 4		# Incremento puntero Z
            
            addi t3, t3, -1		# Decremento tamaño del vector
            j lazo				# Repito lazo
            
fin_lazo:	lw ra, 0(sp)		# Recupero ra
            addi sp, sp, 4		# Elimino memoria en stack          
            jr ra				# Retorno programa principal
           
intlin:		li s0 1000
			mul a0 a0 a2		# Xi * a
			sub a2 s0 a2		# 1 - a
			mul a1 a1 a2		# Y * (1 - a)
            add a0 a0 a1		# Xi * a + Y * (1 - a)
            jr ra
            
mostrar:	mv t0, a0			# Puntero Z
			mv t1, a1			# Tamaño del vector
            li a0, 4			# Muestro cadena
            la a1, cad
            ecall
            
lazo_m:		beqz t1, fin_mostrar	# Si el tamaño llega a 0 termino
            li a0, 1				# Muestro numero entero
            lw a1, 0(t0)			# Cargo elemento del vector Z
            ecall					# Muestro elemento
            
            li a0, 11				# Muestro un espacio
            li a1, 32
            ecall
            
            addi t0, t0, 4			# Incremento el puntero Z
            addi t1, t1, -1			# Decremento tamaño
            j lazo_m
            
fin_mostrar: jr ra            
            
fin:		li a0, 10
			ecall