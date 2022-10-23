#	Escriba una subrutina en lenguaje ensamblador del Cortex-M4 que calcule la operación modulo,
#	que cumpla el estándar EABI y que responda al siguiente prototipo:
#	uint16_t modulo(uint16_t dividendo, uint16_t divisor);			D = d * C + R -> R = D - d * C

			.data
Dividendo:	.half 9
divisor:	.half 5
Modulo:		.half 0
            .text
            .globl main
main:		
			lhu a0, Dividendo	# Dividendo
            lhu a1, divisor		# divisor
            jal modulo			# Llamo subrutina
            #rem a0, a0, a1
            la t0, Modulo		# Guardo resultado en memoria
            sh a0, 0(t0)
            
            mv a1, a0			# Muestro resultado
            li a0, 1
            ecall
            
            j fin
modulo:
			div t0, a0, a1		# C = D / d
            mul t0, a1, t0		# aux = d * C
            sub a0, a0, t0		# R = D - d * C
            ret					# Retorno al programa principal
fin:
			li a0, 10			# Seleccion de servicio terminar programa sin error
            ecall				# Termina el programa y retorna al sistema operativo
