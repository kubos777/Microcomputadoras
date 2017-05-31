#include <16f877.h>
#fuses HS,NOPROTECT,
#use delay(clock=20000000)
#use rs232(baud=38400, xmit=PIN_C6, rcv=PIN_C7) // (xmit=pinc_c6 ) = tx , (rcv=PIN_C7)= Rx
#org 0x1F00, 0x1FFF void loader16F877(void) {} //for the 8k 16F876/7
void main(){
while(1){
 output_b(0xff); //En ensamblador hubieramos pasado a w un valor hexadecimal h'ff' y después moverlo al puerto B previamente configurado
 printf(" Todos los bits encendidos \n\r"); //No mandamos a terminal mensajes pero sí enviamos a través de la comunicación asíncrona del pic
 delay_ms(1000); // Sacabamos el tiempo por instrucción y lo multiplicabamos para obtener un retardo de cierto tiempo
 output_b(0x00);//En ensamblador hubieramos pasado a w un valor hexadecimal h'00' y después moverlo al puerto B previamente configurado
 printf(" Todos los leds apagados \n\r"); // No mandamos a terminal mensajes pero sí enviamos a través de la comunicación asíncrona del pic
 delay_ms(1000); //Sacabamos el tiempo por instrucción y lo multiplicabamos para obtener un retardo de cierto tiempo
}//while
}//main
