;Pràctica 6 Ejercicio 1
	processor 16f877 
	include <p16f877.inc>
J equ H'24'
K equ H'25'
	org	0			;Carga al vector de RESET la dirección de inicio
	goto inicio
	org 05
inicio:
		clrf PORTA ; Limpiamos el puerto A 
		clrf PORTB ; Limpimos el puerto B
		bsf STATUS,RP0 ;Nos cambiamos de banco
		bcf	STATUS,RP1 
		;YA ESTAMOS EN EL BANCO 1
		movlw H'00'    ;Configuramos E/S analògicas 
		movwf ADCON1
		movlw H'00'  ;Configuramos Puerto B como salida
		movwf TRISB	
		;Regresamos al banco 0
		bcf STATUS,RP0
		movlw b'11000001' ;Seleccionamos la frecuencia del reloj, selecciòn de canal y usar CAD
		movwf ADCON0
		
convers:
	   bcf STATUS,C  ;Limpiamos el carry
		bsf	ADCON0,2 ;Modificamos el bit 2 de ADCON0, comienza la conversiòn
		call retardo  ;Detenemos la conversiòn, llamando a un retardo muy pequeño
		bcf ADCON0,2  
		movfw ADRESH ;Guardamos la conversiòn
		sublw D'85'		; Realizamos una resta de la literal con 85
		btfsc STATUS,C  ; Si el carry esta habilitado saltamos a caso1
		goto caso1
		movfw ADRESH ;Guardamos la conversiòn       
		sublw D'170'   ; Realizamos una resta de la literal con 170
		btfsc STATUS,C ; Si el carry esta habilitado saltamos a caso2
		goto caso2		;Saltamos a caso 2, si no
		goto caso3		;Saltamos a caso3
		goto convers ;  Regresamos a la conversiòn
caso1:
		movlw b'00000001' ;Movemos la combinación para encender el led 0
		movwf PORTB		; Movemos lo que tiene w al Puerto B
		GOTO convers 	;Saltamos a convertir de nuevo si no esta entre el rango
caso2:
		movlw b'00000011' Movemos la combinación para encender los leds 0 y 1
		movwf PORTB	; Movemos lo que tiene w al Puerto B
		GOTO convers ;Saltamos a convertir de nuevo si no esta entre el rango
caso3:
		movlw b'00000111'	;Movemos la combinación para encender el led 0
		movwf PORTB			;Movemos lo que tiene w al Puerto B
		GOTO convers 		;Saltamos a convertir de nuevo si no esta entre el rango

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
end ;Fin del programa
