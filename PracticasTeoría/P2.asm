	processor 16f877 
	include <p16f877.inc>

valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
J equ H'24'
K equ H'25'
cte1 equ h'C3'
cte2 equ 100h
cte3 equ 120h

	org	0			;Carga al vector de RESET la dirección de inicio
	goto inicio
	org 05

inicio:
		clrf PORTA ; Limpiamos el puerto A 
		clrf PORTB ; Limpimos el puerto B
		clrf PORTC
		bsf STATUS,RP0 ;Nos cambiamos de banco
		bcf	STATUS,RP1 
		;YA ESTAMOS EN EL BANCO 1
		movlw H'00'    ;Configuramos E/S analògicas 
		movwf ADCON1
		movlw H'00'  ;Configuramos Puerto B como salida
		movwf TRISB	
		movwf TRISC
		;Regresamos al banco 0
		bcf STATUS,RP0
		movlw b'11000001' ;Seleccionamos la frecuencia del reloj, selecciòn de canal y usar CAD
		movwf ADCON0
		
lee_pot:
		call retardo
		clrf PORTB
		clrf PORTC
		movlw H'EF'		
		movwf INDF 		; INDF = CLAVE-1 En el apuntador está la clave-1
		bsf	ADCON0,2 	;Modificamos el bit 2 de ADCON0, comienza la conversiòn
		call retardoc
		bcf ADCON0,2
		movfw ADRESH 	;Guardamos la conversiòn en W
		subwf INDF,1	; F = F - W
		btfss STATUS,0 ; IF carry = 1 GOTO clave; ELSE IF carry = 0 goto mascara
		goto clave
		goto convers

convers:
		andlw b'00001111' 	;Hacemos máscara de bits para el valor menos significativo
		call TABLA			;Sacamos el valor en el display por medio de la tabla
		movwf PORTC			;Pasamos el valor de la tabla al display
		movfw ADRESH 		;Pasamos nuevamente la conversiòn en W
		movwf INDF			;Pasamos la conversión al apuntador
		RRF INDF,1
		RRF INDF,1
		RRF INDF,1
		RRF INDF,1			;Recorremos 4 bits para obtener el valor más significativo
		movfw INDF
		andlw b'00001111' 	;Hacemos máscara de bits para el valor más (ahora menos) significativo
		call TABLA			;Sacamos el valor en el display por medio de la tabla
		movwf PORTB			;Pasamos el valor de la tabla al display
		goto lee_pot

clave: 
		movlw B'01110001'
		movwf PORTB 		;Movemos el byte mas significativo al puerto B
		movlw B'00111111'
		movwf PORTC 		;Movemos el byte menos significativo al puerto C
		goto lee_pot


retardo:				;Subrutina de retardo
		movlw cte1
 		movwf valor1
tres 	movlw cte2
 		movwf valor2
dos 	movlw cte3
 		movwf valor3
uno 	decfsz valor3
 		goto uno
 		decfsz valor2
 		goto dos
 		decfsz valor1
 		goto tres
		return

TABLA   ADDWF       PCL,F ; PCL + W
        RETLW       B'00111111' ; CODIGO PARA EL 0
        RETLW       B'00000110' ; CODIGO PARA EL 1
        RETLW       B'01011011' ; CODIGO PARA EL 2
        RETLW       B'01001111' ; CODIGO PARA EL 3
        RETLW       B'01100110' ; CODIGO PARA EL 4
        RETLW       B'01101101' ; CODIGO PARA EL 5
        RETLW       B'01111101' ; CODIGO PARA EL 6
        RETLW       B'00000111' ; CODIGO PARA EL 7
        RETLW       B'01111111' ; CODIGO PARA EL 8
        RETLW       B'01100111' ; CODIGO PARA EL 9
        RETLW		B'01110111' ; A 
        RETLW		B'01111100' ; b
        RETLW		B'00111001' ; C
        RETLW		B'01011110' ; d
        RETLW		B'01111001' ; e
        RETLW		B'01110001' ; F

retardoc:				;Subrutina de retardo
		movlw D'25'		;Cargamos un 25 decimal 
		movwf  J 		;Movemos el valor que tiene w a J
jloop: 
		movwf K 		;El valor del registro lo movemos a K
kloop:
		decfsz K,f 		;Decrementamos K y lo movemos al registro
		goto kloop  	; Saltamos a kloop
		decfsz J,f 		;Decrementamos J y lo movemos al registro
		goto jloop      ;Saltamos a subrutina jloop
		return

END ;FIN DEL PROGRAMA