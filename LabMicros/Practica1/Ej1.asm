	processor 16f877 ;Practica1  
	include <p16f877.inc>
K equ H'26'  ;Asignamos espacio de memoria para la variable K
L equ H'27'  ;Asignamos espacio de memoria para la variable L

org 0	;Vector RESET
goto inicio
	org 5
	inicio: 
	movlw h'05' ;A w le cargamos un 5 en hexa
	addwf K,0   ;Sumamos un 5 con el valor de K
	movwf L		;Movemos a la variable L el valor de K+w 
goto inicio
end