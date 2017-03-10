;Programa 2
	processor 16f877 
	include <p16f877.inc>
	A equ H'24'	
	org	0			;Carga al vector de RESET la dirección de inicio
	goto inicio
	org 05	 		;Dirección de inicio del programa del usuario
   
inicio: 
		clrf PORTA
		bsf STATUS,RP0
		bcf STATUS,RP1
		
		movlw H'07'
		movwf ADCON1
		movlw H'FF'
		movwf TRISA
		movlw H'00'
		movwf TRISB
		bcf	STATUS,RP0
INFRA:
	movf PORTA,0
	movwf A
	movwf H'07'
	andwf A,f
	movfw A
	xorlw H'00'
	btfsc STATUS,Z
	call paso1

	movf PORTA,0
	xorlw H'01'
	btfsc STATUS,Z
	call paso2

    movf PORTA,0
	xorlw H'02'
	btfsc STATUS,Z
	call paso3

    movf PORTA,0
	xorlw H'04'
	btfsc STATUS,Z
	call paso4

	goto	inicio

paso1:
	movlw	b'00001011'
	movwf	PORTB
	return
paso2:
	movlw	b'11111111'
	movwf	PORTB
	return
paso3:
	movlw	b'00001110'
	movwf	PORTB
	return
paso4:
	movlw	b'00000000'
	movwf	PORTB
	return

	end
		