	processor 16f877A
	include <p16f877A.inc>

aux	equ H'24'
cont equ H'25'

	org 0
	goto inicio
	org 5

inicio: 
	movlw H'20'
	movfw FSR
	clrf  aux
	movlw H'04'
	movwf cont
loop:
	incf aux,1
	movf aux,0
	movwf INDF
	incf FSR,1
	decfsz cont,1
	goto loop
	goto fin
fin:
	goto fin