;Programa 1
	processor 16f877 
	include <p16f877.inc>
	org	0			;Carga al vector de RESET la dirección de inicio
	goto inicio
	org 05	 		;Dirección de inicio del programa del usuario
inicio: 
		bsf STATUS,RP0
		bcf STATUS,RP1
		
		movlw H'07'
		movwf ADCON1
		movlw H'FF'
		movwf TRISA
		movlw H'00'
		movwf TRISB
		bcf	STATUS,RP0
AND:
		movlw H'07'
		andwf PORTA,w
		movwf PORTB
		goto AND
	end
		