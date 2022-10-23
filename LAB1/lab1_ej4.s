			.data
cad1:		.asciiz "A = "
cad2:		.asciiz " B = "
A:			.byte 36
B:			.byte 25
            .text
            .globl main
            
main:		la a0, A				# Direccion de A
			la a1, B				# Direccion de B
			jal ra, comparar		# Llamo subrutina
            j mostrar				
            
comparar:	lb t0, 0(a0)			# Cargo A
			lb t1, 0(a1)			# Cargo B
            
            blt t0, t1, menor		# Comparo si A < B -> salto a menor
            sb t1, 0(a0)			# Si no entonces B <= A
            sb t0, 0(a1)
            jr ra
            
menor:		sb t0, 0(a0)
			sb t1, 0(a1)
            
mostrar:	li a0, 4				# Muestro la cad1
			la a1, cad1
            ecall
            li a0, 1
            lb a1, A				# Muestro A
            ecall
            
            li a0, 4				# Muestro la cad2
			la a1, cad2
            ecall
            li a0, 1
            lb a1, B				# Muestro B
            ecall
            
fin:		li a0, 10
			ecall

