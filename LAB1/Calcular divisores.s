#	Escriba una subrutina transparente divisores que calcule todos los divisores de un número
#	entero positivo menor o igual a 255. La misma debe recibir en el registro R0 el número y en el
#	registro R1 la dirección de inicio del vector donde se almacenarán los divisores encontrado. La
#	subrutina deberá devolver en R0 la cantidad de divisores encontrados para el número.
       		.data
num:		.byte 24
vector:		.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 # 20 bytes reservados
            .text
            .globl main
main:		
			lbu a0, num
            la a1, vector
            jal divisores
            mv a1, a0
            li a0, 1
            ecall
            j fin
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
			sb t1, 0(a1)
            addi a1, a1, 1
			addi t0, t0, 1
            addi t1, t1, 1
            j lazo
end:
			mv a0, t0
            ret
fin:
			li a0, 10				# Seleccion de servicio terminar programa sin error
            ecall					# Termina el programa y retorna al sistema operativo

            