processor 16f877
include<p16f877.inc>
K equ H'26' ;Asignamos espacio de memoria para la variable K
J equ H'27' ;Asignamos espacio de memoria para la variable J
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 20h ; Estos registros nos ayudaran a generar el retardo
cte2 equ 50h
cte3 equ 60h
org 0 ;Para el vector reset
goto inicio  ;Nos movemos a la subrutina inicio
org 5 
inicio ;Comienza inicio
	bsf STATUS,5   ;Para cambiarnos de banco y trabajar con PortB y TrisB, ponemos un 1 en el bit 5 del registro status
	BCF STATUS,6 ; Ponemos un cero en el bit 6 del registro status para cambiar de banco
	MOVLW H'0' ;Movemos un cero a w
	MOVWF TRISB  ;Movemos lo que hay en w al registro TrisB
	BCF STATUS,5 ;Ponemos a cero el bit 5 del registro status para regresar el banco
	clrf PORTB; Limpiamos el puerto B

ciclo: 

movlw h'80' ;movemos un 1 a w

movwf PORTB ; movemos lo que hay en w a K

call retardo; LLamamos a la subrutina de retardo

movlw h'07' ;movemos un 7 a w

movwf J ;movemos lo que hay en w a J

corrimiento:

rrf PORTB,1 ;Corrimiento a la derecha de uno en uno

decf J,1 ; Decrementa J en 1, este es el contador

call retardo ; LLamamos a la subrutina de retardo

btfss STATUS,Z ;Salta si Z=1 esto implica que hubo un cero en J

goto corrimiento ; Salta a subrutina corrimiento

goto ciclo ;Saltamos a ciclo

retardo ; Empieza la subrutina retardo
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