processor 16f877   	  
include <p16f877.inc>  
Y equ H'24' 		;Asignamos la memoria a Y 
contador equ h'20'        
valor1 equ h'21'	   
valor2 equ h'22'	   
valor3 equ h'23'	
;Constantes para el retardo   
cte1 equ 20h       
cte2 equ 50h		   
cte3 equ 60h		   
org 0   		     	 
goto inicio   		   
org 5   			   
inicio  
    clrf PORTB    	  ;Limpiamos el puerto B
    BSF STATUS,RP0    ;Cambiamos al banco 1
    BCF STATUS,RP1
    clrf TRISB		 ;Configuramos el puerto B como salida 
trans:  
    bsf TXSTA, BRGH   ; Para la velocidad de transmisión alta BRGH=1
    movlw D'32'    	 ;Este es el valor decimal de acuerdo baud rate =38400 y Fosc =20 Mhz
    movwf SPBRG
    bcf TXSTA, SYNC   ;Para la comunicación serie asíncrona
    bsf TXSTA, TXEN   ;Habilitamos el transmisor
    bcf STATUS, RP0
    bsf RCSTA, SPEN  ; Habilitamos el puerto serie
    bsf RCSTA, CREN  ;Dejamos disponibles TX y RX 
recibe  
    btfss PIR1, RCIF  ;Bandera de interrupción se activan cuando ocurre una interrupcion y termina la recepción
    goto recibe             ;Vamos a la subrutina recibe
    movf RCREG, W ;si se pone en 1 RCIF, se guarda el resultado en RCREG la lectura del  teclado	
    movwf Y                ;Movemos el contenido de W a la variable Y    
ciclo
    clrf PORTB          ;Limpiamos PORTB
    bcf STATUS, Z    ;Ponemos a 0 a la bandera Z
   movf Y,W              ;Movemos lo que tiene Y a W
    xorlw A'0'              ;ASCII que realiza la operación lógica xor entre la entrada del teclado y w
    btfsc STATUS,Z   ;si z=0 saltamos al caso 1
    goto caso1	         		
    movf Y,W              ;Movemos el contenido de Y a W
    xorlw A'1'              ;ASCII que realiza la operación lógica entre la entrada del teclado y w
    btfsc STATUS,Z   ;si z=0 saltamos a la subrutina caso2
    goto caso2	         

    movf Y,W              ;Movemos el contenido de Y a W
    xorlw A'2'              ;ASCII que realiza la operación lógica entre la entrada del teclado y w
    btfsc STATUS,Z   ;si z=0 saltamos a la subrutina caso3
    goto caso3	         
     movf Y,W              ;Movemos el contenido de Y a W
    xorlw A'3'              ;ASCII que realiza la operación lógica entre la entrada del teclado y w
    btfsc STATUS,Z   ;si z=0 saltamos a la subrutina caso4
    goto caso4	         
    movf Y,W              ;Movemos el contenido de Y a W
    xorlw A'4'              ;ASCII que realiza la operación lógica entre la entrada del teclado y w
    btfsc STATUS,Z   ;si z=0 saltamos a la subrutina caso5
    goto caso5	         
    movf Y,W              ;Movemos el contenido de Y a W
    xorlw A'5'              ;ASCII que realiza la operación lógica entre la entrada del teclado y w
    btfsc STATUS,Z   ;si z=0 saltamos a la subrutina caso6
    goto caso6	         
 

 recepcion
    movf RCREG, W   ;Movemos el contenido del registro de recepción RCREG a W
    movwf TXREG      ;Movemos el contenido de W al registro de transmisión TXREG  
    bsf STATUS, RP0 ;Nos cambiamos al banco 1
transmite
    btfss TXSTA, TRMT     ; Para verificar si se realizo la transmisión 1=TSR vacio
    goto transmite                ;saltamos a la subrutina transmite 0 =TSR lleno
    bcf STATUS, RP0         ;Nos cambiamos al banco 0
    goto recibe                     ;Saltamos a la subrutina recibe
 caso1                    ;dato 000, acción LED’S apagados
   bcf STATUS,0    ;limpia el bit 0 del registro STATUS, evita que se prendan dos LED’S
   clrf PORTB        ;limpia el puerto B, LED’S apagados
   goto recepcion           ;Saltamos a la subrutina recepción
 caso2         	      ;dato 001, acción LED’S encendidos
   bcf STATUS,0    ;limpia el bit 0 del registro STATUS, evita que se prendan dos LED’S
   movlw h'FF'       ;Movemos un 1 al registro W
   movwf PORTB  ; Movemos el contenido de W a PORTB , enciende LED’S
   goto recepcion           ;salto a la subrutina recepción
caso3			;dato 010, acción corrimiento de bit hacia la derecha
   bcf STATUS,0    ;limpia el bit 0 del registro STATUS, evita que se prendan dos LED’S
   movlw H'80'             ;Movemos H’80’ a W
   movwf PORTB        ;Movemos el contenido de W a PORTB, fin de secuencia
   call retardo		;Llamamos a la subrutina retardo	
   movlw H’08’'            ;Movemos H‘08’ a W
   movwf L                   ;Movemos el contenido de W a L, inicia secuencia
corrimiento:
   call retardo		;Llamamos a la subrutina retardo	
   rrf PORTB,1   	;corrimiento hacia la derecha de bits de 1 en 1 sobre el puerto B
   decf L,1                    ;Decrementamos a L en 1 
   btfsc STATUS,2      ;  cuando se esta en cero estado que nos brinda STATUS
   goto recepcion           ;salto a la subrutina recepción
   goto corrimiento       ;no hemos llegado a cero, seguimos con el corrimiento
caso4 		            ;dato 011, acción corrimiento de bit hacia la izquierda
   bcf STATUS,0          ;limpia el bit 0 del registro STATUS, evita que se prendan dos LED’S
   movlw H'01'             ;Movemos H’80’ a W
   movwf PORTB        ;Movemos el contenido de W a PORTB, fin de secuencia
   call retardo		;Llamamos a la subrutina retardo	
   movlw H’08’'            ;Movemos H‘08’ a W
   movwf L                   ;Movemos el contenido de W a L, inicia secuencia
corrimiento2:
   call retardo		;Llamamos a la subrutina retardo	
   rlf PORTB,1   	;corrimiento hacia la derecha de bits de 1 en 1 sobre el puerto B
   decf L,1                    ;Decrementamos a L en 1 
   btfsc STATUS,2      ;  Si el bit 2 es cero saltamos a...
   goto recepcion           ;salto a la subrutina recepción
   goto corrimiento2      ;no hemos llegado a cero, seguimos con el corrimiento
caso5     		;dato 100, acción corrimiento de bit hacia la derecha y a la izquierda
   bcf STATUS,0          ;limpia el bit 0 del registro STATUS, evita que se prendan dos LED’S
   movlw H'80'             ;Movemos H’80’ a W
   movwf PORTB        ;Movemos el contenido de W a PORTB, fin de secuencia
   call retardo		;Llamamos a la subrutina retardo	
   movlw H’08’'            ;Movemos H‘08’ a W
   movwf L                   ;Movemos el contenido de W a L, inicia secuencia
corrimiento3:
   call retardo		;Llamamos a la subrutina retardo	
   rrf PORTB,1   	;corrimiento hacia la derecha de bits de 1 en 1 sobre el puerto B
   decf L,1                    ;Decrementamos a L en 1 
   btfsc STATUS,2       ;  cuando se esta en cero estado que nos brinda STATUS
   goto caso4               ;salto a la subrutina corrimiento a la izquierda caso4
   goto corrimiento3     ;no hemos llegado a cero, seguimos con el corrimiento
caso6			;dato 101, acción se apagan y prenden todos los LED’S
   movlw b'11111111' ;Movemos b’11111111’ a W
   movwf PORTB       ;Movemos el contenido de W a PORTB, para encender LED’S
   call retardo	           ;Llamamos a la subrutina retardo	
   clrf PORTB	           ;se limpia el puerto B para que se apaguen los leds
   call retardo	           ;Llamamos a la subrutina retardo 	
   goto recepcion           ;salto a la subrutina recepción
retardo 
     movlw cte1              ;Movemos el contenido del cte1 a W 
     movwf valor1	  ;Movemos el contenido de w a la dirección de valor1	
tresillos
     movlw cte2		  ;Movemos el contenido del cte2 a W
     movwf valor2	  ;Movemos el contenido de w a a la dirección de valor2
dos
    movlw cte3		  ;Movemos el contenido del cte3 a W	
    movwf valor3            ;Movemos el contenido de w a a la dirección de valor3
uno 
    decfsz valor3	 ;Decrementamos a valor3 y escapa a uno cuando llegue a 0 	
    goto uno		 ;saltamos a la dirección de uno para iniciar de nuevo
    decfsz valor2	 ;Decrementamos a valor2 y escapa a dos cuando llegue a 0
    goto dos		 ;Saltamos a la direccion de dos para iniciar de nuevo	
    decfsz valor1	 ;decrementa a valor1 y escapa a tres cuando llegue a 0
    goto tres		 ;saltamos a la direccion de tres para iniciar de nuevo
    return		;retorno a la subrutina retardo
end	