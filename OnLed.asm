	processor 16f877A
	include <p16f877A.inc>
N equ H'01'
reg1 equ H'20'
	org 0
	goto inicio
	org 5
inicio: 
		bsf	STATUS,5 ; Paso al banco 1
		clrf	TRISB ; Configuurar PORT B como salida
		bcf		STATUS,5 ;Paso al banco 0
loop2:
		movlw	H'01'
		movwf	PORTB
		call	Retardo
		clrf 	PORTB
		call 	Retardo
		goto loop2

Retardo: 
		movlw N
		movwf reg1
loop:
		decfsz reg1,1
		goto loop
		return
		end