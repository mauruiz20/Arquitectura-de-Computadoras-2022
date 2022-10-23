# Escriba un programa que agregue un bit de paridad a una cadena de caracteres
# ASCII. La finalización de la cadena esta marcada con el valor 0x00 y el bloque comienza
# en la dirección base. Se debe poner en 1 el bit más significativo de cada caracter si y sólo si
# esto hace que el número total de unos en ese byte sea par.			
            .data
base:		.byte 0x06 0x7A 0x7B 0x7C 0x00			# Resultado: 0x06 0xFA 0x7B 0xFC 0x00            
            .text
            .globl main
main:		
			la a0, base
            jal paridad
            j fin
paridad:	
			addi sp, sp, -4
            sw ra, 0(sp)
            
			mv s0, a0
            lb s1, 0(a0)
            li s2, 128
            li s3, 1
lazo:            
            lb s1, 0(s0)
            beqz s1, fin_lazo
            addi s0, s0, 1
            mv a0, s1
            jal contador 
            and t0, a0, s3
            beqz t0, lazo
            or s1, s1, s2
            sb s1, -1(s0)
            j lazo
fin_lazo:	
			lw ra, 0(sp)
            addi sp, sp, 4
			ret
contador:	
			mv t0, zero				# Contador = 0
            mv t1, a0				# Numero a contar los bits
            li t2, 1				# Primera mascara                        
            li t3, 0				# Desplazamiento a la derecha
lazo_c:		
			beq t2, s2, fin_lazo_c	# Si la mascara es igual a 128 ya finalice
            and t4, t1, t2			# Aplico mascara
            srl t4, t4, t3			# Desplazo el resultado a la primera posicion
            add t0, t0, t4			# Acumulo el resultado
            li t4, 2
            mul t2, t2, t4			# Multiplico la mascara por 2
            addi t3, t3, 1			# Aumento el desplazamiento a la derecha en 1
			j lazo_c
fin_lazo_c:	
			mv a0, t0
			ret
fin:		
			li a0, 10				# Seleccion del servicio terminar programa sin error
            ecall					# Termina el programa y vuelve al sistema operativo
			
			