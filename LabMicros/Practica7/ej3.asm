processor 16f877
include<p16f877.inc>
  	
; Variable para el DELAY
val equ h'20'

;Variable para las lecturas del cad
  valor1 equ 0x21
  valor2 equ 0x22
  valor3 equ 0x23

  goto INICIO
  org 05h

INICIO:
       clrf PORTA
       clrf PORTB
       bsf STATUS,RP0    ;Cambia la banco 1
       bcf STATUS,RP1 
       movlw 00h         ;Configura puertos A y E como analógicos
       movwf ADCON1
       movlw 3fh         ;Configura el purto A como entrada
       movwf TRISA
       movlw h'0'
       movwf TRISB       ;Configura puerto B como salida
	   
       ;Configuración transmisor
       bsf TXSTA, BRGH   ;velocidad alta
       movlw d'129'      
       movwf SPBRG       ;Velocidad 9600 baud
       bcf TXSTA, SYNC   ;Comunicación asincrona SYNC=0   
       bsf TXSTA, TXEN   ;transmisión Activa
       bcf STATUS, RP0   ;banco=00

       ;Configuración receptor
       bsf RCSTA, SPEN   ;Habilita puerto serie 
       bsf RCSTA, CREN   ;Configura recepción continua en modoasíncrono

ciclo:
  movlw H'C9'
  movwf ADCON0		;Habilita canal 0 de CAD
  bsf ADCON0,2		;Inicia conversiòn
espera: btfsc ADCON0,2	;Esperamos que acabe la conversiòn
  goto espera
  call retardo
  movf ADRESH,0		;Transfiere el valor de conversiòn al banco de trabajo
  movwf valor1			;Primer valor de conversiòn

  movlw  H'D1'
  movwf ADCON0		;Habilita canal 1 de CAD
  bsf ADCON0,2		;Inicia conversiòn
espera2: btfsc ADCON0,2	;Esperamos que acabe la conversiòn
  goto espera2
  call retardo
  movf ADRESH,0		;Transfiere el valor de conversiòn al banco de trabajo
  movwf valor2			;Segundo valor de conversiòn

  movlw H'D9'
  movwf ADCON0		;Habilita canal 3 de CAD
  bsf ADCON0,2		;Inicia conversiòn
espera3: btfsc ADCON0,2	;Esperamos que acabe la conversiòn
  goto espera3
  call retardo
  movf ADRESH,0		;Transfiere el valor de conversiòn al banco de trabajo
  movwf valor3			;Tercer valor de conversiòn

  movf valor1,0			;Primer valor de conversiòn
  subwf valor2,0		;Comparaciòn contra segundo valor
  btfsc STATUS,C	
  goto comparacion2
  movf valor1,0
  subwf valor3,0
  btfsc STATUS,C
  goto comparacion3
  goto tercio1

comparacion3:
  movf valor3,0			;Tercer valor de conversiòn
  subwf valor2,0
  btfsc STATUS,C
  goto tercio2
  goto tercio3
  

comparacion2:
  movf valor2,0
  subwf valor3,0
  btfsc STATUS,C
  goto tercio3
  goto tercio2
  

tercio1:
  movlw H'01'		;Un LED encendido a 1/3 de voltaje
  movwf PORTB
  movlw 'a'
  movwf TXREG 
  call retardo  
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo

  goto ciclo

tercio2:
  movlw H'03'		;Dos LEDs encendidos a 2/3 de voltaje
  movwf PORTB
  movlw 'b'
  movwf TXREG
  call retardo
  call retardo   
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo
  goto ciclo

tercio3:
  movlw H'07'		;Tres LEDs encendidos cuando el voltaje es mayor a 2/3
  movwf PORTB   
  movlw 'c'
  movwf TXREG
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo
  call retardo

  goto ciclo

retardo:
  movlw H'30'
  movwf 0x20
loop1:
  decfsz 0x20
  goto loop1
  return 

  end  
