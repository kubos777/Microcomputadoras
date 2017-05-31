#include <16f877.h>
#device adc=8 //en caso de emplear el conv. A/D indica resoluci�n de 8 bits
#fuses HS,NOPROTECT
#use delay (clock=20000000)
#use rs232 (baud=38400,xmit=PIN_C6,rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void){}
int converse; //Donde se almacenar� el resultado de la conversi�n
void main(){
      setup_port_a(ALL_ANALOG); /*Habilitamos el puerto an�logico, en ensamblador hubieramos
      tenido que cambiar de banco para configurar con un H'00' para entrada anal�gica
      al ADCON1 y ser configurado el puerto A como entrada*/
      setup_adc (ADC_CLOCK_INTERNAL); //Indicamos que utilizaremos el reloj interno del pic
      set_adc_channel (3);//Indicamos que utilizaremos el canal 3 para la se�al
      while(1){
         delay_us(20);//Retardo de 20 microsegs
         converse=read_adc(); //Realiza la conversi�n y la guarda en converse
         printf("La conversi�n es: =%x\r",converse);
         output_b(converse); //Se muestra el valor de la conversi�n en el puerto B
      }
      }
