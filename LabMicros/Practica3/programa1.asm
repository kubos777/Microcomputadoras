processor 16f877 ;Indica la versión del procesador
 include<p16f877.inc>
 org 0 ;Para el vector reset a la dirección de inicio
 goto inicio ;Salta a inicio
 org 5
inicio:
	clrf	PORTB ;Limpiamos lo que haya en puerto B
	clrf	PORTA ;Limpiamos lo que haya en le puerto A
	bsf		STATUS,RP0 
	bcf		STATUS,RP1  ;CAMBIAMOS A BANCO 1
	movlw	H'07'
	movwf	ADCON1  ; Registro para Entradas/Salidas DIGITALES
	movlw	H'FF' 
	movwf	TRISA    
	movlw H'00'		;Movemos un 0 
	movwf TRISB
	bcf STATUS,RP0 ;CAMBIAMOS A BANCO 0
ciclo:
		btfsc PORTA,0 ; Si es cero entonces salta a apaga
		goto enciende  ;Si es 1 salta a enciende
		goto apaga
apaga:
		clrf PORTB  ;Limpiamos lo que hay en el puerto B
		goto ciclo ; Se cicla lo que hay en puerto B para que permanezca en ese estado
enciende:
		movlw H'FF' ;Para el ultimo bit del puerto B
		movwf PORTB ; Movemos lo que hay en w
		goto ciclo ;Saltamos al ciclo

end