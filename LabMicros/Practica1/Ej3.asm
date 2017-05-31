	processor 16f877 ;Practica1  
	include <p16f877.inc>
K equ H'26'  ;Asignamos espacio de memoria para la variable K
J equ H'27'  ;Asignamos espacio de memoria para la variable J

org 0	;Vector RESET
goto inicio
	org 5
	inicio: 
	movlw h'01' ;movemos un 1 a w
	movwf K		; movemos lo que hay en w a K
	movlw h'07' ;movemos un 7 a w
	movwf J ;movemos lo que hay en w a J

corrimiento:
	rlf K,1	;Corrimiento a la derecha de uno en uno
	decf J,1 ; Decrementa J en 1
	btfss STATUS,Z ;Salta si  Z=1
	goto corrimiento ; Salta a subrutina corrimiento
	goto inicio ;Saltamos a inicio
end