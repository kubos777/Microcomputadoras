	processor 16f877A
	include <p16f877A.inc>

D1	equ H'20'	 
D2  equ H'21'
Res equ H'22'
Aca equ H'23'

	org 0
	goto inicio
	org 05H
inicio

	movlw	H'06'	; w=06H
	movwf	D1		; D1= w
	
	movlw	H'02'	; w=02H
	movwf	D2		; D2= w
	;Datos cargados

	movwf	D1,0	; w=D1
	addwf	D2,0	; w= w + D2

	btfss	STATUS,0
	goto	no_hubo
	goto	si_hubo

no_hubo:
		
		movwf Res 	; Res=w
		clrf Aca	; Aca=00H
		goto inicio	
si_hubo:
		
		movwf Res 	; Res=w
		movlw H'01'	; w= 01H
		movwf Aca	; Aca = w
		goto inicio
		
		end
