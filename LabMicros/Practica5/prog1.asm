;Programa 1
	processor 16f877 
	include <p16f877.inc>
	org	0			;Carga al vector de RESET la dirección de inicio
	goto inicio
	org 05	 		;Dirección de inicio del programa del usuario
inicio: 
		bsf STATUS,RP0 ; Nos cambiamos de banco
		bcf STATUS,RP1	
		movlw H'07'   
		movwf ADCON1  ;Configuramos el registro como entrada/salida
		movlw H'FF'   ;
		movwf TRISA   ;
		movlw H'00'   
		movwf TRISB    
		bcf	STATUS,RP0
AND:
		movlw H'07'		;Movemos un 7 a w
		andwf PORTA,w	;Aplicamos un and a lo que hay en el puerto B
		movwf PORTB		;Mostramos el reflejo de lo que hay en w en el puerto B 
		goto AND 		;Regresamos a la subrutina AND
	end
		