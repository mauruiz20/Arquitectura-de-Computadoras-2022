			.data
cad:		.asciiz "cadena de caracteres"            
            .text
            .globl main
main:
			la a0, cad				# Direccion de memoria del primer caracter de la cadena
            jal mostrar				# Llamo subrutina
            j fin					
mostrar:
			mv a1, a0				# Muevo la direccion a a1
            li a0, 4				# Seleccion de servicio mostrar string
            ecall					# Muestro por pantalla la cadena de caracteres
            ret						# Retorno al programa principal
fin:		
			li a0, 10				# Seleccion de servicio terminar programa sin errores
			ecall					# Termina el programa y retorna al sistema operativo
			