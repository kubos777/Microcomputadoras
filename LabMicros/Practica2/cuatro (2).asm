	processor 16f877 ;Practica1  
	include <p16f877.inc>
K equ H'26'  ;Asignamos espacio de memoria para la variable K
J equ H'27'  ;Asignamos espacio de memoria para la variable J
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 40h
cte2 equ 100h
cte3 equ 120h

org 0	;Vector RESET
goto inicio
	org 5
	inicio:
	bsf STATUS,RP0
 	BCF STATUS,RP1
 	MOVLW H'0'
	MOVWF TRISB
 	BCF STATUS,RP0
 	clrf PORTB
ciclo: 
	movlw h'80' ;movemos un 1 a w
	movwf PORTB		; movemos lo que hay en w a K
	call retardo
	movlw h'07' ;movemos un 7 a w
	movwf J ;cmovemos lo que hay en w a J

corrimiento:
	rrf PORTB,1	;Corrimiento a la derecha de uno en uno
	decf J,1 ; Decrementa J en 1 este es el contador
	call retardo
	btfss STATUS,Z ;Salta si  Z=1 esto implica que hubo un cero en J
	goto corrimiento ; Salta a subrutina corrimiento
	goto ciclo ;Saltamos a ciclo

retardo movlw cte1
 movwf valor1
tres movlw cte2
 movwf valor2
dos movlw cte3
 movwf valor3
uno decfsz valor3
 goto uno
 decfsz valor2
 goto dos
 decfsz valor1
 goto tres
return
 END