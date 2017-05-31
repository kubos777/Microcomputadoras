#include <16f877.h>
#fuses HS,NOPROTECT,
#use delay(clock=20000000)
#org 0x1F00, 0x1FFF void loader16F877(void) {} //for the 8k 16F876/7
int var1; //Se inicializa una variable, en ensamblador seria var1  EQU y una direcciòn disponible
void main(){
while(1){  //En ensamblador crearíamos una subrutina loop y ahí las demás instrucciones
var1=input_a(); //En ensamblador hubieramos configurado el puerto A como entrada
output_b(var1); //Lo que se lee en el puerto A se manda directamente al puerto B, para usar el puerto A debimos configurarlo como entrada con TRISA
}//while
}//
