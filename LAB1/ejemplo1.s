# suma dos números almacenados en memoria y guarda el resultado en memoria
    	.data
        
num1:	.word 5
num2:	.word 12
res:	.word 1
        
        .text
        .globl main
main:	
		lw t0, num1				# Se carga el primer operando desde memoria
        lw t1, num2				# Se carga el segundo operando desde memoria
        add t0, t0, t1			# Se calcula el resultado como la suma de los operandos
        
        la t2, res				# Se carga la dirección para almacenar resultado
        sw t0, 0(t2)			# Se almacena el resultado utilizando el puntero
final:
        li a0, 10				# Selección del servicio terminar el programa sin error
		ecall					# Termina el programa y retorna al sistema operativo