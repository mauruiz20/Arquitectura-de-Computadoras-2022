			.data
vector:		.byte 1 2 3 4 5 0 6 7 8      
cad1:		.asciiz "Suma: "
cad2:		.asciiz "\nPromedio: "
            .text
            .globl main            
main:		
			la a0, vector			# Puntero al inicio del vector
            jal rutina				# Llamo subrutina
            j fin					# Fin del programa
rutina:		
			mv t0, zero				# Suma
            mv t1, zero				# Promedio      
lazo:
			lb t2, 0(a0)			# Cargo un elemento del vector
			beqz t2, fin_lazo		# if(elemento == 0) -> fin_lazo
            add t0, t0, t2			# Acumulo la suma
            addi t1, t1, 1			# Incremento contador
            addi a0, a0, 1			# Muevo puntero al siguiente elemento
            j lazo					# Repito lazo
fin_lazo:	
			li a0, 4				# Seleccion de servicio mostrar string
            la a1, cad1				# Puntero a la cadena1
            ecall					# Muestro por pantalla la cadena
            li a0, 1				# Seleccion de servicio mostrar entero
            mv a1, t0				# Cargo resultado de la suma
            ecall					# Muestro por pantalla el entero
            
            div t1, t0, t1			# Calculo promedio
            
            li a0, 4				# Seleccion de servicio mostrar string
            la a1, cad2				# Puntero a la cadena2
            ecall					# Muestro por pantalla la cadena
            li a0, 1				# Seleccion de servicio mostrar entero
            mv a1, t1				# Cargo resultado del promedio
            ecall					# Muestro por pantalla el entero
			ret						# Retorno al programa principal
fin:		
			li a0, 10				# Seleccion de servicio terminar el programa sin error
			ecall					# Termina el programa y retorna al sistema operativo
			