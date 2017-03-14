;Programa 2
	processor 16f877 
	include <p16f877.inc>
	A equ H'24'	
	org	0			;Carga al vector de RESET la dirección de inicio
	goto inicio 
	org 05	 		;Dirección de inicio del programa del usuario  
inicio: 
		clrf PORTA ;Limpiamos lo que hay en el puerto A
		bsf STATUS,RP0 ; Nos cambiamos de banco
		bcf STATUS,RP1	
		movlw H'07'   
		movwf ADCON1  ;Configuramos el registro como entrada/salida
		movlw H'FF'   ;Movemos un 255 a w
		movwf TRISA   ;Movemos w al registro TRISA
		movlw H'00'   ;Movemos un 0 a w
		movwf TRISB    ;Movemos w al registro TRISB
		bcf	STATUS,RP0 ;Regresamos al banco 0



INFRA: ;Le asignamos el nombre INFRA a la subrutina
	
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
	movlw	b'00001011' ;	El motor 1 gira hacia atrás y el 2 hacia adelante
	movwf	PORTB		; Movemos el resultado anterior al puerto B que son los motores
	return
paso2:
	movlw	b'11111111'	;Ambos motores giran hacia adelante
	movwf	PORTB		; Movemos el resultado anterior al puerto B que son los motores
	return
paso3:
	movlw	b'00001110' ;El motor 1 gira hacia adelante y el segundo hacia atrás
	movwf	PORTB		; Movemos el resultado anterior al puerto B que son los motores
	return
paso4:
	movlw	b'00000000' ;Ambos motores se encuentran en paro cuando no se cubre ningún sensor
	movwf	PORTB		; Movemos el resultado anterior al puerto B que son los motores
	return

	end   ;fin del programa
		