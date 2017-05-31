processor 16f877 ;Indica la versión del procesador
 include<p16f877.inc>
contador equ h'20' ;Nos ayudara en los corrimientos
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 20h      ;Constantes para el retardo
cte2 equ 50h
cte3 equ 60h


 org 0 ;Para el vector reset a la dirección de inicio
 goto inicio ;salto incondicional a inicio
 org 5
inicio:
	clrf	PORTB ;Limpiamos el puerto B
	clrf	PORTA ;Limpiamos el puerto A
	bsf		STATUS,RP0
	bcf		STATUS,RP1  ;CAMBIAMOS A BANCO 1
	movlw	H'07' ;Movemos un 7 a w
	movwf	ADCON1  ; Registro para Entradas/Salidas DIGITALES
	movlw	H'FF'	;Movemos el valor FF de la literal a w
	movwf	TRISA    ;Movemos al registro TRISA Lo de w
	movlw H'00'	; Movemos lo de la literal a w
	movwf TRISB	;Movemos lo que tiene w a TRISB
	bcf STATUS,RP0 ;CAMBIAMOS A BANCO 0 
ciclo:
		btfsc PORTA,2 ;Preguntamos por el bit 2 del Puerto A
		goto c56   ;Para el caso 5 o 6
		goto c1234 ; Para el caso del 1 al 4
c1234:
		btfsc PORTA,1 ;Preguntamos por el bit 1 del Puerto A
		goto c34 ;Para el caso 3 y 4
		goto c12 ; Para el caso 1 y 2
c12:
		btfsc PORTA,0 ;Preguntamos por el bit 0 del puerto A
		goto c2 ;Entramos al caso 2
		goto c1 ; Pasamos al caso 1
c34:
		btfsc PORTA,0 ;Preguntamos por el bit 0 del puerto A
		goto c4 ;Pasamos al caso4
		goto c3 ; Pasamos al caso3
c56:
		btfsc PORTA,0 ;Preguntamos por el bit 0 del puerto A
		goto c6 ;Para el caso 6
		goto c5 ;Para el caso 5
c1: 	;En este caso el LED se APAGA
		clrf PORTB ;Limpiamos lo que hay en el puerto B
		goto ciclo ;Regresamos al ciclo
c2: ;En este caso el LED se ENCIENDE
		movlw H'FF'	;Movemos a w el valor FF 
		movwf PORTB ;Moviendo el valor de w al puerto B se encendera el led
		goto ciclo

c3: ;En este caso se hace corrimiento a la derecha con los LEDS
	bcf STATUS,0 ;Con esto limpiamos al carry
	movlw H'80'
	movwf PORTB
	movlw H'08'
	movwf contador
loop1: ;Ciclo para el corrimiento a la derecha
	call retardo	;Llamamos al retardo
	rrf PORTB,1		;recorremos los bits a la derecha
	decf contador	;Decrementamos el contador
	btfsc	STATUS,2 ;Preguntamos por el bit 2 del registro status
	goto ciclo
	goto loop1
c4: ;En este caso se hace corrimiento a la izquierda con los LEDS
	bcf STATUS,0
	movlw H'80'
	movwf PORTB
	movlw H'08'
	movwf contador
loop2:
	call retardo
	rlf PORTB,1
	decf contador
	btfsc	STATUS,2
	goto ciclo
	goto loop2
c5:		;En este caso hacemos ambos corrimientos, primero a la derecha, luego a la izquierda
	;--------HACEMOS EL CORRIMIENTO DERECHA
	bcf STATUS,0 ;Con esto limpiamos al carry
	movlw H'80'
	movwf PORTB
	movlw H'08'
	movwf contador
	loop3:
		call retardo
		rrf PORTB,1
		decf contador
		btfss	STATUS,2
		goto loop3
	;------ HACEMOS EL CORRIMIENTO A LA IZQUIERDA
	movlw H'08'
	movwf contador
	goto loop2 ;

c6: ;En este caso prendemos y apagamos todos los LEDS con retardo de 1/2 segundo
	movlw b'11111111'
	movwf PORTB
	call retardo
	movlw b'00000000'
	movwf PORTB
	call retardo
	goto ciclo
	goto c6

retardo  ;Subrutina utilizada para controlar el tiempo de retardo
	movlw cte1 ;carga el valor de cte1 en w
 	movwf valor1 ;almacena en valor1 lo que hay en w
tres movlw cte2
 	movwf valor2
dos movlw cte3
 	movwf valor3
uno 
	decfsz valor3 ;decrementa valor3 y compara con 0 si es distinto repite el ciclo
 	goto uno
 	decfsz valor2
 	goto dos
 	decfsz valor1
 	goto tres
	return
end