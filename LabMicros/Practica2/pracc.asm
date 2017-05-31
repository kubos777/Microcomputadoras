processor 16f877
include<p16f877.inc>
contador equ h'20' ;Asignamos dirección de memoria a la literal contador, valores
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 20h ; Estos registros nos ayudaran a generar el retardo
cte2 equ 50h
cte3 equ 60h
org 0 ;Para el vector reset
goto inicio  ;Saltamos a inicio
org 5 
inicio bsf STATUS,5   ;comienza inicio
	BCF STATUS,6 ; Para cambiarnos de banco ponemos un 0 en el bit 6 del registro status
	MOVLW H'0' ;Movemos un cero a w
	MOVWF TRISB  ;Movemos el contenido de w al registro trisB
	BCF STATUS,5 ;Para regresar al banco ponemos un 0 en el bit 5 del registro status
	clrf PORTB; Limpiamos lo que hay en el puerto B

loop2 
	bsf PORTB,0  ; Ponemos un 1 en el puerto B
	call retardo ;Hacemos una llamada a la subrutina retardo
	bcf PORTB,0 ; Ponemos un 0 en el puerto B
	call retardo  ;Hacemos una llamada a la subrutina retardo
	goto loop2  ;Vamos a la subrutina loop2
retardo ; Empieza la etiqueta retardo
	movlw cte1  ;Movemos lo que tiene la literal cte1 a w
	tres movlw cte2   ; Movemos lo que tiene la literal cte2 a w
	movwf valor2; Movemos lo que tiene w a valor2
	dos movlw cte3  ; Movemos lo que tiene cte3 a w
	movwf valor3 ;Movemos lo que tiene w a valor3
	uno decfsz valor3  ; Decrementamos el valor de valor3  y saltamos si valor3=0
	goto uno ;Saltamos a la subrutina uno
	decfsz valor2 ; Decrementamos el valor de valor2 saltamos si valor2=0
	goto dos ;Nos movemos a la subrutina  dos
	decfsz valor1 ;Decrementa el valor de valor1 salta cuando valor1=0
	goto tres ; Nos movemos a la subrutina tres
	return ;Intruccion para que vuelva al programa
END ;Fin del programa