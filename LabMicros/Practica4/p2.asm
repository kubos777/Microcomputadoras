;Programa 1
	processor 16f877 
	include <p16f877.inc>
	org	0			;Carga al vector de RESET la dirección de inicio
	goto inicio
	org 05	 		;Dirección de inicio del programa del usuario
inicio: 
	; Configuraciones para tratar puertos DIGITALES
	clrf	PORTA 	; Limpia el registro PORTA
	bsf		STATUS,RP0 ; Cambiando al banco 1
	bcf 	STATUS,RP1
 	movlw 	H'07' 	; Configura puertos A y E como digitales
	movwf 	ADCON1
	movlw 	H'FF' 	; Configura el puerto A como entrada
	movwf 	TRISA
	movlw 	H'00'	; Configura el puerto B como salida
 	movwf 	TRISB	
	bcf 	STATUS,RP0 ; Regresa al banco cero

PUERTOA:
	movf 	PORTA,0	;leer lo que hay en el puerto A y cargarlo en w
	xorlw	b'00000000'
	btfsc	STATUS,Z
	call	paso1
	movf	PORTA,0
	xorlw	b'00000001'
	btfsc	STATUS,Z
	call	paso2
	movf	PORTA,0
	xorlw	b'00000010'
	btfsc	STATUS,Z
	call	paso3
	movf	PORTA,0
	xorlw	b'00000011'
	btfsc	STATUS,Z
	call	paso4
	movf	PORTA,0
	xorlw	b'00000100'
	btfsc	STATUS,Z
	call	paso5

	goto	PUERTOA

paso1:
	movlw	b'00000000'
	movwf	PORTB
	return
paso2:
	movlw	b'11111111'
	movwf	PORTB
	return
paso3:
	movlw	b'00001010'
	movwf	PORTB
	return
paso4:
	movlw	b'00001110'
	movwf	PORTB
	return
paso5:
	movlw	b'00001011'
	movwf	PORTB
	return
	
	end