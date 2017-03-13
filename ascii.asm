		processor 16f877A
		include <p16f877A.inc>
Dato_IN		equ H'20'
eval		equ H'21'
casteado	equ H'22'

			org 0 
			goto inicio
			org 5
inicio:
		clrf eval ;Limpiamos el contenido de eval
		bsf	Dato_IN,5
		call evauluar
		btfsc eval,0
		goto letra
		goto numero
letra:
		movf Dato:IN,w
		andlw H'0F'
		call Tabla
		movf casteado
		goto fin		
numero: 
		movf Dato:IN,w
		andlw H'0F'
		movf casteado
		goto fin
evaluar:
		movf Dato_IN,w
		andlw H'F0' ;Con estas dos líneas ya tenemos en el acumulador un 60 o un 30
		xorlw H'30'
		btfss STATUS,2
		goto es_letra
		goto es_num
		return

es_letra:
		bsf eval,0 ; Si es letra eval vale 1, se pone a 1 el bit.
		goto reg1
es_num:
		clrf eval
reg1:
		return
Tabla:
		addlw PCL,f
		retlw H'00' ;00
		retlw H'0A' ;01
		retlw H'0B' ;02
		retlw H'0C' ;03
		retlw H'0D' ;04
		retlw H'0E' ;05
		retlw H'0E' ;06
fin:
		goto fin
		end