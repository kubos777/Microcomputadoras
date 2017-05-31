	processor 16f877 ;Practica1  
	include <p16f877.inc>
K equ H'26'  ;Asignamos espacio de memoria para la variable K
J equ H'27'  ;Asignamos espacio de memoria para la variable J

org 0	;Vector RESET
goto inicio
	org 5
	inicio: 
	movlw d'00' ;movemos un 0 decimal a w
	movwf K		; movemos lo que hay en w a K
	movlw d'20' ; movemos un 20 decimal a w
	movwf J		;movemos lo que hay en w a J
	
contador:
	incf K,1 ; Incrementa K en 1
	decf J,1 ;Decrementa J en 1
	btfss STATUS,Z ;Salta si  Z=0
	goto contador ; Salta a subrutina contador
	goto inicio ;Saltamos a inicio
end