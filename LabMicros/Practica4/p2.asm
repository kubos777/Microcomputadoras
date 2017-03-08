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

PUERTOA:     ;Configuramos las opciones para el dipswitch en bits
	movf 	PORTA,0	;leer lo que hay en el puerto A y cargarlo en w
	xorlw	b'00000000'	;Aplicamos una operación lógica a la literal y verificamos la bandera Z
	btfsc	STATUS,Z	;Si Z es cero, salta.
	call	paso1		;Llamamos al paso 1
	movf	PORTA,0		; Realizamos lo mismo para los pasos siguientes.
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
	movlw	b'00000000'  ;Ambos motores estan en paro
	movwf	PORTB		 ; Se mueve al puerto B la acción
	return
paso2:
	movlw	b'11111111' ; Ambos motores estan habilitados y girando en sentido horario
	movwf	PORTB		; Se mueve al puerto B la acción
	return
paso3:
	movlw	b'00001010' ;Ambos motores estan habilitados y girando en sentido antihorario
	movwf	PORTB		; Se mueve al puerto B la acción
	return
paso4:
	movlw	b'00001110' ;Ambos motores estan habilitados pero el motor 1 gira en sentido horario y el 2 al revés
	movwf	PORTB		; Se mueve al puerto B la acción
	return
paso5:
	movlw	b'00001011'	;Ambos motores estan habilitados pero el motor 2 gira en sentido horario y el 1 al revés.
	movwf	PORTB		; Se mueve al puerto B la acción
	return
	
	end