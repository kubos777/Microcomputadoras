processor 16f877 ;Indica la versión del procesador
 include<p16f877.inc>
contador equ h'20' ;
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 20h
cte2 equ 50h
cte3 equ 60h


 org 0 ;carga el vector reset a la dirección de inicio
 goto inicio ;salto incondicional a inicio
 org 5
inicio:
	clrf	PORTB
	clrf	PORTB
	bsf		STATUS,RP0
	bcf		STATUS,RP1  ;CAMBIAMOS A BANCO 1
	movlw	H'07'
	movwf	ADCON1  ; E/S DIGITALES
	movlw	H'FF'
	movwf	TRISA    
	movlw H'00'
	movwf TRISB
	bcf STATUS,RP0 ;CAMBIAMOS A BANCO 0
ciclo:
		btfsc PORTA,2
		goto c56   ;Para el caso 5 o 6
		goto c1234 ; Para el caso 1-4
c1234:
		btfsc PORTA,1
		goto c34 ;Para el caso 3y 4
		goto c12 ; Para el caso 1 y 2
c12:
		btfsc PORTA,0
		goto c2 ;Entramos al caso 2
		goto c1 ; Pasamos al caso 1
c34:
		btfsc PORTA,0 
		goto c4 ;Pasamos al caso4
		goto c3 ; Pasamos al caso3
c56:
		btfsc PORTA,0
		goto c6 ;Para el caso 6
		goto c5 ;Para el caso 5
c1: ;ENCIENDE
		clrf PORTB
		goto ciclo
c2: ;APAGA
		movlw H'FF'
		movwf PORTB
		goto ciclo

c3: 
	bcf STATUS,0 ;Con esto limpiamos al carry
	movlw H'80'
	movwf PORTB
	movlw H'08'
	movwf contador
loop1:
	call retardo
	rrf PORTB,1
	decf contador
	btfsc	STATUS,2
	goto ciclo
	goto loop1
c4:
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
c5:
	;--------DERECHA
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
	;------IZQUIERDA
	movlw H'08'
	movwf contador
	goto loop2
c6:
	movlw b'11111111'
	movwf PORTB
	call retardo
	movlw b'00000000'
	movwf PORTB
	call retardo
	goto ciclo
	goto c6



retardo  ;rutina utilizada para controlar el tiempo de retardo
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