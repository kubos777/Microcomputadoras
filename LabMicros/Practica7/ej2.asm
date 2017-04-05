processor 16f877    
include<p16f877.inc>  
;Variables para el Retardo
valor1 equ h'21'  
valor2 equ h'22'  	
valor3 equ h'23'  
;Configuraci�n DISPLAY SIETE SEGMENTOS
;Para las vocales may�sculas
AM EQU b'01110111'  
EM EQU b'01111001'  
IM EQU b'00000110'  
OM EQU b'00111111'
UM EQU b'00111110' 
;Para las vocales min�sculas
Am EQU b'11011111' 
Em EQU b'11111011' 
Im EQU b'10000100' 
Om EQU b'11011100
Um EQU b'10011100'

;Para cargar valores usaremos var
var equ h'24'
org 0h;
goto INICIO
org 05h
INICIO: 
clrf PORTB
bsf STATUS,RP0 
bcf STATUS,RP1 ;Cambiamos al Banco 1
clrf TRISB ;Configura el puerto B como salida. 
;Configuraci�n del registro transmisor
bsf TXSTA, BRGH ;Bit de selecci�n de velocidad alta,BRGH=1 
movlw d'32' ;Velocidad 38400 baud
movwf SPBRG ;Cargamos la velocidad de comunicaci�n 
bcf TXSTA, SYNC ;Comunicaci�n asincrona SYNC=0 
bsf TXSTA, TXEN ;Activa la transmisi�n 
bcf STATUS, RP0 ;Cambiamos al Banco 0
;Configuraci�n del registro receptor
bsf RCSTA, SPEN ;Habilita puerto serie 
bsf RCSTA, CREN ;Configura recepci�n continua en modo
;as�ncrono
RECIBE:
;Registros Banderas
btfss PIR1, RCIF ;Verificamos si la recepci�n est� completa 
goto RECIBE  ;Si no, sigue recibiendo
movf RCREG,w  ;Si, mueve lo que recibe registro de 
;recepci�n RCREG a W
CICLO: 
clrf PORTB 
;Verificamos si es "a"
movlw 'a' ;Mueve 'a' a W
movwf var ;Mueve el contenido de W a var, var=a
movfw RCREG ;Mueve el contenido de RCREG a W
xorwf var,w ;Realiza var xor W
btfsc STATUS,Z ;Verificamos si Z=0
goto a ;NO, son iguales
;SI, verifica la siguiente opci�n
;Verificamos si es "e" 
movlw 'e'
movwf var
movfw RCREG
xorwf var,w
btfsc STATUS,Z
goto e
;Verificamos si es "i"
movlw 'i'
movwf var
movfw RCREG
xorwf var,w
btfsc STATUS,Z
goto i
;Verificamos si es "o"
movlw 'o'
movwf var
movfw RCREG
xorwf var,w
btfsc STATUS,Z
goto o
;Verificamos si es "u"
movlw 'u'
movwf var
movfw RCREG
xorwf var,w
btfsc STATUS,Z
goto u
;Verificamos si es "A"
movlw 'A'
movwf var
movfw RCREG
xorwf var,w
btfsc STATUS,Z
goto A
;Verificamos si es "E"
movlw 'E'
movwf var
movfw RCREG
xorwf var,w
btfsc STATUS,Z
goto E
;Verificamos si es "I"
movlw 'I'
movwf var
movfw RCREG
xorwf var,w
btfsc STATUS,Z
goto I
;Verificamos si es "O"
movlw 'O'
movwf var
movfw RCREG
xorwf var,w
btfsc STATUS,Z
goto O
;Verificamos si es "U"
movlw 'U'
movwf var
movfw RCREG
xorwf var,w
btfsc STATUS,Z
goto U
;Mostramos vocales min�sculas en el DISPLAY
a: 
movlw Am ;Mueve el valor de Am a W
movwf PORTB ;Mueve el valor de W a PORTB
call retardo ;Tiempo de Retardo
goto CICLO
e: 
movlw Em 
movwf PORTB
call retardo 
goto CICLO
i: 
movlw Im
movwf PORTB
call retardo 
goto CICLO
o: 
movlw Om
movwf PORTB
call retardo 
goto CICLO
u: 
movlw Um
movwf PORTB
call retardo 
goto CICLO
;Mostramos vocales may�sculas en el DISPLAY
A: 
movlw AM
movwf PORTB
call retardo 
goto CICLO
E: 
movlw EM
movwf PORTB
call retardo 
goto CICLO
I: 
movlw IM
movwf PORTB
call retardo 
goto CICLO
O: 
movlw OM
movwf PORTB
call retardo 
goto CICLO
U: 
movlw UM
movwf PORTB
call retardo 
goto CICLO
retardo: 
movlw h'10' ;RRetardo
movwf valor1 
tres movlw h'50'
movwf valor2
dos movlw h'60'
movwf valor3
uno decfsz valor3 
goto uno 
decfsz valor2 
goto dos
decfsz valor1 
goto tres
return
end