	processor 16f877 ;Practica1/
	include <p16f877.inc>
K equ H'26'  ;Asignamos espacio de memoria para la variable K
J equ H'27'  ;Asignamos espacio de memoria para la variable J
R1 equ H'28'
C1 equ H'29'
org 0	;Vector RESET
goto inicio
	org 5
	inicio:
	 
	movf J,0 ;Leemos J y lo movemos a w
	addwf K,0  ;Leemos K y lo sumamos con w que es J
	movwf R1	;Movemos a R1 el resultado de  el valor de K+J 
	btfsc STATUS,C ;Si c=0 brinca a clrf, si no a ponuno, determinamos si es acarreo o no
	goto ponuno
	clrf C1 ;Limpiamos el acarreo
	goto inicio ;Saltamos a inicio
ponuno:
	movlw h'01' ;Cargamos a w un 1 del acarreo
	movwf C1	; Movemos el acarreo a C1
	goto inicio
end