	processor 16f877A
	include <p16f877A.inc>
N equ H'53'
reg1 equ H'20'
	org 0
	goto inicio
	org 5
inicio: movlw N
		movwf reg1

		nop
loop:
		decfsz reg1,1
		goto loop
		nop ; para que contrinuya al retardo, da los 50 segs exacto

		nop
		end