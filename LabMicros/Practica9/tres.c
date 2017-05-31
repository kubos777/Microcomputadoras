#include <16f877.h>
#device adc=8 //en caso de emplear el conv. A/D indica resolución de 8 bits
#fuses HS,NOPROTECT
#use delay (clock=20000000)
#use rs232 (baud=38400,xmit=PIN_C6,rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void){}
int conv; //Variable para guardar la conversiòn
long cont=0; //Contador para activar la interrupciòn
#int_RTCC //Para generar una interrupción
clock_isr(){ 
cont++; //Implementa el contador
//Determinamos 30 segundos mediante la formula
if(cont==2307){
printf("El mejor laboratorio de microcomputadoras\n"); //Cuando se active la interrupciòn mostrarà el valor de la conversion
cont=0;
   }
}
void main(){
set_timer0(0); //Inicia timer0 en 00H
setup_counters(RTCC_INTERNAL,RTCC_DIV_256); //Fuente de reloj y pre-divisor,  configura la razón
//de tiempo en la que se prenderá; 
enable_interrupts(INT_RTCC); //Habilita interrupcion del timer0 
enable_interrupts(GLOBAL); //Habilita interrupciones generales

setup_port_a(ALL_ANALOG); /*Habilitamos el puerto análogico, en ensamblador hubieramos
      tenido que cambiar de banco para configurar con un H'00' para entrada analógica
      al ADCON1 y ser configurado el puerto A como entrada*/
setup_adc (ADC_CLOCK_INTERNAL);//Indicamos que se usará el reloj interno del pic
set_adc_channel (3);//Configuramos el canal 3 
while(1){
delay_us(20); //Retraso para que termine la conversion

conv=read_adc(); //Guardamos el resultado de la conversiòn

}
}
