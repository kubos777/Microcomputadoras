#include <16f877.h>
#device adc=8 //en caso de emplear el conv. A/D indica resoluci�n de 8 bits
#fuses HS,NOPROTECT
#use delay (clock=20000000)
#use rs232 (baud=38400,xmit=PIN_C6,rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void){}
int conv; //Variable para guardar la conversi�n
long cont=0; //Contador para activar la interrupci�n
//Funcion de la interrupcion
#int_RTCC
clock_isr(){
cont++; //Implementa el contador, en ensamblador cont equ h'24'
//Determinamos 10 segundos mediante la formula
if(cont==769){ //En ensamblador se utilizar�a btfsc para verificar si el bit cambio y pasar a la subrutina que ejecuta el codigo dentro del if
printf("La conversi�n es: =%x\r",conv*0.019); //Cuando se active la interrupci�n mostrar� el valor de la conversion
cont=0;
   }
}
void main(){
set_timer0(0); //Inicia timer0 en 00H
setup_counters(RTCC_INTERNAL,RTCC_DIV_256); //Fuente de reloj y pre-divisor
enable_interrupts(INT_RTCC); //Habilita interrupcion del timer0
enable_interrupts(GLOBAL); //Habilita interrupciones generales

setup_port_a(ALL_ANALOG); /*Habilitamos el puerto an�logico, en ensamblador hubieramos
      tenido que cambiar de banco para configurar con un H'00' para entrada anal�gica
      al ADCON1 y ser configurado el puerto A como entrada*/
setup_adc (ADC_CLOCK_INTERNAL);//Indicamos que utilizaremos el reloj interno del pic
set_adc_channel (3);//Indicamos que utilizaremos el canal 3 para la se�al
while(1){
delay_us(20); //Retraso para que termine la conversion

conv=read_adc(); //Guardamos el resultado de la conversi�n

}
}
//t=tciclo de reloj (255)(256) Tciclo
