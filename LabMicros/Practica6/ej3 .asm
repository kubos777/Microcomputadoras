  processor 16f877
  include<p16f877.inc>
  ret equ h'20'

  ;CANALES
  cal1 equ h'21'
  cal2 equ h'22'

  org 0h
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
       bcf STATUS,RP0    ;regresa al banco 0

CICLO:       
       movlw b'11000001' ;Configuración ADCON0 canal 0
       movwf ADCON0
       bsf ADCON0,2      ;Conversion en progreso GO=1
       call retardo      ;Espera que termine la conversión

ESPERA1
       btfsc ADCON0,2    ;Pregunta Termino conversión?
       goto ESPERA1
       movf ADRESH,0     ;Mueve a W
       movwf cal1        ;Guardamos el valor en cal1
       movlw b'11001001' ;Configuración ADCON0 canal 1
       movwf ADCON0
       bsf ADCON0,2      ;Conversión en sus marcas
       call retardo      ;Espera que termine la conversión

ESPERA:
       btfsc ADCON0,2    ;Pregunta termino conversión?
       goto ESPERA
       movf ADRESH,0     ;Mueve a W
       movwf cal2        ;Guardamos el valor en cal2
       movf cal1,w       ;Mueve cal1 a w
       subwf cal2        ;Realizamos la resta del canal2 - canal1          
       btfss STATUS,0    ;Verifica si W es mayor
       goto SALIDA2      ;No, entonces Ve2>Ve1 
       goto SALIDA1      ;Si, entonces Ve1>Ve2

SALIDA1:
       movlw b'00000001'        
       movwf PORTB       ;Salida 0001
       goto CICLO

SALIDA2:
       movlw b'00000010'        ;Salida 0010
       movwf PORTB
       goto CICLO

retardo                  ;DELAY de 2micoSeg aprox.
      movlw h'30'
      movwf ret
loop  decfsz ret
      goto loop
      return
   end  