;Pr�ctica 6 Ejercicio 1
	processor 16f877 
	include <p16f877.inc>
J equ H'24'
K equ H'25'
	org	0			;Carga al vector de RESET la direcci�n de inicio
	goto inicio
	org 05
inicio:
		clrf PORTA ; Limpiamos el puerto A 
		clrf PORTB ; Limpimos el puerto B
		bsf STATUS,RP0 ;Nos cambiamos de banco
		bcf	STATUS,RP1 
		;YA ESTAMOS EN EL BANCO 1
		movlw H'00'    ;Configuramos E/S anal�gicas 
		movwf ADCON1
		movlw H'00'  ;Configuramos Puerto B como salida
		movwf TRISB	
		;Regresamos al banco 0
		bcf STATUS,RP0
		movlw b'11000001' ;Seleccionamos la frecuencia del reloj, selecci�n de canal y usar CAD
		movwf ADCON0
		
convers:
		bsf	ADCON0,2 ;Modificamos el bit 2 de ADCON0, comienza la conversi�n
		call retardo  ;Detenemos la conversi�n, llamando a un retardo muy peque�o
		bcf ADCON0,2
		movfw ADRESH ;Guardamos la conversi�n 
		movwf PORTB	;Mandamos la conversi�n al puerto B
		goto convers ;  Regresamos a la conversi�n

retardo:				;Subrutina de retardo
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
end
