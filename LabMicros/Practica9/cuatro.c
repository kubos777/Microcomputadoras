#include <16f877.h>
#device adc=8 //en caso de emplear el conv. A/D indica resolución de 8 bits
#fuses HS,NOPROTECT
#use delay (clock=20000000)
#use rs232 (baud=38400,xmit=PIN_C6,rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void){}
int var1; //En ensamblador hubieramos declarado var1 equ h'Xx'
#int_rb //Habilitamos rb para los dipswitch
int_p(){ 
if(input(pin_b4))//En ensamblador hubieramos llamadoa  una subrutina 
printf("\nPB4 ACTIVADA"); //Manda un mensaje si se active el bit RB4
else
printf("\nPB4 DE BAJADA"); //Manda un mensaje si se active el bit RB4
if(input(pin_b5))
printf("\nPB5 ACTIVADA"); //Manda un mensaje si se active el bit RB5
else
printf("\nPB4 DE BAJADA"); //Manda un mensaje si se active el bit RB4
if(input(pin_b6))
printf("\nPB6 ACTIVADA"); //Manda un mensaje si se active el bit RB6
else
printf("\nPB4 DE BAJADA"); //Manda un mensaje si se active el bit RB4
if(input(pin_b7))
printf("\nPB7 ACTIVADA"); //Manda un mensaje si se active el bit RB7
else
printf("\nPB4 DE BAJADA"); //Manda un mensaje si se active el bit RB4
}
void main(){
setup_counters(RTCC_INTERNAL,RTCC_DIV_256); //Fuente de reloj y pre-divisor,configura la razón
//de tiempo en la que se prenderá; 
enable_interrupts(INT_RB); //Habilita interrupcion del timer0, cuando se reciba por RB
enable_interrupts(GLOBAL); //Habilita interrupciones generales
while(1){
var1=input_b(); //Ciclo para poder cambiar y asi activar la interrupcion de puerto b
}
}
