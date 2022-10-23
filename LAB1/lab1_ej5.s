			.data
vector:		.byte 9 15 3 6 10 1 8 4 5 11
cad0:		.asciiz "Vector original: "
cad1:		.asciiz "\nVector ordenado: "
            .text
            .globl main
            
main:		#--------------# 				Mostrar vector original
			li a0, 4
			la a1, cad0
            ecall
			la a0, vector			
      		li a1, 10
			jal ra, mostrar
            #--------------#         
            la a0, vector				# En a0 cargo la direccion del vector				
      		li a1, 10					# En a1 cargo el tamaño del vector
      		jal ra, ordenar				# Llamo subrutina ordenar 
            #--------------#			Mostrar vector ordenado
            li a0, 4
			la a1, cad1
            ecall
            la a0, vector	
      		li a1, 10
            jal ra, mostrar
            #--------------#
            j fin						# Fin
#---------------------------------------------------------------------------------#            
ordenar:   	addi sp, sp, -4				# Reservo memoria en stack
			sw ra, 0(sp)				# Guardo ra

			li t0, 0					# indice i
            li t1, 1					# indice j
            addi t2, a1, -1				# n-1		
            
lazo1:		bge t0, t2, fin_lazo1		# if (i >= n-1) -> fin_lazo1
			addi a1, a0, 1				# puntero j = i + 1
            addi t1, t0, 1				# j = i + 1
            
lazo2:		bgt t1, t2, fin_lazo2		# if (j > n-1) -> fin_lazo2
            jal ra, comparar			# if (vector[j] < vector[i]) -> intercambio
            addi a1, a1, 1				# puntero j = j + 1
         	addi t1, t1, 1				# j = j + 1
			j lazo2						# Repito lazo2

fin_lazo2:	addi a0, a0, 1				# puntero i = i + 1
			addi t0, t0, 1				# i = i + 1
            j lazo1						# Repito lazo1

fin_lazo1:	lw ra, 0(sp)				# Recupero ra
			addi sp, sp, 4				# Elimino memoria del stack
			jr ra						# Vuelvo al programa principal
#---------------------------------------------------------------------------------#      
comparar:	addi sp, sp, -2				# Reservo memoria en stack
			sb t0, 0(sp)				# Guardo t0
			sb t1, 1(sp)				# Guardo t1
            
			lb t0, 0(a0)				# Cargo A
			lb t1, 0(a1)				# Cargo B       
            blt t0, t1, menor			# Comparo si A < B -> menor
            sb t1, 0(a0)				# Si no entonces B <= A
            sb t0, 0(a1)				# Intercambio
            
menor:      							# Ya esta ordenado
			lb t0, 0(sp)				# Recupero t0
			lb t1, 1(sp)				# Recupero t1
            addi sp, sp, 2				# Elimino memoria del stack
			jr ra						# Vuelvo al programa principal
#---------------------------------------------------------------------------------#    
mostrar:	li t0, 0
			mv t1, a1
            mv t2, a0
            
l_mostrar:	bge t0, t1, f_mostrar

			li a0, 1
			lb a1, 0(t2)
			ecall
            
            li a0, 11
            li a1, 44
            ecall
            
            addi t2, t2, 1
            addi t0, t0, 1
            j l_mostrar
            
f_mostrar:	jr ra
#---------------------------------------------------------------------------------#
fin:		li a0, 10
			ecall

