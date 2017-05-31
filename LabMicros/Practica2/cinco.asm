processor 16f877
include<p16f877.inc>
K equ H'26' ;Asignamos espacio de memoria para la variable K

J equ H'27' ;Asignamos espacio de memoria para la variable J
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 eaqu 20h ; Registros a recorren para generar el retardo
cte2 equ 50h
cte3 equ 60h
org 0 ;Vector reset
goto inicio  ;Salta a la etiqueta inicio
org 5 
inicio bsf STATUS,5   ;Ponemos un 1 en el bit 5 del registro status.
	BCF STATUS,6 ; Ponemos un cero en el bit 6 del registro status para cambiar de banco
	MOVLW H'0' ;Movemos un cero en el w
	MOVWF TRISB  ;Movemos lo que tiene w al registro TrisB
	BCF STATUS,5 ;Ponemos un cero en el bit 5 del registro status para regresar el banco
	clrf PORTB; Limpiamos el puerto B
ciclo:
	incf PORTB,1 ; Incrementamos en 1 lo que hay en el puerto B
	call retardo ; LLamamos al retardo
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