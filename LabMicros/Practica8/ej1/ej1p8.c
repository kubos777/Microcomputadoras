#include <16f877.h>
#fuses HS,NOPROTECT,  //Indicamos que trabajaremos a alta frecuencia
#use delay(clock=20000000) //Frecuencia de oscilaciòn de acuerdo al cristal ensamblado
#org 0x1F00, 0x1FFF void loader16F877(void) {}
void main(){
//De aquì para arriba es la plantilla para C compiler
while(1){
 output_b(0x01); //En ensamblador debimos configurar los registros TRIS para usar el puerto B
 delay_ms(1000); //Enn ensamblador se debiò crear una rutina con el tiempo de cada instrucciòn
 output_b(0x00); //En ensamblador hubieramos mandado 0 al puerto B
 delay_ms(1000); //Retardo 1 seg
}//while
}//main
