processor 16f877 ;Indica la versión del procesador
 include<p16f877.inc>
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
		btfsc PORTA,0
		goto enciende
		goto apaga
apaga:
		clrf PORTB
		goto ciclo
enciende:
		movlw H'FF'
		movwf PORTB
		goto ciclo

end