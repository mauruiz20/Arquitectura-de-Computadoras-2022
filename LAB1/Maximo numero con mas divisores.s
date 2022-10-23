#	Escriba un programa que, usando las subrutinas anteriores, encuentre el número N, positivo
#	menor que 255, con la mayor cantidad de divisores. El programa deberá almacenar el resultado
#	encontrado en la variable global numero y la cantidad de divisores correspondientes en
#	la variable global maximo.
       		.data
num:		.byte 2
maximo:		.byte 1
            .text
            .globl main
main:		
            jal max_div
            la s0, num
            sb a2, 0(s0)
            la s0, maximo
            sb a1, 0(s0)
            j fin
max_div:	
			addi sp, sp, -4
            sw ra, 0(sp)
            
			li s0, 255
            li s1, 1
            mv a1, zero				# Maxima cantidad de divisores
            mv a2, zero				# Numero con la maxima cantidad de divisores
lazo_div:
			beq s0, s1, end_div
            mv a0, s0
            jal divisores
            bgt a0, a1, nuevo
            addi s0, s0, -1
            j lazo_div
nuevo:
			mv a1, a0
            mv a2, s0
            addi s0, s0, -1
            j lazo_div
end_div:
			lw ra, 0(sp)
            addi sp, sp, 4
			ret
divisores:
			mv t0, zero				# Contador de divisores
            li t1, 1				# Posible divisor
lazo:		
			bgt t1, a0, end			# Posible divisor > num -> end
			rem t2, a0, t1
            beqz t2, es_divisor
            addi t1, t1, 1
            j lazo
es_divisor: 			
			addi t0, t0, 1
            addi t1, t1, 1
            j lazo
end:
			mv a0, t0
            ret
fin:
			li a0, 10				# Seleccion de servicio terminar programa sin error
            ecall					# Termina el programa y retorna al sistema operativo

            